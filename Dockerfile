FROM ubuntu:14.04
MAINTAINER Tommaso Visconti <tommaso.visconti@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && apt-get install -y wget apache2 supervisor libcrypt-ssleay-perl libencode-hanextra-perl libgd-gd2-perl libgd-text-perl libgd-graph-perl libjson-xs-perl liblwp-useragent-determined-perl libmail-imapclient-perl libapache2-mod-perl2 libnet-dns-perl libnet-ldap-perl libpdf-api2-perl libtext-csv-xs-perl libxml-parser-perl libyaml-perl libcrypt-eksblowfish-perl libyaml-libyaml-perl libnet-ldap-perl mysql-server fetchmail

# Supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Begin MySQL server setup
RUN sed -i -e"s/^key_buffer\s*=\s*16M/key_buffer_size=32M/" /etc/mysql/my.cnf
RUN sed -i -e"s/^max_allowed_packet\s*=\s*16M/max_allowed_packet=32M/" /etc/mysql/my.cnf
ADD otrs/database.sql /root/database.sql
RUN /usr/sbin/mysqld & \
    sleep 10s &&\
    echo "CREATE DATABASE otrs; GRANT ALL ON otrs.* TO 'otrs'@'localhost' IDENTIFIED BY 'g5eE94BaP' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql &&\
    mysql -u root -D otrs < /root/database.sql &&\
    rm /root/database.sql
# End MySQL server setup

# OTRS
RUN wget http://ftp.otrs.org/pub/otrs/otrs-3.3.7.tar.bz2
RUN tar -C /opt -xjf otrs-3.3.7.tar.bz2 && rm otrs-3.3.7.tar.bz2 && mv /opt/otrs-3.3.7 /opt/otrs
RUN useradd -r -d /opt/otrs -c 'OTRS service user' otrsserviceuser
RUN usermod -G nogroup otrsserviceuser
ADD otrs/Config.pm /opt/otrs/Kernel/Config.pm
RUN cd /opt/otrs/Kernel/Config && cp GenericAgent.pm.dist GenericAgent.pm
RUN cd /opt/otrs/var/cron && for foo in *.dist; do cp $foo `basename $foo .dist`; done
RUN cd /opt/otrs/bin && ./otrs.SetPermissions.pl /opt/otrs --otrs-user=otrsserviceuser --otrs-group=nogroup --web-user=www-data --web-group=www-data
RUN ln -s /opt/otrs/scripts/apache2-httpd.include.conf /etc/apache2/conf-enabled/otrs.conf

# ITSM with MySQL server
RUN /usr/sbin/mysqld & \
    sleep 10s &&\
    cd /opt/otrs && wget http://ftp.otrs.org/pub/otrs/itsm/bundle33/ITSM-3.3.7.opm && chown otrsserviceuser:nogroup /opt/otrs/ITSM-3.3.7.opm && su otrsserviceuser -c "/opt/otrs/bin/otrs.PackageManager.pl -a install -p /opt/otrs/ITSM-3.3.7.opm" && rm /opt/otrs/ITSM-3.3.7.opm && cd /opt/otrs/bin && ./otrs.SetPermissions.pl /opt/otrs --otrs-user=otrsserviceuser --otrs-group=nogroup --web-user=www-data --web-group=www-data

# ITSM without MySQL server
# RUN cd /opt/otrs && wget http://ftp.otrs.org/pub/otrs/itsm/bundle33/ITSM-3.3.7.opm && chown otrsserviceuser:nogroup /opt/otrs/ITSM-3.3.7.opm && su otrsserviceuser -c "/opt/otrs/bin/otrs.PackageManager.pl -a install -p /opt/otrs/ITSM-3.3.7.opm" && rm /opt/otrs/ITSM-3.3.7.opm && cd /opt/otrs/bin && ./otrs.SetPermissions.pl /opt/otrs --otrs-user=otrsserviceuser --otrs-group=nogroup --web-user=www-data --web-group=www-data

# Set OTRS cron jobs
su otrsserviceuser -c "/opt/otrs/bin/Cron.sh start"

# Begin SSH server setup
ENV ROOT_PWD s3cr3t
RUN apt-get install -y openssh-server pwgen
RUN mkdir -p /var/run/sshd
ADD sshd_config /etc/ssh/sshd_config
RUN echo "root:$ROOT_PWD" | chpasswd
# End SSH server setup

RUN apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

EXPOSE 22 80

CMD ["/usr/bin/supervisord"]
