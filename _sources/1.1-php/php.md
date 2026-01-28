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
Sommige functies hebben geen argumenten, zoals de functie
[`pi`](https://www.php.net/manual/en/function.pi.php) die de waarde π,
3,14159..., teruggeeft. Deze functie wordt aangeroepen met lege haakjes, dus 
als `pi()`.

## PHP als webserver

* directorystructuur
* php -S localhost
* sequentiediagram
* assets

## Navigatie

* HTML (a)
* superglobals

