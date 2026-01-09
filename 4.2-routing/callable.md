# Verwijzingen naar functies

Voor een router kan het handig zijn om per route aan te geven welke functie 
deze route afhandelt. Hiertoe zou bijvoorbeeld een associatieve array 
gebruikt kunnen worden met URL-patronen als sleutels en een verwijzing naar 
de bijbehorende functie als waardes. Dit is overigens zeker niet de enige 
mogelijke, of zelfs maar beste, implementatie. De vraag hierbij is op welke 
manier je verwijzingen naar functies kan opslaan. Daarnaast is het bij 
functionele programmeerstijlen vaak handig om met 
verwijzingen naar funties te werken. In PHP bestaan hiervoor twee types.

## Callables

Het eerste type is een
[callable](https://www.php.net/manual/en/language.types.callable.php). Dit is
een generiek type dat een functieverwijzing beschrijft. Als een variabele 
`$a` van het type `callable` is, kan de functie waarnaar `$a` verwijst 
aangeroepen worden met `$a()`, waarbij eventuele argumenten net als bij een 
normale aanroep tussen de haakjes worden gezet.

Een callable kan op een aantal manieren gemaakt worden. In de eerste plaats 
is de naam van een functie, als string, een callable, die je vervolgens 
zoals hierboven beschreven kan aanroepen. Dit wordt toegepast in het 
onderstaande voorbeeld.

```php
$a = 'strlen';
var_dump($a('text'));
```

Deze code zal `int(4)`, de lengte van de string `text`, afdrukken.

In veel standaardfuncties van PHP is het mogelijk om een callable mee te 
geven die bepaalt hoe de functie werkt. Soms hebben deze functies iets 
andere namen dan de functie met standaardgedrag. Zo zal de functie
[`sort`](https://www.php.net/manual/en/function.sort.php) een array sorteren
door gebruik te maken van de ingebouwde volgorde van waardes die ook 
gebruikt wordt als je vergelijkt met `>` of `<`. Als je echter een andere 
volgorde wil hebben, kan je gebruik maken van de functie
[`usort`](https://www.php.net/manual/en/function.usort.php), waarbij je als 
tweede parameter een callable kan opgeven. In dit specifieke geval heeft die 
callable twee parameters, de waardes waartussen vergeleken moet worden, en 
moet de functie -1, 0 of 1 teruggeven als het eerste argument respectievelijke 
kleiner dan, gelijk aan of groter dan het tweede argument.

Een tweede manier om een callable te maken is door een array met twee 
elementen te gebruiken. Het element met index 0 is dan een object, en het 
element met index 1 is een string met de naam van een methode op dat object. 
Deze callable representeert een verwijzing naar een methode op een specifiek 
object. Merk op dat index 0 een object en geen klassenaam bevat; een methode 
kan immers altijd alleen worden aangeroepen op een specifieke instantie van 
een klasse. Stel bijvoorbeeld dat we een variabele `$kernel` hebben 
die `KernelInterface` implementeert. Deze interface heeft een methode 
`handle`. Om een callable te maken die naar deze methode verwijst, kunnen we 
een array met twee elementen `[$kernel, 'handle']` gebruiken.

Daarnaast is elke anonieme functie, die we hierna nog zullen bespreken, ook een 
callable en is elk object dat een methode `__invoke` heeft ook een callable. 
In dat laatste geval wordt door het aanroepen van het object als callable 
die methode `__invoke` aangeroepen; `$obj()` is dan dus feitelijk gelijk aan 
`$obj->__invoke()`.

Sinds PHP 8.1 is er bovendien de mogelijkheid om rechtstreeks een callable 
te verkrijgen door een
[pseudo-functieaanroep](https://www.php.net/manual/en/functions.first_class_callable_syntax.php),
waardoor het in beginsel niet meer noodzakelijk is om de eerdergenoemde
callable-syntaxen met strings en arrays te gebruiken. Door de functie of 
methode aan te roepen met het beletselteken `...` als parameterlijst, wordt 
de functie niet aangeroepen, maar wordt er een callable van gemaakt. Waar 
hierboven bijvoorbeeld de string `'strlen'` werd gebruikt om een callable 
naar de functie `strlen` te maken, kan dit ook met de pseudo-aanroep
`strlen(...)`, zoals in onderstaand voorbeeld.

```php
$a = strlen(...);
var_dump($a('text'));
```

Op dezelfde manier kan dit gedaan worden met methode-aanroepen. Waar we 
eerder `[$kernel, 'handle']` gebruikten om een callable te verkrijgen naar 
de methode `handle` van het object `$kernel`, kan dat dus ook met de syntax 
`$kernel->handle(...)`.

Deze syntax is qua gedrag niet geheel identiek aan de eerdergenoemde 
syntaxen met strings of arrays. In de eerste plaats wordt de controle of een 
methode bereikbaar is, als deze bijvoorbeeld private is, gedaan op de plek 
waar de callable gemaakt wordt, en niet op de plek waar deze gebruikt wordt. 
Zo is het dus met deze syntax mogelijk om een verwijzing naar een `private` 
functie terug te geven vanuit een andere methode van dat object. Als je dat 
zou proberen met de oude syntax, zou het gebruik van de callable buiten het 
object tot een foutmelding leiden, omdat op die plek de `private` functie 
niet beschikbaar is.

Daarnaast zijn callables die op deze manier worden gemaakt een instantie van 
een subtype van callable, de klasse
[`Closure`](https://www.php.net/manual/en/class.closure.php). Dit biedt 
enkele mogelijkheden die verder gaan dan het generieke type `callable`, maar 
die voeren te ver om hier uit te werken. In het algemeen is het aan te raden 
om bij typehinting het type `callable` te gebruiken, zodat ook de hier 
genoemde syntaxen met strings en arrays gebruikt kunnen worden.

## Anonieme functies

Het kan, afhankelijk van de gekozen programmeerstijl, voorkomen dat je veel 
callbacks nodig hebt die zeer kort zijn en vaak slechts één keer gebruikt 
worden. Dit zal met name voorkomen bij een meer functionele programmeerstijl.
Als je bijvoorbeeld de functie
[`array_map`](https://www.php.net/manual/en/function.array-map.php)
gebruikt heb je een callable nodig die op elk element van een array 
toegepast zal worden; een constructie die te vergelijken is met list 
comprehensions in Python. Zo kan je bijvoorbeeld op onderstaande manier een 
array krijgen met de lengtes van alle strings in een array.

```php
$array = ['dit', 'is', 'een', 'array', 'met', 'strings'];
var_dump(array_map('strlen', $array));
```

Hierbij kan je gebruik maken van een callable die verwijst naar de 
ingebouwde functie `strlen`. Zou je echter de getallen in een array willen 
verdubbelen, dan is daar geen ingebouwde functie voor beschikbaar en moet je 
die dus zelf schrijven, zoals hieronder.

```php
function dbl($x) {
    return $x * 2;
}

$array = [1, 2, 3, 4];
var_dump(array_map('dbl', $array));
```

Dit is niet ideaal, omdat hiermee een functie in de global namespace gezet 
wordt die eigenlijk alleen maar lokaal nodig is en bovendien de definitie 
van de functie mogelijk vrij ver verwijderd staat van het gebruik in 
`array_map`, waardoor de flow van de code moeilijker te volgen is.

Een alternatief is het gebruik van
[anonieme functies](https://www.php.net/manual/en/functions.anonymous.php).
Anonieme functies krijgen geen naam en zijn, net als callables die de
`(...)`-syntax gebruiken, instanties van `Closure`.

Anonieme functies zijn bovendien expressies., Dit betekent dat je ze niet als 
apart statement hoeft te schrijven, maar je ze meteen waar ze nodig zijn kan 
gebruiken, zoals in een toekenning of bijvoorbeeld als argument in de 
functie `array_map`. De syntax hierbij is dat het keyword `function` 
gebruikt wordt, net als bij een reguliere functie, maar dat daarna meteen de 
lijst met parameters volgt; de functie krijgt dus geen naam. Dit ziet er als 
volgt uit.

```php
$array = [1, 2, 3, 4];
var_dump(array_map(function ($x) {
    return $x * 2;
}, $array));
```

Op deze manier wordt meteen bij het lezen van de aanroep van `array_map` 
duidelijk wat de operatie is die uitgevoerd wordt.

Een tweede mogelijkheid van anonieme functies is dat je ze kan *binden* aan 
lokale variabelen in de scope waarbinnen de anonieme functie wordt 
aangemaakt. In principe kunnen anonieme functies dergelijke variabelen niet 
lezen; onderstaande code zal dus een waarschuwing over een ongedefinieerde 
variabele geven.

```php
$number = 2;
$mul = function ($a) { return $a * $number; }
var_dump($mul(5));
```

Om een lokale variabele toch binnen een anonieme functie te kunnen gebruiken,
moet deze hieraan gebonden worden met het keyword `use`. Daardoor wordt de 
waarde van die variabele op het moment dat de anonieme functie gedefinieerd 
wordt vastgelegd en zal die anonieme functie altijd die waarde blijven 
gebruiken, ook als de variabele later een andere waarde krijgt.

```php
$number = 2;
$mul = function ($a) use ($number) { return $a * $number; }
$number = 3;
var_dump($mul(5));
```

Bovenstaande code zal dus `int(10)` afdrukken, omdat op het moment dat de 
functie in de tweede regel gedefinieerd wordt, de waarde 2 hieraan gebonden 
wordt en het dus niet meer uitmaakt dat de variabele in regel 3 een andere 
waarde krijgt. Het is wel mogelijk om de anonieme functie rechtstreeks aan 
de variabele te binden, zodanig dat de actuele waarde van de variabele 
gebruikt wordt. Dit kan door de variabele *by reference* te binden. Net als 
bij parameters die *by reference* zijn, gebeurt dit door een ampersand `&` 
voor de variabele te zetten, zoals in onderstaand voorbeeld.

```php
$number = 2;
$mul = function ($a) use (&$number) { return $a * $number; }
$number = 3;
var_dump($mul(5));
```

Deze code zal wel `int(15)` afdrukken, omdat de variabele `$number` *by 
reference* gebonden is en dus steeds de actuele waarde van `$number` gebruikt.

Merk op dat het in het algemeen niet nodig is om variabelen *by reference* 
te binden. Vaak is het juist logisch om *by value* te binden, dus zonder 
ampersand. Zo kan je bijvoorbeeld een callable teruggeven als 
functieresultaat die gebind is aan variabelen die beschikbaar waren in het 
object op het moment van de functieaanroep die de callable teruggeeft, en 
kan je daarmee relevante toestand bewaren. Denk hierbij bijvoorbeeld aan een 
callable die door de router wordt teruggegeven en moet weten welke 
parameters in de URL zaten.

Daarnaast is, als een anonieme functie binnen een object wordt gedefinieerd, 
de referentie naar het actuele object, `$this`, altijd gebonden aan de 
anonieme functie en dus beschikbaar.

Omdat in veel gevallen anonieme functies alleen een return-statement 
bevatten, dus feitelijk simpele berekeningen zijn, zoals in het hierboven 
aangehaald voorbeeld met `array_map`, is hier een kortere syntax voor 
beschikbaar. Dit heet een
[arrow-functie](https://www.php.net/manual/en/functions.arrow.php).
In deze syntax wordt in plaats van het keyword `function` het keyword `fn` 
gebruikt en volgt na de parameterlijst een pijl `=>` en een expressie die 
als functieresultaat gebruikt wordt. In plaats van `function ($x) { return 
$x * 2; }` kan je dus `fn($x) => $x * 2` schrijven. Als we dit toepassen op 
het voorbeeld met `array_map` ziet dat er als volgt uit.

```php
$array = [1, 2, 3, 4];
var_dump(array_map(fn($x) => $x * 2, $array));
```

Bijzonder aan deze arrow-syntax is dat alle lokale variabelen automatisch 
*by value* gebonden zijn; zo zal onderstaande code `int(10)` afdrukken omdat de 
variabele `$number` gebonden wordt. Sterker, het gebruik van een 
`use`-clausule is bij deze syntax niet toegestaan.

```php
$number = 2;
$mul = fn($a) => $a * $number;
$number = 3;
var_dump($mul(5));
```

