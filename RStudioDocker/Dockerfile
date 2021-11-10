FROM rocker/verse:4.1.1

LABEL description="This is the docker container for the SocioMap RStudio"

EXPOSE 8787

RUN apt-get update

RUN  apt-get install -y --no-install-recommends \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	lsb-release \
	libxml2 \
  git

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

RUN echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
  docker-ce docker-ce-cli containerd.io

#ensures that /var/run/docker.sock exists
RUN touch /var/run/docker.sock

#changes the ownership of /var/run/docker.sock
RUN chown rstudio:docker /var/run/docker.sock

#gives  user permissions to access /var/run/docker.sock
RUN usermod -a -G docker rstudio

USER rstudio
