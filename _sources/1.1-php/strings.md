# Strings

Net als veel andere talen kent PHP een
[stringtype](https://www.php.net/manual/en/language.types.string.php).
Een string is een 
verzameling karakters; in PHP zijn dit altijd 8-bit-karakters. Dit heeft 
invloed op de manier waarop bepaalde stringfuncties werken, zoals we nog 
kunnen zien.

Strings kunnen omsloten worden door enkele aanhalingstekens `'` of door 
dubbele aanhalingstekens `"`. De keuze van aanhalingstekens bepaalt op welke 
manier de string wordt geïnterpreteerd. In een string met
[enkele aanhalingstekens](https://www.php.net/manual/en/language.types.string.php#language.types.string.syntax.single)
worden vrijwel alle tekens letterlijk geïnterpreteerd. Alleen het enkele 
aanhalingsteken zelf en de backslash `\` moeten, om op te nemen in de 
string, geëscapet worden door er een backslash voor te zetten. In een 
string met
[dubbele aanhalingstekens](https://www.php.net/manual/en/language.types.string.php#language.types.string.syntax.double)
kunnen ook andere escapesequenties gebruikt worden; zo betekent de 
combinatie `\n` in een string met dubbele aanhalingstekens een *newline*, 
terwijl dit in een string met enkele aanhalingstekens gewoon voor de 
karakters `\n` staat. Een ander voorbeeld is de combinatie `\t` die voor 
een tab staat.

Ook bieden strings met dubbele aanhalingstekens de mogelijkheid om varabelen 
te [*interpoleren*](https://www.php.net/manual/en/language.types.string.php#language.types.string.parsing)
in de string. Als je de naam van een variabele opneemt in 
een string, wordt deze vervangen door de waarde daarvan, zoals in 
onderstaand voorbeeld.

```php
$foo = 1;
$bar = 2;
$double = "foo = $foo\nbar = $bar";
$single = 'foo = $foo\nbar = $bar';
var_dump($double); // bevat foo = 1, newline, bar = 2
var_dump($single); // bevat foo = $foo\nbar = $bar
```

Als de varabele gevolgt moet worden door letters zal PHP denken dat deze bij 
de variabelenaam horen; als je bijvoorbeeld de variabele `$var` wil laten 
volgen door het woord `test`, zou je `"$vartest"` willen gebruiken, maar dan 
zal PHP de variabele `$vartest` interpoleren. Om dit te voorkomen kan je de 
variabele omsluiten met accolades, door `"{$var}test"` te gebruiken.

Daarnaast biedt PHP de mogelijkheid om strings over meerdere regels op te 
nemen met de zogeheten
[heredoc](https://www.php.net/manual/en/language.types.string.php#language.types.string.syntax.heredoc)- en
[nowdoc](https://www.php.net/manual/en/language.types.string.php#language.types.string.syntax.nowdoc)-syntax.
Bij de heredoc-syntax begint de string met drie kleiner-dantekens `<<<`, 
gevolgd door een identifier die normaal gesproken in hoofdletters is. 
Daarna volgt de string, die meerdere regels kan bevatten. De string wordt 
afgesloten als aan het begin van een regel de identifier staat. Hierbij 
worden ook variabelen geïnterpoleerd, dit is dus te vergelijken met een 
string met dubbele aanhalingstekens. In de nowdoc-syntax gebeurt dit niet; 
hierbij moet de identifier die na de kleiner-dantekens staat omsloten worden 
met enkele aanhalingstekens. Van beide vormen is hieronder een voorbeeld te 
zien.

```php
$var = 'foo';
$heredoc = <<<HERE
Hello $var!
HERE;
$nowdoc = <<<'NOW'
Hello $var!
NOW;
```

## Stringoperaties

Een alternatief voor de hierboven genoemde stringinterpolatie is
[stringconcatenatie](https://www.php.net/manual/en/language.operators.string.php)
door middel van de operator `.`. Anders dan in Java en Python worden strings 
niet samengevoegd met de operator `+` maar is hier een aparte operator `.` 
voor. Hiermee kunnen variabelen ook in strings gezet worden; het bovenstaande 
voorbeeld zou ook als volgt opgebouwd kunnen worden.

```php
$foo = 1;
$bar = 2;
$interpolate = "foo = $foo\nbar = $bar";
$concatenate = 'foo = '.$foo."\nbar = ".$bar;
var_dump($interpolate === $concatenate); // beide strings zijn gelijk
```

Niet alleen stringvariabelen mogen geïnterpoleerd of samengevoegd worden; 
andere types variabelen zullen worden omgezet naar strings zodat ze in de 
string gezet kunnen worden.

Je kan de individuele karakters van een string aanspreken door de positie, 
geteld vanaf 0, van het karakter tussen blokhaken achter de string te zetten.
Als bijvoorbeeld de variabele `$var` de waarde `'abc'` bevat, is `$var[0]` 
gelijk aan `'a'` en `$var[2]` gelijk aan `'b'`. PHP heeft geen apart type 
voor losse karakters zoals het type `char` in Java, dus het type van 
`$var[0]` is `string`. Anders dan in bijvoorbeeld Python is het bovendien 
mogelijk om een enkel karakter van een string aan te passen door een nieuw 
karakter toe te kennen aan `$var[0]`, zoals in onderstaand voorbeeld. Merk 
op dat het ook mogelijk is om indices te gebruiken die buiten de 
oorspronkelijke string vallen; eventuele tussenliggende karakters worden 
opgevuld met spaties.

```php
$var = 'abc';
$var[0] = 'x'; // $var is nu 'xbc';
$var[3] = 'd'; // $var is nu 'xbcd';
$var[5] = 'e'; // $var is nu 'xbcd e';
```

## Stringfuncties

PHP heeft een grote verzameling
[stringfuncties](https://www.php.net/manual/en/ref.strings.php).
In de eerste plaats is het mogelijk om de lengte van de string te 
verkrijgen met de functie
[`strlen`](https://www.php.net/manual/en/function.strlen.php).
Daarnaast kan je een deel van de string verkrijgen met de functie
[`substr`](https://www.php.net/manual/en/function.substr.php),
vergelijkbaar met een string *slice* in Python.

PHP heeft weliswaar geen type voor losse karakters, maar heeft wel twee 
functies om een karakter om te zetten naar zijn ASCII-waarde en omgekeerd.  
Dit zijn de functies
[`ord`](https://www.php.net/manual/en/function.ord.php) en
[`chr`](https://www.php.net/manual/en/function.chr.php).
De functie `ord` kijkt specifiek alleen naar het eerste karakter van de 
meegegeven string en zal, als deze meer karakters bevat, een waarschuwing 
geven. Merk hierbij op dat deze functies, net als de andere hier genoemde 
functies, geen weet hebben van de *encoding* van een string. Als een string 
dus geëncodeerd is met UTF-8 en het eerste karakter uit meerdere bytes 
bestaat, zoals bijvoorbeeld een letter met een accent, dan wordt de waarde 
van het eerste byte van dat karakter teruggegeven, niet het 
Unicode-codepoint van het karakter als geheel.

Strings kunnen met de functies
[`strtolower`](https://www.php.net/manual/en/function.strtolower.php) en
[`strtoupper`](https://www.php.net/manual/en/function.strtoupper.php)
omgezet worden in respectievelijke kleine letters en hoofdletters. Als 
alleen het eerste teken moet worden omgezet kunnen in plaats daarvan
[`lcfirst`](https://www.php.net/manual/en/function.lcfirst.php) en
[`ucfirst`](https://www.php.net/manual/en/function.ucfirst.php)
gebruikt worden. Bovendien kan
[`ucwords`](https://www.php.net/manual/en/function.ucwords.php)
gebruikt worden om van de eerste letter van elk woord in de string een 
hoofdletter te maken. Daarnaast kan de functie
[`trim`](https://www.php.net/manual/en/function.trim.php)
worden gebruikt om witruimte, zoals spaties, tabs en newlines, te 
verwijderen aan het begin en einde van een string.

Met de functie
[`strpos`](https://www.php.net/manual/en/function.strpos.php)
kan de positie van een substring in een string worden gevonden. Merk op dat 
deze functie `false` teruggeeft als de substring niet gevonden wordt, maar 
ook het getal 0 kan teruggeven als de string begint met de gezochte 
substring. Daarnaast kan je met
[`str_replace`](https://www.php.net/manual/en/function.str-replace.php)
bepaalde substrings laten vervangen door andere.

Het is ook mogelijk om alleen te kijken of een bepaalde string een andere 
string bevat, zonder hierbij de positie nodig te hebben. Dit kan met de 
functie [`str_contains`](https://www.php.net/manual/en/function.str-contains.php).
Daarnaast kan gekeken worden of een string begint of eindigt met een andere 
string door gebruik te maken van de functies
[`str_starts_with`](https://www.php.net/manual/en/function.str-starts-with.php) en
[`str_ends_with`](https://www.php.net/manual/en/function.str-ends-with.php).

Aangezien PHP met name gebruikt wordt voor webapplicaties, heeft het een 
aantal functies om tekst te kunnen gebruiken in HTML pagina's. Belangrijke 
functies hiervoor zijn
[`htmlspecialchars`](https://www.php.net/manual/en/function.htmlspecialchars.php),
waarmee alle karakters die een speciale betekenis hebben in HTML, zoals `<` 
en `>`, omgezet worden naar HTML-entity's, en
[`strip_tags`](https://www.php.net/manual/en/function.strip-tags.php),
waarmee alle HTML-tags uit een string worden verwijderd. Daarnaast kan de 
functie
[`urlencode`](https://www.php.net/manual/en/function.urlencode.php)
gebruikt worden om een waarde geschikt te maken om te dienen als parameter 
in een URL. Deze functies kunnen gebruikt worden als onderdeel van een 
strategie om
[XSS](https://nl.wikipedia.org/wiki/Cross-site_scripting)-aanvallen
te mitigeren.

## *Multibyte encodings*

In het verleden gebruikten websites en andere applicaties veelal encodings 
waarbij elk karakter een enkele byte was. In Nederland werd hier met name 
ASCII, ISO 8859-1, ISO 8859-15 of Windows-1252 voor gebruikt. Deze encodings 
hebben echter allemaal als probleem dat ze alleen het Latijnse schrift met 
een zeer beperkte verrzameling accenten ondersteunen. Daarom wordt nu 
vrijwel altijd gebruik gemaakt van
[Unicode](https://nl.wikipedia.org/wiki/Unicode),
met name via de encoding
[UTF-8](https://nl.wikipedia.org/wiki/UTF-8).
Strings in PHP, anders dan in bijvoorbeeld Python, hebben hier echter geen 
weet van. Dit brengt met zich mee dat de hierboven genoemde functies er in 
principe vanuit gaan dat elke byte in een string een karakter is, zo zal 
bijvoorbeeld `strlen('ë')` gelijk zijn aan 2 en `strlen('🙂')` gelijk zijn 
aan 4, omdat dat het aantal bytes is dat noodzakelijk is om deze karakters 
in UTF-8 te encoden.

PHP heeft een extensie met een aantal functies om hiermee om te gaan. Dit is 
de extensie [mbstring](https://www.php.net/manual/en/intro.mbstring.php). 
Deze extensie bevat functies zoals
[`mb_strlen`](https://www.php.net/manual/en/function.mb-strlen.php),
die het aantal karakters in een string teruggeeft. De bovengenoemde 
voorbeelden geven allebei 1 terug als `mb_strlen` wordt gebruikt in plaats 
van `strlen`. De
[meeste hierboven genoemde functies](https://www.php.net/manual/en/ref.mbstring.php)
hebben een corresponderende multibyte-versie.
