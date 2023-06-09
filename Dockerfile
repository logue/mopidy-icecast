FROM python:slim-bullseye

LABEL description="Mopidy Radio"
LABEL version="0.0"
LABEL auhor="Logue"

ENV PUID="${PUID:-1000}"
ENV PGID="${PGID:-1000}"
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /mopidy

# Update latest
RUN apt update && apt upgrade -y

# Register Mopidy registory
RUN apt install wget -y \
  && mkdir -p /etc/apt/keyrings \
  && wget -q -O /etc/apt/keyrings/mopidy-archive-keyring.gpg https://apt.mopidy.com/mopidy.gpg \
  && wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/bullseye.list \
  && apt update && apt upgrade -y

# Install Dependencies
RUN apt install -y \
  alsa-utils \
  darkice \
  icecast2 \
  lame \
  nano \
  pulseaudio \
  python3-pip \
  # Main
  mopidy \
  mopidy-alsamixer \
  mopidy-beets \
  mopidy-dleyna \
  mopidy-doc \
  mopidy-internetarchive \
  mopidy-local \
  mopidy-mpd \
  mopidy-mpris \
  mopidy-podcast \
  mopidy-podcast-itunes \
  mopidy-scrobbler \
  mopidy-somafm \
  mopidy-soundcloud \
  mopidy-spotify \
  mopidy-tunein

# Install Mopidy Extensions
RUN pip install \
  Mopidy-Iris \
  Mopidy-WebSettings \
  Mopidy-YouTube \
  Mopidy-YTMusic

# Update latest
RUN apt update && apt upgrade -y
# Create media directory
RUN mkdir -p /media && chmod 0777 /media
# Create Mopidy data directory
RUN mkdir -p /data && chmod 0777 /data

# Setup icecast2
RUN sed "s/^load-module module-console-kit/#load-module module-console-kit/" -i /etc/pulse/default.pa \
  && sed "s/ENABLE=false/ENABLE=true/" -i /etc/default/icecast2 \
  && useradd -u 1000 -m -d /home/user -s /bin/sh user \
  && usermod -aG audio user
ADD ./conf/icecast.xml /etc/icecast2/icecast.xml
ADD ./conf/silence.mp3 /usr/share/icecast2/web/silence.mp3

# Setup Scrpts
ADD ./scripts/start.sh /bin/start.sh
ADD ./scripts/custom_boot.sh /data/custom_boot.sh

# Add Config files
COPY ./conf/mopidy.conf /data/mopidy.conf
COPY ./conf/darkice.cfg /data/darkice.cfg

EXPOSE 1780 6600 6680 8337 20300
VOLUME ["/media", "/data"]
ENTRYPOINT [ "/bin/start.sh" ]
