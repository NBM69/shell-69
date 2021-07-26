FROM node:14

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get update &&  apt-get install -y  curl lsb-release
RUN apt-get update \
    && apt-get -y install \
    --no-install-recommends \
    wget \
    mediainfo \
    neofetch \
    jq \
    aria2 \
    golang \
    python3 \
    python3-pip \
    p7zip-full \
    make \
    nginx \
    git \
    gcc \
    g++ \
    unzip \
    busybox \
    build-essential \
    gnupg2 \
    openssl \
    ffmpeg \
    zip \
    ca-certificates \
    && update-ca-certificates \
    && curl  \
    https://mega.nz/linux/MEGAsync/Debian_9.0/i386/megacmd-Debian_9.0_i386.deb \
    --output /tmp/megacmd.deb \
    && apt install /tmp/megacmd.deb -y --allow-remove-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/megacmd.*
#gdrive setup
RUN wget -P /tmp https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /tmp/go1.11.5.linux-amd64.tar.gz
RUN rm /tmp/go1.11.5.linux-amd64.tar.gz
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN go get github.com/Jitendra7007/gdrive
#ytdl
RUN pip3 install setuptools && \
pip3 install https://github.com/yt-dlp/yt-dlp/archive/master.zip
#Rclone
RUN curl https://rclone.org/install.sh | bash 
  # setup workdir
WORKDIR /bot
COPY . .
RUN npm install
CMD ["bash", "start.sh"]

