FROM alpine:3.12
RUN apk --update add unbound \
&& rm -rf /var/cache/apk/*
COPY unbound.conf.ORIG /etc/unbound/unbound.conf
COPY localrecords.example /etc/unbound/localrecords.conf
COPY entrypoint.sh /entrypoint.sh
EXPOSE 53/udp
EXPOSE 53/tcp
ENTRYPOINT ["/entrypoint.sh"]
CMD ["unbound","-d"]
