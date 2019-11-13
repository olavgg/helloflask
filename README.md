# helloflask
Docker example with a hello world flask application, uwsgi and nginx with self signed SSL certificate


# TO BUILD: 
`sudo docker build -t helloflask .`
# TO RUN: 
`sudo docker run -it --name helloflask -p 80:80 -p 443:443 --rm helloflask`
