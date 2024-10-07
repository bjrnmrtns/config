#!/usr/bin/env sh
git clone https://github.com/helmfile/helmfile.git
cd helmfile
sudo go build -o /usr/local/bin/helmfile

