#!/bin/bash


cd data && find . \! -name '.gitkeep' | xargs rm -r
cd ..

vagrant destroy -f
vagrant up
