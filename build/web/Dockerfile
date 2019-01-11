FROM centos:7.6.1810

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

RUN yum -y update && yum clean all

RUN rm -f /etc/rpm/macros.image-language-conf && \
    sed -i '/^override_install_lang=/d' /etc/yum.conf && \
    yum reinstall -y glibc-common && \
    yum clean all

# change locale
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

# base
RUN yum install -y zlib zlib-devel gcc gcc-c++ openssh openssh-server \
    make openssl openssl-devel net-tools wget tar which tree git ntp

# httpd
RUN yum install -y httpd && \
    yum clean all && \
    systemctl enable httpd.service

# mysql-client
RUN yum install -y http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
RUN yum install -y mysql-community-client

# php7.3
RUN yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum install -y --enablerepo=remi-php73 php php-cli php-common php-devel php-gd php-mbstring php-mysqlnd php-intl

# jenkins
RUN yum install -y java-1.8.0-openjdk
RUN curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
RUN yum install -y jenkins

# start jenkins service
RUN chmod -x /etc/init.d/jenkins
COPY ./jenkins.service /etc/systemd/system/jenkins.service
RUN systemctl enable jenkins.service

# make dump db dir. jenkins uses this dir.
RUN mkdir -p /dump && \
    chmod -R 777 /dump

COPY ./php/php.ini /etc/php.ini

RUN ln -nfs /usr/share/zoneinfo/Asia/Tokyo /etc/localetime
