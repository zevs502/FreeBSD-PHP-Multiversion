#!/bin/sh

dist=$(pwd)
listport="php56 php72 php73"
pecllist="${dist}/all"
peclbk="${dist}/backup"
portsdir="/usr/ports"
deystv="${1}"

if [ -z "${deystv}" ]; then
echo "Usage ./setports.sh install|remove"
else
for list in $listport
do
lsdir=$(ls -lah ${dist}/${list} | grep -v "total" | grep -v "итого" | awk '{ print $NF}' | sed 's,\.,=,' | grep -v "=")
for lscat in $lsdir
do
if [ -d "${portsdir}/${lscat}" ]; then
lsports=$(ls -lah ${dist}/${list}/${lscat} | grep -v "total" | grep -v "итого" | awk '{ print $NF}' | sed 's,\.,=,' | grep -v "=")
for mod in $lsports
do
if [ "${deystv}" == "install" ]; then
sources="${dist}/${list}/${lscat}/${mod}"
if [ -d "${sources}" ]; then
echo "Installing module: ${mod}"
echo "To destination: ${portsdir}/${lscat}/${mod}"
echo ""
cp -rf ${sources} ${portsdir}/${lscat}/${mod}

fi
fi
if [ "${deystv}" == "remove" ]; then
sources="${portsdir}/${lscat}/${mod}"
if [ -d "${sources}" ]; then
echo "Remove module: ${mod}"
echo ""
rm -rf ${sources}
fi
fi

done
fi
done
done

mkdir -p ${peclbk}
lsall=$(ls -lah ${pecllist} | grep -v "total" | grep -v "итого" | awk '{ print $NF}' | sed 's,\.,=,' | grep -v "=")
for lscat in $lsall
do

lsports=$(ls -lah ${pecllist}/${lscat} | grep -v "total" | grep -v "итого" | awk '{ print $NF}' | sed 's,\.,=,' | grep -v "=")
if [ "${deystv}" == "install" ]; then
mkdir -p ${peclbk}/${lscat}

for lspecl in $lsports
do
if [ -d "${portsdir}/${lscat}/${lspecl}" ]; then
mv -f ${portsdir}/${lscat}/${lspecl} ${peclbk}/${lscat}/${lspecl}
fi
cp -rf ${pecllist}/${lscat}/${lspecl} ${portsdir}/${lscat}/${lspecl}
done

fi

if [ "${deystv}" == "remove" ]; then

for lspecl in $lsports
do
checkport=$(cat ${portsdir}/${lscat}/${lspecl}/Makefile | grep "MAINTAINER" | awk -F "\t" '{ print $NF}')
if [ "${checkport}" == "zevs5@zevs5.ru" ]; then
rm -rf ${portsdir}/${lscat}/${lspecl}
if [ -d "${peclbk}/${lscat}/${lspecl}" ]; then
cp -rf ${peclbk}/${lscat}/${lspecl} ${portsdir}/${lscat}/${lspecl}
rm -rf ${peclbk}/${lscat}/${lspecl}
fi
fi
done

fi

done

if [ "${deystv}" == "install" ]; then
if [ ! -f "${portsdir}/Mk/Uses/phpm.mk" ]; then
echo "Installing macros: phpm.mk"
echo "To destination: ${portsdir}/Mk/Uses/"
echo ""
cp -f ${dist}/phpm.mk ${portsdir}/Mk/Uses/
else
echo "Macros: phpm.mk already exists"
fi
fi
if [ "${deystv}" == "remove" ]; then
if [ -f "${portsdir}/Mk/Uses/phpm.mk" ]; then
echo "Remove macros: phpm.mk"
echo ""
rm -f ${portsdir}/Mk/Uses/phpm.mk
else
echo "Remove macros: phpm.mk not found"
fi
fi
fi