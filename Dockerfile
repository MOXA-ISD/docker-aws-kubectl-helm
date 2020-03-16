FROM alpine:3.11

LABEL maintainer ThingsPro SRE Team <thingspro.sre@moxa.com>

COPY config.ini /

# install dependancies
RUN apk --update add --no-cache bash curl make git ca-certificates groff less python py-pip && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apk/*

# install awscli
RUN export $(egrep -v '^#' /config.ini | xargs) && \
    pip install awscli==$AWSCLI_VERSION

# install kubectl
RUN export $(egrep -v '^#' /config.ini | xargs) && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl && \
    chmod u+x kubectl && \
    mv kubectl /bin/kubectl

# install helm
RUN export $(egrep -v '^#' /config.ini | xargs) && \
    curl -L https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64

CMD [ "tail", "-f", "/dev/null" ]
