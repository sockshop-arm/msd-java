FROM openjdk:8-alpine

ENV SERVICE_USER='myuser' \
  SERVICE_UID='10001' \
  SERVICE_GROUP='mygroup' \
  SERVICE_GID='10001'

RUN addgroup -g ${SERVICE_GID} ${SERVICE_GROUP}

RUN adduser -g "${SERVICE_NAME} user" -D -H -G ${SERVICE_GROUP} -s /sbin/nologin -u ${SERVICE_UID} ${SERVICE_USER}

RUN apk add --no-progress --update libcap

RUN mkdir /lib64

RUN ln -s /usr/lib/jvm/java-1.8-openjdk/jre/lib/aarch32/server/libjvm.so /lib/libjvm.so

RUN ln -s /usr/lib/jvm/java-1.8-openjdk/lib/aarch32/jli/libjli.so /lib/libjli.so

RUN setcap "cap_net_bind_service=+ep" $(readlink -f $(which java))

COPY java.sh /usr/local/bin/java.sh

RUN chmod +x /usr/local/bin/java.sh
