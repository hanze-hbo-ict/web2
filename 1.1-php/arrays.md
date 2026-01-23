# Arrays

PHP heeft een ingebouwd type
[`array`](https://www.php.net/manual/en/language.types.array.php)
dat vergelijkbaar is met arrays of lijsten in andere talen. Een array bevat 
een aantal andere waarden die opgezocht kunnen worden aan de hand van hun 
index. Dit is vergelijkbaar met arrays in een taal als Java. Het grote 
verschil is echter dat een array in PHP geen vaststaande lengte heeft. In 
bijvoorbeeld Java wordt de lengte van een array vastgelegd; als de wens is 
dat de array later kan worden uitgebreid zou een `ArrayList` gebruikt moeten 
worden. In PHP is het echter mogelijk om later elementen toe te voegen aan 
de array. In dat opzicht heeft de array in PHP meer gelijkenissen met het 
type `list` in Python. Ook kan een array in PHP, omdat het een dynamische 
taal is, waarden van elk willekeurig type bevatten, die bovendien niet 
allemaal hetzelfde hoeven te zijn in een enkele array. Een array kan ook 
zelf weer arrays bevatten en wordt dan een multidimensionale array genoemd.

Om een array te maken kunnen de waardes die in de array moeten komen tussen 
blokhaken gezet worden. Deze elementen worden genummerd vanaf 0 en kunnen 
worden aangesproken en veranderd door de index tussen blokhaken achter de 
variabelenaam te zetten. Dit lijkt allemaal op de syntax van lijsten in 
Python, zoals ook te zien in onderstaand voorbeeld.

```php
$a = [1, 'hallo', true];
var_dump($a[1]); // drukt 'hallo' af
$a[1] = 'test';
var_dump($a[1]); // drukt 'test' af
```

Er zijn echter ook syntax- en betekenisverschillen met Python. In de eerste 
plaats kan een element aan de array worden toegevoegd door lege blokhaken 
achter de variabelenaam te zetten; deze nieuwe waarde krijgt de 
eerstvolgende nog niet gebruikte index in de array. Bovendien wordt, als 
een array aan een andere variabele wordt toegekend, die toekenning *by 
value* gedaan. Anders gezegd, de nieuwe array bestaat onafhankelijk van de 
originele array en eventuele aanpassingen zijn niet zichtbaar in de 
oorspronkelijke array. Bij lijsten in Python is dit wel zo.

```php
$a = []; // lege array
$a[] = 1;
$a[] = 'hallo';
var_dump($a); // de array is nu gelijk aan [1, 'hallo']
$b = $a;
$b[1] = 'test';
var_dump($a[1]); // drukt nog steeds 'hallo' af; $a is niet veranderd
```

Net als Java en Python heeft PHP ook een specifieke syntax om over alle 
elementen van een array te itereren. Het hierbij behorende keyword is 
[`foreach`](https://www.php.net/manual/en/control-structures.foreach.php),
en de syntax ziet er als volgt uit.

```php
foreach ($array as $x) {
    var_dump($x);
}
```

Hier is ook, net als bij de andere controlestatements, een alternatieve 
syntax met `endforeach` beschikbaar.

```php
foreach ($array as $x):
    var_dump($x);
endforeach;
```

Het is ook mogelijk om de lusvariabele *by reference* te verkrijgen; dit 
betekent dat deze waarde binnen de lus aangepast kan worden en dat daarmee 
de onderliggende array ook aangepast wordt. Dit kan door een ampersand `&` 
voor de variabelenaam te zetten. Onderstaande code zal bijvoorbeeld alle 
elementen in de array met 1 verhogen.

```php
$array = [1, 2, 3];
foreach ($array as &$x) {
    $x += 1;
}
```

## Associatieve arrays

Tot nog toe hebben we arrays beschouwd als lijsten: meerdere waardes die 
met opvolgende numerieke indices aangesproken kunnen worden, precies zoals 
een `list` in Python of een array of `ArrayList` in Java. Arrays in PHP zijn 
echter feitelijk beter te beschouwen als een *map*, een datastructuur die in 
Java geïmplementeerd is als de interface `Map`, zoals in een `HashMap`, en 
in Python een `dict` of *dictionary* heet. Kenmerkend aan een map is dat 
deze waardes niet associeert met numerieke indices, maar met meer algemene 
sleutelwaardes. In PHP worden arrays die van deze mogelijkheid gebruik maken 
ook wel *associatieve arrays* genoemd.

Een associatieve array wordt gemaakt door bij het maken van een array voor 
de waarde die opgeslagen moet worden de sleutel te zetten, gevolgd door een 
dubbele pijl `=>`. Dit hoeft niet bij elk element te gebeuren; alle 
elementen zonder pijl krijgen numerieke sleutels, waarbij steeds een getal 
wordt gekozen dat 1 groter is dan de grootste numerieke sleutel tot dan toe, 
zoals te zien in onderstaand voorbeeld, waar de sleutels van `'b'`, `'d'` en 
`'e'` gegeven zijn, `'a'` de sleutel 0 krijgt omdat er nog geen numerieke 
sleutels zijn, `'c'` de sleutel 1 krijgt omdat de grootste tot dan to 0 is 
en `f` de sleutel 9 krijgt omdat de grootste tot dan toe 8 is.

```php
$assoc = ['a', 'key' => 'b', 'c', 8 => 'd', -1 => 'e', 'f']; 
// $assoc is nu [0 => 'a', 'key' => 'b', 1 => 'c', 8 => 'd', -1 => 'e', 9 => 'f']; 
```

Aan bovenstaand voorbeeld is ook te zien dat de numerieke sleutels niet op 
volgorde hoeven te staan. De gegeven volgorde wordt wel bijgehouden; een 
`foreach`-lus over bovenstaande array zal de waardes altijd in volgorde van 
`'a'` tot en met `'f'` teruggeven. Bovendien is te zien dat er gaten mogen 
zitten in de numerieke sleutels; de sleutels 2 tot en met 7 zijn hier niet 
gedefinieerd. Dit betekent ook dat een arraytoekenning met een bepaalde 
index altijd werkt, ook als die index niet bestaat, zoals in onderstaand 
voorbeeld. Ook is het zoals hier te zien altijd toegestaan om een string als 
sleutel te gebruiken. Daarnaast kunnen waardes uit arrays verwijderd worden met 
`unset`; hierdoor worden de overige sleutels niet aangepast zodat er gaten 
kunnen ontstaan in de numerieke indices.

```php
$array = [1, 2, 3];
$array[5] = 4;
$array['test'] = 5;
var_dump($array); // [0 => 1, 1 => 2, 2 => 3, 5 => 4, 'test' => 5]
unset($array[1]);
var_dump($array); // [0 => 1, 2 => 3, 5 => 4, 'test' => 5]
```

Sleutels kunnen ints of strings zijn. Als een float wordt gebruikt als sleutel, 
zal deze afgerond. Bools worden omgezet naar ints en de waarde `null` wordt 
gezien als de lege string. Gebruik van andere types zullen een foutmelding 
geven. Daarnaast worden strings die een decimaal geheel getal bevatten, zoals 
bijvoorbeeld `'8'`, omgezet naar ints. `$array['5']` en `$array[5]` 
verwijzen dus per definitie naar dezelfde waarde. `$array['3.4']` en
`$array[3.4]` echter niet; `'3.4'` is geen decimaal geheel getal dus wordt 
deze gewoon als string gebruikt, en `3.4` wordt afgerond naar 3.

Het statement `foreach` werkt ook als de array associatief is; in dat geval 
wordt geïtereerd over de waarden. Merk op dat de `for`-lus in Python bij een 
`dict` juist over de sleutels itereert en niet over de waardes; dat gedrag 
is dus anders. Het is wel mogelijk om ook de sleutels te verkrijgen, zoals 
in onderstaand voorbeeld, waarbij `$k` de sleutel wordt en `$v` de waarde.

```php
foreach ($assoc as $k => $v) {
    var_dump($k, $v);
}
```

## Arrayoperaties

Twee arrays kunnen in PHP vergeleken worden met de operator `==`. Arrays 
zijn gelijk als ze dezelfde sleutels en waarden hebben; ook twee 
verschillende arrays kunnen gelijk zijn, mits hun inhoud maar gelijk is. 
Om ook te vergelijken of de arrays in dezelfde volgorde staan, kan `===` 
gebruikt worden. Zo is `[1 => 1, 0 => 0] == [0 => 0, 1 => 1]` wel waar, maar
`[1 => 1, 0 => 0] === [0 => 0, 1 => 1]` niet. Omgekeerd kunnen `!=` en `!==` 
gebruikt worden om op dezelfde manier te kijken of twee arrays ongelijk zijn.

Er zijn vaak situaties waarin je niet zeker weet welke sleutels al dan niet 
aanwezig zijn in een array; als een sleutel niet aanwezig is wil je vaak een 
defaultwaarde gebruiken. We zullen zien dat dit bijvoorbeeld gebruikt zal 
worden bij het parseren van de invoer van de gebruiker. Je zou dan de functie
[`isset`]()
kunnen gebruiken om te kijken of de waarde bestaat en hierop te handelen, 
zoals in onderstaand voorbeeld.

```php
if (isset($array[$key])) {
    $x = $array[$key];
} else {
    $x = $default;
}
```

Dit is echter vrij lang. De ternaire conditionele operator kan gebruikt 
worden om dit korter te maken, als
`$x = isset($array[$key]) ? $array[$key] : $default`, maar dit is nog steeds 
vrij lang voor een relatief veel voorkomend stukje code. Vandaar dat PHP 
sinds versie 7 de
[*null coalesce operator*](https://www.php.net/manual/en/migration70.new-features.php#migration70.new-features.null-coalesce-op)
`??` kent. Deze operator geeft de linkeroperand terug, behalve als deze 
niet bestaat of `null` is, dan wordt de rechteroperand teruggegeven. 
Bovenstaande code kan dus vervangen worden door onderstaande code.

```php
$x = $array[$key] ?? $default;
```

Hiervan is ook een toekenningsvariant beschikbaar; `$array[$key] ??= 
$default;` zal de waarde `$default` toekennen aan `$array[$key]` als die 
laatste waarde `null` was of als de sleutel `$key` nog niet bestond in 
`$array`, anders zal de waarde hetzelfde blijven.

Ten slotte zijn er enkele manieren om op een kortere manier waardes uit 
arrays te lezen of om arrays samen te stellen. Vaak bevat een array een 
aantal waarden die ieder een bepaalde betekenis hebben. Dan kan het handig 
zijn om deze ieder snel toe te kennen aan een variabele. Denk hierbij 
bijvoorbeeld aan een regel uit een databestand die je kan splitsen met de 
hieronder besproken functie `explode`, zoals in onderstaand voorbeeld.

```php
$line = 'Jan Klaassen;8913621;8.0';
[$name, $id, $grade] = explode(';', $line);
```

In dit voorbeeld zal `$name` de string `'Jan Klaassen'` bevatten, `$id` de 
string `'8913621'` en zo verder. Dit wordt
[*array destructuring*](https://www.php.net/manual/en/language.types.array.php#language.types.array.syntax.destructuring)
genoemd. Het is ook mogelijk om slechts een deel van de array toe te kennen, 
of om alleen bepaalde sleutels uit een associatieve array toe te kennen, 
zoals in onderstaande voorbeelden.

```php
$array = [0, 1, 2, 3, 4];
[$a, $b] = $array; // $a == 0 en $b == 1
[, , $c, $d] = $array; // $c == 2, $d == 3
$assoc = ['a' => 0, 'b' => 1, 'c' => 2];
['a' => $a, 'c' => $c] = $assoc; // $a == 0 en $c == 2
```

Dit kan ook in een `foreach`-lus toegepast worden; als `$dataset` een 
multidimensionale array is kan elk element worden gedestructureerd als in 
onderstaand voorbeeld.

```php
foreach ($dataset as [$name, $id, $grade]) {
    ...
}
```

Het is ook mogelijk om bij het maken van een array waardes uit andere arrays 
te gebruiken. Dit kan met behulp van
[*array unpacking*]().
Hierbij zet je voor de naam van de array die je wilt unpacken een 
beletselteken `...`, in deze context ook wel de *splat operator* genoemd. 
Dit heeft tot gevolg dat je dit moet lezen alsof de waardes van die array 
één voor één worden opgesomd. Een voorbeeld kan dit wellicht verduidelijken.

```php
$a = [2, 3];
$array = [0, 1, ...$a, 4];
var_dump($array); // [0, 1, 2, 3, 4]
```

Dit werkt ook voor associatieve arrays, en hiermee kunnen bijvoorbeeld twee 
arrays worden samengevoegd, zoals in onderstaand voorbeeld.

```php
$a = [0, 1, 2];
$b = [3, 4];
$array = [...$a, ...$b];
var_dump($array); // [0, 1, 2, 3, 4]
```

* array unpacking $a = [...$b, ...$c]

## Arrayfuncties

PHP heeft een uitgebreide lijst ingebouwde
[arrayfuncties](https://www.php.net/manual/en/ref.array.php).
Om deze allemaal te bespreken zou te ver voeren, maar een aantal relevante 
functies zullen hier genoemd worden.

Om het aantal elementen in een array te bepalen, kan je de functie
[`count`](https://www.php.net/manual/en/function.count.php)
gebruiken. Je kan de functie
[`array_is_list`](https://www.php.net/manual/en/function.array-is-list.php) 
gebruiken om te bepalen of een gegeven array een *lijst* is, oftewel, dat de 
sleutels van de array opeenvolgende nummers vanaf 0 zijn.

De functie
[`in_array`](https://www.php.net/manual/en/function.in-array.php)
kan worden gebruikt om te zoeken of een bepaalde waarde voorkomt in een 
array. Om ook de sleutel te vinden waar deze waarde te vinden is, kan
[`array_search`](https://www.php.net/manual/en/function.array-search.php)
worden gebruikt. Als je niet in een specifieke waarde bent geïnteresseerd, maar 
een wilt weten of een specifieke sleutel bestaat kan je
[`array_key_exists`](https://www.php.net/manual/en/function.array-key-exists.php)
gebruiken.

Om een array te verkrijgen met alle sleutels van een associatieve array kan je 
[`array_keys`](https://www.php.net/manual/en/function.array-keys.php)
gebruiken; om alleen de waardes te verkrijgen kan je
[`array_values`](https://www.php.net/manual/en/function.array-values.php)
gebruiken. Twee arrays, één met sleutels en één met waardes, kan je weer 
samenvoegen tot een associatieve array met
[`array_combine`](https://www.php.net/manual/en/function.array-combine.php).

PHP kent geen *slice*-syntax zoals Python. Het is echter wel mogelijk om de 
functie
[`array_slice`](https://www.php.net/manual/en/function.array-slice.php)
te gebruiken om iets soortgelijks te verkrijgen. Met deze functie kan je een 
aaneengesloten stuk van een array krijgen, dus zoals een slice in Python met 
stapgrootte 1. Om een bepaalde slice van een array te vervangen door een 
andere array kan de functie
[`array_splice`](https://www.php.net/manual/en/function.array-splice.php)
gebruikt worden; let op de extra P in deze functienaam.


Je kan een array als
[*stack*](https://nl.wikipedia.org/wiki/Stack_(informatica)) gebruiken met
de functies
[`array_push`](https://www.php.net/manual/en/function.array-push.php)
en
[`array_pop`](https://www.php.net/manual/en/function.array-pop.php),
die een waarde respectievelijke toevoegen en verwijderen aan 
het einde van een array. Waardes toevoegen en verwijderen aan het begin van 
een array kan met respectievelijk de functies 
[`array_unshift`](https://www.php.net/manual/en/function.array-unshift.php)
en 
[`array_shift`](https://www.php.net/manual/en/function.array-shift.php).
Door bijvoorbeeld `array_unshift` en `array_pop` te combineren, kan een 
array dienen als
[*queue*](https://nl.wikipedia.org/wiki/Queue_(informatica)).

Om meerdere arrays samen te voegen, kan de functie
[`array_merge`](https://www.php.net/manual/en/function.array-merge.php)
worden gebruikt. Met
[`array_unique`](https://www.php.net/manual/en/function.array-unique.php)
kunnen alle dubbele waarden uit een array verwijderd worden en met
[`array_diff`](https://www.php.net/manual/en/function.array-diff.php)
krijg je een array terug die alleen die waarden bevat die wel in het eerste 
argument aanwezig zijn maar niet in de overige argumenten.
[`array_intersect`](https://www.php.net/manual/en/function.array-intersect.php)
geeft een array terug met alleen die waarden die in alle meegegeven arrays 
voorkomen.

Om een array te sorteren, kan je
[`sort`](https://www.php.net/manual/en/function.sort.php)
gebruiken. Deze functie werkt *in place*, dat wil zeggen dat de meegegeven 
array aangepast wordt. Bovendien worden alle sleutels verwijderd en is het 
resultaat een array met oplopende numerieke indices. Als de sleutels wel 
bewaard moeten blijven, kan je
[`asort`](https://www.php.net/manual/en/function.asort.php)
gebruiken; als je op de sleutels wil sorteren in plaats van de waardes, 
gebruik je [`ksort`](https://www.php.net/manual/en/function.ksort.php).

Ten slotte zijn er nog twee functies om een string te splitsen in onderdelen 
of om een array samen te voegen tot een string. Om een string te splitsen 
gebruik je
[`explode`](https://www.php.net/manual/en/function.explode.php);
om een array samen te voegen gebruik je
[`implode`](https://www.php.net/manual/en/function.implode.php).
Beide functies krijgen als eerste argument het te gebruiken scheidingsteken 
mee; `explode` krijgt als tweede argument de te splitsen string mee, en 
`implode` krijgt op die plaats de samen te voegen array mee.
