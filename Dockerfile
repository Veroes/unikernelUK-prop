FROM node:21-alpine AS node

WORKDIR /usr/src

COPY package*.json ./
RUN npm install

COPY . .

FROM scratch

# Node Binary
COPY --from=node /usr/local/bin/node /usr/bin/node

# System Libraries
COPY --from=node /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=node /usr/lib/libgcc_s.so.1 /usr/lib/libgcc_s.so.1
COPY --from=node /usr/lib/libstdc++.so.6 /usr/lib/libstdc++.so.6

# Express App Codebase
COPY --from=node /usr/src/node_modules /usr/src/node_modules
COPY --from=node /usr/src/app.js /usr/src/app.js
COPY --from=node /usr/src/index.html /usr/src/index.html
COPY --from=node /usr/src/public /usr/src/public

WORKDIR /usr/src

CMD ["node", "app.js"]