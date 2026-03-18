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

In de meeste gevallen roep je vanuit de programmeerlaag niet zonder meer een sql-statement aan – zeker niet wanneer er gebruik gemaakt wordt van gebruikersinput. Stel je voor dat je in de code de onderstaande functie hebt:

```php
<?php
function select($where_clause) {
    $conn = new PDO('mysql:host=127.0.0.1;dbname=demo;charset=utf8mb4', 'root');
    $sql = "select * from users where $where_clause";
    $stmt = $conn->execute($sql);
    return $stmt->fetchAll();
}
```

Wanneer `$where_clause` gelijk is aan `aantal>5`, zou dit prima werken. De variabele `$sql` wordt dan immers `select * from table where aantal>5`, wat mogelijk is wat de bezoeker wilde weten. Maar wanneer onze bezoeker kwaad in de zin heeft, zou hij ook kunnen proberen of de variabele `$where_clause` gelijk kan worden gemaakt aan `1; drop table users; --`. Kijk maar eens wat de waarde van `$sql` in dat geval wordt...

![exploits of a mom, by xkcd](https://imgs.xkcd.com/comics/exploits_of_a_mom_2x.png)

Om dit soort *injecties* te voorkomen, moeten we alle karakters die een bepaalde betekenis hebben in sql uit de input filteren. Dat kunnen we natuurlijk met de hand doen, maar php (en de meeste andere programmeertalen) hebben hier een speciale techniek voor: *prepared statements*.

```{admonition} Ook wat sneller
:class: info
Behalve veiliger zijn *prepared statements ook subtiel efficiënter. Het maakt het namelijk mogelijk om de sql te *precompilen*. Bekijk eventueel [de documentatie op wikipedia](https://en.wikipedia.org/wiki/Prepared_statement).
```

Het idee is dat je het sql-statement als string opstelt terwijl je de in te voeren waarden nog leeg houdt. Vervolgens geef die deze string mee aan de `execute`-methode, waarbij je de daadwerkelijke waarden meegeeft.

Er zijn in php twee vormen van een prepared statement. De eerste is met vraagtekens. Bekijk het onderstaande voorbeeld (hierin is `$dbh` een database-handler die al eerder is opgezet):

```php
<?php
$sql = 'SELECT naam, adres woonplaat 
    FROM bezoekers 
    WHERE leeftijd > ?
    AND lengte < ?';
$stmt = $dbh->prepare($sql);
$stmt->execute([30, 190]);
$geschikt = $sth->fetchAll();
```

De tweede vorm maakt gebruik van zogenaamde *named parameters*:

```php
<?php
$sql = 'SELECT naam, adres woonplaat 
    FROM bezoekers 
    WHERE leeftijd > :leeftijd 
    AND lengte < :lengte';
$stmt = $dbh->prepare($sql);
$stmt->execute(['leeftijd' => 30, 'lengte' => 190]);
$geschikt = $sth->fetchAll();
```

Het is de bedoeling dat je in al je projecten *altijd* gebruik maakt van *prepared statements*.

