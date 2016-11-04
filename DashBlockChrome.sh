#!/bin/bash

./GetCertificateFromDashboard.sh

rm certificate.crt

chromium-browser --ignore-certiicate-errors http://localhost:8080
