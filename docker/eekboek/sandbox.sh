#!/usr/bin/env bash
set -eu

print_error() {
  echo "ERROR"
}
trap print_error ERR

if [ ! -e "config" ]; then
  echo "There is no config file."
  exit 1
fi

. config

docker_options="
 --rm
 -it
 -e HOME=/home/${USER}
 -e USER=${USER}
 -v /home/${USER}/projects/personal/Documents/expeditious/Accounting:/home/${USER}/accounting:rw
 -v /home/${USER}:/home/${USER}:rw
 -v /etc/group:/etc/group:ro
 -v /etc/passwd:/etc/passwd:ro
 -u `id -u`:`id -g`
 -w /home/${USER}
"

docker run ${docker_options} eekboek:latest 
exit $?
