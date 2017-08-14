FROM amazonlinux:latest

# Setup for ssh onto github
RUN mkdir -p /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
ADD known_hosts /root/.ssh/known_hosts
RUN chmod 700 /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/known_hosts
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable
RUN yum install -y bzip2-devel gcc gcc-c++ git openssl-devel readline-devel sqlite-devel zip python35 && yum clean all
ENV PYENV_ROOT=/usr/local/pyenv PYTHON_CONFIGURE_OPTS="OPT=\"-fPIC\""
RUN git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
RUN /usr/local/pyenv/bin/pyenv install 2.7.13
RUN /usr/local/pyenv/bin/pyenv install 3.6.1
RUN /usr/local/pyenv/bin/pyenv global 3.6.1 2.7.13
ADD build.sh /usr/local/bin/
VOLUME ["/code"]
WORKDIR /code
ENTRYPOINT ["/usr/local/bin/build.sh"]
