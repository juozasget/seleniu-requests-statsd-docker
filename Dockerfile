FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
    python3 python3-pip \
    libgconf2-4 libnss3-1d libxss1 \
    fonts-liberation libappindicator1 xdg-utils \
    software-properties-common \
    curl unzip wget \
    xvfb \
    libasound2


# Install chromedriver and google-chrome.

RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    wget https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip -d /usr/bin
RUN chmod +x /usr/bin/chromedriver

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb
RUN apt-get install -y -f

RUN pip3 install selenium
RUN pip3 install requests
RUN pip3 install pytz
RUN pip3 install statsd

ENV APP_HOME /usr/src/app

WORKDIR /$APP_HOME

COPY . $APP_HOME/

CMD tail -f /dev/null


# run application

CMD python3 h2.py
