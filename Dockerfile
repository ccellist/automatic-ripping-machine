FROM debian:bullseye-backports
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt update && apt install -y vim
RUN ex -c "%s/main$/main contrib non-free/g" -c "wq" /etc/apt/sources.list
RUN apt update && apt install -yqq wget supervisor file apt-utils
COPY scripts/deb-install-quiet.sh ./
RUN chmod +x deb-install-quiet.sh
RUN ./deb-install-quiet.sh
COPY scripts/arm_listener.sh /opt/arm/scripts
RUN chmod +x /opt/arm/scripts/arm_listener.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
EXPOSE 8080
