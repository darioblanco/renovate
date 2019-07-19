FROM node:12.3.1-alpine
LABEL maintainer="development@minddoc.com"

# Install dependecies
RUN apk --update --no-cache add --virtual build-dependencies python build-base &&\
  apk add git

RUN chown node:node -R /usr/local/lib/node_modules /root/ /usr/local/bin/
USER node

RUN npm i -g renovate

USER root

RUN apk del build-dependencies


WORKDIR /usr/src/app
COPY renovate.js default_config.json ./

USER node
CMD [ "renovate" ]
