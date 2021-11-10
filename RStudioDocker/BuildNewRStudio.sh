# script to build rstudio docker for SocioMap

docker build -t rstudio ./RStudioDocker/.;

docker run \
    --name=rstudio \
    -d \
    --publish=8787:8787 \
    --volume=$HOME/SocioMapDocker/data:$HOME/SocioMap \
    --restart unless-stopped \
    -e PASSWORD=SM@8172020 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    rstudio;

docker cp ~/.gitconfig rstudio:/home/rstudio;

docker cp ~/.ssh rstudio:/home/rstudio;

git glone git@github.com:bischrob/SocioMap.git;

useradd rstudio

usermod -aG docker rstudio

usermod -aG sudo rstudio

