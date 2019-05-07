############################################################
# Supervisord service
############################################################

FROM  trobz/ubuntu:16.04

MAINTAINER Michel Meyer <mmeyer@trobz.com> Nguyen Duc Tam <nguyenductamlhp@gmail.com>

# Install common dependencies
############################################################

RUN apt-get install -y supervisor

# supervisor

COPY config/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir -p /var/run/supervisor
RUN mkdir -p /var/log/supervisor

# Finalization
############################################################

VOLUME ["/var/log/supervisor"]

EXPOSE 8011

ONBUILD RUN apt-get update
ONBUILD RUN apt-get upgrade -y
ONBUILD RUN updatedb

# configure supervisord
ADD scripts/start/init/05_supervisord.sh /usr/local/docker/start/init/05_supervisord.sh

# run supervisord
ADD scripts/start/run.sh /usr/local/docker/start/run.sh
