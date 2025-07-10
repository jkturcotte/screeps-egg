FROM screepers/screeps-launcher

RUN adduser --disabled-password --home /home/container container

USER container
ENV USER=container HOME=/home/container

