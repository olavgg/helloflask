# TO BUILD: sudo docker build -t helloflask .
# TO RUN: sudo docker run -it --name helloflask -p 80:80 -p 443:443 --rm helloflask

FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get install -y \
	python3-pip \
	python3-dev \
	build-essential \
	uwsgi \
	nginx \
	uwsgi-plugin-python3 \
	openssl

COPY start.sh /usr/local/bin/

# Configure nginx
ADD nginx.conf /etc/nginx/
ADD helloflask.conf /etc/nginx/sites-available/
RUN rm /etc/nginx/sites-enabled/default
RUN ln -sf /etc/nginx/sites-available/helloflask.conf \
        /etc/nginx/sites-enabled/helloflask.conf

# Create self signed certificate
ADD generate_ssl_key.sh /usr/local/bin/
RUN /usr/local/bin/generate_ssl_key.sh example.org
RUN mv cert.pem /etc/ssl/certs/
RUN mv key.pem /etc/ssl/private/

# Install python dependicies
RUN python3 -m pip install flask

# Copy application
COPY helloflask /opt/helloflask

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["start.sh"]


