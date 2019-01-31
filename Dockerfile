FROM python:3.6-slim
ENV NPM_CONFIG_LOGLEVEL warn

USER root
RUN apt-get update && apt-get -y install curl gnupg

# Install Chrome for Selenium
RUN curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /chrome.deb
RUN dpkg -i /chrome.deb || apt-get install -yf
RUN rm /chrome.deb



WORKDIR /src

RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -

RUN apt-get -y install nodejs

RUN npm install -g serve

ADD . /src

CMD serve -s build

EXPOSE 5000


RUN npm install --save

RUN npm run build



# Run apt-get remove python3-pip

# RUN apt-get install -y python python-dev python3.6 python3.6-dev python3.6-distutils

# RUN curl https://bootstrap.pypa.io/get-pip.py |  python3.6

RUN pip -V

RUN pip install setuptools pip --upgrade --force-reinstall

RUN cd pytest && pip install -r requirements.txt



CMD [ "sh", "-c", "/bin/bash ./docker-entry.sh" ]
