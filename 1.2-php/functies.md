# Functies

PHP biedt natuurlijk de mogelijkheid om zelf
[functies](https://www.php.net/manual/en/functions.user-defined.php) te 
schrijven. De syntax hiervan zal de gemiddelde programmeur bekend voorkomen. 
Functies worden in PHP gedefinieerd door middel van het keyword `function`, 
gevolgd door de naam van de functie, de lijst van parameters tussen haakjes 
en ten slotte de code van de functie tussen accolades.

Parameternamen worden geschreven als variabelen, ze beginnen dus met een 
dollarteken `$`. Het is toegestaan en zeer aan te bevelen om een typenaam zoals 
`int`, `string` of de naam van een klasse voor de parameternaam te zetten. 
Als je dit doet, moet het argument dat je meegeeft van dit type zijn. Dit 
zal hieronder nog in meer detail worden besproken. Het is bovendien 
mogelijk om een defaultwaarde mee te geven door `=` en de defaultwaarde na 
de parameternaam op te nemen. Als de betreffende parameter dan niet wordt 
meegegeven, wordt de defaultwaarde ingevuld. Zie bijvoorbeeld de 
voorbeeldfunctie hieronder. In de tweede aanroep zal `$c` de waarde 
`'default'` krijgen omdat die niet expliciet is meegegeven.

```php
function test($a, $b, $c = 'default')
{
    var_dump($a, $b, $c);
}

test(1, 'a', 'b');
test(5, 'test');
```

Het is ook mogelijk om argumenten op naam mee te geven door voor de waarde 
van het argument de naam van de parameter op te nemen, zonder dollarteken, 
gevolgd door een dubbele punt. Als een functie een veelvoud aan parameters 
heeft, kan hiermee duidelijk gemaakt worden welke parameter bedoelt wordt. 
Ook is het hiermee mogelijk om parameters over te slaan, zodat voor die 
parameters de defaultwaarde gebruikt wordt. De functie
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
oorspronkelijke variabele en deze ook kan aanpassen, zoals te zien in 
onderstaand voorbeeld.

```php
function byref(&$count)
{
    $count += 1;
}

$count = 5;
byref($count);
var_dump($count);
```

In dit voorbeeld zal `$count` na de aanroep van `byref` de waarde 6 bevatten.

Functies kunnen ook, net als in de meeste programmeertalen,
[waardes teruggeven](https://www.php.net/manual/en/functions.returning-values.php).
Hiervoor wordt zoals gebruikelijk het keyword `return` gebruikt binnen de 
functie. Het keyword `return` kan ook zonder waarde worden gebruikt om een 
functie voortijdig te beëindigen, zoals te zien in onderstaande 
voorbeelden.

```php
function double($x)
{
    return 2*$x;
}

function hello($name)
{
    if (!$name) {
        echo 'Hello, nameless person!', PHP_EOL
        return;
    }
    echo "Hello, $name!", PHP_EOL;
}
```

## Typedeclaraties

In beginsel is PHP een dynamisch getypeerde taal. Dit betekent dat, net als 
in Python, je niet hoeft aan te geven wat het type van een variabele is. Het 
kan echter heel nuttig zijn om bij een functie aan te geven welk type de 
argumenten moeten hebben. De signatuur van een functie wordt immers vaak los 
getoond van de code, bijvoorbeeld in documentatie of IDE's, en het tonen van 
een type kan dan erg informatief zijn. Het is in PHP dan ook mogelijk om bij 
een functie aan te geven van welk type elke parameter is, en welk type 
teruggegeven wordt uit de functie. Aangezien PHP dit ook zal afdwingen en 
een foutmelding zal geven als een verkeerd type wordt meegegeven, kan 
hierdoor de kwaliteit van de code verhoogd worden. Het is dan ook ten 
zeerste aan te bevelen om elke functie die je schrijft te voorzien van 
dergelijke
[typedeclaraties](https://www.php.net/manual/en/language.types.declarations.php).
In het voorbeeld hieronder zal de vierde aanroep een foutmelding geven, omdat 
het meegegeven type voor `$count` niet klopt met het vereiste type in de 
parameterlijst. Merk op dat de tweede aanroep wel werkt; PHP zal de int `1` 
omzetten in de string `'1'`. Ook de derde aanroep werkt; de string `'5'` 
bevat alleen een getal, en kan daarom door PHP omgezet worden in de int `5`. 
Deze omstreden faciliteit wordt *type juggling* genoemd en zal hieronder nog 
besproken worden.

```php
function repeat(string $s, int $count)
{
    for ($i = 0; $i < $count; $i++) {
        echo $s;
   }
   echo PHP_EOL;
}

repeat('a', 5);
repeat(1, 5);
repeat('a', '5');
repeat('a', 'b');

```

Om aan te geven welk type een parameter heeft, zet je dit type simpelweg 
voor de variabelenaam. Het returntype kan aangegeven worden door na de 
parameterlijst een dubbele punt te zetten, gevolgd door het type dat de 
functie zal teruggeven. Hierbij kan ook het type
[`void`](https://www.php.net/manual/en/language.types.void.php) gebruikt 
worden, dat aangeeft dat de functie geen returnwaarde mag geven. Het is dan wel 
toegestaan om het statement `return` zonder waarde te gebruiken om de 
functieaanroep eerder te beëindigen, maar niet om hier een waarde aan mee te 
geven. Ook kan je het type
[`never`](https://www.php.net/manual/en/language.types.never.php) gebruiken 
om aan te geven dat de functie nooit regulier zal terugkeren naar de 
aanroepende functie; oftewel, dat er geen `return`-statement zal worden 
uitgevoerd en dat ook het einde van de functie niet bereikt zal worden. Dit 
kan alleen als de functie een eindeloze lus is, de applicatie zal beëindigen 
met de functie
[`exit`](https://www.php.net/manual/en/function.exit.php)
of alleen maar via excepties, die nog besproken zullen worden, de functie 
zal beëindigen.

```php
function print_number(int $a): void {
    echo $a, PHP_EOL;
    return; // deze return is toegestaan maar hoeft niet
}

function fibonacci(): never {
    $a = 1;
    $b = 1;
    while (true) {
        $c = $a + $b;
        $a = $b;
        $b = $c;
        echo $c, PHP_EOL;
        usleep(100_000); // wacht 100.000 microseconden (0,1 seconde)
    }
    // deze functie eindigt nooit
}
```

Soms wil je juist wel elk type accepteren, bijvoorbeeld in een functie die een 
array maakt met aantal kopieën van een gegeven waarde toevoegt aan een array. 
Het maakt immers niet uit wat het type is van de waarde die in de array 
gezet moet worden. In dat geval kan je het type
[`mixed`](https://www.php.net/manual/en/language.types.mixed.php) gebruiken. 
In andere gevallen mag een variabele van meerdere types zijn. Het zou 
bijvoorbeeld zo kunnen zijn dat we een gebruiker expliciet kunnen meegeven 
als gegevens in een `array` of als id van het type `int`. De typedeclaratie 
zal dan `array|int` zijn, dus beide types gescheiden door een pipe `|`. Dit 
heet een
[*union type*](https://www.php.net/manual/en/language.types.declarations.php#language.types.declarations.composite.union).
Een veelvoorkomende situatie die hieraan verwant is, is dat een bepaalde 
parameter optioneel is. Vaak wordt dit geïmplementeerd door de parameter 
`null` te laten zijn als deze ontbreekt. Als echter een typedeclaratie 
wordt gebruikt, bijvoorbeeld `string`, zal dit een foutmelding geven omdat 
`null` geen string is. Het type `string|null` kan dan gebruikt worden, dat 
type laat immers zowel strings als `null` toe. Omdat deze constructie vaak 
voorkomt, is hier een kortere versie voor, het type `?string`. Dit wordt een
[*nullable*](https://www.php.net/manual/en/language.types.declarations.php#language.types.declarations.nullable)
string genoemd. Hieronder zijn enkele voorbeelden hiervan te zien.

```php
function repeat_array(mixed $value, int $count): array
{
    $result = [];
    for ($i = 0; $i < $count; $i++) {
        $result[] = $value;
    }
    return $result;
}

function echo_user_name(array|int $user): void
{
    if (is_int($user)) {
        $user = get_user_by_id($user);
    }
    echo $user['name'], PHP_EOL;
}

function hello(?string $name = null): void
{
    $name ??= 'anonymous user';
    echo "Hello, $name!", PHP_EOL;
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

