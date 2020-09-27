FROM arm32v7/node:12 as build

# Set timezone  
ENV TZ=America/New_York
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY ./steward-master/steward/package.json /usr/src/app
COPY ./steward-master/steward/package-lock.json /usr/src/app
RUN npm install

FROM arm32v7/node:12-slim

COPY --from=build /usr/src/app/node_modules /usr/src/app/node_modules

# Copy sources
COPY ./steward-master/steward/ /usr/src/app

WORKDIR /usr/src/app

EXPOSE 8887 8888
CMD ["/bin/bash", "-c", "node --inspect index.js 2>&1 | tee /usr/src/app/db/steward.log"]