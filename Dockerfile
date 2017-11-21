FROM elastest/ci-docker-compose-siblings:latest

LABEL maintainer "elastest-users@googlegroups.com"
LABEL version="0.1.0"
LABEL description="Builds a docker-in-docker image that includes python 3.6 & test requirements."

USER root

RUN python3 -V

RUN apt-get install -y python3-pip build-essential libssl-dev libffi-dev python-dev 
RUN add-apt-repository ppa:jonathonf/python-3.6 \
	&& apt-get update \
	&& apt-get install -y python3.6 libbz2-dev libreadline-dev libsqlite3-dev libevent-dev tk-dev
	
RUN pip install --upgrade pip flask_testing coverage nose pluggy py randomize tox

# RUN add-apt-repository ppa:jonathonf/python-3.6 \
#    && apt-get update \
#        && apt-get install -y python3.6 python3-pip python3.6 build-essential libbz2-dev libssl-dev libreadline-dev libsqlite3-dev tk-dev  \
#	    && update-alternatives --install /usr/bin/python python /usr/bin/python3.6 10 \
#	        && pip install --upgrade pip flask_testing coverage nose pluggy py randomize tox

RUN pip install pyyaml

ENV WORKSPACE /home/jenkins

USER jenkins 

WORKDIR ${WORKSPACE}

# launch container
ENTRYPOINT ["/bin/bash"]
