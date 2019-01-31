FROM ubuntu:18.04

USER root
RUN apt-get update && apt-get -y install curl gnupg

# Install Nginx.
RUN \
  apt-get install -y  software-properties-common && \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

CMD ["nginx"]
EXPOSE 80

# Install Chrome for Selenium
RUN curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /chrome.deb
RUN dpkg -i /chrome.deb || apt-get install -yf
RUN rm /chrome.deb


# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get -y install  nodejs

WORKDIR /src
ADD . /src

# Build react app
RUN npm install --save
RUN npm run build
RUN cp -rf build /var/www/html

# Install python3.6
RUN apt-get install -y python python-dev python3.6 python3.6-dev python3.6-distutils
RUN curl https://bootstrap.pypa.io/get-pip.py |  python3.6
RUN pip -V

# Install python dependencies
RUN pip install setuptools pip --upgrade --force-reinstall
RUN cd pytest && pip install -r requirements.txt


# CMD [ "sh", "-c", "/bin/bash ./docker-entry.sh" ]
