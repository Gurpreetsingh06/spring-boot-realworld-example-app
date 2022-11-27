#!/bin/bash
sudo apt update -y
sudo apt install software-properties-common apt-transport-https ca-certificates curl -y
sudo apt update -y
sudo apt install python3.8 -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update -y
sudo apt install git docker-ce -y
sudo usermod -aG docker ubuntu
sudo apt-get install openjdk-11-jdk -y
git clone https://github.com/Gurpreetsingh06/spring-boot-realworld-example-app.git
cd spring-boot-realworld-example-app
./gradlew bootJar
sudo docker build -t spring-boot-realworld-example-app:latest .
sudo docker run --log-driver=awslogs --log-opt awslogs-region=us-east-1 --log-opt awslogs-group=/aws/app/loggroup --name realworld-app -e MYSQL_HOST=${db_address} -e MYSQL_PORT=${db_port} -e MYSQL_USER=admin -e MYSQL_PWD=${db_password} -p 8080:8080 -d spring-boot-realworld-example-app:latest 
newgrp docker