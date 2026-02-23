# Composition root

Als klassen hun eigen afhankelijkheden maken of ophalen, is het duidelijk waar 
dit gebeurt, namelijk op de plek waar die afhankelijkheid nodig is. Als je 
echter dependency injection wilt gebruiken, is dit minder duidelijk. De 
vraag die dan voorligt, is op welke plaats in de code de afhankelijkheden dan 
aangemaakt worden. Dit is geen bezigheid die binnen de reguliere flow van de 
applicatie plaastvindt, dus schematisch wordt dit buiten die flow getekend.

![Architectuur met dependency injection](../images/schema-di.png)

## Objectgraaf

Een essentiële constatering die nodig is om de vraag waar alle componenten 
aangemaakt worden te kunnen beantwoorden is dat de objecten in een 
applicatie een [*graaf*](https://nl.wikipedia.org/wiki/Grafentheorie) vormen.
Hierbij verwijst elk object naar zijn afhankelijkheden; dat zijn weer 
objecten die op hun beurt naar hun afhankelijkheden wijzen, en zo verder. Er 
is echter in het algemeen één object die het beginpunt van de applicatie 
vormt. In een webapplicatie is dat de kernel. We hebben immers al gezien dat 
de flow in de front controller is dat de kernel een request omzet in een 
response en deze response vervolgens naar de browser stuurt.

![Objectgraaf met composition root](../images/compositionroot.png)

Daarnaast is een belangrijke constatering dat we het hier over een 
object*graaf* en niet over een object*boom* hebben. Kenmerkend aan een graaf 
is dat bepaalde knopen op meerdere manieren te bereiken zijn, anders dan bij 
een boom, waar elke knoop een uniek pad heeft. Dit is belangrijk omdat dit 
suggereert dat bepaalde objecten een afhankelijkheid kunnen zijn van 
meerdere andere objecten, oftewel dat afhankelijkheden hergebruikt kunnen 
worden. Het probleem immers waar we mee begonnen is dat we willen dat 
sommige klassen een singleton zijn. Als we de objectgraaf zó opzetten, dat 
er van een singletonklasse maar één instantie is die hergebruikt wordt 
overal waar die service nodig is, bereiken we dit doel zonder dat hiervoor 
het singleton pattern noodzakelijk is.

Hieronder is een versimpeld voorbeeld van het instantiëren van een 
objectgraaf zichtbaar. Hierbij zien we dat de klassen `Database` en 
`TemplateEngine` beiden als service in twee controllers gebruikt worden, 
maar dat van beide maar een enkele instantie aanwezig is. Het zijn dus 
singletonklassen.

```php
$db = new Database('mysql://localhost:3306/test');
$tpl = new TemplateEngine(__DIR__);
$router = new Router([
    '/' => new IndexController($db, $tpl),
    '/blog' => new BlogController($db, $tpl),
]);
$kernel = new Kernel($router);
```

## Front controller

De plaats in de applicatie waar de objectgraaf wordt opgebouwd heet de
*composition root*. In een webapplicatie is dit in de front controller. 
Alleen hier worden services geïnstantieerd en worden deze door middel van 
dependency injection meegegeven aan andere services, waardoor de 
objectgraaf wordt opgezet. De applicatie verkrijgt hiermee een verwijzing 
naar het beginpunt van de applicatie en kan zo de applicatie starten.

Als detail merken we hierbij op dat in een webcontext het request-object 
buiten de objectgraaf valt. Dit object wordt immers alleen gebruikt als 
parameter voor de kernelaanroep en is zelf geen service. Dit brengt met zich 
mee dat de front controller de volgende vier acties zal uitvoeren.

1. Request-object maken aan de hand van superglobals.
2. Kernel maken door middel van dependency injection (*composition root*)
3. Kernel aanroepen met request als parameter om response te verkrijgen.
4. Response naar de browser sturen.

Om de composition root te scheiden van de rest van de front controller, kan 
ervoor gekozen worden om deze in een apart bestand te zetten en via 
`require` te laden in de front controller. Het bestand met de composition root 
kan dan een `return`-statement gebruiken om de kernel terug te geven aan de 
front controller. Als uitbreiding van het hierboven getoonde voorbeeld zou de 
composition root in onderstaand bestand `compositionroot.php` kunnen staan.

```php
<?php

$db = new Database('mysql://localhost:3306/test');
$tpl = new TemplateEngine(__DIR__);
$router = new Router([
    '/' => new IndexController($db, $tpl),
    '/blog' => new BlogController($db, $tpl),
]);
return new Kernel($router);
```

De front controller zou op onderstaande manier van deze composition root 
gebruik kunnen maken.

```php
<?php

require_once '../vendor/autoload.php';

$request = Request::createFromGlobals();
$kernel = require '../compositionroot.php';
$response = $kernel->handle($request);
Response::send($response);
```


