#!/bin/bash

echo "Time to make a deb file!"

if ! gem spec fpm > /dev/null 2>&1; then
    echo "Gem fpm is not installed! installing!"
    sudo gem install fpm
fi

echo "getting configuration"

deb_name=`grep "\"name\"" package.json | sed -e 's/^.*: //p' | tr -d \"\, | uniq`
deb_version=`grep "\"version\"" package.json | sed -e 's/^.*: //p' | tr -d \"\, | uniq`

echo $deb_name
echo $deb_version

echo "Cleaning up..."

rm *.deb 2> /dev/null
rm -rf to_deb/
mkdir to_deb/
cd to_deb/

echo "Creating necessary directories"

mkdir -p opt/sm/$deb_name
mkdir -p etc/init
mkdir -p bin

cd ..

echo "Making bin and conf stuff"

chmod 755 ./deb_files/$deb_name
cp ./deb_files/$deb_name ./to_deb/bin
cp ./deb_files/$deb_name.conf ./to_deb/etc

echo "Copying over necessary files specified in deb-files.whitelist"

for file in $(cat deb_files/files.whitelist); do
    echo "copying:" $file
    cp -R $file to_deb/opt/sm/$deb_name
done

echo "building .deb with fpm"

cd to_deb/
fpm -s dir -t deb -n $deb_name -v $deb_version ./*
mv *.deb ./../

echo "post creation clean up"
cd ..
rm -rf ./to_deb

echo "all done!"
