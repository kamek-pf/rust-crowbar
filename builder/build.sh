#!/bin/bash
set -euo pipefail
export CARGO_TARGET_DIR=$(mktemp -d)
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

(
    if [[ $# -gt 0 ]]; then
        yum install -y "$@"
    fi
    eval `ssh-agent -s`
    ssh-add
    . $HOME/.cargo/env
    cargo build ${CARGO_FLAGS:-} --release
) 1>&2
cd $CARGO_TARGET_DIR/release
(
    strip liblambda.so
    zip lambda.zip liblambda.so
) 1>&2
exec cat lambda.zip
