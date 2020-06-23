FROM alpine:3.10

RUN apk update && apk upgrade && \
    apk add --no-cache git openssh

RUN apk update && \
    apk upgrade && \
    apk add bash

RUN apk add --no-cache curl ca-certificates git-lfs && \
#    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
#    apk add --no-cache git-lfs && \
    git lfs install

COPY mirror.sh /mirror.sh
COPY setup-ssh.sh /setup-ssh.sh

ENTRYPOINT ["/mirror.sh"]
