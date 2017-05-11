#!/bin/bash

#inkrementDay="$paramday"
#****************************************)))))
#inkrementDay=$DAYS
inkrementDay=-2
date="$(date -d "$inkrementDay day" +"%Y%m%d")"

#date="$(date -d "-2 day" +"%Y%m%d")"
#date2="$("%Y%m%d%H%M%S")"
download_accesslog() {
cd /home/qateam/melloadtest
mkdir -p "$date"
FULLNAME=pablo-mel-main_$date.access.log.gz
cp /mnt/logs/nginx/nginx/$FULLNAME /home/qateam/melloadtest/$date
cd $date
gunzip -f $FULLNAME
mv -f pablo-mel-main_$date.access.log access.log
}

download_testini(){
wget /home/qateam/melloadtest/$date https://github.com/qateam2/general/archive/master.zip
unzip -j -o master.zip
rm master.zip
}

delete_lines() {
sed -i '/HTTP\/1.[0,1]\" [4,5]/d' access.log
sed -i '/300\] \"[HEAD,POST]/d' access.log
}

shuffle_lines() {
shuf access.log --output=access.log
}

yandex_tank_start() {
yandex-tank -c "conf.ini"
}

copyresults(){
find /home/qateam/melloadtest/$date -iname '*.html' -and -type f -mmin -1 -exec cp '{}' /home/qateam/Reports/publo-mel \;
}

deletefiles(){
rm -rf /home/qateam/melloadtest/$date
}

download_accesslog
download_testini
delete_lines
shuffle_lines
yandex_tank_start
copyresults
#deletefiles



exit 0