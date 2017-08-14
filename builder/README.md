# Building Lambda functions with crowbar in Docker

The `Dockerfile` and `build.sh` script here help you build Lambda functions against libraries in Amazon Linux (used for the Lambda execution environment).
Make sure to copy your `id_rsa` and `known_hosts` in this directory before your build.
Also, don't push this image to a public repo, it contains your SSH key.

```bash
cp $HOME/.ssh/id_rsa .
cp $HOME/.ssh/known_hosts .
```

To build the image :

```bash
docker build . -t crowbar
```

Then from you project :

```bash
docker run --rm -v $(pwd):/code:ro crowbar > lambda.zip
```

If you need extra packages, add them as arguments:

```bash
docker run --rm -v $(pwd):/code:ro ilianaw/crowbar-builder openssl-devel > lambda.zip
```
