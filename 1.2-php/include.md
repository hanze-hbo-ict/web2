# Bestanden invoegen

Tot nog toe heeft alle code steeds in een enkel bestand gestaan. Dit is 
natuurlijk geen schaalbare aanpak. Als een applicatie groter wordt, is het 
wenselijk en zelfs noodzakelijk om de code over verschillende bestanden te 
verdelen. De primaire manier waarop dit in PHP gebeurt is met een viertal 
keywords. Dit zijn
[`require`](https://www.php.net/manual/en/function.require.php),
[`require_once`](https://www.php.net/manual/en/function.require-once.php),
[`include`](https://www.php.net/manual/en/function.include.php) en 
[`include_once`](https://www.php.net/manual/en/function.include-once.php). 
Ze werken alle vier op een grotendeels gelijkende manier, maar hebben enkele 
relevante verschillen.

Wat alle vier de keywords gemeen hebben is dat ze alle vier een expressie 
zijn die als effect heeft dat ze virtueel vervangen worden door de inhoud van 
een bepaald bestand; de bestandsnaam staat als string achter het keyword. 
Dit betekent dat als bijvoorbeeld functies of variabelen gedeclareerd worden 
in het ingevoegde bestand, deze vervolgens beschikbaar zijn in het 
invoegende bestand. Omgekeerd kan het ingevoegde bestand gebruik maken van 
variabelen en functies die al bestonden in het invoegende bestand. Wel is 
het zo dat het ingevoegde bestand altijd in HTML-modus begint; om PHP-code 
uit te voeren, moet een PHP-tag gebruikt worden.

In het volgende voorbeeld wordt getoond hoe functies en variabelen 
uitgewisseld kunnen worden van en naar het ingevoegde bestand.

```php
// a.php
<?php
$a = 5;
include 'b.php';
var_dump($a); // 10, want $a is aangepast in b.php
var_dump(dbl($b)); // 6, want dbl en $b zijn gedeclareerd in b.php

// b.php
<?php
var_dump($a); // 5, want $a komt mee uit de scope waarin dit bestand is ingevoegd
$a = 10;
$b = 3;
function dbl(int $x): int
{
    return $x * 2;
}
```

Een ingevoegd bestand kan naast functies en variabelen declareren ook een 
waarde teruggeven met het keyword `return`, vergelijkbaar met een functie. 
Deze waarde kan in het invoegende bestand toegekend worden aan een variabele,
zoals in onderstaand voorbeeld.

```php
// a.php
<?php
$val = include 'b.php';
var_dump($val); // $val heeft hier de waarde 5.

// b.php
<?php
return 5;
```

## Paden naar ingevoegde bestanden

Het is belangrijk om te begrijpen op welke manier PHP naar een ingevoegd 
bestand zoekt; in beginsel kan hier een absoluut pad worden gebruikt, dat 
begint met een slash of op Windows met een drive-letter, maar dat is vaak 
niet wenselijk omdat het daarmee lastig wordt om de applicatie naar een 
andere omgeving te verplaatsen. Daarom zal in principe een relatief pad 
worden gebruikt. Dit pad wordt geëvalueerd vanuit de directory waar het 
oorspronkelijke PHP-bestand, waarmee de applicatie gestart is, wordt 
uitgevoerd. Als de applicatie dus gestart wordt vanuit `a.php`, en deze een 
bestand `b.php` invoegt die op zijn beurt weer een 
bestand `c.php` invoegt, dan wordt `c.php` in principe gezocht vanuit de 
directory waar `a.php` staat. Dit betekent dat als `b.php` in een andere 
directory staat dan `a.php`, het voor het evalueren van het pad naar `c.php` 
uitmaakt of `b.php` vanuit `a.php` ingevoegd wordt, of dat deze rechtstreeks 
wordt gestart. Dit is natuurlijk verwarrend, zoals in onderstaand voorbeeld 
duidelijk wordt gemaakt.

```php
// /web/src/a.php
<?php
include 'includes/b.php' # voeg het bestand /web/src/includes/b.php in

// /web/src/includes/b.php
<?php
include 'c.php' # voeg het bestand /web/src/c.php in
```

Merk op dat in bovenstaand voorbeeld het bestand `c.php` gezocht wordt in 
`/web/src`, omdat dat de directory is waar `a.php` staat. Je zou kunnen 
verwachten dat in `/web/src/includes` gezocht wordt, omdat `b.php` daar 
staat. Als `b.php` het script is waarmee de webapplicatie gestart wordt, zou 
dat ook zo zijn, maar omdat hier de applicatie vanuit `a.php` gestart wordt, 
wordt dat het beginpunt voor alle relatieve paden.

Het is dan ook goed gebruik dat een pad voor het invoegen van een bestand
altijd absoluut gemaakt wordt door de constante `__DIR__` te gebruiken.
Deze constante bevat de directory waarin het bestand waarin deze constante 
gebruikt wordt zich bevind. Door vanaf deze directory te navigeren kunnen 
bestanden op een eenduidige manier worden aangeduid; gebruik dus liever 
`include __DIR__.'/../includes/inc.php'` in plaats van `include
'../includes/inc.php'`.

## Verschil tussen de vier keywords

Het verschil tussen de vier keywords is dat de varianten met `include` een 
waarschuwing geven als het in te voegen bestand niet bestaat, terwijl de 
varianten met `require` een foutmelding geven. Daarnaast zullen de varianten 
die eindigen op `once` een bestand altijd slechts één keer invoegen. Als een 
bepaald bestand al ingevoegd is, zal een aanroep met `include_once` of 
`require_once` deze niet opnieuw invoegen. Als het ingevoegde bestand 
functies definieert, is dat handig, aangezien anders de foutmelding gegeven 
zal worden dat de functie al bestond. Als echter het ingevoegde bestand een 
waarde teruggeeft met `return` zal dit alleen de eerste keer gebeuren. Als 
een dergelijk bestand daarna nog een keer met `include_once` of 
`require_once` wordt ingevoegd, zal het niet opnieuw deze waarde teruggeven.