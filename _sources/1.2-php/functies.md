# Functies

PHP biedt natuurlijk de mogelijkheid om zelf functies te schrijven. De 
syntax hiervan zal de gemiddelde programmeur bekend voorkomen. Functies 
worden in PHP gedefinieerd door middel van het keyword `function`, gevolgd 
door de naam van de functie, de lijst van parameters tussen haakjes en ten 
slotte de code van de functie tussen accolades.

Parameternamen worden geschreven als variabelen, ze beginnen dus met een 
dollarteken `$`. Het is toegestaan en zeer aan te bevelen om een typenaam zoals 
`int`, `string` of de naam van een klasse voor de parameternaam te zetten. 
Als je dit doet, moet het argument dat je meegeeft van dit type zijn. Dit 
zal hieronder nog in meer detail worden besproken. Het is bovendien 
mogelijk om een  defaultwaarde mee te geven door `=` en de defaultwaarde na 
de parameternaam op te nemen. Als de betreffende parameter dan niet wordt 
meegegeven, wordt de defaultwaarde ingevuld. Zie bijvoorbeeld de 
voorbeeldfunctie hieronder.

```php
function test(int $a, $b, string $c = 'default')
{
    var_dump($a, $b, $c);
}

test(1, 'a', 'b');
test(5, 'test');
test('a', 'b', 'c');
```

In dit voorbeeld zijn de eerste twee aanroepen correct; in de tweede aanroep 
zal `$c` de waarde `'default'` krijgen omdat die niet expliciet is 
meegegeven. De derde aanroep zal een foutmelding geven omdat `'a'` geen 
`int` is.

Het is ook mogelijk om argumenten op naam mee te geven door voor de waarde 
van het argument de naam van de parameter op te nemen, zonder dollarteken, 
gevolgd door een dubbele punt. Als een functie een 
veelvoud aan parameters heeft, kan hiermee duidelijk gemaakt worden welke 
parameter bedoelt wordt. Ook is het hiermee mogelijk om parameters over te 
slaan, zodat voor die parameters de defaultwaarde gebruikt wordt. De functie
[`htmlentities`](https://www.php.net/manual/en/function.htmlentities.php) 
heeft bijvoorbeeld vier parameters, waarbij alleen de eerste geen 
defaultwaarde heeft. Onderstaande aanroep gebruikt de defaultwaardes voor de 
tweede en derde parameter, `$flags` en `$encoding`, maar gebruikt wel een 
andere waarde voor de vierde parameter.

```php
htmlentities("rhytm &amp; blues", double_encode: false)
```

Argumenten van functies worden standaard *by value* meegegeven. Dit betekent 
dat in ieder geval conceptueel een kopie van de waarde wordt gemaakt en die 
kopie wordt meegegeven aan de functie. In de praktijk wordt die kopie soms pas 
gemaakt als de functie zou proberen de waarde aan te passen. Dit gebeurt 
bijvoorbeeld bij arrays. Als een array wordt meegegeven aan een functie, 
wordt geen kopie gemaakt, maar als in de functie de array wordt aangepast, 
wordt op dat moment wel een kopie gemaakt en kan de functie alleen de kopie 
aanpassen. Op deze manier is het mogelijk om een array mee te geven aan een 
functie zonder dat deze gewijzigd kan worden door de functie. Dit gedrag 
wordt *copy-on-write* genoemd. Een uitzondering hierop is het meegeven van 
objecten, die nog nader besproken zullen worden. De functie kan het object 
niet vervangen door een geheel nieuw object, maar kan de inhoud van het 
object wel aanpassen. Objecten zijn dus *mutable*.

Het is mogelijk om deze default aan te passen. Door een ampersand `&` te 
zetten voor het dollarteken van de parameternaam, wordt de parameter *by 
reference*. Dit betekent dat de functie een verwijzing krijgt naar de 
oorspronkelijke variabele en deze ook kan aanpassen. Dit is voor alle types 
mogelijk, zoals te zien in onderstaand voorbeeld.

```php
function byref(int &$count)
{
    $count += 1;
}

$count = 5;
byref($count);
var_dump($count);
```

In dit voorbeeld zal `$count` na de aanroep van `byref` de waarde 6 bevatten.

Functies kunnen ook, net als in de meeste programmeertalen, waardes 
teruggeven. Hiervoor wordt zoals gebruikelijk het keyword `return` gebruikt 
binnen de functie. Het is in principe niet verplicht om bij de functie te 
vermelden wat het returntype zal zijn, aangezien PHP een dynamische taal is, 
maar dit is wel zeer aan te bevelen. Dit kan je doen door na de 
parameterlijst een dubbele punt te zetten, gevolgd door het type dat de 
functie zal teruggeven. Hierbij kan ook het type `void` gebruikt worden, dat 
aangeeft dat de functie geen returnwaarde mag geven. Het is dan wel 
toegestaan om het statement `return` zonder waarde te gebruike om de 
functieaanroep eerder te beëindigen, maar niet om hier een waarde aan mee te 
geven. Hieronder is van deze varianten een voorbeeld te zien.

```php
function double(int $x): int
{
    return 2*$x;
}

function hello(string $name): void
{
    echo "Hello, $name!\n";
    return; // dit is optioneel maar mag wel
}
```

## Variadische functies

Soms is het niet mogelijk om van te voren te definiëren hoeveel parameters 
een functie moet hebben. De functie `var_dump` bijvoorbeeld is niet beperkt 
tot het afdrukken van een enkele waarde en kan aangeroepen worden met elk 
willekeurig aantal argumenten. Een dergelijke functie wordt *variadisch* 
genoemd. PHP biedt ondersteuning voor het maken van dergelijke functies. Dit 
kan door de laatste parameter in de functiedefinitie vooraf te laten gaan 
door het beletselteken `...`. Het effect hiervan is dat alle argumenten 
die niet expliciet zijn opgenomen in de parameterlijst als array aan 
deze laatste parameter worden toegekend. Hiermee kan bijvoorbeeld een 
functie worden gemaakt die een willekeurig aantal parameters bij elkaar 
optelt. In dit voorbeeld wordt het getal 15 afgedrukt.

```php
function sum(int ...$values): int
{
    $result = 0;
    for ($values as $val) {
        $result += $val;
    }
    return $result;
}

var_dump(sum(1, 2, 3, 4, 5));
```

Omgekeerd kan een array van argumenten gebruikt worden om een functie aan te 
roepen. Dit mag, maar hoeft geen variadische functie te zijn; ook een 
reguliere functie kan op deze manier aangeroepen worden. Dit doe je door het 
beletselteken `...` voor de array te zetten in de parameterlijst. 
Arrayelementen zonder sleutel worden als opvolgende parameters gebruikt, en 
eventuele arrayelementen met sleutel worden gebruikt om parameters met 
dezelfde naam te vullen. Hieronder staan enkele voorbeelden, waarbij de functie
[`strpos`](https://www.php.net/manual/en/function.strpos.php) gebruikt wordt.

```php
$a = ['abc', 'b'];
var_dump(strpos(...$a));
var_dump(strpos(...['needle' => 'c', 'haystack' => 'abc']));
```

De eerste aanroep zal 1 teruggeven, omdat `b` op de tweede positie van de 
string `abc` staat; de tweede aanroep zal 2 teruggeven.

## Typedeclaraties

* nullable types
* union/intersect types
* mixed, void, never
* type coercion
* declare strict types


## Require/include