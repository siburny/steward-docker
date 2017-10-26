FROM resin/raspberry-pi2-debian

# Set timezone  
ENV TZ=America/New_York
RUN echo America/New_York | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# Update and install essentials
RUN apt-get update && apt-get install -y --no-install-recommends build-essential git python \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

# gpg keys listed at https://github.com/nodejs/node
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    56730D5401028683275BD23C23EFEFE93C4CFFFE \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

# Install NodeJS
ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 6.11.5
ARG ARMPLATFORM=armv7l
RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARMPLATFORM.tar.gz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-$ARMPLATFORM.tar.gz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xzf "node-v$NODE_VERSION-linux-$ARMPLATFORM.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-$ARMPLATFORM.tar.gz" SHASUMS256.txt SHASUMS256.txt.asc

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY ./steward-master/steward/package.json /usr/src/app
RUN npm install

# Copy sources
COPY ./steward-master/steward/ /usr/src/app

EXPOSE 8887 8888
CMD ["/bin/bash", "-c", "node index.js 2>&1 | tee /usr/src/app/db/steward.log"]