#! /bin/bash
read -e -i 'Visible Translations 1.14-1.21.3 Release1.0 '"$(date +%F)"'.zip' -p 'Version Name: ' VERSION
find * | zip -@ '../'"$VERSION"
