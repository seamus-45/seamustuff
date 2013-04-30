#!/bin/bash
# This script check availability of network cifs shares described in .auto.cifs.shares file
# and add bookmarks to .gtk-bookmarks file
# Shares mounted with automount (autofs daemon)
# author: sr.fido@gmail.com
# ver 0.1

# run only one instance (exit - if greater than one)
if [ $(pidof -x $0 -o $$ | wc -w) -gt 1 ];
then
  echo Another instance is running.
  exit 1
fi

# file with shares we should mount
FSHARES="${HOME}/.auto.cifs.shares"
# file for store bookmarks
FBOOKS="${HOME}/.gtk-bookmarks"
# file with domain secret
FSECRET="${HOME}/.auto.cifs"
# autofs directory
DAUTOFS="/network"
# minimal length of password
PWDMIN="6"
# pause for next check
PAUSE="30s"

while true; do
  # if a regular file with shares exists
  if [[ -f ${FSHARES} ]];
  then
    # extract shares / remove unneeded spaces / convert commas to spaces
    SHARES=$(grep ^shares ${FSHARES} | sed 's@\s@@g' | awk -F'=' '{print $2}' | sed 's@,@ @g');
    # if shares not empty
    if [[ -n ${SHARES} ]];
    then
      # check autofs share availability
      for i in ${SHARES}; do
        ls $DAUTOFS/${i}:${USER} &>/dev/null;
        # if mounting cifs share not successfully
        if [[ $? != 0 ]];
        then
          # if file with domain password was created then show error message
          [[ -f ${FSECRET} ]] && zenity --error --text="Один или несколько сетевых ресурсов недоступны.\nПопробуйте ввести пароль заново.\nЕсли это не помогло, убедитесь в наличии сетевого подключения, а также, что пароль к домену верен.\n\nЕсли все условия выполнены, доступ к диску восстановится в течении ${PAUSE} секунд";
          PASSWORD=$(zenity --password --title="Доступ к сетевому диску");
          # password is defined and greater than minimal length
          if [[ ${#PASSWORD} -ge ${PWDMIN} ]];
          then
            # if file with password was not created then do it
            [[ ! -f ${FSECRET} ]] && touch ${FSECRET} && chmod 0600 ${FSECRET};
            echo -n "* ${PASSWORD}" > ${FSECRET};
            zenity --info --text="Пароль успешно изменен.";
            break;
          else
            zenity --error --text="Пароли менее чем ${PWDMIN} символов не допускаются";
            break;
          fi # PASSWORD
        # share mount successfully. check gtk-bookmarks and add bookmark if needed.
        else
          BM=$(grep ${i} ${FBOOKS});
          # bookmark not found
          if [[ -z ${BM} ]];
          then
            BNAME=$(echo ${i} | awk -F':' '{print $2}');
            echo "file://${DAUTOFS}/${i}:${USER} ${BNAME}" >> ${FBOOKS};
          fi
        fi # mounting cifs
      done # check autofs
    fi # SHARES
  fi # FSHARES
  # wait for next check
  sleep ${PAUSE};
done # main loop

