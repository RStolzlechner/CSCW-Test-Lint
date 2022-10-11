# Beschreibung:
- moodle mit docker
- inkl. `plugin` Ordner
- `plugin` Ordner wird als Docker-Volume gemountet, so ist das plugin im Container verfügbar (siehe Zeile 55 in `docker-compose.yml`) 
# Setup:
1. Im Hauptverzeichnis `.env` Datei anlegen
2. folgenden Inhalt einfügen:
```
# 
# author Marc Burchart <marc.burchart@fernuni-hagen.de>
# version 1.0-20200928
# description The enviroment variables which should be passed to the service creation.
# 

# 
# Moodle configuration
#

MOODLE_LANG="de"                                    # The default language
MOODLE_ADDRESS="http://localhost:8081"              # The address of the webserver [You have to use http://...]
MOODLE_ADMINUSERNAME="fapra"                        # The username of the admin account
MOODLE_ADMINPASSWORD="password"                     # The password of the admin account
MOODLE_ADMINEMAIL="fapra@fernuni-hagen.de"          # The email address of the admin
MOODLE_FULLNAME="My test Moodle"                    # The name of the Moodle instance
MOODLE_SHORTNAME="MTM"                              # A shortname for the Moodle instance

# 
# Postgresql Database
#

POSTGRESQL_USERNAME="fapra"                         # The root username
POSTGRESQL_PASSWORD="password"                      # The root password
POSTGRESQL_MOODLEDB="moodle"                        # The database name where Moodle should store its data

# 
# Pgadmin - A database admin tool running at tcp/8080
#

PGADMIN_EMAIL="fapra@fernuni-hagen.de"              # An email for the login
PGADMIN_PASSWORD="password"                         # A password for the login

# 
# Git
#

GIT_EMAIL="fapra@fernuni-hagen.de"                  # The email of the git user
GIT_NAME="Max Mustermann"                           # The name of the git user
GIT_PWD_SSH=""                                      # The ssh key for a secured encryption [can be blank]
GIT_PWD_GPG="password"                              # The gpg key for signing commits
```
3. Ins Verzeichnis `plugin` navigieren
4. `npm install`
5. `npm run build`
6. `docker-compose up` (Installation dauert ein wenig)

