# Oefeningen

## Variabelen en operatoren

### Toekennen en printen

Schrijf een programma waarin drie variabelen `$hours_worked`, `$pay_rate` en 
`$tax_rate` voorkomen. Deze variabelen moeten respectievelijke de waardes 40, 
10 en 0.10 krijgen. Druk nu het aantal gewerkte uren, het totale salaris en 
het totale belastingbedrag af. Je kan het totale salaris berekenen door 
`$hours_worked` te vermenigvuldigen met `$pay_rate`, en het totale 
belastingbedrag door dit resultaat te vermenigvuldigen met `$tax_rate`. Het 
resultaat moet er als volgt uitzien, waarbij de getallen natuurlijk 
berekend moeten worden.

```
Hours Worked: 40
Pay Amount  : 400
Tax Amount  : 40
```

Je kan je programma uitvoeren met het commando `php bestandsnaam.php`, of 
door in PhpStorm op het groene playknopje (rechtsboven) te klikken.

### Meer toekennen en printen

Pas het vorige script zo aan dat de variabele `$hours_worked` de waarde 
`"40"` krijgt (waarbij je de aanhalingstekens letterlijk overneemt in de 
code). Kijk wat nu de uitvoer is van het script. Gebruik vervolgens de 
waarde `"40x"` en kijk nu wat de uitvoer is. Gebruik ten slotte de waarde 
`"x40"` en kijk weer wat de uitvoer is.

### Waarde van kwadratische formule

Schrijf een programma dat de waarde van de formule $3x^2-8x+4$ berekent. 
Gebruik hierbij een variabele `$x` en ken hier een waarde aan toe. Schrijf 
een statement dat een waarde berekent voor de vergelijking en sla het 
resultaat op in een andere variabele. Druk tenslotte het resultaat af, 
bijvoorbeeld als volgt.

```
Voor X = 4 is de waarde 20
```

Voer het programma uit met verschillende waarden voor `$x` (bewerk het 
programma voor elke waarde van `$x`) en onderzoek het resultaat. Gebruik 
waarden met decimalen, grote waarden, kleine waarden, negatieve waarden en 
nul. Als je op zou lossen voor welke waarden van `$x` deze formule 0 is, zou 
je vinden dat dit zo is als `$x` gelijk is aan 2 of aan 2/3. Probeer deze 
waarden voor $x. Zijn de resultaten precies goed?

### Waarden opnieuw toewijzen aan variabelen

Wijzig het vorige programma zodanig dat in één run van het programma de 
waarde van de kwadratische functie wordt berekend en uitgeschreven voor 
drie verschillende waarden van `$x`: 0, 2 en 4 (of drie waarden naar keuze).

Schrijf het programma met slechts twee variabelen, `$x` en `$value` (de 
uitkomst van de formule voor $x). Dit betekent natuurlijk dat je op 
verschillende plaatsen in het programma verschillende dingen in deze 
variabelen moet zetten.

## Strings, lussen en keuzes

### Order checker

Bob’s IJzerwaren Discounter rekent met de volgende prijzen:

* 5 cent per bout
* 3 cent per moer
* 1 cent per sluitring

Schrijf een functie die het aantal bouten, moeren en sluitringen in een 
aankoop als parameters meekrijgt en dan het totaal berekent en afdrukt.

Als extra functie controleert het programma de bestelling. Een correcte 
bestelling moet

* minstens evenveel moeren als bouten bevatten
* minstens tweemaal zoveel sluitringen als bouten bevatten

Als dit niet het geval is dan heeft de bestelling een fout. Bij een fout 
schrijft het programma `Controleer de bestelling: te weinig moeren` of 
`Controleer de bestelling: te weinig sluitringen`, al naar gelang het geval.
Beide foutmeldingen worden geschreven als de bestelling beide fouten heeft. 
Als er geen fouten zijn, schrijft het programma `Bestelling is OK`. In alle 
gevallen wordt de totaalprijs in centen (van het opgegeven aantal stuks) 
uitgeschreven. Als bijvoorbeeld het aantal bouten 12, het aantal moeren 8 
en het aantal ringen 24 is moet het volgende worden afgedrukt:

```
Controleer de bestelling: te weinig moeren

Totale kosten: 108
```

### Tanken of scheuren

Het bekende Al’s Last Chance Gas pompstation ligt aan Route 190 aan de rand 
van Death Valley, Verenigde Staten.Er is geen ander benzinestation in een 
omtrek van 320 kilometer. Schrijf een functie om bestuurders te helpen 
beslissen of ze moeten tanken. De functie krijgt de volgende parameters mee:

* De inhoud van de benzinetank, in liters.
* De aanduiding van de benzinemeter in procenten (vol = 100, driekwart vol 
  = 75, enzovoort).
* Het aantal kilometer per liter van de auto.

Het programma schrijft dan `Tanken!` of `Rijd door` afhankelijk van of de 
auto de 320 kilometer kan halen met de resterende benzine in de tank. Als 
bijvoorbeeld de tankinhoud 48 liter is, de benzinemeter op 30% staat en de 
auto 15 kilometers per liter rijdt, moet het volgende worden afgedrukt:

```
Tanken!
```

### Millenniumbug

Schrijf een functie waar een geboortejaar, met twee cijfers, en het huidige 
jaar, ook met twee cijfers, wordt afgedrukt. De functie moet de leeftijd 
correct in jaren teruggeven.

Als bijvoorbeeld het geboortejaar 62 is en het huidige jaar 99, is de 
leeftijd 37. De functie moet bepalen of een tweecijferige waarde zoals 62 
overeenkomt met een jaar in de 20e eeuw (1962) of in de 21e eeuw (2062).

