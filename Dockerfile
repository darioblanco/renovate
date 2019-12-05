FROM node:12.13-alpine
LABEL maintainer="development@minddoc.com"

# Install dependecies
RUN apk --update --no-cache add --virtual build-dependencies python build-base && \
  apk add git && \
  npm install -g yarn && \
  chown node:node -R /usr/local/lib/node_modules /root/ /usr/local/bin/

USER node
RUN npm i -g renovate
USER root

RUN apk del build-dependencies

WORKDIR /usr/src/app
COPY renovate.js default_config.json ./

ENV RENOVATE_CONFIG_FILE=/usr/src/app/renovate.js \
    ONBOARDING_CONFIG_PATH=/usr/src/app/default_config.js \
    BINARY_SOURCE=yarn

USER node

CMD [ "renovate" ]
