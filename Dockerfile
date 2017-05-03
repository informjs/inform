FROM alpine
MAINTAINER Bailey Stoner <code@monokro.me>


RUN apk update
RUN apk upgrade

RUN apk add build-base
RUN apk add nodejs
RUN apk add python
RUN apk add libzmq zeromq-dev

RUN npm install -g coffee-script


ADD . /opt/informjs/


WORKDIR /opt/informjs/shared
RUN rm -rf node_modules
RUN npm install
RUN npm link
RUN make


WORKDIR /opt/informjs/plugins/tropo-sms
RUN rm -rf node_modules
RUN npm install
RUN npm link
RUN npm link inform-shared
RUN make


WORKDIR /opt/informjs/plugins/tropo-sms
RUN rm -rf node_modules
RUN npm install
RUN npm link
RUN make


WORKDIR /opt/informjs/daemon
RUN rm -rf node_modules
RUN npm install
RUN npm link
RUN npm link inform-shared
RUN npm link inform-daemon


EXPOSE 5000


CMD ["bin/informd"]
