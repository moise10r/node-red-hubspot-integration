FROM nodered/node-red:latest

COPY data/package*.json /data/

USER root
RUN chown -R node-red:node-red /data

USER node-red
WORKDIR /data
RUN npm i


COPY data/ /data/

WORKDIR /usr/src/node-red