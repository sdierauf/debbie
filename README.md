# Debbie

*An fpm wrapper for node projects*

I got sick of manually building .deb files at work for node projects, so I wrote this little collection of scripts/spec for my sanity.

## Why Debbie is cool

Debbie will grab your project's name and version from your `package.json` when building the deb file. This is awesome because you only have to  make a change in one place and then run `sh make-deb.sh` and you'll have a brand new deb with all the correct stuff configured! 

## How to use

1. Clone this repository
2. Copy paste `make-deb.sh` and `deb_files/` to your project's root directory
3. Edit deb_files/files.whitelist with the names of all the files and folders in your root directory that you want to include.
4. Add whatever you want to go in `/bin` with your project's name to `deb_files/` (e.g. `node opt/<projectname>/myproject.js`)
5. Add a `<projectname>.conf` to `deb_files` that specifies your configuration

## Dependencies

* Some of the commands `make-deb.sh` relies on (notably, the `grep` commands used to scrape out the name and version from `package.json`) will currently only work reliably on linux. 
* `make-deb.sh` makes use of fpm for the actual packaging, which it will install for you if it is not installed. This does require rubygems.

*The script is not complicated, edit it as you see fit!*

## Todo:

* Lock down node_modules with shrinkwrap, so node_module binaries can be installed after .deb is deployed
* Support building debs on OS X
* Make script less brittle and output more pretty
