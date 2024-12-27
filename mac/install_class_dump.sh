#!/usr/bin/env bash

wget -qO- http://stevenygard.com/download/class-dump-3.5.tar.gz | sudo tar xvz - -C /usr/local/bin

sudo cp /usr/local/bin/class-dump*/class-dump /usr/local/bin/
