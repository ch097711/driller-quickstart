FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    build-essential libtool-bin automake bison flex libglib2.0-dev python3 python3-pip python3-dev git libssl-dev libffi-dev gcc-multilib autoconf debootstrap debian-archive-keyring git wget vim libacl1-dev

RUN sed -i '/^# deb-src /s/^# //' /etc/apt/sources.list && \
    apt-get update && \
    apt-get build-dep -y qemu

RUN pip3 install --upgrade pip
RUN pip3 install angr
RUN pip3 install cle
RUN pip3 install git+https://github.com/angr/tracer
RUN pip3 install git+https://github.com/shellphish/driller

COPY . .
RUN cd AFL && make -j$(nproc) && cd qemu_mode && ./build_qemu_support.sh

RUN gcc -o fuzz_target fuzz_target.c
ENV AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1
CMD ["./AFL/afl-fuzz", "-M", "fuzzer-master", "-i", "./input", "-o", "./output", "-Q", "./fuzz_target"]    