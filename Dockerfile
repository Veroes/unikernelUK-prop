FROM node:21-alpine AS node

WORKDIR /usr/src

COPY package*.json ./
RUN npm install

COPY . .

FROM alpine:3 AS sys

RUN set -xe; \
    mkdir -p /target/etc; \
    mkdir -p /blank; \
    for i in 1 2 3; do \
      apk --no-cache add ca-certificates tzdata && break || sleep 5; \
    done; \
    update-ca-certificates; \
    ln -sf ../usr/share/zoneinfo/Etc/UTC /target/etc/localtime; \
    echo "Etc/UTC" > /target/etc/timezone;

FROM scratch

COPY --from=sys /target/etc /etc
COPY --from=sys /usr/share/zoneinfo/Etc/UTC /usr/share/zoneinfo/Etc/UTC
COPY --from=sys /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=sys /blank /tmp

COPY --from=node /usr/local/bin/node /usr/bin/node

COPY --from=node /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=node /usr/lib/libgcc_s.so.1 /usr/lib/libgcc_s.so.1
COPY --from=node /usr/lib/libstdc++.so.6 /usr/lib/libstdc++.so.6

COPY --from=node /usr/src/node_modules /usr/src/node_modules
COPY --from=node /usr/src/app.js /usr/src/app.js
COPY --from=node /usr/src/index.html /usr/src/index.html
COPY --from=node /usr/src/public /usr/src/public

WORKDIR /usr/src

CMD ["node", "app.js"]
