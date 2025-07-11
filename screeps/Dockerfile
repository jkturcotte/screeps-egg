FROM ghcr.io/screepers/screeps-launcher:main

ENTRYPOINT []

USER root
RUN adduser --disabled-password --home /home/container container

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chown container:container /entrypoint.sh

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container



CMD ["/bin/bash", "/entrypoint.sh"]
