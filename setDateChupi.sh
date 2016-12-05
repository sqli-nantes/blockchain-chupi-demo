#!/bin/bash

ssh pi@10.42.0.61 sudo date -s @`(date -u +"%s")`
