# Typeconversie

In sommige gevallen zal PHP
[automatisch waardes omzetten](https://www.php.net/manual/en/language.types.type-juggling.php)
van het ene type naar een ander type. Zeker in het verleden waren de regels 
hiervoor vrij los waardoor dit tot vreemde resultaten kon leiden, maar in 
recente PHP versies zijn de regels hier veel strakker voor geworden 
waardoor dit maar zelden tot problemen zal leiden. De historische reden 
voor deze faciliteit is dat veel invoer voor PHP vanuit een URL zal komen, 
via de al besproken superglobal `$_GET`. Deze array bevat echter alleen 
maar stringwaardes, terwijl die strings vaak getallen zullen bevatten. Om 
het makkelijker te maken om hiermee te werken, konden deze strings op veel 
plekken als getallen gebruikt worden en werden ze dus automatisch omgezet.

## Automatische typeconversie

In de eerste plaats zet PHP automatisch types om bij wiskundige 
operatoren. Als één van de operanden, de waardes waarop de operator werkt, 
een float is, worden beide operanden omgezet naar floats. Anders worden 
beide operanden omgezet naar ints. Zo zal `5.0 + 3` gelijk zijn aan 8.0, 
want de int 3 wordt omgezet naar de float 3.0, en zal `3 + "5"` gelijk zijn 
aan 8, omdat de string `"5"` wordt omgezet naar de int 5.

Ook als een 
string en een getal worden vergeleken met bijvoorbeeld `<` of `>=` wordt de 
string eerst omgezet naar hetzelfde type als het getal. Dit gebeurt ook als 
twee strings die beide een getal bevatten worden vergeleken. Dit kan leiden 
tot onverwachte resultaten; zo is `"1" == "01"` waar, omdat beide strings 
een getal bevatten en wel beide het getal 1. Als dit onwenselijk is, en dat 
zal vaak zo zijn, dan is het slim om de operator `===` te gebruiken. Deze 
operator zal geen typeconversie toepassen en alleen `true` geven als beide 
types gelijk zijn. Dit betekent dan wel weer dat `1 === 1.0` onwaar is; 
weliswaar zijn beide getallen 1, maar een int is geen float.

Daarnaast worden bij het afdrukken van waarden en het samenvoegen van strings
variabelen waar nodig omgezet naar strings. Zo zal `3 . "5"` gelijk zijn 
aan de string `"35"`, want de int 3 wordt voor stringconcatenatie omgezet 
naar de string `"3"`. Dit gedrag is minder controversieel; het is vaak zeer 
handig om bijvoorbeeld getallen rechtstreeks in strings te kunnen interpoleren.

Verder worden waardes omgezet naar booleans in een `if`- of 
`while`-statement of bij gebruik van de ternaire vergelijkingsoperator `?:`. 
Ook dit is weinig controversieel; ook bijvoorbeeld C en Python hebben dit 
gedrag. Allerlei 'lege' waardes worden boolean als `false` gezien, zoals 
`null`, 0, 0.0, de lege string en de lege array. Ook de string `"0"` wordt 
als `false` gezien; dit kan mogelijk verwarrend zijn, dus het is bij een 
`if`-statement beter om expliciet met de lege string te vergelijken in 
plaats van aan te nemen dat alle niet-lege strings `true` zijn.

## Typeconversies bij functies

Ook bij het gebruik van typedeclaraties in functies worden variabelen 
omgezet naar het gewenste type. Als de functie `dbl` gedeclareerd is als 
`function dbl(int $x): int`, dan zal `dbl("2")` bijvoorbeeld gelijk zijn aan 
`dbl(2)`. Ook `dbl(2.0)` zal gelijk zijn aan `dbl(2)`. Dit betekent ook dat 
het gebruik van typedeclaraties kan leiden tot subtiel andere antwoorden, 
zoals in onderstaande voorbeelden te zien is.

```php
function dbl1($x) { return 2 * $x; }
function dbl2(int $x): int { return 2 * $x; }
function dbl3(int|float $x): int|float { return 2 * $x; }

var_dump(dbl1(2), dbl1(2.0), dbl1("2")); // 4, 4.0, 4 want 2.0 * 2 == 4.0
var_dump(dbl2(2), dbl2(2.0), dbl2("2")); // 4, 4, 4 want $x wordt altijd 2
var_dump(dbl3(2), dbl3(2.0), dbl3("2")); // 4, 4.0, 4 want alleen "2" wordt 2
```

Het is mogelijk om automatische typeconversies voor functies uit te zetten. 
Dit kan door het statement
[`declare(strict_types=1);`](https://www.php.net/manual/en/language.types.declarations.php#language.types.declarations.strict)
als eerste statement 
in een PHP-bestand op te nemen. Als dat gedaan wordt, worden 
functieargumenten in aanroepen naar functies in dat bestand niet meer 
automatisch omgezet. De enige uitzondering hierop is dat een `int` wel naar 
`float` omgezet kan worden. Als een onjuist type wordt meegegeven, zal er 
een foutmelding worden gegeven.

## Handmatige typeconversie

Door gebruik te maken van de
[*type casting*](https://www.php.net/manual/en/language.types.type-juggling.php#language.types.typecasting)
is het mogelijk om expliciet waardes van het ene type naar het andere type 
om te zetten. Dit kan door de naam van het gewenste type tussen haakjes voor 
de om te zetten waarde te plaatsen. Zo kan een waarde `$x` expliciet worden 
omgezet naar een int via `(int) $x` of naar een string via `(string) $x`. 
Daarnaast bestaan er een aantal functies die hetzelfde effect hebben als een 
typecast; dit zijn 
[`intval`](https://www.php.net/manual/en/function.intval.php),
[`floatval`](https://www.php.net/manual/en/function.floatval.php),
[`boolval`](https://www.php.net/manual/en/function.boolval.php) en
[`strval`](https://www.php.net/manual/en/function.strval.php)
die omzetten 
naar respectievelijke int, float, bool en string.