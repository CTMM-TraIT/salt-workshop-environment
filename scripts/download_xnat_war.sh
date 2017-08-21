#!/bin/sh
VERSION=1.7.3.1
OUTPUTDIR=/srv/salt/xnat/wars
OUTPUTFILE=$OUTPUTDIR/xnat-$VERSION.war

echo "Downloading xnat ${VERSION} to ${OUTPUTFILE}"

curl -L https://bintray.com/nrgxnat/applications/download_file?file_path=xnat-web-${VERSION}.war -o ${OUTPUTFILE}

if [ ! -f ${OUTPUTFILE} ]; then
    echo "Download was not succesful, try again or try to find the problem"
else
    echo "Download was succesful!"
fi

