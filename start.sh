#!/usr/bin/env sh

service nginx start && uwsgi \
    --uid www-data \
    -s /tmp/uwsgi.sock \
    --plugins python3 \
    --pidfile /var/run/uwsgi.pid \
    --wsgi-file helloflask.py \
    --callable app \
    -M -p 4 \
    --chdir /opt/helloflask \
    --python-path /opt/helloflask \
    --harakiri 30 \
    --die-on-term


