FROM ubuntu:22.04

LABEL version="1.0" author="Chernuha Andrew"

ARG NODE_MAJOR=18

RUN apt-get update && \ 
    apt-get install -yq curl && \
    curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash && \
    apt-get install -yq nodejs

RUN node -v
RUN npm -v

WORKDIR /app

COPY app/package*.json .
COPY app/webpack.config.js .
COPY app/src ./src/

# Install dependencies for front end and back end
# Probably it would be better to use npm ci here to use package-lock.json
RUN npm install

# Build front end assets with webpack
RUN npm run build

CMD ["npm", "start"]

EXPOSE 3000