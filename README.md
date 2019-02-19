# docker-pgmodeler-build

## Build pgmodeler in a container

Modified https://github.com/ksylvan/docker-pgmodeler for building the Linux binaries only.

It can then be copied from the `/out` directory.

This repository also includes the required `start.sh` and `pgmodeler.vars` file.

## Usage

```
docker build -t rawbert/pgmodeler-build --name pgmodeler-build .
docker run -t --name pgmodeler-build rawbert/pgmodeler-build
docker cp -a pgmodeler-build:/out/ ./pgmodeler
```
