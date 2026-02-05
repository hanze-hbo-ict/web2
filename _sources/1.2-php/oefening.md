# Oefeningen

## Functies en types

### Kwadraten berekenen

Schrijf een functie `squares` die een array getallen accepteert en een nieuwe 
array teruggeeft waar elk getal gekwadrateerd is. Maak hierbij gebruik van 
een lege array waarin je de kwadraten zet, en gebruik een lus om de nieuwe 
array te vullen.

### Kwadraten by reference

Schrijf een functie `squaresByRef` die een array getallen accepteert, maar 
geen returnwaarde heeft. De functie moet de getallen in de meegegeven array 
kwadrateren, zodat de array die je meegeeft daarna ook daadwerkelijk 
veranderd is.

### Gemiddelde van meerdere argumenten

Schrijf een functie `averageAll` die een onbekend aantal argumenten accepteert.
Gebruik hiervoor de spread operator. Elk van de argumenten is een array van 
getallen of een enkel getal; je kan dit onderscheid maken door gebruik te 
maken van de functie
[`is_array`](https://www.php.net/manual/en/function.is-array.php).
De functie moet het gemiddelde van de waarden in alle argumenten berekenen, 
zoals in onderstaande voorbeeld.

```php
echo averageAll([1, 2, 3], 4, [5]), PHP_EOL; // 3
```

### Stringinterpolatie

Een operatie die in veel talen uitgevoerd kan worden is *stringinterpolatie*. 
In Python kan je bijvoorbeeld *f-strings* gebruiken: `f"{a} {b}"` is gelijk aan 
de waarde van de variabele `a`, gevolgd door een spatie, gevolgd door de 
waarde van de variabele `b`. In SQL kan je prepared statements op een 
vergelijkbare manier gebruiken, bijvoorbeeld als `SELECT * FROM users WHERE 
username = :username`, waarbij de parameter `username` in de `WHERE`-clause 
gezet wordt. PHP zelf kan dit met dubbele aanhalingstekens zoals in 
`"$a $b"`. Schrijf een functie `interpolate`, die een string gevolgd door een 
onbekend aantal parameters accepteert. De functie moet de waardes van de 
overige parameters in de string zetten, zoals in de onderstaande voorbeelden.

```php
echo interpolate('{a} en {b}', a: 3, b: 5), PHP_EOL; // 3 en 5
echo interpolate('{0} en {1}', 2, 3), PHP_EOL; // 2 en 3
```

Je kan de *spread operator* gebruiken voor argumenten met en zonder naam. Als 
ze een naam hebben, wordt die naam de sleutel in de associatieve array. 
Anders worden ze genummerd.

Gebruik de functie 
[`str_replace`](https://www.php.net/manual/en/function.str-replace.php)
om de interpolatie uit te voeren.

### Zoeken in JSON-formaat

[JSON](https://nl.wikipedia.org/wiki/JSON) is een dataformaat dat veel 
gebruikt wordt om complexe structuren over HTTP te sturen. Je kan in PHP de 
functie
[`json_decode`](https://www.php.net/manual/en/function.json-decode.php) 
gebruiken om dit te parsen. Schrijf een functie `getJsonValue` 
die een JSON-string en daarnaast een onbeperkt aantal keys accepteert. Als je 
bijvoorbeeld de keys `foo`, `bar` en `baz` meegeeft, moet de functie de 
JSON-string parsen en de waarde `$json['foo']['bar']['baz']` teruggeven, 
zoals in onderstaande voorbeeld. Het resultaat in dit voorbeeld moet dan 1 zijn.

```json
{"foo":{"bar":{"baz":1,"foo":2},"baz":3}}
```

Als één van de keys niet bestaat, moet de returnwaarde `null` zijn. Gebruik 
hiervoor de *null-coalesceoperator* `??`. Zie ook de onderstaande voorbeelden.

```php
$json = '{"foo":{"bar":{"baz":1,"foo":2},"baz":3}}';
echo jsonFind($json, 'foo', 'bar', 'baz'), PHP_EOL; // 1
echo jsonFind($json, 'foo', 'baz'), PHP_EOL; // 3
echo jsonFind($json, 'foo', 'baz', 'bar'), PHP_EOL; // null
echo jsonFind($json, 'baz'), PHP_EOL; // null
```

## Objecten en klassen

### Rationale getallen

[Rationale getallen](https://nl.wikipedia.org/wiki/Rationaal_getal)
zijn getallen die kunnen worden weergegeven als de  verhouding van twee 
gehele getallen; dat wil zeggen, elk getal $\frac{p}{q}$ waarbij 
$p$ en $q$ gehele getallen zijn is een rationaal getal. Je zal hier breuken 
in herkennen en breuken zijn inderdaad rationale getallen. PHP benadert 
niet-gehele rationale getallen met behulp van het type `float`, maar dit 
type biedt onvoldoende nauwkeurigheid, zeker waar het gaat om grotere 
getallen. In deze opgave ga je rationale getallen representeren met een 
klasse `Rational`.

### De klasse `Rational`

De klasse `Rational` heeft de volgende constructor

```php
public function __construct(private int $numerator, private int $denominator)
```

en de volgende methoden:

```php
/**
 * Voeg het Rational object b toe aan het object
 * en geef een nieuwe Rational terug met de som.
 */
public function add(Rational $b): Rational

/**
 * Vermenigvuldig het Rational object b met het object
 * en geef een nieuwe Rational terug met het product.
 */
public function multiply(Rational $b): Rational

/**
 * Trek het Rational object b af van het object en geef
 * een nieuwe Rational terug met het verschil.
 */
public function subtract(Rational $b): Rational

/**
 * Deel het object door het Rational object b en geef
 * een nieuwe Rational terug met het resultaat.
 */
public function divide(Rational $b): Rational

/**
 * Geeft true terug als het gelijk is aan een ander
 * Rational object, anders false
 */
public function equals(Rational $b): bool

/**
 * Geeft een string representatie terug van het rationale getal.
 * Als de noemer 1 is, druk dan alleen de teller af.
 */
public function __toString(): string
```

De klasse Rational bevat een tweetal instantievariabelen van het type `int` 
(`$numerator` en `$denominator`); deze worden gezet in de constructor bij het 
initialiseren van een nieuwe instantie van deze klasse.

Verder zie je methoden voor het vergelijken, optellen (1), aftrekken (2), 
vermenigvuldigen (3) en delen (4) van rationale getallen. Let op: 
operatires op twee rationale getallen geven altijd een nieuwe `Rational` terug, 
dit zie je ook terugkomen in de declaratie van deze methoden.

$$
\begin{eqnarray}
\frac{a}{b} + \frac{c}{d} &=& \frac{a \times d + c \times b}{b \times d} & (1)\\
\frac{a}{b} - \frac{c}{d} &=& \frac{a \times d - c \times b}{b \times d} & (2)\\
\frac{a}{b} \times \frac{c}{d} &=& \frac{a \times c}{b \times d} & (3) \\
\frac{a}{b} \div \frac{c}{d} &=& \frac{a \times d}{b \times c} & (4) \\
\end{eqnarray}
$$

Een typisch gebruik van deze klasse zou als volgt kunnen zijn:

```php
$a = new Rational(2, 3);
$b = new Rational(-1, 3);
$sum = $a->add($b);
echo $sum, PHP_EOL;  // prints 1/3
```

Let op: de laatste regel in het bovenstaande voorbeeld zal voor de eerste 
versie van `Rational` de waarde 3/9 geven. Later zal je een verbetering 
doorvoeren die de vereenvoudiging 1/3 als resultaat heeft.

Implementeer de klasse `Rational` op basis van de hierboven gegeven 
beschrijving. Bedenk ook hoe je omgaat met negatieve getallen en nul (delen 
door nul moet een `DivisionByZeroError` geven).

### `Rational` gebruiken

Schrijf een programma die de klasse `Rational` gaat gebruiken in een nieuw 
bestand, in dezelfde directory als het bestand met de klasse `Rational`. Dit 
programma gaat onderstaande functie implementeren.

```php
function approxE(int $n): Rational
```

Implementeer de functie `approxE` met de bovenstaande signatuur. In deze 
methode ga je een
[Taylorreeks](https://nl.wikipedia.org/wiki/Taylorreeks) gebruiken om de 
eerste `$n` termen van de rationale benadering 
van het getal $e$ te berekenen. Deze reeks is als volgt

$$
e = \frac{1}{0!} + \frac{1}{1!} + \frac{1}{2!} + \frac{1}{3!} + \frac{1}{4!} + \frac{1}{5!} + \cdots
$$

Je zal hier ook een methode voor de berekening van de faculteit nodig hebben;
je kan hiervoor onderstaande functie gebruiken.

```php
function factorial(int $n): int
{
    for ($fac = 1; $n > 0; $n--) {
        $fac *= $n;
    }
    return $fac;
}
```

Print steeds de waarde die je krijgt nadat elke term aan de benadering is 
toegevoegd. De uitvoer voor `approxE(6)` zal als volgt zijn.

```
1 2 5/2 32/12 780/288 93888/34560
```

### `Rational` verbeteren

Er zijn verschillende problemen met onze implementatie van de rationele 
getalklasse. Als we proberen een nauwkeurigere benadering van $e$ te berekenen, 
bijvoorbeeld `$n` rond 10, wat gebeurt er met de waarden? Het vreemde gedrag 
dat je waarneemt is het resultaat van overflow. PHP zal het type `float` 
gebruiken als een geheel getal buiten het bereik van het type `int` valt, 
maar dat type is niet toegestaan in de constructor van Rational. Je moet dus 
altijd voorzichtig zijn bij het uitvoeren van numerieke berekeningen.

Er zijn een paar relatief eenvoudige wijzigingen die we kunnen aanbrengen in 
de klasse Rational om overflow voor nog een aantal termen van de benadering 
te voorkomen. Merk ten eerste op dat onze rationele getallen niet altijd in 
hun meest eenvoudige vorm worden opgeslagen. In de vierde term in het 
bovenstaande voorbeeld zijn bijvoorbeeld zowel teller als noemer deelbaar 
door 4, dus we slaan het resultaat liever op als 8/3 in plaats van 32/12.

Je kan dit probleem oplossen door de klasse `Rational` te wijzigen door alleen 
rationale getallen met teller en noemer
[relatief priem](https://nl.wikipedia.org/wiki/Relatief_priem) op te slaan 
en terug te geven. Voeg een *private* methode `gcd` (*greatest common 
divisor*, grootste gemene delr) toe die het
[algoritme van Euclides](https://nl.wikipedia.org/wiki/Algoritme_van_Euclides)
implementeert om de grootste gemene deler van twee getallen te berekenen, 
en gebruik dit resultaat om deze voorwaarde af te dwingen.

Het algoritme van Euclides berust erop dat de grootste gemene deler van twee 
gehele getallen ook de grootste gemene deler is van zowel het kleinste getal 
als van de rest die overblijft bij deling van het grootste getal door het 
kleinste. Zo ontstaat er een aflopend iteratief proces.  Je kan de grootste 
gemene deler (ggd) efficiënt berekenen met behulp van de volgende eigenschap,
die geldt voor positieve gehele getallen p en q:

Als $p > q$, is de ggd van $p$ en $q$ gelijk aan de ggd van $q$ en $p \mod q$.

Een recursieve uitwerking is als volgt

```
private function gcd(int $p, int $q): int
{
    if ($q == 0) {
        return $p;
    } else {
        return $this->gcd($q, $p % $q);
    }
}
```

Bereken de benadering van $e$ opnieuw nadat je de relevante methoden in de 
klasse Rational hebt aangepast. Is de benadering van $e$ verbeterd?

### Tot slot

Bedenk dat het niet van belang is hoe de methoden van Rational worden 
geïmplementeerd voor programma’s die deze klasse gebruiken, zolang de 
interface maar gelijk blijft. Dat wil zeggen, zolang de *signatuur* van de 
methoden (methodenaam, parameters en returntype) gelijk blijft, zijn geen 
wijzigingen op andere lokaties nodig (bijvoorbeeld in `approxE`). Dit is een 
belangrijk voordeel van modulair en objectgeoriënteerd programmeren: de 
clientcode blijft geïsoleerd van de details van de implementatie.

## Interfaces en excepties

### De functie `intToHex`

Implementeer de functie `intToHex`.
 
```php
/**
 * Converts a positive integer to hexadecimal
 * 
 * @param int $x Positive integer number
 * @return string containing hexadecimal value
 */
function intToHex(int $x): string
```

Maak geen gebruik van reeds aanwezige methodes voor het converteren van 
decimaal naar hexadecimaal. Je hoeft geen rekening te houden met eventueel 
ongeldige waardes van `$x`.

Een letter genereren aan de hand van een integer-waarde kan als volgt.

```php
$i = 1;
$c = chr(ord('A') + $i); // $c = 'B'
```

Je kan de methode testen met onderstaande aanroepen.

```
echo intToHex(128), PHP_EOL; // 80
echo intToHex(11256099), PHP_EOL; // ABC123
echo intToHex(0), PHP_EOL; // 0
echo intToHex(-1), PHP_EOL; // Ongeldig
```

### De functie `hexToInt`

Implementeer de functie `hexToInt`.

```php
/**
 * Converts a hexadecimal number to integer
 *
 * @param string $s String containing hexadecimal number
 * @return int value of hexadecimal number
 */
function hexToInt(string $s): int
```

Maak geen gebruik van reeds aanwezige  methodes voor het converteren van 
hexadecimaal naar decimaal. Je hoeft geen rekening te houden met eventueel 
ongeldige waardes van `$s`.

Een integer-waarde genereren aan de hand van een letter kan als volgt.

```php
$c = 'B';
$i = ord($c) - ord('A'); // $i = 1
```

Je kan een afzonderlijk karakter uit een string halen door de string als een 
array te indexeren.

```
$s = 'ABC';
$c = $s[1]; // $c = 'B'
```

Je kan de methode testen met onderstaande aanroepen.

```php
echo hexToInt('100'), PHP_EOL; // 256
echo hexToInt('EFFE'), PHP_EOL; // 61438
echo hexToInt('1A0'), PHP_EOL; // 416
echo hexToInt('0'), PHP_EOL; // 0
echo hexToInt(''), PHP_EOL; // Ongeldig
echo hexToInt('PHP'), PHP_EOL; // Ongeldig
```

### Excepties

Welke argumenten voor de methodes `intToHex` en `hexToInt` zijn niet geldig?
Test de gemaakte methodes met ongeldige waardes. Wat gebeurt er?

De gevolgen van ongeldige argumenten zijn afhankelijk van jouw implementatie.
Het kan zijn dat het ongeldige argument genegeerd wordt (met een 
onvoorspelbaar resultaat) of dat er een fout (exceptie) verschijnt.

Pas je code aan zodat deze een exceptie gooit in het geval van een ongeldig 
argument. Een ongeldig argument kan een ongeldige waarde zijn, maar ook een 
ongeldig karakter als het gaat om een string.

Kies uit de volgende excepties: `Exception`, `Error`, `Throwable`,
`DomainException`, `IllegalArgumentException`. Welke van deze excepties 
gebruik je, en waarom?

### Interface `Stack`

Implementeer een klasse die de volgende interface implementeert.

```php
interface Stack
{
    /**
     * Voegt een item toe aan de stack
     */
    public function push(mixed $item): void;

    /**
     * Verwijdert het laatste item van de stack en geeft het terug
     */
    public function pop(): mixed;

    /**
     * Verwijdert alle items van de stack
     */
    public function clear(): void;

    /**
     * Retourneert true als de stack leeg is
     */
    public function isEmpty(): bool;
}
```

De klasse zal gebruik maken van een array om de stack te bewaren, en heeft 
daarom ten minste één instantievariabele.

```
private array $items;
```

De klasse heeft ook één constructor die een lege stack initialiseert:

```
public function __construct()
```

Er hoeft nog geen rekening gehouden te worden met fouten als gevolg van 
incorrect gebruik van de stack.

### De stack testen

Test de klasse als volgt; hierbij is $stack een nieuwe instantie van je klasse.

```php
$stack->push('Pascal');
$stack->clear();
$stack->push("Python");
$stack->push("Java");
$stack->push("C");
echo $stack->pop(), PHP_EOL; // C
$stack->push("PHP");
echo $stack->pop(), PHP_EOL; // PHP
echo $stack->pop(), PHP_EOL; // Java
echo $stack->isEmpty() ? 'true' : 'false', PHP_EOL; // false
echo $stack->pop(), PHP_EOL; // Python
echo $stack->isEmpty() ? 'true' : 'false', PHP_EOL; // true
echo $stack->pop(), PHP_EOL; // Deze is te veel...
```

### Excepties

Welke fouten kunnen optreden bij incorrect gebruik van de stack?
Denk goed na wat er allemaal mis kan gaan. Een voorbeeld is de methode `pop` 
gebruiken terwijl de stack leeg is.

Let op. Niet elke fout is een probleem. Niet elke ogenschijnlijke fout is 
een probleem. Bijvoorbeeld de methode `clear` aanroepen op een lege stack 
lijkt niet zinvol, maar het levert verder geen enkel probleem op.
In dat geval is een exceptie niet wenselijk.

Zorg ervoor dat in geval van fouten een exceptie wordt gegooid met een 
duidelijke foutmelding. Kies zelf geschikte exceptieklassen.

Maak vervolgens een klasse `StackException` die gebruikt gaat worden voor 
alle excepties die gegooid worden door je implementatie van de interface 
`Stack`. Van welke klasse moet `StackException` overerven om deze correct 
werkend te krijgen?

Aanbeveling: Maak eerst een kopie van je klasse om de vorige versie te behouden.

### Exception handling

Onderstaande code verwijdert alle items van een stack en drukt ze af op het 
scherm, zonder dat bekend is hoe veel items er zijn:

```php
$stack->push(7);
$stack->push(210);
$stack->push(-20);
try {
    while (true) {
        echo $stack->pop(), "\n";
    }
} catch (Exception) { }
echo "Einde stack\n";
```

Waarom is het gebruik maken van exception handling in deze situatie niet 
wenselijk?  Herschrijf deze code zodat deze bad practice niet meer voorkomt.

## Extra oefeningen

Op internet is een veelvoud aan oefenmateriaal te vinden om te oefenen met 
functies, objecten en klassen in PHP. Hierbij spelen twee aspecten een rol. 
Aan de ene kant is het schrijven hiervan een vaardigheid die taalonafhankelijk 
is, waar het gaat om het selecteren en toepassen van het juiste algoritme. Dit kan 
bijvoorbeeld geoefend worden op de site van w3resource, waar oefeningen voor 
[functies](https://www.w3resource.com/php-exercises/php-function-exercises.php)
en [objectgeroriënteerd programmeren](https://www.w3resource.com/php-exercises/oop/index.php)
te vinden zijn.

Aan de andere kant heeft PHP een aantal specifieke functionaliteiten en 
keywords waarmee je kan oefenen. De kata's op CodeWars gaant met name over 
dit aspect. Kijk bij de 
[functiekata's](https://www.codewars.com/collections/php-functions)
naar de kata's over Default Arguments, Pass By 
Reference, Splat Operator, Type Declarations en Return Type Declarations. De 
overige kata's op deze pagina gaan over aspecten van PHP die (nog) niet 
besproken zijn. Bij de
[kata's over objectgeoriënteerd programmeren](https://www.codewars.com/collections/object-oriented-php)
gaat de laatste kata in de reeks, Objects on the Fly, over anonieme klassen;
dit is niet besproken. De overige kata's gaan over onderwerpen die wel 
besproken zijn.