# Day 08 – Cloud Server Setup: Docker, Nginx & Web Deployment

## Objective

Successfully launched a cloud server on AWS EC2, connected using SSH, installed Docker and Nginx, configured security groups, and extracted Nginx logs.

---

## Commands Used

```bash
ssh -i day08.pem ubuntu@52.32.44.80

sudo apt update && sudo apt upgrade -y

sudo apt install docker.io -y
docker --version
sudo systemctl start docker
sudo systemctl enable docker

sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx

sudo cat /var/log/nginx/access.log

sudo cp /var/log/nginx/access.log ~/nginx-logs.txt