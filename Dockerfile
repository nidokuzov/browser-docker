FROM alpine:3.3
MAINTAINER Simen Huuse - itelligence / NTT Data // Thanks to Alex Bordei - Bigstep Inc.
LABEL Simen Huuse - itelligence / NTT Data // Thanks to Alex Bordei - Bigstep Inc.

run apk add --update darkhttpd && rm -rf /var/cache/apk/*

ADD index.html /var/www/localhost/htdocs/index.html
ADD entrypoint.sh /entrypoint.sh
ADD sapcloudplatform.png /var/www/localhost/htdocs/sapcloudplatform.png
ADD nttdata.png /var/www/localhost/htdocs/nttdata.png
ADD git.gif /var/www/localhost/htdocs/git.gif
ADD docker.jpg /var/www/localhost/htdocs/docker.jpg

RUN wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | sudo apt-key add - \
 && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
 && mkdir ~/.gnupg \
 && gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys ${TOR_FINGERPRINT} \
 && gpg --fingerprint ${TOR_FINGERPRINT} | grep -q "Key fingerprint = EF6E 286D DA85 EA2A 4BA7  DE68 4E2C 6E87 9329 8290" \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y xz-utils file locales dbus-x11 pulseaudio dmz-cursor-theme curl \
      fonts-dejavu fonts-liberation hicolor-icon-theme \
      libcanberra-gtk3-0 libcanberra-gtk-module libcanberra-gtk3-module \
      libasound2 libglib2.0 libgtk2.0-0 libdbus-glib-1-2 libxt6 libexif12 \
      libgl1-mesa-glx libgl1-mesa-dri libstdc++6 nvidia-346 \
      gstreamer-1.0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
      gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav \
      google-chrome-stable chromium-browser firefox \
&& update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX \



EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
