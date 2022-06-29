FROM python:3.11.0b3-alpine3.15

RUN apk add wget alpine-sdk sudo python3-dev

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN addgroup appuser abuild

RUN cp /usr/include/python3.9/*.h /usr/include/

RUN echo "%abuild ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/abuild

USER appuser
WORKDIR /home/appuser

RUN abuild-keygen -a -i -n

ADD APKBUILD APKBUILD
ADD missing-int64_t.patch missing-int64_t.patch
ADD numpy-1.22.3-cp311-cp311-linux_x86_64.whl numpy-1.22.3-cp311-cp311-linux_x86_64.whl
RUN pip3 install cython Tempita
RUN pip3 install ./numpy-1.22.3-cp311-cp311-linux_x86_64.whl
RUN pip3 install pybind11==2.9.2

RUN abuild checksum && abuild -r
