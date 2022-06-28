FROM python:3.11.0b3-alpine3.15

RUN apk add wget alpine-sdk sudo

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN addgroup appuser abuild

RUN echo "%abuild ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/abuild

USER appuser
WORKDIR /home/appuser

RUN abuild-keygen -a -i -n

ADD APKBUILD APKBUILD
ADD missing-int64_t.patch missing-int64_t.patch

RUN abuild checksum && abuild -r