Het getal 00 kan bijvoorbeeld gebruikt worden om het jaar 2000 aan te 
duiden. Als het geboortejaar 62 is en het huidige jaar 00, dus 2000, is de 
leeftijd 38.

Veronderstel verder dat leeftijden niet negatief zijn, dus als het 
geboortejaar 27 is en het huidige jaar 07, is de leeftijd niet -20 maar 80. 
Een ander randgeval is bijvoorbeeld de situatie waar het geboortejaar 01 is 
en het huidige jaar 07. Dan kan de leeftijd 6 of 106 zijn. Neem dan aan dat 
de leeftijd altijd kleiner dan 100 zal zijn.

### ABC

Een woord is zogezegd *abecedarisch* als de letters in het woord in 
alfabetische volgorde voorkomen. De volgende woorden zijn bijvoorbeeld 
allemaal abecedarische woorden:

```
accent, accept, afkoop, afloop, agnost, begijn, bekort, beloop, bemost, 
chintz, chloor, dekkop, dekmos, dikkop, dikoor, eenoor, effort, floppy, 
glossy, abelmos, accijns, beknopt, bennoot, bijknop, bijloop, bijnoot, 
deinoor, deeghouw, knoop
```

Schrijf een PHP-script waarin je de GET-parameter `s` uitleest die een woord 
bevat en een boolean afdrukt die aangeeft of het woord abecedarisch is. Je 
kan de GET-parameter uitlezen mwt `$_GET['s']`. Draai dit script in een 
webserver met `php -S localhost:8000` en roep het aan via 
`http://localhost:8000/bestand.php?s=woord`.

### Dubbelwoorden

Men zegt dat een woord een *dubbelwoord* is als elke letter die voorkomt in 
het woord precies twee keer voorkomt. Hier zijn enkele voorbeelden van 
dubbelwoorden:

```
dodo, enen, jojo, lala, mama, mimi, papa, bonbon, dumdum, inging, kerker, 
tamtam, tenten, verver, beriberi, couscous, genegene, taaitaai
```

Ook veel (maar lang niet alle) palindromen zijn dubbelwoorden:

```
hannah, neen, raar, redder, parteretrap
```

Schrijf een PHP-script waarin je de GET-parameter `s` uitleest die een woord 
bevat en een boolean afdrukt die aangeeft of het een dubbelwoord is. Draai 
dit script in een webserver.

Om hoofdletters te negeren, kan je de functie `strtolower` gebruiken die 
een string in kleine letters omzet, voordat je deze controleert.

### Schaakstukken

```
♔ ♕ ♖ ♗ ♘ ♙ ♚ ♛ ♜ ♝ ♞ ♟
```

In [Unicode](https://home.unicode.org) worden karakters door numerieke 
*code points* gerepresenteerd. Schaakstukken zijn ook
[gedefinieerd](https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode) en 
kunnen als karakters worden gebruikt.  Het is een oplopende reeks die begint 
met 9812 (witte koning) en eindigt op 9823 (zwarte pion). Doorloop deze 
reeks met een lus en print elke waarde als een Unicode-karakter. Je kan 
hiervoor de functie 
[`mb_chr`](https://www.php.net/manual/en/function.mb-chr.php) gebruiken.

## Arrays

### Gemiddelde berekenen

Schrijf een PHP-script waarin je de GET-parameter `x` uitleest die een array 
met getallen bevat en het gemiddelde van deze getallen afdrukt. Je 
kan de array uitlezen en omzetten naar integers met onderstaand snippet.

```php
$array = array_map('intval', $_GET['x']);
```

Je mag aannemen 
dat de array niet leeg is; dit hoef je niet te controleren. Gebruik een lus 
om de getallen in de array op te tellen, en een standaardfunctie om het 
aantal getallen te bepalen.

Draai dit script in een 
webserver met `php -S localhost:8000` en roep het aan via bijvoorbeeld
`http://localhost:8000/bestand.php?x[]=1&x[]=2&x[]=3`.

### Kwadraten

Schrijf een PHP-script waarin je de GET-parameter `x` uitleest die een array 
met getallen bevat en een nieuwe array afdrukt waar elk getal gekwadrateerd 
is. Maak hierbij gebruik van een lege array waarin je de kwadraten zet, en 
gebruik een lus om de nieuwe array te vullen. Merk op dat als je `echo` 
gebruikt om een array af te drukken je de tekst `Array` zult zien, maak 
daarom gebruik van `var_dump`.

### Meer kwadraten

Schrijf een PHP-script waarin je de GET-parameter `x` uitleest die een array 
met getallen bevat en dezelfde array afdrukt waarbij elk getal gekwadrateerd 
is. Maak hierbij geen gebruik van een lege array; in plaats daarvan 
moet je een lus gebruiken om de elementen van de originele array één voor 
één te vervangen door hun kwadraat. Je mag hierbij aannemen dat de array 
niet associatief is, dus dat de sleutels van de array oplopende getallen 
vanaf 0 zijn.

### Elementen tellen

Schrijf een PHP-script waarin je de GET-parameter `x` uitleest die een array 
bevat en druk een associatieve array af waarbij elk van de elementen van de 
originele array als sleutel in het resultaat terugkomt, en de bijbehorende 
waarde het aantal voorkomens van deze sleutel in de oorspronkelijke array is.
Je kan in dit geval rechtstreeks de waarde `$_GET['x']` gebruiken.

Als je bijvoorbeeld de array `['a', 'a', 'b', 'a', 'c', 'b']` meegeeft, moet 
het resultaat de associatieve array `['a' => 3, 'b' => 2, 'c' => 1]` zijn.
