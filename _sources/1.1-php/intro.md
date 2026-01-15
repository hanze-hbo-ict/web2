# Intro

* Drielaagsarchitectuur
* Backend
* Plaatsbepaling/welke programmeertaal
* Geschiedenis PHP



# Applicatie maken

Een PHP-applicatie bevindt zich in een directorystructuur die als project in de
IDE geopend wordt. [TODO]

Zoals eerder genoemd hebben webapplicaties in beginsel een 
client-serverarchitectuur. De browser van de gebruiker dient als client die
verzoeken doet aan de applicatie die als server dient. Dit betekent dat deze
applicatie niet, zoals bijvoorbeeld reguliere Python-programma's, eenmalig 
draaien en dan stoppen, maar steeds beschikbaar moeten zijn voor 
verzoeken van clients. Dit is vergelijkbaar met Python-programma's die Flask
gebruiken.

Er is echter een relevant verschil waardoor we PHP-programma's toch als 
eenmalig draaiende programma's kunnen schrijven. Een Python Flask-applicatie 
moet zelf zorgdragen voor het afhandelen van meerdere verzoeken, en gebruikt 
in het algemeen een functie als aanspreekpunt hiervoor. Alle verzoeken 
worden dus door dezelfde instantie van de applicatie uitgevoerd. Bij PHP is 
het daarentegen gebruikelijk dat er een webserver is die zorgt voor het 
afhandelen van verzoeken en deze doorstuurt naar een PHP-applicatie die een 
enkel verzoek afhandelt. Elke instantie van de PHP-applicatie hoeft dus 
slechts een enkel verzoek af te handelen.

[TODO routing obv directorystructuur]

Dit alles laat zich samenvatten in het onderstaande sequentiediagram.

[TODO sequentiediagram]

Zoals hierboven vermeld scheidt PHP de webserver van de applicatie. In een 
productieomgeving wordt vaak een webserver als Apache of Nginx gebruikt. In 
een ontwikkelomgeving is dit echter overkill. Vandaar dat er een eenvoudige 
webserver ingebouwd is in PHP, die voor ontwikkelomgevingen gebruikt kan 
worden. Deze kan gestart worden door onderstaand commando.

```sh
php -S localhost:8000
```

Na het uitvoeren van dit commando wordt de huidige directory, van waaruit 
het commando was uitgevoerd, gepubliceerd op `http://localhost:8000`. De 
huidige directory wordt nu de _document root_ van de server genoemd. Dit 
zal in principe de hoofdddirectory van het project zijn. Omdat we later 
allerlei configuratiebestanden zullen toevoegen aan de applicatie die niet 
aan de eindgebruiker getoond mogen worden, is het gebruik van de 
hoofddirectory als document root ongewenst vanuit securityperspectief.

Het is daarom gebruikelijk een directory `public` te maken die gebruikt wordt
als document root. Op die manier kunnen statische bestanden en PHP-scripts die 
door de gebruiker aangeroepen mogen worden in die directory worden gezet 
maar kan de gebruiker niet bij andere bestanden. Om PHP te vertellen dat 
`public` als document root gebruikt moet worden, wordt bovenstaand commando als
volgt aangepast.

```sh
php -S localhost:8000 -t public
```

## ???





* directorystructuur
* php -S localhost
* sequentiediagram
* php-tags
* echo
* assets
* HTML (a)

# Dynamische webpagina's

Op dit moment kunnen we met PHP-programma's alleen nog maar statische 
content genereren; het heeft nu dus nog geen toegevoegde waarde ten opzichte 
van 'kale' HTML-bestanden.

PHP heeft echter natuurlijk genoeg functionaliteiten om wel degelijk een 
meerwaarde te hebben. In dit hoofdstuk zullen we zien dat PHP variabelen 
heeft, en zoals elke imperatieve taal commando's sequentieel kan 
uitvoeren en conditionele statements en lusconstructies kent.

## Variabelen

Variabelen worden in PHP altijd voorafgegaan door het teken `$`. Daarnaast 
hebben variabelen in PHP in principe geen vastgesteld type; PHP is een 
dynamisch getypeerde taal, net als bijvoorbeeld Python. Dit betekent dat een 
variabele bijvoorbeeld eerst een getal en daarna een string kan bevatten. 
Ook kent PHP de gangbare wiskunde operatoren `+`, `-`, `*`, `/`, `**` voor 
machtsverheffen en `%` als modulo-operator.

```php
$a = 5;
$b = 2.5;
$c = $a * $b;
echo($c);
```

Bovenstaande code zal het getal `12.5` afdrukken.

Net als Python kunnen `+=`, `-=` en zo verder gebruikt worden als gecombineerde 
berekening en toekenning. `$a += 5` is functioneel gelijk aan `$a = $a + 5`. 
Daarnaast bestaan de operatoren `++` en `--` op dezelfde 

[TODO strings]



* variabelen
* strings en strings interpoleren
* Operators
* if
* for/while

# Gebruikersinvoer

* _GET, _SERVER
* arrays, associatieve arrays
* foreach

* var_dump