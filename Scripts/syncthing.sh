#!/usr/bin/env bash

SYNCTHING_VERSION=1.29.7
SYNCTHING_PATH=/media/fat/Scripts/.config/syncthing

export STCONFDIR=${SYNCTHING_PATH}
export STDATADIR=${SYNCTHING_PATH}/data

install() {
  [[ -d ${SYNCTHING_PATH} ]] || mkdir -p ${SYNCTHING_PATH}
  if ! [[ -f "${SYNCTHING_PATH}/syncthing" ]]; then
    wget \
      -O/tmp/syncthing.tar.gz \
      https://github.com/syncthing/syncthing/releases/download/v${SYNCTHING_VERSION}/syncthing-linux-arm-v${SYNCTHING_VERSION}.tar.gz
    tar xf /tmp/syncthing.tar.gz -C /tmp
    cp /tmp/syncthing-linux-arm-v${SYNCTHING_VERSION}/syncthing ${SYNCTHING_PATH}
    STGUIADDRESS=0.0.0.0:8384 ${SYNCTHING_PATH}/syncthing generate
    rm /tmp/syncthing.tar.gz
  fi
  if ! grep -q "# davewongillies/syncthing" /media/fat/linux/user-startup.sh ; then
    echo Adding syncthing.sh to user-startup.sh
    echo '
# davewongillies/syncthing
[[ -e /media/fat/Scripts/syncthing.sh ]] && /media/fat/Scripts/syncthing.sh $1 &' >> /media/fat/linux/user-startup.sh
  fi

}

start() {
  ${SYNCTHING_PATH}/syncthing serve --logfile=/var/log/syncthing.log > /dev/null 2>&1 &
}

stop() {
  ${SYNCTHING_PATH}/syncthing cli operations shutdown
}

restart() {
  ${SYNCTHING_PATH}/syncthing cli operations restart
}

main() {
  install
  $1
}

main "${@}"
