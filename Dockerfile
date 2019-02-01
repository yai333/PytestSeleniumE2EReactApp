FROM ubuntu
USER root

ENV BUNDLE_SILENCE_ROOT_WARNING=1

RUN apt-get update && apt-get -y install curl gnupg unzip wget

# Install Nginx.
RUN set -ex && \
  apt-get install -y  software-properties-common && \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  chown -R www-data:www-data /var/lib/nginx


# Set the Chrome repo.
RUN wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Install Chrome.
RUN apt-get update && apt-get -y install google-chrome-stable

# Install nodejs
RUN wget -qO - https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get -y install nodejs

WORKDIR /src
ADD . /src

# Build react app
RUN npm install --save
RUN npm run build
RUN cp -rf build/. /var/www/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


# Install python3.6
RUN apt-get install -y python python-dev python3.6 python3.6-dev python3.6-distutils
RUN curl -sL https://bootstrap.pypa.io/get-pip.py |  python3.6
RUN pip -V

# Chrome Driver
RUN mkdir -p /opt/selenium \
    && wget -q http://chromedriver.storage.googleapis.com/2.45/chromedriver_linux64.zip -O /opt/selenium/chromedriver_linux64.zip \
    && cd /opt/selenium; unzip /opt/selenium/chromedriver_linux64.zip; rm -rf chromedriver_linux64.zip; ln -fs /opt/selenium/chromedriver /usr/local/bin/chromedriver;

# Install python dependencies
RUN pip install setuptools pip --upgrade --force-reinstall
RUN cd pytest && pip install -r requirements.txt

CMD [ "sh", "-c", "/bin/bash ./docker-entry.sh" ]
