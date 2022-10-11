# Beispiel-Plugin "mod_template"
Das hinterlegte Plugin `mod_template` soll Ihnen als Vorlage dienen. Als Typ wurde in diesem Beispiel das sog. Activity-Modul gewählt.
Eine genauere Beschreibung aller Plugin-Typen, die von Moodle unterstützt werden, finden Sie in der offiziellen Moodle-Dokumentation/[Plugin-Typen](https://docs.moodle.org/dev/Plugin_types).
Das Plugin fügt zu Moodle eine neue Aktivität mit dem Namen `Template` hinzu. Wird die Instanz aufgerufen, zeigt sie alle in dem Kurs eingeschriebenen Teilnehmer*innen an.
Bitte beachten Sie, dass Sie beim Anlegen eines neuen Kurses nicht automatisch in diesen Kurs eingeschrieben sind!
<br /><br />Versuchen Sie, einen Überblick über die einzelnen Komponenten des Plugins zu erlangen, und entwickeln Sie das Plugin nach Ihren Anforderungen weiter. Die Wahl des Plugin-Typs bleibt Ihnen überlassen.

Folgende Komponenten benötigen <ins>keiner</ins> näheren Betrachtung.
Sofern allerdings Interesse besteht, kann der Nutzen der Komponenten mithilfe des jeweiligen folgenden Links nachgelesen werden.
* nodemon.json - [Nodemon](https://www.npmjs.com/package/nodemon)
* .babelrc - [Babel](https://babeljs.io/)
* webpack.config.js - [Webpack](https://webpack.js.org/)
* package.json; package-lock.json - [Node Package Manager](https://www.npmjs.com/)
* .gitignore - [Gitignore](https://git-scm.com/docs/gitignore)

## Installation des Plugins
Um das Plugin zu installieren, führen Sie bitte folgende Schritte aus:
* Navigieren Sie mit der Git Bash in den Ordner `{moodle-pfad}/mod` und klonen Sie dieses Repository mit <br />`git clone git@gitlab.pi6.fernuni-hagen.de:ks/fapra/fachpraktikum-2021/template.git`.
Achten Sie darauf, dass Sie die neuste Version des Plugins haben. Dies kann jederzeit mit dem Ausführen von `git pull origin master` (im vorher erstellten Plugin-Ordner) gewährleistet werden.
* Navigieren Sie in den dadurch erstellten `template/vue`-Ordner und führen Sie den Befehl `npm install` aus. Hierbei werden alle benötigten JavaScript-Module durch den `Node Package Manager` installiert. Mehr informationen zum Package Manager finden Sie [hier](https://www.npmjs.com/).
* Navigieren Sie zur Moodle-Hauptseite und folgen Sie dem angezeigten Dialog zur Installation des Plugins.

## Umbenennung des Plugins
Wenn Sie das Plugin umbenennen wollen, müssen Sie an folgenden Stellen den neuen Namen übergeben:
* view.php 'mod_template' zu 'mod_NAME'
* lang/en/template.php umbenennen zu NAME.php
* view.php, Zeile 13,17
* db/install.xml, Zeile 2
* db/upgrade, Zeile 5
* db/access.php, Zeile 7, 16
* mod_form.php, Zeile 10
* db/external.php, Zeile 6
* lib.php, Zeile 3, 14, 24, 37
* classes/permission/context.php
* classes/permission/course.php
* classes/permission/coursecategory.php
* classes/permission/module.php

## JavaScript-Änderungen bzw. Vue-Änderungen übernehmen
Für das Frontend sollten Sie hauptsächlich im Ordner `vue` arbeiten. Dort können Sie JavaScript- bzw. Vue-Dateien anlegen.
Führen Sie den Befehl `npm run build` mithilfe des Terminals in diesen Verzeichnis des Plugins aus, um die Änderungen minifiziert einmalig zu übernehmen. 
Möchten Sie, dass die Änderungen automatisch nach dem Speichern übernommen werden, rufen Sie den Befehl `npm run nodemon` auf.

Verwendet wird die Vue-Version 2.6.12. Ein Guide ist unter [https://vuejs.org/v2/guide/](https://vuejs.org/v2/guide/) zu finden.