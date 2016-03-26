FROM debian:jessie
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && apt-get update && apt-get install -y --no-install-recommends \
gcc libc6-dev make vim
ADD fcron-3.2.0.src.tar.gz /
WORKDIR /fcron-3.2.0
RUN ./configure --prefix=/usr          \
            --sysconfdir=/etc      \
            --localstatedir=/var   \
            --with-sendmail=no     \
            --with-boot-install=no \
            --with-systemdsystemunitdir=no \
            --with-editor=/usr/bin/vim \
            --with-pam=no \
            --with-selinux=no \
            --with-fcrondyn=no \
            && make && make install
CMD fcrontab /etc/fcrontab && fcron -f --nosyslog

ADD test.fcrontab /etc/fcrontab