#!/bin/bash

sudo -u vagrant -H /bin/bash --login -c 'wget -q https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py -O bootstrap.py && python bootstrap.py --application-choice browser --no-interactive'