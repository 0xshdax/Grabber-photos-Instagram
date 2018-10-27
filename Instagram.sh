#!/bin/bash
# Rafsanazani Suhada - ZeroByte.ID
# Instagram Photos Downloader 
# Tested on Ubuntu 16.04

HIJAU='\033[0;32m'
MERAH='\033[01;31m'
NORMAL='\033[0m'
CYAN='\033[0;36m'
BIRU='\033[0;34m'
PUTIH='\033[1;37m'
printf ${MERAH}
echo "    ____                      ____  __________"
echo "   / __ \____ _      ______  / __ \/  _/ ____/"
echo "  / / / / __ \ | /| / / __ \/ /_/ // // / __  "
printf ${PUTIH}
echo " / /_/ / /_/ / |/ |/ / / / / ____// // /_/ /  "
echo "/_____/\____/|__/|__/_/ /_/_/   /___/\____/   "
echo "";
yOLo_Downloader() {
	read -p " Masukan URL Photos Instagram : " URLi # Example : https://www.instagram.com/p/BngvUsvgYbO/
	cCharU=$(echo $URLi | wc -c)
	gUname=$(curl -s -L ${URLi} | grep -Po '(?<=username":").*?(?=")' | sed -e '$!d');
	if [[ $cCharU =~ '41' ]]; then
		uRLpD=$(curl -s "${URLi}" | grep -Po '(?<=display_url":").*?(?=")')
		wget ${uRLpD} -O "${gUname}_.jpg" > /dev/null 2>&1
		printf ${HIJAU}
		echo -ne "   [OK] Download . . . . "
		sleep 2s
		echo ". . . . Done"
		echo "Result Photos ${gUname}_.jpg"
	else
		echo "Masukan URL Photos Instagram";
		echo "Example : https://www.instagram.com/p/BngvUsvgYbO/"
	fi		
}
SmUa_Downloader() {
	read -p " Masukan Username Instagram : " uSerIG # Example : rsuhada.99
	wCekuSer=$(curl -s -L "https://www.instagram.com/${uSerIG}/")
	if [[ $wCekuSer =~ 'Page Not Found &bull; Instagram' ]]; then
		printf ${MERAH}"  [INVALID]${NORMAL} Username ${PUTIH}${uSerIG}${NORMAL} Not Found!\n";
	elif [[ $wCekuSer =~ 'is_private":true' ]]; then
		printf ${MERAH}"  [INVALID]${NORMAL} Username ${PUTIH}${uSerIG}${NORMAL} Account Private!\n";
	else
		mkdir -p ${uSerIG}
		printf ${HIJAU}"  [VALID]${NORMAL} Username ${PUTIH}${uSerIG}\n"
		curl -s "https://www.instagram.com/${uSerIG}/" | grep -Po '(?<="display_url":")[^",]*' >> tmp_list-url-photos.txt
		sleep 2s
		start=1;
		cekr=1;
		for uRLpD in $(cat tmp_list-url-photos.txt); do
			wget ${uRLpD} -O "${uSerIG}/${uSerIG}_$((start++)).jpg" > /dev/null 2>&1
			if [[ $(ls ${uSerIG}) =~ "${uSerIG}_$((cekr++)).jpg" ]]; then
				printf ${HIJAU}
				echo -ne "   [OK] Download . . . . "
				sleep 2s
				echo ". . . . Done"
			fi
		done
		printf ${NORMAL}
		rm tmp_list-url-photos.txt
		echo "Result Photos in folder ${uSerIG}"
	fi
}
printf ${CYAN}
echo " 1. Download Instagram Photos [Use Link Photos IG]";
echo " 2. Download All Instagram Photos [Use Username + Get 12 Photos ]";
printf ${NORMAL}
read -p "Pilih? " pIlIH
if [[ $pIlIH =~ '1' ]]; then
	printf ${PUTIH}
	echo -ne "[*] Please wait . . . "
	sleep 1.30s
	echo " . . . [*]"
	printf ${NORMAL}
	yOLo_Downloader
elif [[ $pIlIH =~ '2' ]]; then
	printf ${PUTIH}
	echo -ne "[*] Please wait . . . "
	sleep 1.30s
	echo " . . . [*]"
	printf ${NORMAL}
	SmUa_Downloader
else
	printf ${MERAH}
	echo "[!] Please choose 1 or 2 [!]";
	printf ${NORMAL}
fi
