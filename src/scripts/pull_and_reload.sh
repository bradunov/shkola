#!/bin/bash

pushd .
cd /home/bozidar/shkola/src
git pull > /home/bozidar/crout.txt

if grep -q "Already " /home/bozidar/crout.txt
then 
    echo "No new files" >> /home/bozidar/crout.txt
else
    echo "New files - sending reload" >> /home/bozidar/crout.txt
    sleep 5
    wget -qO- http://shkola.majstor.org:8080/reload &> /dev/null
fi

popd

