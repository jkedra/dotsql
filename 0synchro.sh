#!/bin/bash

ssh-add /shared_apps/home/jerzy/.ssh/id_dsa

for i in 1 2 3 4; do
	echo drac0${i}
	scp -q * oracle@drac0${i}:.sql/j
done

for i in 1 2 3 4; do
	echo oracprod$i
	scp -q * oracle@oracprod0${i}:.sql/j
done

echo emdb2
scp -q * oracle@emdb2:.sql




