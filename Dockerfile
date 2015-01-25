# jenkins
#
# VERSION: see `TAG` 
FROM jenkins:latest
MAINTAINER Joao Paulo Dubas "joao.dubas@gmail.com"

USER root
RUN groupadd -g 999 docker \
    && usermod -aG sudo,docker jenkins \
    && passwd -d jenkins \
    && ssh-keyscan -H github.com >> /etc/ssh/ssh_kwnow_hosts

RUN apt-get -y -qq --force-yes update \
    && apt-get -y -qq --force-yes install \
        build-essential \
        python-setuptools \
        python-dev \
        sudo \
    && easy_install pip

RUN pip install \
        paramiko==1.15.2 \
        PyYAML==3.11 \
        Jinja2==2.7.3 \
        httplib2==0.9 \
        docker-py==0.7.1 \
    && pip install ansible==1.8.2

USER jenkins
COPY ./jenkins/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
VOLUME ["/tmp/jenkins"]
