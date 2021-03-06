FROM alpine:3.6

LABEL maintainer="Kanin Peanviriyakulkit <kanin.pean@gmail.com>"

RUN apk update \
  && apk upgrade

RUN apk add --no-cache \
  openssh-client \
  git \
  tar \
  curl

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://github.com/mholt/caddy/releases/download/v0.10.7/caddy_v0.10.7_linux_amd64.tar.gz" \
    | tar --no-same-owner -C /usr/bin -xz \
 && mv /usr/bin/caddy_linux_amd64 /usr/bin/caddy \
 && chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version

EXPOSE 80 443 2015
VOLUME /root/.caddy
WORKDIR /srv

COPY Caddyfile /etc/Caddyfile

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
