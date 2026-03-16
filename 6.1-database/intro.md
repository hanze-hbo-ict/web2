# Introductie

Nagenoeg alle applicaties (niet per se webapplicaties) maken gebruik van een database. Uiteindelijk wil je immers dat de data die je aanmaakt, aanpast of verwijderd, ook gepersisteerd wordt – dat de aanpassingen ook nog beschikbaar zijn wanneer je de computer uit en weer aan hebt gezet. De operaties die je met data kunt doen, worden samengevat onder het fijne CRUD-acroniem (voor *Create*, *Read*, *Update* en *Delete*).

## `ConnectionInterface`

Om met een database te kunnen werken hebben we natuurlijk allereerst een *verbinding* met die database nodig. Deze verbinding wordt via een separate klasse ingesteld en onderhouden die vervolgens als een *service* beschikbaar wordt gesteld. Klassen die iets met de database moeten doen, krijgen deze *service* dan (in de regel) [via de constructor geïnjecteerd](../5.1-di/dependencyinjection.md#dependency-injection).

Klassen die de verbinding met de database onderhouden implementeren [de `ConnectionInterface`](interface.md). Als je deze interface bekijkt, zie je dat de enige methoden die worden voorgeschreven te maken hebben met het uitvoeren van *queries* – dat houdt in dat er geen manier is om buiten deze klasse de daadwerkelijke connectie met de database op te vragen.

Als je er over nadenkt, is dat ook logisch. Deze connectie-klasse is verantwoordelijk voor het bijhouden van de connectie met de database; klassen die de database nodig hebben, delegeren de specifieke database-operaties naar deze klasse. De gebruikende klassen zeggen als het ware tegen de `ConnectionInterface`: "Hier is de data, doe je ding".

## Sqlite

Voor het huidige project maken we gebruik van [sqlite](https://sqlite.org/index.html). Het grote voordeel van deze engine in een onderwijscontext is dat de hele database *file based* is: je hoeft dus geen relatief complexe infrastructuur op te zetten om met de database te kunnen werken (zoals bijvoorbeeld bij mysql of mssql wel het geval is). Je kunt eenvoudig het databasebestand openen via de command-line:

```shell
% sqlite3 demo.sqlite3
SQLite version 3.51.0 2025-06-12 13:14:41
Enter ".help" for usage hints.
sqlite> 
```

We hebben dezelde database-engine gezien [bij webtechnologie1 in de propedeuse](https://hanze-hbo-ict.github.io/webtech1/week6/flask-views-deel1.html), waar we het koppelden aan python/flask. Het is belangrijk om je te beseffen dat alle database-commando's met een punt beginnen (`.schema`, `.headers on`, `.exit`), terwijl de sql-commando's gewoon zijn zoals je gewend bent (`select * from users`).

Als het allemaal wat is weggezakt, bekijk dan nog even [de documentatie](https://sqlite.org/docs.html).

## Sqlite en php

Omdat de instantie die de `ConnectionInterface` implementeert wel een connectie met de database moet hebben, is het van belang dat deze (bij voorbeeld of bij voorkeur) in de constructor wordt aangemaakt. In php maken we gebruik van [`PDO`](https://www.php.net/manual/en/book.pdo.php). Het ligt voor de hand dat je in deze constructor het pad meegeeft waar de database te vinden is (of zou moeten zijn):

```php
<?php
   public function __construct(string $file) {
        $file = realpath($file);
        $this->connection = new \PDO("sqlite:$file");
    }
```

## Prepared statements

