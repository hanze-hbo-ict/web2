# PHP

[PHP](https://nl.wikipedia.org/wiki/PHP)
is een programmeertaal die in beginsel voor alle doeleinden gebruikt kan 
worden, maar oorspronkelijk geschreven is, en bovendien uiterst geschikt is, 
voor de ontwikkeling van websites en webapplicaties. Het is in 1994 
ontwikkeld door Rasmus Lerdorf, waarbij PHP oorspronkelijk voor stond voor 
"Personal Home Page". Tegenwoordig staat PHP echter voor "PHP: Hypertext 
Preprocessor".

## Syntax

Kenmerkend aan de taal PHP is dat deze twee modussen kent. Elk willekeurig 
tekstbestand kan feitelijk als PHP-programma uitgevoerd worden, want PHP 
begint in een modus waarbij de inhoud van het bestand letterlijk als uitvoer 
gegeven wordt. Pas als een
[PHP-tag](https://www.php.net/manual/en/language.basic-syntax.phptags.php)
`<?php` gebruikt wordt, wordt de PHP-modus gestart. Vanaf dat punt wordt de 
code als PHP-code gezien en uitgevoerd, totdat een sluittag `?>` gebruikt 
wordt. Vaak zullen PHP-bestanden alleen PHP-code bevatten en dan is het 
gebruikelijk om de opentag `<?php` meteen aan het begin van het bestand te 
zetten; de sluittag kan dan weggelaten worden.

Binnen de PHP-modus worden PHP-statements gebruikt. Deze worden afgesloten 
met een puntkomma `;`, net als in Java. Commentaar begint met `/*` en 
eindigt met `*/`, en commentaar op een enkele regel begint met `//`. Om 
tekst af te drukken kan je het statement `echo` gebruiken. Hier kan je een 
aantal waardes, gescheiden door komma's, achter zetten die afgedrukt moeten 
worden. `echo` zal niet standaard naar een nieuwe regel gaan na het 
afdrukken van deze waardes. Als je dat wel wil, kan je de waarde `PHP_EOL` 
afdrukken, zoals in onderstaand voorbeeld.

```php
Dit wordt letterlijk afgedrukt.
<?php
echo 1;
echo 2, PHP_EOL;
echo 3;
?>
Dit wordt ook letterlijk afgedrukt.
```

Je kan, als je deze code bijvoorbeeld in `test.php` hebt opgeslagen, dit 
bestand door PHP laten uitvoeren met het commando `php test.php`. Dit geeft 
onderstaande uitvoer.

```
Dit wordt letterlijk afgedrukt.
12
3Dit wordt ook letterlijk afgedrukt.
```

Je ziet dat er geen nieuwe regel wordt begonnen na het eerste en het derde 
`echo`-statement.

Als je PHP en HTML, of andere tekst, combineert kan het voorkomen dat een 
PHP-blok slechts een enkel `echo`-statement bevat. Denk hierbij bijvoorbeeld 
aan de situatie dat je een CSS-klasse wil gebruiken, zoals in onderstaand 
voorbeeld.

```php
<a href="/" class="color-<?php echo 1; ?>">
```

Deze situatie komt relatief veel voor. Je kan hierbij dan ook de 
onderstaande, kortere syntax gebruiken.

```php
<a href="/" class="color-<?= 1 ?>">
```

Je ziet dat hier de kortere begintag `<?=` wordt gebruikt. Deze tag betekent 
dat de inhoud van de tag als PHP-expressie moet worden uitgerekend en 
afgedrukt. Merk bovendien op dat het gebruik van PHP hier nog niets toevoegt.
PHP heeft echter natuurlijk de mogelijkheid om variabelen te declareren en 
te gebruiken, waardoor je de waarde die afgedrukt wordt afhankelijk kan 
maken van de context.

Net als vrijwel elke programmeertaal heeft PHP de mogelijkheid om functies 
aan te roepen. De argumenten van een functie worden gescheiden met 
komma's en tussen haakjes achter de functienaam gezet. Zo kent PHP de functie
[`pow`](https://www.php.net/manual/en/function.pow.php) die een 
machtsverheffing uitvoert, om 2³ uit te rekenen kan de expressie `pow(2, 3)` 
gebruikt worden; het resultaat kan met `echo` of `<?=` afgedrukt worden. 
Sommige functies hebben geen parameters, zoals de functie
[`pi`](https://www.php.net/manual/en/function.pi.php) die de waarde π,
3,14159..., teruggeeft. Deze functie wordt aangeroepen met lege haakjes, dus 
als `pi()`.

## PHP als webserver

Zoals al aangehaald is PHP oorspronkelijk bedacht, en ook zeer geschikt, voor
het schrijven van websites en webapplicaties. Dit brengt met zich mee dat 
verzoeken van browsers opgevangen moeten kunnen worden door PHP-applicaties. 
Hier zijn meerdere manieren voor, zo kan PHP gebruik maken van de
[Common Gateway Interface](https://nl.wikipedia.org/wiki/Common_Gateway_Interface)
(CGI) en kan PHP geïntegreerd worden in de webserver
[Apache](https://nl.wikipedia.org/wiki/Apache_(webserver)). Daarnaast heeft 
PHP sinds versie 5.4 een ingeboude
[webserver](https://www.php.net/manual/en/features.commandline.webserver.php)
die geschikt is voor gebruik tijdens het ontwikkelen van een applicatie. 
Merk op dat deze websrver expliciet niet bedoeld is om te gebruiken voor een 
productie-omgeving.

Deze webserver kan worden gestart met het commando `php -S localhost:8000`, 
waarbij het getal 8000 de poort is waarop de webserver zal draaien. Dit 
betekent dat deze server in een browser aangesproken kan worden via de URL 
`http://localhost:8000`. Als poort 8000 niet beschikbaar is, kan ook een 
andere poort, bijvoorbeeld 8080, worden gebruikt. In het hiernavolgend wordt 
echter steeds van poort 8000 uitgegaan.

De webserver zal alle bestanden die in de directory van waaruit de 
server werd gestart staan, aanbieden. Deze directory wordt wel de *document 
root* genoemd. Als bijvoorbeeld de URL `http://localhost:8000/test.php` 
wordt aangeroepen, wordt het bestand `test.php` uit de document root 
hiervoor gebruikt. De uitvoer van dit script wordt naar de browser gestuurd. 

Naast PHP-bestanden kan de document root ook andere bestandstypes bevatten, 
zoals afbeeldingen of CSS-bestanden. Deze bestanden worden ook door de 
server aangeboden; als de document root bijvoorbeeld een bestand `main.css` 
bevat, kan dit bestand verkregen worden via de URL 
`http://localhost:8000/main.css`.

We zullen nog zien dat een webapplicatie in PHP vaak ook bestanden bevat die 
niet door de webserver aangeboden moeten worden. Denk bijvoorbeeld aan 
een configuratiebestand waarin het wachtwoord voor een database staan. Om te 
voorkomen dat deze bestanden worden aangeboden, is het gebruikelijk om een 
subdirectory binnen het project te gebruiken als document root. Het is 
gangbaar om hiervoor de directory `public` te gebruiken. PHP kan hiervan op 
de hoogte gesteld worden door het hierboven genoemde commando aan te passen 
op onderstaande wijze.

```shell
php -S localhost:8000 -t public
```

Als dit commando wordt uitgevoerd, wordt de directory `public` in de huidige 
directory de document root. Dit betekent dat bijvoorbeeld een bestand 
`public/test.php` beschikbaar is via `http://localhost:8000/test.php`. Een 
bestand dat in een andere directory staat, bijvoorbeeld `src/secret.php`, 
kan echter niet opgevraagd worden via de webserver.

## Gebruikersinvoer en navigatie

Een webapplicatie is natuurlijk meer dan een enkel PHP-bestand. In veel 
gevallen bestaat een applicatie uit een veelvoud aan pagina's die naar 
elkaar verwijzen. Dit is ook de essentie van HTML. Hiervoor is in HTML dan 
ook de
[`a`-tag](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/a),
voor anchor, beschikbaar. Als bijvoorbeeld een bestand `public/test.php` 
onderstaande tag bevat, zal de gebruiker, die deze pagina ziet op de URL 
`http://localhost:8000/test.php`, na het klikken op de link navigeren naar 
de pagina `http://localhost:8000/other.php`. Hiervoor zal vervolgens het 
bestand `public/other.php` worden gebruikt. Merk op dat de link in het 
onderstaande snippet een absolute URL bevat, die dus altijd rechtstreeks 
achter de domeinnaam, hier `http://localhost:8000`, gezet wordt.

```html
<a href="/other.php">Link naar andere pagina</a>
```

Door middel van URL's en links is het dus mogelijk om te selecteren welk 
PHP-bestand gebruikt wordt. Het is echter ook mogelijk om binnen een 
PHP-bestand gebruikersinvoer te verwerken. Deze invoer zal ook onderdeel 
moeten zijn van de URL, aangezien dat het primaire mechanisme is waarmee 
gebruikers interacteren met een webserver. Na een URL kan een vraagteken 
worden gezet met daarna een aantal waarden, in het onderstaande formaat.

```
http://localhost:8000/test.php?name=henk&age=20
```

De bovenstaande URL verwijst naar het bestand `test.php` maar heeft twee 
extra parameters, te weten `name` met waarde `henk` en `age` met waarde `20`.
In PHP kunnen deze waarden opgevraagd worden via `$_GET['name']` en
`$_GET['age']`. Hierbij worden een aantal PHP-constructen gebruikt die in 
dit hoofdstuk nog nader besproken worden, namelijk arrays en strings. Op dit 
moment is het voldoende om te weten dat `$_GET` één van een aantal
[superglobals](https://www.php.net/manual/en/language.variables.superglobals.php)
in PHP is, variabelen die altijd beschikbaar zijn, en dat
[`$_GET`](https://www.php.net/manual/en/reserved.variables.get.php) de 
parameters bevat die in de URL zijn meegegeven. Als voorbeeld kan 
onderstaand bestand opgeslagen worden als `public/test.php`

```php
<h1>Hallo, <?= $_GET['name'] ?>!</h1>
<p>Je bent <?= $_GET['age'] ?> jaar oud.</p>
```

Als dan de hierboven genoemde URL
`http://localhost:8000/test.php?name=henk&age=20` wordt gebruikt, zullen de 
teksten `Hallo, henk!` en `Je bent 20 jaar oud.` getoond worden.
