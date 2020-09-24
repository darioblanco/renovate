FROM node:lts-alpine
LABEL maintainer="development@minddoc.com"

ARG VERSION=unknown
ENV VERSION=$VERSION

# Ruby gems
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1
ADD gemrc /root/.gemrc

# Install global dependecies
RUN apk update \
&& apk add ca-certificates \
           curl \
           less \
           libressl \
           git \
           gnupg \
           g++ \
           make \
           openjdk11-jre-headless \
           openssh-client \
           python3 \
           ruby \
           ruby-bigdecimal \
           ruby-etc \
           ruby-io-console \
           ruby-irb \
           unzip \
           xz \
           wget \
&& apk add --virtual .build-dependencies \
                     build-base \
                     libressl-dev \
                     python3-dev \
                     ruby-dev \
\
&& gem install bundler || apk add ruby-bundler \
&& bundle config build.nokogiri --use-system-libraries \
&& bundle config git.allow_insecure true \
&& gem install json \
&& gem cleanup \
&& apk del .build-dependencies \
&& rm -rf /usr/lib/ruby/gems/*/cache/* \
          /var/cache/apk/* \
          /tmp/* \
          /var/tmp/* \
\
&& npm install -g yarn --force \
&& chown node:node -R /usr/local/lib/node_modules /root/ /usr/local/bin/

# Gradle
ENV GRADLE_VERSION=6.3
RUN wget --no-verbose https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip && \
    unzip -q -d /opt/ gradle-$GRADLE_VERSION-bin.zip && \
    rm -f gradle-$GRADLE_VERSION-bin.zip && \
    mv /opt/gradle-$GRADLE_VERSION /opt/gradle && \
    ln -s /opt/gradle/bin/gradle /usr/local/bin/gradle

# Renovate client setup
USER node
RUN npm i -g renovate@$VERSION
USER root
WORKDIR /usr/src/app
COPY renovate.js default_config.json ./
RUN chown node:node -R /usr/src/app
USER node

CMD [ "renovate" ]
