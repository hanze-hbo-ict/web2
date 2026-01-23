# PHP installeren

Om PHP te kunnen gebruiken moet dit natuurlijk geïnstalleerd worden. Het is 
handig om dit op een gestandaardiseerde manier te doen, zodat eventuele 
fouten in de installatie makkelijk opgespoord kunnen worden.

## Package managers

De eenvoudigste manier om PHP te installeren is om gebruik te maken van een 
package manager. Hierdoor worden de noodzakelijke dependency's goed 
geïnstalleerd en kan PHP later ook makkelijker verwijderd worden. Bovendien 
zal de executable van PHP beschikbaar gemaakt worden in het zoekpad. Voor elk 
besturingssysteem is wel een package manager te vinden.

Let erop dat een
up-to-dateversie van PHP geïnstalleerd wordt; op het moment van schrijven
is PHOP 8.5 de meest recente PHP-versie en in het hiernavolgende zal ervan
uitgegaan worden dat deze versie gebruikt wordt.

Windows-gebruikers kunnen gebruikmaken van [Scoop](https://scoop.sh). Indien 
nodig kan Scoop geïnstalleerd worden via de instructies op de website, en 
vervolgens kan PHP met onderstaand commando geïnstalleerd worden.

```sh
scoop install php
```

Voor macOS (en overigens ook Linux) is [Homebrew](https://brew.sh) 
beschikbaar. Na installatie kan PHP via onderstaand commando geïnstalleerd 
worden.

```sh
brew install php
```

Linux-distributies bieden in het algemeen hun eigen package manager aan; 
Debian en Debian-achtigen (zoals Ubuntu) bieden bijvoorbeeld APT aan. Zeker 
LTS-versies hebben vaak echter wat verouderde PHP-versies. Het kan dan nodig 
zijn om een extra repository toe te voegen. PHP.Watch heeft hier een
[artikel](https://php.watch/articles/php-8-5-installation-upgrade-guide-debian-ubuntu)
aan gewijd.

## Installatie controleren

Om te controleren dat PHP goed geïnstalleerd is, kunnen onderstaande commando's
worden gebruikt.

```sh
php -v
php -i
```

Het eerste commando toont de versieinformatie van PHP, en geeft ongeveer 
onderstaande uitvoer.

```
PHP 8.5.1 (cli) (built: Dec 16 2025 15:59:07) (NTS)
Copyright (c) The PHP Group
Built by Homebrew
Zend Engine v4.5.1, Copyright (c) Zend Technologies
    with Zend OPcache v8.5.1, Copyright (c), by Zend Technologies
```

Let er met name op dat op de eerste regel de versie van PHP staat, hier 8.5.1.
Dit zou dus in ieder geval ten minste 8.5.0 moeten zijn.

Het tweede commando toont de uitvoer van het commando `phpinfo()`, dat alle 
configuratieinformatie van de PHP-installatie toont. Relevant hier is dat 
het ook laat zien waar het configuratiebestand van PHP staat. Vrij vroeg in 
de uitvoer is dit te vinden; dit lijkt op onderstaande snippet.

```
...
Configuration File (php.ini) Path => /opt/homebrew/etc/php/8.5
Loaded Configuration File => /opt/homebrew/etc/php/8.5/php.ini
Scan this dir for additional .ini files => /opt/homebrew/etc/php/8.5/conf.d
Additional .ini files parsed => (none)
...
```

Hier is te zien dat in deze configuratie het configuratiebestand `php.ini` 
te vinden is in `/opt/homebrew/etc/php/8.5/php.ini`.

Ten slotte kan een kort "hello-world"-programma gebruikt worden om te zien 
of PHP werkt.

```sh
echo '<?php echo "Hello world!\n";' | php
```

Dit zou onderstaande uitvoer moeten geven; later zal nog uitgelegd worden 
hoe de hierbij gebruikte PHP-taalconstructen werken.

```
Hello world!
```

Als dit commando zichtbaar is, is PHP waarschijnlijk juist geïnstalleerd.

## IDE installeren

PHP-code zou in principe met een tool als Notepad bewerkt kunnen worden. Dit 
heeft echter twee nadelen ten opzichte van het gebruik van een IDE. In de 
eerste plaats zal er geen syntax  highlighting aanwezig zijn. Belangrijker 
echter is dat een IDE ondersteuning  zal bieden voor het zoeken naar 
functies en het navigeren door een project. Daarom is het aan te bevelen een 
IDE te gebruiken. Hierbij kan gedacht worden aan 
[PHPStorm](https://www.jetbrains.com/phpstorm/) of
[Visual Studio Code](https://code.visualstudio.com).