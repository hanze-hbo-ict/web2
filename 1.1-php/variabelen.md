# Variabelen

PHP heeft net als elke andere imperatieve taal de mogelijkheid om variabelen 
te gebruiken. Anders dan in Java hoeven variabelen in PHP niet gedeclareerd 
te worden voordat je ze kan gebruiken. Bovendien hebben variabelen in PHP in 
principe geen vastgesteld type; je kan zonder problemen eerst een getal 
toekennen aan een variabele en daarna een string, net zoals in Python. PHP 
is dan ook een dynamisch getypeerde taal. Daarnaast is belangrijk op te 
merken dat een variabelenaam in PHP altijd voorafgegaan wordt door het 
dollarteken `$`. Deze syntax is ontleend aan de programmeertaal Perl. 
Waardes kunnen aan variabelen worden toegekend met de toekenningsoperator 
`=`, zoals bijvoorbeeld `$a = 5;`. Later in de code kan deze variabele weer 
aangesproke worden met de naam `$a`.

Een vrij unieke techniek in PHP is dat een variabele *indirect* kan worden 
aangesproken. Hierbij wordt een naam voorafgegaan door *twee* dollartekens. 
Wat dit betekent is dat eerst de waarde van de genoemde variabele wordt 
opgehaald, en dat deze naam vervolgens als variabelenaam gezien wordt. 
Hiermee kan je dus dynamisch bepalen welke variabele je wilt aanspreken. 
Hieronder is hier een voorbeeld van te zien.

```php
$a = 'var'; // strings worden nog besproken
$var = 5;
echo $var, PHP_EOL; // drukt 5 af
echo $a, PHP_EOL; // drukt 'var' af
echo $$a, PHP_EOL; // drukt 5 af
```

De eerste twee `echo`-statements drukken de waarden van de variabelen `$var` 
en `$a` af; ze spreken deze variabelen *direct* aan. In het laatste 
`echo`-statement wordt de waarde van `$a`, de string `'var'`, gebruikt als 
naam van de variabele die aangesproken moet worden. Hierdoor wordt de 
variabele `$var` dus *indirect* aangesproken en wordt de waarde 5 afgedrukt.

De waarde van een variabele kan op twee manieren worden afgedrukt. In de 
eerste plaats kan het al besproken `echo`-statement worden gebruikt. Dit 
drukt de waarde op zich af, zonder aan te geven welk type dit is, net als 
wanneer de waarde zelf in het statement zou staan. Daarnaast kan de 
functie `var_dump` worden gebruikt om ook het type te tonen; dit lijkt niet 
direct nuttig maar kan erg handig zijn voor het debuggen van code. 
Daarnaast wordt niet elke waarde op een nuttige manier afgedrukt met `echo`,
maar `var_dump` zal altijd een voor het debuggen nuttig resultaat geven, 
zoals te zien in onderstaand voorbeeld.

```php
$num = 1;
$array = [1, 2, 3]; // alleen ter illustratie, arrays worden nog besproken
echo $num, PHP_EOL, $array, PHP_EOL; // drukt '1' en 'Array' af
var_dump($num, $array); // drukt 'int(1)' en de inhoud van $array af
```

Naast variabelen kent PHP ook constanten. Een constante wordt gedefinieerd 
met de functie
[`define`](https://www.php.net/manual/en/function.define.php) en kan 
vervolgens gebruikt worden door de naam als kale string, dus zonder 
aanhalingstekens of dollartekens, te gebruiken, zoals in onderstaand voorbeeld.

```php
define('FOO', 1);
echo FOO, PHP_EOL; // drukt 1 af
```

## Operatoren

PHP kent natuurlijk de gangbare
[rekenkunde operatoren](https://www.php.net/manual/en/language.operators.arithmetic.php)
`+`, `-`, `*`, `/` en daarnaast `**` voor machtsverheffen en `%` als 
modulo-operator, zoals te zien in onderstaand voorbeeld. Daarnaast heeft PHP 
een uitgebreide verzameling ingebouwde
[wiskundige functies](https://www.php.net/manual/en/ref.math.php)
zoals onder meer
[`abs`](https://www.php.net/manual/en/function.abs.php),
[`round`](https://www.php.net/manual/en/function.round.php)
[`min`](https://www.php.net/manual/en/function.min.php) en
[`max`](https://www.php.net/manual/en/function.max.php).

```php
$a = 9;
$b = 1.5;
$c = 2;
echo $a + $b, PHP_EOL; // 10.5
echo $a - $b, PHP_EOL; // 7.5
echo $a * $b, PHP_EOL; // 13.5
echo $a / $b, PHP_EOL; // 6
echo $a ** $b, PHP_EOL; // 27
echo $a % $c, PHP_EOL; // 1
```

Net als Python kunnen `+=`, `-=` en zo verder gebruikt worden als
[gecombineerde berekening en toekenning](https://www.php.net/manual/en/language.operators.assignment.php#language.operators.assignment.arithmetic).
`$a += 5` is functioneel gelijk aan `$a = $a + 5`. Daarnaast kent PHP net 
als Java de 
[operatoren `++` en `--`](https://www.php.net/manual/en/language.operators.increment.php).

## Datatypes

Zoals gezegd is PHP een dynamisch getypeerde taal. Dat betekent niet dat de 
taal geen datatypes kent, maar alleen dat een variabele niet met een 
bijbehorend type gedeclareerd hoeft te worden, maar steeds andere types mag 
bevatten. PHP kent dus wel degelijk een aantal types.

PHP heeft twee getaltypes,
[`int`](https://www.php.net/manual/en/language.types.integer.php) en
[`float`](https://www.php.net/manual/en/language.types.float.php).
Het type `int` kan alleen gehele getallen, *integers*, bevatten. In principe 
geven berekeningen op integers weer integers terug, behalve als het getal 
te groot of te klein is om in een integer te passen, of als de operator `/` 
wordt gebruikt en het antwoord geen geheel getal is. In beide gevallen 
wordt een waarde van het type `float` teruggegeven. Dat type bevat 
kommagetallen, waarbij de komma niet op een vaste positie hoeft te staan, 
dus een zogeheten *floating-point*-getal. Als een getal aan een variabele 
wordt toegekend is dit een `float` als er een decimale punt instaat of als 
wetenschappelijke notatie, te herkennen aan een `e` in het getal, gebruikt 
wordt. Anders is dit een `int`. `$a = 1` kent dus een `int` toe aan `$a`, 
maar `$a = 1.0` of `$a = 1e0` (1 · 10⁰ = 1) kennen een `float` toe aan `$a`.

Daarnaast heeft PHP een *boolean* type
[`bool`](https://www.php.net/manual/en/language.types.boolean.php) om een 
waarheidswaarde `true` of `false` op te slaan en het type
[`null`](https://www.php.net/manual/en/language.types.null.php) dat gebruikt 
wordt voor onbekende of ongeïnitialiseerde waardes. Verder heeft PHP nog een 
aantal complexere types die later besproken worden, waaronder strings, 
arrays en objecten.
