#!/bin/bash

sudo -u vagrant -H /bin/bash --login -c 'brew install python'
sudo -u vagrant -H /bin/bash --login -c 'wget https://bootstrap.pypa.io/get-pip.py'
sudo -u vagrant -H /bin/bash --login -c 'python get-pip.py'
sudo -u vagrant -H /bin/bash --login -c 'pip install compare-locales'

sudo -u vagrant -H /bin/bash --login -c 'npm -g install appdmg'
