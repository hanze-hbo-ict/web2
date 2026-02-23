# Reguliere expressies

Een manier om het formaat van URL's kernachtig uit te drukken is door 
gebruik te maken van
[reguliere expressies](https://nl.wikipedia.org/wiki/Reguliere_expressie), 
ook wel *regexes* genoemd. 
Een reguliere expressie is een patroon van tekens die een verzameling 
strings beschrijven die gematcht moeten worden door de reguliere expressie. 
Anders gezegd, we kunnen een string laten doorzoeken aan de hand van de 
reguliere expressie, en deze kan wel of geen match zijn. Als bijvoorbeeld 
alle blogposts te vinden moeten zijn onder het pad `/blog/`, gevolgd door de 
id van de blogpost, kan dit pad als de reguliere expressie `^/blog/\d+` 
uitgedrukt worden.

## Speciale tekens

De meeste tekens komen letterlijk overeen met het gezochte pad, maar er zijn 
enkele uitzonderingen hierop.

Zo staat `\d+` voor één of meer cijfers; `\d` kan worden gematcht door de 
cijfers 0 tot en met 9, en het plusteken betekent dat het voorgaande teken, 
hier dus `\d`, één of meer keer voor mag komen. Niet alleen een enkel cijfer 
is dus toegestaan, maar ook meerdere cijfers.

Daarnaast geeft het teken `^` aan dat een match van de reguliere expressie 
alleen gevonden mag worden aan het begin van de string waarin gezocht wordt;
concreet betekent het hier dus dat `/blog/5` wel voldoet aan het patroon, 
maar bijvoorbeeld `/test/blog/5` niet.

Enkele andere speciale tekens zijn de punt `.`, die voor elk willekeurig 
teken staat en de blokhaken `[` en `]` die gebruikt kunnen worden om een paar 
specifiek tekens te accepteren. Zo zal `h[eu]lp` matchen op zowel de string 
`help` als de string `hulp`. Ook kan `\w` gebruikt worden om een willekeurig 
*word character* te matchen; dit zijn letters, cijfers en de underscore.

Naast het plusteken dat één of meer betekent, kan ook de asterisk `*` 
gebruikt worden om aan te geven dat het vorige teken nul of meer keer voor 
mag komen, en het vraagteken `?` om aan te geven dat het vorige teken nul of 
één keer voor mag komen.

Ten slotte kan naast `^`, dat aangeeft dat een match alleen gevonden mag 
worden aan het begin van de string, het dollarteken `$` gebruikt worden om 
aan te geven dat een match alleen gevonden mag worden aan het eind van de 
string. Zo zou de reguliere expressie `a` matchen op de string `van`, 
aangezien in die string de substring `a` te vinden is die overeenkomt met de 
reguliere expressie, maar zal de regex `^a$` niet matchen op `van`, maar ook 
niet op `va` of `an`, omdat in alle gevallen er nog tekens voor of na de 
match staan.

In alle gevallen kan een speciaal teken voorafgegaan worden door een 
backslash om de letterlijke betekenis te gebruiken; zo matcht `.` op alle 
tekens, maar `\.` alleen op de punt.

De scherpe lezer zal opmerken dat in het eerstgenoemde voorbeeld de 
reguliere expressie `^/blog/\d+` inderdaad niet op `/test/blog/5` zal 
matchen, aangezien er nog tekens voor de match staan en het teken `^` is 
gebruikt in de regex. Echter, deze regex zal wel matchen op bijvoorbeeld 
`/blog/5-php-8.5-is-nu-beschikbaar`, omdat geen dollarteken wordt 
gebruikt. Dit is in dit geval bewust;
[Google](https://developers.google.com/search/docs/crawling-indexing/url-structure)
raadt bijvoorbeeld het opnemen van een beschrijving van de pagina aan voor het
optimaliseren van zoekresultaten: *"When possible, use readable words 
rather than long ID numbers in your URLs."* Een voorbeeld van een dergelijke 
URL-structuur in de praktijk is te vinden op nu.nl: de URL
https://www.nu.nl/binnenland/6381848/live-sneeuw-vanaf-middernacht-code-oranje-in-het-noorden-vanwege-gladheid.html
is de "officiële" URL waar naar gelinkt worden, maar alleen het getal is 
relevant. De URL https://www.nu.nl/test/6381848/test kan bijvoorbeeld ook 
gebruikt worden om dezelfde pagina te vinden.

## Regexes in PHP

In PHP is de functie
[`preg_match`](https://www.php.net/manual/en/function.preg-match.php) 
beschikbaar om strings te doorzoeken op reguliere expressies. De eerste
parameter van deze functie is de te gebruiken reguliere expressie en de 
tweede parameter is de string die doorzocht moet worden. Als de regex 
gevonden wordt, geeft de functie de waarde 1 terug, anders de waarde 0.

Let er hierbij op dat de reguliere expressie omsloten moet worden door twee 
niet-alfanumerieke tekens, de zogeheten *delimiters*. Het is gebruikelijk om 
hier slashes voor te gebruiken, zoals in het onderstaande voorbeeld. Dit is 
bijvoorbeeld ook het gebruik in talen als Perl en JavaScript.

```php
$match = preg_match('/h[eu]lp/', 'helpen');
```

In dit voorbeeld zal de waarde van `$match` 1 zijn, aangezien de regex 
gevonden kan worden in de string `helpen`.

Als je de delimiters wilt gebruiken binnen de regex, moeten deze 
voorafgegaan worden door een backslash. De eerdergenoemde regex `/blog/\d+` 
zou dus, als slashes als delimiters worden gebruikt, als `/\/blog\/\d+/` 
geformatteerd moeten worden. Dit is duidelijk niet ideaal; het is daarom aan 
te bevelen om andere delimiters te gebruiken. Als bijvoorbeeld uitroeptekens 
worden gebruikt kan de regex als `!/blog/\d+!` worden geformatteerd.

## Capturing groups

Het matchen van URL's is een begin, maar in vrijwel alle gevallen zullen we 
een onderdeel van de URL nodig hebben om het request goed af te handelen. In 
het voorbeeld `^/blog/\d+`, willen we onderscheid kunnen maken tussen 
bijvoorbeeld `/blog/1` en `/blog/5`. Nu is het natuurlijk mogelijk om in de 
controller het pad opnieuw op te halen en daar, met bijvoorbeeld de functie 
`explode`, het tweede gedeelte van het pad op te halen en dat te gebruiken. 
Dat is echter niet ideaal: als we zouden besluiten om in plaats van `/blog/` 
de prefix `/nl/blog/` te gaan gebruiken moet dan niet alleen het pad in de 
router worden aangepast, maar ook de logica die het getal uit het pad haalt.

Het zou daarom de voorkeur hebben als de id meteen bij het matchen van de 
reguliere expressie verkregen kan worden. Dit is ook mogelijk; het is 
mogelijk om haakjes `(` en `)` te gebruiken om een deel van de reguliere 
expressie als *capturing group* aan te merken. Als we bijvoorbeeld het id 
willen verkrijgen, kunnen we de regex `^/blog/(\d+)` gebruiken. Het is dan 
in PHP mogelijk om een derde parameter mee te geven aan `preg_match`. Deze 
parameter is *by reference*, dus dit moet een verwijzing naar een variabele 
zijn. In deze variabele wordt een array gezet met de hele gevonden match en 
alle capturing groups, zoals in onderstaand voorbeeld.

```php
$has_match = preg_match('!^/blog/(\d+)!', '/blog/5-php-8.5-is-nu-beschikbaar', $matches);
var_dump($has_match, $matches);
```

Bovenstaande code zal onderstaande uitvoer geven.
```
int(1)
array(2) {
  [0]=>
  string(7) "/blog/5"
  [1]=>
  string(1) "5"
}
```

Te zien is dat de hele match, `/blog/5`, te vinden is op index 0 van de 
array. Daarnaast is de capturing group `(\d+)` terug te vinden op index 1; 
als er meerdere capturing groups zijn worden ze van links naar rechts genummerd 
aan de hand van de positie van het openingshaakje.

Bij een capturing group kunnen we ook een naam meegeven; de capturing group 
zal dan ook onder die naam in de array terugkomen. Dit kan door `?P<id>` aan 
het begin van de capturing group te zetten, waarbij `id` de sleutel in de 
array wordt en dus vervangen kan worden door een andere naam. Als we 
bovenstaande voorbeeld hiermee aanpassen, zoals hieronder staat, zal ook de 
sleutel `id` verschijnen in de array `$matches`.

```php
$has_match = preg_match('!^/blog/(?P<id>\d+)!', '/blog/5-php-8.5-is-nu-beschikbaar', $matches);
var_dump($has_match, $matches);
```

De uitvoer wordt nu als volgt.

```
int(1)
array(3) {
  [0]=>
  string(7) "/blog/5"
  ["id"]=>
  string(1) "5"
  [1]=>
  string(1) "5"
}
```

Te zien is dat de id nu zowel beschikbaar is onder de index 1 als onder de 
sleutel `id`.