# Docker-Entwicklungsumgebung für Moodle
<!--<img src="https://upload.wikimedia.org/wikipedia/commons/7/79/Docker_%28container_engine%29_logo.png" /><br />-->
Das hier hinterlegte Projekt enthält eine Kombination von Abbildungen (Images), welche zusammen eine fertige Umgebung für die Entwicklung von Moodle-Plugins bereitstellen. Mithilfe der Open Source Software [Docker](https://www.docker.com/) können die Images virtualisiert auf dem Host-Rechner in Form von sog. Containern ausgeführt werden. Somit können die Anwendungen (bis zu einem bestimmten Grad) isoliert vom Host-Betriebssystem laufen. Docker basiert auf Linux, auch wenn mittlerweile eigene Programmierschnittstellen von den Entwicklern entwickelt wurden.

## Installation von Docker
Docker wird für alle gängigen Betriebssysteme zur Verfügung gestellt. Für das hier hinterlegte Projekt sind die beiden Komponenten _Docker Engine_ und _Docker Compose_ erforderlich und müssen deshalb beide auf dem Host-Computer installiert sein. Eine genaue Installationsanweisung zu Ihrem Betriebssystem finden Sie in der folgenden Tabelle.

<table>
    <tr>
        <th>Betriebssystem</th>
        <th>Docker Engine</th>
        <th>Docker Compose</th>
    </tr>
    <tr>
        <td>macOS</td>
        <td colspan="2">[Docker Desktop](https://docs.docker.com/docker-for-mac/install/)</td>        
    </tr>
    <tr>
        <td>Windows 10</td>
        <td colspan="2">[Docker Desktop](https://docs.docker.com/docker-for-windows/install/)</td>        
    </tr>
    <tr>
        <td>CentOS</td>
        <td>[Docker Engine](https://docs.docker.com/engine/install/centos/)</td>
        <td>[Docker Compose](https://docs.docker.com/compose/install/)</td>
    </tr>
    <tr>
        <td>Debian</td>
        <td>[Docker Engine](https://docs.docker.com/engine/install/debian/)</td>
        <td>[Docker Compose](https://docs.docker.com/compose/install/)</td>
    </tr>
    <tr>
        <td>Fedora</td>
        <td>[Docker Engine](https://docs.docker.com/engine/install/fedora/)</td>
        <td>[Docker Compose](https://docs.docker.com/compose/install/)</td>
    </tr>
    <tr>
        <td>Raspbian</td>
        <td>[Docker Engine](https://docs.docker.com/engine/install/debian/)</td>
        <td>[Docker Compose](https://docs.docker.com/compose/install/)</td>
    </tr>
    <tr>
        <td>Ubuntu</td>
        <td>[Docker Engine](https://docs.docker.com/engine/install/ubuntu/)</td>
        <td>[Docker Compose](https://docs.docker.com/compose/install/)</td>
    </tr>
</table>

## Wesentliche Software innerhalb der Abbildungen/Container
Die hier angebotene Umgebung verwendet – wie bereits oben erwähnt – einen Sammlung von verschiedenen Containern, die teilweise miteinander in Verbindung stehen. Im Folgenden werden die Namen der einzelnen Container und ihre "Inhalte" kurz aufgeführt:
* postgres - PostgreSQL ist ein freies, objektrelationales Datenbankmanagementsystem.
* pgadmin - Eine Open-Source-Software zur Entwicklung und Administration von PostgreSQL-Datenbanken.
* moodle - Ein Webserver (Apache2) mit PHP, Git (ein freie Software zur verteilten Versionsverwaltung) und der Instanz der Lernplattform Moodle.  

## Insgesamt installierte Pakete
* Apache2 (latest)
* PostgreSQL (latest)
* Pgadmin4 
* PHP (latest) mit allen benötigten Extensions
* Gnupg2
* Wget
* Curl
* Git

## Erstellen der Docker-Container

Navigieren Sie mit der Betriebssystem-Shell in den Ordner des auf dem Host-Computer geklonten Repositories. Öffnen Sie die .env Datei mit einem Editor Ihrer wahl geben dort eigene Login-Daten ein. Dabei kann `GIT_PWD_SSH` einen leeren String erhalten, im Gegensatz zu `GIT_PWD_GPG`. Bitte beachten Sie auch, dass Sie die richtige GitLab-Mailadresse angeben.
Mit der Shell können Sie nun folgende Befehle verwenden:
* `docker-compose up`      Erstellen und erstmaliges Ausführen der Container.
* `docker-compose start`   Die Ausführung der Container starten. (Dieser Befehl wird anstatt `docker-compose up` ausgeführt, wenn die Container schon angelegt wurden).
* `docker-compose stop`    Die Ausführung der Container stoppen.
* `docker-compose pause`   Die Ausführung der Container pausieren.
* `docker-compose unpause` Die Ausführung der Container nach dem Pausieren wieder starten.
* `docker-compose rm`      Die Ausführung der Container stoppen und die Container löschen.

Eine vollständige Liste mit allen Befehlen finden Sie in der offiziellen [Dokumentation](https://docs.docker.com/compose/reference/).

Werden die Container erstmalig erstellt, wird im Root-Verzeichnis des Projekts ein Ordner `keys` angelegt. Dieser Ordner enthält die öffentlichen Schlüsseldateien des Moodle-Containers, welche in GitLab für den SSH-Zugriff und zur GPG-Validierung verwendet werden.
Kopieren Sie jeweils den Inhalt der Dateien gpg.pub und ssh.pub und fügen Sie ihn in die Einstellungen von GitLab (Weboberfläche) ein.
* ssh.pub – Einstellungen > SSH-Schlüssel
* gpg.pub – Einstellungen > GPG-Schlüssel

## Zugriff auf Moodle
Um per Webserver Zugriff auf die Moodle-Instanz zu nehmen, verwenden Sie bitte den Browser Ihrer Wahl und öffnen Sie die URL [http://localhost](http://localhost). Bitte achten Sie darauf, dass der Port 80 auf Ihrem Host-Computer zu der Zeit nicht verwendet wird.

## Zugriff auf die Datenbank
Um Zugriff auf die verwendete PostgreSQL-Datenbank zu nehmen, öffnen Sie bitte mit dem o.g. Browser die URL [http://localhost:8080](http://localhost:8080).

## Entwicklung innerhalb des Moodle-Containers
Es empfiehlt sich als Entwicklungsumgebung [Visual Studio Code](https://code.visualstudio.com/) zusammen mit dem VSC-Plugin [Remote - Container](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) zu verwenden. In der linken Hauptnavigation des Editors finden Sie nach erfolgreicher Installation beider Komponenten den Eintrag "Remote Explorer". Dort sollte eine Übersicht erscheinen, mithilfe der Sie den laufenden Moodle-Container auswählen können. Dabei öffnet sich oben eine leere Adressleiste, die Sie nutzen können, um zu dem benötigten Pfad innerhalb des Containers navigieren zu können. Das Root-Verzeichnis des Webservers befindet sich unter `/var/www`, wo auch die Moodle-Instanz zu finden ist. Mit dem Terminal von Visual Code können inneerhalb des Containers Befehle ausgeführt werden (besonders nützlich für Git).

## Bei Fragen oder Problemen
Sollten Fragen oder Probleme auftreten, können Sie sich gerne direkt an [Marc Burchart](mailto:marc.burchart@fernuni-hagen.de) wenden.