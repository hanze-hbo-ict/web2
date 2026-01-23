# Conditionele en lusstatements

PHP heeft net als vrijwel elke imperatieve programmeertaal de beschikking 
over conditionele statements, de `if`- en `switch`-statements, en enkele 
lusstatements, `while`, `do`-`while` en `for`. Deze statements zijn allemaal 
vergelijkbaar met de controlestatements in Java en C; ze zullen dan ook niet 
uitgebreid besproken worden.

## `if`-statement

De structuur van het
[`if`-statement](https://www.php.net/manual/en/control-structures.if.php)
ziet er als volgt uit.

```php
if ($condition_1) {
    // ...
} elseif ($condition_2) {
    // ...
} else {
    // ...
}
```

Als de waarde van `$condition_1` evalueert naar `true` wordt de code na de 
`if` uitgevoerd; als die evalueert naar `false` wordt, maar de waarde van 
`$condition_2` wel evalueert naar `true` wordt, dan wordt de code na de 
`elseif` uitgevoerd en anders de code na de `else`.

Bij het evalueren van de voorwaarden geldt dat booleans natuurlijk 
rechtstreeks gebruikt kunnen worden, maar andere waarden ook. In grote 
lijnen geldt dat als een getal gelijk aan 0 is of een string of array leeg 
is, deze evalueert naar `false`. Andere waarden evalueren naar `true`.

Merk op dat het keyword `elseif` hier gebruikt wordt; dit had ook `else if` 
mogen zijn zoals in Java, maar PHP kent het ook als enkel keyword. Daarnaast 
is een relevant verschil ten opzichte van Java dat de te testen waarde, in 
het voorbeeld `$condition`, een bool mag zijn, maar dat dat zoals gezegd niet 
hoeft. 

PHP kent ook een
[ternaire conditionele operator](https://www.php.net/manual/en/language.operators.comparison.php#language.operators.comparison.ternary)
`?` en `:` die het mogelijk maakt om in een expressie een keuze te maken. Als 
het gedeelte voor het vraagteken waar is, is het resultaat van de expressie het 
gedeelte tussen vraagteken en dubbele punt, anders het gedeelte na de 
dubbele punt. Zo is `$condition ? 1 : 2` gelijk aan 1 als `$condition` waar 
is, anders is de expressie gelijk aan 2.

Een verkorte variant hiervan is de zogeheten
[*elvisoperator*] `?:`. Hierbij wordt het gedeelte tussen vraagteken en 
dubbele punt weggelaten, en wordt het resultaat van de expressie gelijk aan 
de linkeroperand als dit evalueert als `true`, en anders gelijk aan de 
rechteroperand. Zo is `5 ?: 3` gelijk aan 5, want 5 wordt omgezet naar 
`true`, maar is `0 ?: 3` gelijk aan 3, want 0 wordt omgezet naar `false`.

## `switch`-statement

PHP kent ook het
[`switch`-statement](https://www.php.net/manual/en/control-structures.switch.php),
dat er ongeveer als volgt uit ziet.

```php
switch ($val) {
    case $a:
        // ...
        break;
    case $b:
    case $c:
        // ...
        break;
    default:
        // ...
}
```

Hierbij geldt dat `$val` één voor één vergeleken wordt met de waardes die 
bij de `case`-clausules staan. Als de waarde gelijk is, wordt vanaf daar de 
code uitgevoerd tot het einde van het `switch`-statement of tot een 
`break`-statement wordt tegengekomen. Deze moeten dus niet vergeten worden, 
maar ze zijn ook niet verplicht, zoals in het voorbeeld te zien is. Daaruit 
volgt namelijk dat als `$val` gelijk is aan `$b`, dezelfde code wordt 
uitgevoerd als wanneer `$val` gelijk is aan `$c`. Als geen enkele `case` 
overeenkomt, wordt de code onder `default` uitgevoerd, als die aanwezig is.

PHP kent ook een
[`match`-expressie](https://www.php.net/manual/en/control-structures.match.php).
Dit is een variant van `switch` die in expressies en berekeningen gebruikt 
kan worden. Deze is vergelijkbaar met de *extended switch* uit Java, maar er 
zijn enige syntaxverschillen. Deze expressie ziet er ongeveer als volgt uit.

```php
$x = match ($val) {
    $a => 1,
    $b, $c => 2,
    default => 3
};
```

In dit voorbeeld wordt de waarde 1 toegekend aan `$x` als `$val` gelijk is 
aan `$a`, de waarde 2 als `$val` gelijk is aan `$b` of `$c` en anders de 
waarde 3.

Hierbij zijn, naast de andere syntax, enkele functionele verschillen te zien 
ten opzichte van het `switch`-statement. In de eerste plaats is het een 
expressie die evalueert naar een waarde, geen statement waarin arbitraire 
code kan worden uitgevoerd. Daarnaast is het niet nodig om, zoals bij 
`switch`, het statement `break` te gebruiken om te voorkomen dat andere 
gevallen worden uitgevoerd. Wat niet zichtbaar is, maar wel een verschil, is 
dat als er geen `default` is en `$val` aan geen van de waarden gelijk is, 
een fout optreedt. Bij het `switch`-statement wordt in dat geval geen 
foutmelding gegeven, maar gewoon geen code uitgevoerd. Ten slotte is de 
vergelijking subtiel anders. De vergelijkingen bij `switch` worden gedaan 
alsof de `==`-operator wordt gebruikt, terwijl bij `match` de `===`-operator 
wordt gebruikt.

## `while`- en `do`-`while`-statements

Het
[`while`-statement](https://www.php.net/manual/en/control-structures.while.php)
heeft de welbekende structuur, hieronder te zien.

```php
while ($condition) {
    // ...
}
```

De inhoud van het blok wordt herhaald, zo lang `$condition` waar is. Elke 
keer voordat het blok wordt uitgevoerd wordt dit gecontroleerd, en als dit 
niet (meer) waar is, wordt het statement beëindigd.

Het
[`do`-`while`-statement](https://www.php.net/manual/en/control-structures.do.while.php),
hieronder, is vrijwel gelijk, maar hier wordt de controle of `$condition` 
waar is ná het uitvoeren van het blok gedaan. Hierdoor wordt dit blok ten 
minste één keer uitgevoerd.

```php
do {
    // ...
} while ($condition);
```

Binnen een lusconstructie kunnen de statements
[`break`](https://www.php.net/manual/en/control-structures.break.php) en
[`continue`](https://www.php.net/manual/en/control-structures.continue.php)
worden gebruikt. `break` breekt uit de huidige lus, waardoor deze beëindigd 
wordt; `continue` onderbreekt alleen de huidige iteratie en gaat verder met 
de controle of de lus nog een keer moet worden uitgevoerd. In beide gevallen 
kan er optioneel een getal achter worden gezet, bijvoorbeeld `break 2;`. In 
dat geval wordt de huidige lus beëindigd als het getal 1 wordt gebruikt; dit 
is ook het geval als het statement zonder getal wordt gebruikt. Als een 2 
wordt gebruikt wordt de eerstvolgende omsluitende lus gebruikt, en zo verder.

## `for`-statement

Het 
[`for`-statement](https://www.php.net/manual/en/control-structures.for.php)
is een alternatief voor een `while`-lus en ziet er als volgt uit.

```php
for ($init; $condition; $update) {
    // ...
}
```

Dit komt overeen met de onderstaande `while`-lus.

```php
$init;
while ($condition) {
    // ...
    $update;
}
```

Eerst wordt dus de expressie `$init` uitgevoerd, en daarna wordt zolang 
`$condition` waar is, de lus herhaald. Aan het einde van elke iteratie wordt 
steeds `$update` uitgevoerd.

Een concreet voorbeeld hiervan is een lus die een vast aantal keer, 
bijvoorbeeld 10 keer, herhaald wordt, zoals hieronder.

```php
for ($i = 0; $i < 10; $i++) {
    // ...
}
```

De drie onderdelen kunnen ieder worden weggelaten of uit meerdere expressies,
gescheiden door komma's, bestaan. Als ze alle drie worden weggelaten is er 
sprake van een eindeloze lus; dit heeft dan de vorm `for (;;) { ... }`.

## Alternatieve syntax

De `if`-, `while`-, `for`- en `switch`-statements hebben allemaal een 
[alternatieve syntax](https://www.php.net/manual/en/control-structures.alternative-syntax.php)
zonder accolades. Hierbij staat steeds na het sluithaakje aan het 
begin van het statement een dubbele punt, ook bij `elseif` en na `else`, en
worden ze afgesloten met respectievelijke `endif`, `endwhile`, `endfor` en 
`endswitch`, zoals in onderstaande voorbeelden.

```php
if ($condition_1):
    // ...
elseif ($condition_2):
    // ...
else:
    // ...
endif;

while ($condition):
    // ...
endwhile;

for ($init; $condition; $update):
    // ...
endfor;

switch ($val):
    case $a;
        // ...
endswitch;
```

Dit kan, als tussen PHP- en HTML-mode geschakeld wordt, leesbaarder zijn dan 
het gebruik van accolades. Als accolades worden gebruikt, is het minder 
duidelijk welk statement wordt beëindigd, zoals in het voorbeeld hieronder.

```php
<ol>
<?php
for ($i = 1; $i <= 10; $i++) { ?>
    <li<?php if ($i % 2) { ?> class="odd"<?php } ?>>Nummer <?= $i; ?></li>
<?php } ?>
</ol>
```

Met de alternatieve syntax is duidelijker welk statement wordt 
afgesloten.

```php
<ol>
<?php
for ($i = 1; $i <= 10; $i++): ?>
    <li<?php if ($i % 2): ?> class="odd"<?php endif; ?>>Nummer <?= $i; ?></li>
<?php endfor; ?>
</ol>
```