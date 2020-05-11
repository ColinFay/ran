#!/bin/bash

cd /home/colin/ran
rm -rf craneur
git clone https://github.com/ColinFay/craneur --depth 1
cd craneur 
Rscript -e "remotes::install_local()"
cd .. 
rm -rf craneur 

cd /home/colin/ran
rm README.md

echo "# Colin's R Archive Network" >> README.md
echo " " >> README.md
echo "## A daily, automatically built RAN." >> README.md
echo " " >> README.md
echo "Every day around 1am, a RAN of up-to-date version (pulled from GitHub) of Colin's Packages is built here." >> README.md
echo " " >> README.md
echo "Use this repo to get the latest dev versions of the packages listed below."
echo "" 
echo " " >> README.md
echo "You can install them with:" >> README.md
echo " " >> README.md
echo "\`\`\` r" >> README.md
echo 'install.packages(PKGNAME, repos = "https://colinfay.me/ran", type = "source")' >> README.md
echo "\`\`\`" >> README.md
echo " " >> README.md
echo "## List of available packages:">> README.md
echo " " >> README.md

for i in dockerstats odds bubble glouton minifyr darkmode gargoyle geoloc resume rnotify aside tweetthat lexiquer argh nessy attempt craneur tidystringdist proustr rfeel rgeoapi backyard feathericons geoloc ariel debugin handydandy fryingpane dockerfiler languagelayeR wtfismyip rpinterest
do
    rm -rf $i
    git clone https://github.com/ColinFay/$i --depth 1
    cd $i
    Rscript -e 'remotes::install_local()'
    Rscript -e 'pkgbuild::build()'
    cd ..
    echo "+ $i" >> README.md
    rm -rf $i
done

rm -rf /home/pi/ran/src/contrib

echo " " >> README.md
echo "Also available at:">> README.md
echo "[https://colinfay.me/ran](https://colinfay.me/ran)" >> README.md

Rscript craneur.R
cd src/contrib
R -e 'rmarkdown::render("index.md")'
cd ../..
Rscript clean_the_mess.R
git add *
git commit -m "automatic update"
git push

Rscript clean_the_mess.R
