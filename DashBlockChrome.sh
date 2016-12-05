#!/bin/bash

echo -ne '\033]0;DASHBOARD-GUI\007'

./GetCertificateFromDashboard.sh

rm certificate.crt

chromium-browser --ignore-certiicate-errors http://localhost:8080
