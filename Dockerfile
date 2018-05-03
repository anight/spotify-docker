FROM ubuntu:16.04

RUN apt-get update

RUN apt-get install -y curl gnupg apt-transport-https

RUN echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410

RUN apt-get update && apt-get install -y spotify-client

ARG user="n/a"
ARG group="n/a"
ARG uid="n/a"
ARG gid="n/a"
ARG video_gid="n/a"
ARG audio_gid="n/a"

RUN groupmod -g ${gid} ${group}
RUN userdel www-data
RUN groupmod -g ${video_gid} video
RUN groupmod -g ${audio_gid} audio
RUN useradd -m -u ${uid} -g ${group} -G ${video_gid},${audio_gid} ${user}

USER ${user}
ENV HOME /home/${user}
CMD /usr/bin/spotify

