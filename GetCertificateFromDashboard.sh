#!/bin/bash

sudo docker exec dashblock cat /home/httpserver/offline_chart/certificates/certificate.crt > certificate.crt

certutil -d sql:$HOME/.pki/nssdb -A -t "C,," -n "webmail" -i certificate.crt

#echo "========================================================="
#echo "A certificate normally appeared on the desktop"
#echo "Import it into chrome/chromium browser"
#echo "---------------------------------------------------------"
#echo "Url : chrome://settings/certificates"
#echo "      Go to authoritiy then import, choose the file"
#echo "========================================================="
#echo ""
#echo "Press Enter To Continue"

#read a
