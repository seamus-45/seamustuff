#!/bin/bash
# Author: sr.fido@gmail.com
# Thanks http://habrahabr.ru/users/mizrael_666 for idea
# Distributed under the terms of the GNU General Public License v3
# 29/04/13 - Fix script for new site structure.

SRC="/tmp/2gis-install-${USERNAME}"
WINEPREFIX="${HOME}/.wine-2gis"
PREFIX="${WINEPREFIX}/drive_c/Program Files"
EXE="${PREFIX}/2gis/3.0/grym.exe"

# if key --run and executable exists, then run 2gis.
if [ "$1" == "--run" ];
then
  if [ -e "${EXE}" ]; 
  then
    env WINEPREFIX=${WINEPREFIX} wine "${EXE}" &
    exit 0
  fi
fi

# create work directory if not exists
mkdir -p "${SRC}"

# delete day old archives
find ${SRC} -name \* -mtime +1 -delete;

wget -O - 'http://2gis.ru/' 2>/dev/null |\
grep "choose_city" | sed "s@^\s*@@g" |\
sed "s@.*\"\(http://.*2gis.ru\)\".*>\(.*\)<\/a.*\$@FALSE\n\2\n\1\/how-get\/linux\/@g" | uniq |\
zenity --list \
	--checklist \
	--height=600 \
	--width=500 \
	--separator='\n' \
	--print-column=3 \
	--title="Обновление ДубльГИС" \
	--text="Выберите город из списка ниже" \
	--column="" \
	--column="Город" \
	--column="Ссылка URL" |\
xargs wget -p -O - 2>/dev/null |\
grep "last\/linux" | sort |\
sed "s|^.*\(http://.*/last/linux/\).*$|\1|g" | uniq |\
xargs -I {} sh -c "wget -c --trust-server-names -N -P"${SRC}" {} 2>&1 |\
	sed -u 's/\ \+[0-9KMB]\+[\ \.]\+\([0-9]\+\)%\ \+[0-9,KMB]\+\ \([0-9hms]\+\)$/\1\n# \1% Осталось: \2/' |\
	zenity --progress --title='Загрузка обновлений...' --auto-close --text=''" &&
mkdir -p "${PREFIX}" &&
unzip -o "${SRC}/*.zip" -d "${PREFIX}"  2>/dev/null | zenity --progress --pulsate --no-cancel --auto-close --title='Установка ДубльГИС'

if [ -e "${EXE}" ];
then
  zenity --info --text='Установка завершена.'
  # if key --run exists, then run 2gis
  [[ "$1" == "--run" ]] && env WINEPREFIX=${WINEPREFIX} wine "${EXE}" &
  exit 0
else
  zenity --error --text='Неизвестная ошибка.'
  exit 1
fi
