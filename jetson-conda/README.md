# Build a Python3 JetsonConda distro

```bash
docker build -t jc-build-im .
docker rm jc-build
docker run --name jc-build -d jc-build-im
docker cp jc-build:/JetsonConda-0.2.1-Linux-aarch64.sh .
docker stop jc-build
docker rm jc-build
```

