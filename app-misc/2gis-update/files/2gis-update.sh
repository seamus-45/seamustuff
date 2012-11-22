#!/bin/bash
# Author: sr.fido@gmail.com
# Thanks http://habrahabr.ru/users/mizrael_666 for idea
# Distributed under the terms of the GNU General Public License v3

SRC="/tmp/2gis-install-${USER}"
WINEPREFIX="${HOME}/.wine-2gis"
PREFIX="${WINEPREFIX}/drive_c/Program Files"
mkdir -p "${SRC}"

wget -O - 'http://www.2gis.ru/how-get/linux/' 2>/dev/null |\
grep "how-get\/linux" | sort |\
sed "s|^.*\(http://.*/how-get/linux/\).*\" \?>\([[:alpha:]]\+\ \?[[:alpha:]]\+\).*$|FALSE\n\2\n\1|g" | uniq |\
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
xargs -I {} sh -c "wget --trust-server-names -N -P"${SRC}" {} 2>&1 |\
	sed -u 's/\ \+[0-9KMB]\+[\ \.]\+\([0-9]\+\)%\ \+[0-9,KMB]\+\ \([0-9hms]\+\)$/\1\n# \1% Осталось: \2/' |\
	zenity --progress --title='Загрузка обновлений...' --auto-close --text=''" &&
mkdir -p "${PREFIX}" &&
unzip -o "${SRC}/*.zip" -d "${PREFIX}"  2>/dev/null | zenity --progress --pulsate --no-cancel --auto-close --title='Установка ДубльГИС'

if [ -e "${PREFIX}/2gis/3.0/grym.exe" ];
then
  zenity --info --text='Установка завершена.'
  exit 0
else
  zenity --error --text='Неизвестная ошибка.'
  exit 1
fi
