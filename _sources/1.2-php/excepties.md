# Foutafhandeling

PHP heeft om historische redenen drie manieren om fouten in een applicatie 
te melden. In de eerste plaats gebeurt dit in sommige gevallen door een 
speciale returnwaarde, meestal `false`, te geven als een functieaanroep faalt.
Zo geeft de functie
[`fopen`](https://www.php.net/manual/en/function.fopen.php) een file pointer 
terug als het bestand geopend kon worden, en `false` als er een fout 
opgetreden is. Deze stijl van foutafhandeling komt met name voor in functies 
die aan C ontleend zijn, aangezien dit ook in C een gebruikelijke manier van 
foutafhandeling is. Deze methode zal hier niet verder besproken worden 
aangezien hier geen nieuwe taalconstructies voor nodig zijn; het is aan de 
gebruiker van dergelijke functie om met een `if`-statement te controleren of 
de functie geslaagd is. Merk hierbij nog op dat de conditie in de `if` normaal 
gesproken gebruik zal maken van de vergelijkingsoperator `===` om te 
voorkomen dat een returnwaarde van 0 of een lege string gezien wordt als een 
fout.

# Errors

Een andere methode die PHP toepast is het rapporteren van
[errors](https://www.php.net/manual/en/language.errors.php),
warnings en notices. Als er een fout optreedt, zal PHP een error 
rapporteren. PHP print dan een melding dat er een fout is opgetreden, en in 
welke regel dat was. Dit gebeurt bijvoorbeeld als de hoeveelheid 
beschikbaar geheugen wordt overschreden, maar ook als een niet-bestaand 
bestand wordt geïncluded met `include_once`. In het eerste geval is er 
sprake van een *fatal error* en zal de applicatie stoppen; in het tweede 
geval is er sprake van een *warning* en zal PHP na het afdrukken van deze 
foutmelding de applicatie verder uitvoeren. Sinds PHP 7 is het aantal 
gevallen waarin PHP een error geeft significant verminderd; veel situaties 
waarin eerst een error werd gegeven zullen nu een exceptie gooien, zoals 
hierna nog besproken wordt. Overschrijding van het beschikbare geheugen is 
echter nog wel een situatie waarin een error wordt gebruikt; hetzelfde geldt 
als het PHP-bestand dat uitgevoerd wordt syntaxfouten bevat.

Zoals we hierboven zagen zijn niet alle gerapporteerde fouten even ernstig. 
In sommige gevallen kan PHP de rest van de applicatie uitvoeren, in andere 
gevallen niet. Foutmeldingen hebben ieder een eigen *severity*. Naast 
enkele varianten van errors en warnings kent PHP ook *notices*, meldingen 
van mogelijke fouten die als minder erg worden gezien dan warnings, en 
*deprecationmeldingen*, meldingen van het gebruik van taalconstructies die 
in een volgende PHP-versie verwijderd zullen worden. Sinds PHP 8 zijn de 
meeste *notices* warnings geworden, dus dat niveau wordt nog maar weinig 
gebruikt.

Al deze niveaus hebben een eigen
[constante](https://www.php.net/manual/en/errorfunc.constants.php)
die gebruikt kan worden om de melding al dan niet te tonen. Dit gebeurt door 
middel van de functie
[`error_reporting`](https://www.php.net/manual/en/function.error-reporting.php).
Deze functie heeft als eerste parameter een getal dat aangeeft welke fouten 
getoond moeten worden. Dit getal wordt opgebouwd door de bitwise OR `|` te 
nemen van de relevante constanten; de constante `E_ALL` kan gebruikt worden 
om alle niveaus te tonen. Zo betekent `error_reporting(0)` dat geen enkele 
fout getoond moet worden, `error_reporting(E_ERROR | E_WARNING | E_PARSE)` 
dat alleen deze drie niveaus getoond moeten worden en `error_reporting(E_ALL 
& ~E_NOTICE)` dat alle niveaus behalve notices getoond moeten worden; `~` is 
de bitwise NOT operator en `&` is bitwise AND. Ook errors die niet 
gerapporteerd worden zullen de applicatie nog steeds stoppen, alleen wordt 
er dan geen melding getoond. Warnings stoppen de applicatie al niet, dus 
door die te onderdrukken worden ze geheel onzichtbaar.

Het is in een ontwikkelomgeving meestal wenselijk om fouten te tonen om het 
onwikkelproces te ondersteunen, maar dit is anders op een productieomgeving. 
Daar is het vaak juist niet wenselijk. In het bestand `php.ini` kan de 
instelling `display_errors` op `0` worden gezet om alle foutmeldingen te 
verbergen; dit kan ook in PHP zelf ingesteld worden door middel van de functie
[`ini_set`](https://www.php.net/manual/en/function.ini-set.php). Onderstaand 
commando zal bijvoorbeeld alle foutmeldingen verbergen.

```php
ini_set('display_errors', '0');
```

Daarnaast is sinds PHP 8.5 de setting `fatal_error_backtraces` beschikbaar. 
Deze setting, die default aan staat, zorgt ervoor dat ook bij een error een 
stacktrace getoond wordt waardoor je kan zien welke functies zijn 
aangeroepen. Dit kan ook uitgezet worden via `php.ini` of `ini_set`.

PHP biedt twee mogelijkheden om op het optreden van fouten te reageren. In 
de eerste plaats kan je een functie maken die wordt aangeroepen elke keer 
als er een fout optreedt. Deze functie krijgt de severity en een foutmelding 
mee als parameters en moet een boolean teruggeven. Als de functie `false` 
teruggeeft, wordt de standaard error handler van PHP gebruikt om de fout af 
te handelen, anders niet. Om deze functie bij PHP te registreren, moet je de 
functie
[`set_error_handler`](https://www.php.net/manual/en/function.set-error-handler.php)
aanroepen met een string met de naam van de functie als parameter, zoals in 
het onderstaande voorbeeld.

```php
function error_handler(int $errno, string $errstr): boolean
{
    throw new ErrorException($errstr, 0, $errno);
}

set_error_handler('error_handler');
```

Merk op dat hier de nog te bespreken syntax voor het gooien van excepties 
wordt gebruikt. Wat deze error handler doet, is de meeste errors die PHP 
rapporteert omzetten in excepties die elders afgevangen zou kunnen worden.
Dit is een niet ongebruikelijke manier om hiermee om te gaan, zeker in PHP 
versies die ouder zijn dan PHP 7. In die versie zijn immers, zoals genoemd, 
de meeste fatale fouten al omgezet naar excepties. De hier genoemde code zal 
ook excepties gooien voor warnings en deprecations. Dit is enigszins 
aggresief; warnings dienen vermeden te worden dus dat die excepties 
opleveren is redelijk, maar deprecations zouden onverwacht kunnen ontstaan 
door het upgraden van de PHP-versie. Door voor dergelijke fouten geen 
exceptie te gooien maar de reguliere error handling te laten uitvoeren kan 
dit ondervangen worden.

Fatale fouten kunnen niet afgehandeld worden door de error handler kunnen 
wel door een *shutdown function* worden afgehandeld, in zoverre dat gelogd zou 
kunnen worden dat ze opgetreden zijn. Het is immers dan niet mogelijk om de 
applicatie nog te laten werken, maar wel zou een nette foutmelding getoond 
kunnen worden. Deze functie kan geregistreerd worden met
[`register_shutdown_function`]().
Een nuttige functie die in de shutdown function gebruikt kan worden is
[`error_get_last`](https://www.php.net/manual/en/function.error-get-last.php),
die informatie geeft over de laatst opgetreden fout. Als dit een fatale fout 
is die niet door de error handler kan worden afgehandeld, kan dit wel in de 
shutdown functie, zoals in onderstaand voorbeeld.

```php
function shutdown_function(): void
{
    $error = error_get_last();
    if ($error !== null && in_array($error['type'], [E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR, E_USER_ERROR, E_RECOVERABLE_ERROR])) {
        echo "Fatal error: {$error['message']}\n";
    }
}

register_shutdown_function('shutdown_function');
```

## Excepties

Ten slotte heeft PHP sinds versie 5 de beschikking over
[*excepties*](https://www.php.net/manual/en/language.exceptions.php).
Deze werken grotendeels op dezelfde manier als in Java. Een exceptie is een 
object van de klasse `Throwable` of een subklasse hiervan. Excepties kunnen 
gegooid worden, en als ze nergens worden gevangen zullen ze uiteindelijk de 
applicatie stoppen. Excepties kunnen gegooid worden door standaardfuncties, 
maar ook door de programmeur door middel van het keyword `throw`, zoals in 
onderstaand voorbeeld, waarin de ingebouwde exceptieklasse `DomainException` 
wordt gebruikt.

```php
if ($x <= 5) {
    $x = 2 * $x;
} else {
    throw new DomainException('$x is too large');
}
```

Sinds PHP 8 is `throw` een expressie, geen statement. Dit betekent niet dat 
het niet als statement gebruikt mag worden; alle expressies mogen namelijk als 
statement gebruikt worden. Het betekent wel dat `throw` bijvoorbeeld 
gebruikt kan worden met de ternary conditionele operator `?:`. Bovenstaande 
code kan dus ook als volgt worden geschreven.

```php
$x = $x <= 5 ? 2 * $x : throw new DomainException('$x is too large');
```

De toegevoegde waarde hiervan is met name dat ook bij gebruik van arrow 
functies, die in een later hoofdstuk besproken zullen worden, excepties 
gegooid kunnen worden, waardoor de code korter en duidelijker kan worden.

Excepties kunnen ook afgevangen worden door middel van een 
`try`-`catch`-blok, vergelijkbaar met Java. Excepties die in het `try`-blok 
worden gegooid zullen de applicatie niet stoppen; in plaats daarvan wordt de 
code in het toepasselijke `catch`-blok uitgevoerd. Het is ook mogelijk om 
het blok te eindigen met een `finally`-blok dat altijd wordt uitgevoerd, 
ongeacht of er een exceptie is gegooid. In het `catch`-blok mag ook een 
nieuwe exceptie gegooid worden die dan eventueel in een bovenliggend 
`try`-`catch`-blok gevangen kan worden.

`catch`-blokken moeten specificeren welke klassen van excepties ze afvangen. 
Hiertoe moet na het keyword `catch` een exceptienaam tussen haakjes worden 
gezet. Het is toegestaan om meerdere `catch`-blokken te hebben die ieder een 
andere exceptie afvangen; deze worden van boven naar beneden gecontroleerd 
en het eerste passende blok wordt gebruikt. Een enkel `catch`-blok kan ook 
meerdere exceptieklassen afvangen; de namen moeten dan gescheiden worden 
door het pipekarakter `|`. Indien gewenst kan na de klassenaam een 
variabelenaam worden gezet; de exceptie wordt in dat geval toegekend aan die 
variabele zodat hiernaar verwezen kan worden in het `catch`-blok.

Enkele mogelijkheden van het `try`-`catch`-blok worden getoond in het 
onderstaande voorbeeld.

```php
function divide($x, $y)
{
    try {
        return $x / $y;
    } catch (DivisionByZeroError) {
        throw new DomainException('$y cannot be zero');
    } catch (TypeError|Exception $e) {
        echo "Unexpected error: $e\n";
    } finally {
        echo "This code is always executed.\n";
    }
}
```

Als deze functie wordt uitgevoerd, zal in alle gevallen de code in het 
`finally`-blok worden uitgevoerd; daarnaast zal, als `$y` gelijk is aan 0, 
uiteindelijk een `DomainException` worden gegooid.

PHP kent twee ingebouwde hiërarchieën voor exceptieklassen. Excepties waren 
namelijk oorspronkelijk altijd instanties van `Exception` of een subklasse. 
Sinds PHP 7 worden een aantal foutcondities die voorheen als error werden 
afgehandeld ook afgehandeld via het exceptiesysteem. Een voorbeeld hiervan 
is delen door 0, dat sinds PHP 7 een `DivisionByZeroError` gooit. Deze 
foutcondities gooien excepties die een instantie van `Error` of een 
subklasse daarvan zijn. Als dus `Exception` wordt gevangen, hetgeen 
gebruikelijk was in PHP-5-code, de zogeheten *Pokémon exception handling* 
("Gotta catch 'em all"), worden deze nieuwe errors niet afgevangen. Er is in 
PHP 7 ook een nieuw supertype van `Exception` en `Error` in het leven 
geroepen, `Throwable`. Alleen instanties van subklassen van dit type kunnen 
in een `throw`-expressie gebruikt worden.

Aangezien het in een webapplicatie vaak wenselijk is om excepties die nergens
anders worden afgevangen toch om te zetten in een redelijke foutpagina, zal er
vaak op een heel hoog niveau een `try`-`catch`-blok zijn dat `Throwable` 
afhandelt. Een andere manier om dit te bewerkstelligen is door het 
registreren van een *exception handler*. Dit is een functie die wordt 
aangeroepen als een exceptie nergens anders is afgehandeld. Nadat deze 
functie is uitgevoerd, wordt de applicatie gestopt. Als dit niet wenselijk 
is, moet een `try`-`catch`-blok gebruikt worden.Om PHP te vertellen welke
functie hiervoor gebruikt wordt, moet de functie 
[`set_exception_handler`](https://www.php.net/manual/en/function.set-exception-handler.php)
aangroepen worden met een string met de naam van de te gebruiken functie als
eerste argument, zoals in onderstaande voorbeeld. 

```php
function exception_handler(Throwable $exception): void {
  echo "Uncaught exception: {$exception->getMessage()}\n";
}

set_exception_handler('exception_handler');

$x = 1/0;
echo "1/0 = $x";
```

Deze code zal `Uncaught exception: Division by zero` afdrukken. Het laatste 
`echo`-statement zal niet worden uitgevoerd.

