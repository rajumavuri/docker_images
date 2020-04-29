#!/bin/bash

JENKINS_MASTER=jenkins-master
JENKINS_PORT=8080
JENKINS_VOLUME=jenkins_volume
JENKINS_NETWORK=jenkins_network
SLAVES=(ruby python)

# check if jenkins master running and stop if it is and remove the container
if docker ps | grep $JENKINS_MASTER > /dev/null; then
  docker stop $JENKINS_MASTER
  docker rm $JENKINS_MASTER
fi

# handling the slave containers
for slave in "${SLAVES[@]}"
do
  docker stop "$slave"_node
  docker rm "$slave"_node
done

# check if jenkins volume exists. ask user if it is allowed to delete the volume and create new volume
if docker volume inspect $JENKINS_VOLUME > /dev/null; then
  read -p "Docker volume $JENKINS_VOLUME already exists. Do you want to delete and recreate it? [Y/n] " prompt_volume
  if [ $prompt_volume == "y" ]; then
    docker volume rm $JENKINS_VOLUME
    docker volume create $JENKINS_VOLUME
  fi
fi

# check if jenkins network exists. ask user if it is allwoed to delete and create new network
if docker network inspect $JENKINS_NETWORK > /dev/null; then
  read -p "Docker network inspect $JENKINS_NETWORK already exists. Do you want to delete and recreate it? [Y/n] " prompt_network 
  if [ $prompt_network == "y" ]; then
    docker network rm $JENKINS_NETWORK
    docker network create $JENKINS_NETWORK
  fi
fi

# creating a new jenkins environment with nodes
git pull origin master

# building the images. if you have any custom nodes, build here
docker build -t jenkins ./jenkins/master
docker build -t ruby_node ./jenkins/slaves/ruby
docker build -t python_node ./jenkins/slaves/python

# running jenkins docker
docker run -d --name $JENKINS_MASTER --network $JENKINS_NETWORK -p $JENKINS_PORT:8080 -p 50000:50000 -v $JENKINS_VOLUME:/var/jenkins_home jenkins:latest

# giving sometime to finish the setup
sleep 30

# running nodes and attaching to master
rm *.txt

for slave in "${SLAVES[@]}"
do
  docker cp $JENKINS_MASTER:/var/jenkins_home/$slave.txt $PWD/$slave.txt
  if [[ "$slave" =~ .*ruby.* ]]
  then
    docker run -d --name "$slave"_node --network $JENKINS_NETWORK \
      -e JENKINS_URL=http://$JENKINS_MASTER:8080 \
      -e JENKINS_SECRET=$secret_ruby \
      -e JENKINS_AGENT_NAME=$slave ruby_node:latest
  elif [[ "$slave" =~ .*python.* ]]
    docker run -d --name "$slave"_node --network $JENKINS_NETWORK \
      -e JENKINS_URL=http://$JENKINS_MASTER:8080 \
      -e JENKINS_SECRET=$secret_ruby \
      -e JENKINS_AGENT_NAME=$slave python_node:latest
  fi
done
