## Simple run
# docker run -p 8080:80 httpbin

## Daemonize
# docker run -d -p 8080:80 httpbin

## Enabling request logging
# ref: https://github.com/postmanlabs/httpbin/issues/421
docker run -p 8080:80 -e GUNICORN_CMD_ARGS="--capture-output --error-logfile - --access-logfile - --access-logformat '%(h)s %(t)s %(r)s %(s)s Host: %({Host}i)s}'" httpbin
