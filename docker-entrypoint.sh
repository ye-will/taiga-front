#!/bin/bash

export TAIGA_BACK_HOST=${TAIGA_BACK_HOST:-localhost}
export TAIGA_BACK_PORT=${TAIGA_BACK_PORT:-8000}
export TAIGA_EVENTS_HOST=${TAIGA_EVENTS_HOST:-localhost}
export TAIGA_EVENTS_PORT=${TAIGA_EVENTS_PORT:-8888}
export NGINX_PORT=${NGINX_PORT:-80}
export EVENTS_URL=$(if [ "X${USE_EVENT}" == "Xtrue" ]; then echo \"/events\"; else echo null; fi)

taiga::config() {
  if [ ! -f /etc/nginx/conf.d/default.conf ]; then
    envsubst '${TAIGA_BACK_HOST} ${TAIGA_BACK_PORT} ${TAIGA_EVENTS_HOST} ${TAIGA_EVENTS_PORT} ${NGINX_PORT}' \
      < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf
  fi
}

nginx::config() {
  if [ ! -f /taiga/taiga-front-dist/conf.json ]; then
    envsubst '$EVENTS_URL' < /taiga/taiga-front-dist/conf.json.template > /taiga/taiga-front-dist/conf.json
  fi
}

nginx::start() {
  nginx -g 'daemon off;'
}

main() {
  case "X$1" in
    "X" )
      taiga::config
      nginx::config
      nginx::start
      ;;
    * )
      echo "hello from taiga-back"
      ;;
  esac
}

main
