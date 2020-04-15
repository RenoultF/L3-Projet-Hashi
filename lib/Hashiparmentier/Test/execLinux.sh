#!/bin/bash

\curl -sSL https://get.rvm.io | bash
rvm install ruby-2.6.3
gem install activerecord
gem install gtk3

exec "./TestFenetre.rb"
