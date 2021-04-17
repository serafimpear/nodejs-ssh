# Docker based on Ubuntu 20.04 with NodeJS 14 LTS + OpenSSH server
> Works with Ubuntu 20.04 LTS

## Installation:
1. Modify `Dockerfile` and change username and password for SSH
```dockerfile
ARG username=user
ARG userpaswd=1234
```
2. Build docker:
```
$ docker build -t serafimpear/nodejs-ssh .
```
3. And run it:
```
$ docker run -d -p 2222:22 -p 8080:80 -p 4430:443 --name nodejs-ssh serafimpear/nodejs-ssh
```

## SSH:
```
$ ssh -p 2222 user@localhost
```

> By using any of the files available in this repository, you understand that you are AGREEING TO USE AT YOUR OWN RISK.
