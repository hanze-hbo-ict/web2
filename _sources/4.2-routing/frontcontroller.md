# De front controller

Tot nu toe hebben we URL's geïnterpreteerd als verwijzingen naar bestanden 
in een lokale directory, zodat we bijvoorbeeld `http://localhost:8080/test.php`
hebben laten uitvoeren door het script `test.php`. Als je echter naar URL's 
in productie-omgevingen kijkt, zie je dat URL's slechts zelden op `.php` 
eindigen. Zo is bijvoorbeeld MediaWiki, de technologie achter Wikipedia, 
geschreven in [PHP](https://www.mediawiki.org/wiki/PHP). Toch eindigen de 
URL's niet in PHP; het lemma over PHP is bijvoorbeeld te vinden op 
`https://nl.wikipedia.org/wiki/PHP`.

Om te zien hoe dit werkt, maken we een bestand `index.php` aan in de 
document root. Dit bestand wordt getoond als de URL
`http://localhost:8080/index.php` gebruikt wordt, zoals je zou verwachten. 
Maar ook als je bijvoorbeeld de URL `http://localhost:8080/welkom` gebruikt,
wordt deze pagina getoond, mits er geen bestand `welkom` in de document root 
staat. Dit werkt op elk niveau; de URL `http://localhost:8000/foo/bar/baz.php` 
wordt in eerste instantie afgehandeld door `foo/bar/baz.php`, maar als die niet
bestaat door `foo/bar/index.php`, en als die niet bestaat door `foo/index.php`,
en als die ook niet bestaat door `index.php`. Pas als ook die laatste niet 
bestaat, zal de server een 404-response geven.

We kunnen van dit fenomeen gebruik maken door slechts één PHP-bestand in de
`public`-folder te zetten, het bestand `index.php`. Alle requests zullen dan 
door dit script worden afgehandeld, behalve als een bestand met die naam 
bestaat. Dit laatste zullen we gebruiken om statische assets zoals 
afbeeldingen en stylesheets te tonen. Het bestand `index.php` wordt de 
*front controller* van de applicatie genoemd.

![Front controller](/images/frontcontroller.png)

## Het pad van een request

Alle requests kunnen nu door een enkele *front controller* `index.php`
afgehandeld worden. We hebben nu echter nog geen informatie over de 
oorspronkelijke URL die door de eindgebruiker is aangeroepen, terwijl het
natuurlijk wel heel logisch is om die te gebruiken om aan te geven welke
informatie getoond moet worden; `https://nl.wikipedia.org/wiki/PHP` en
`https://nl.wikipedia.org/wiki/Python` moeten immers andere lemma's tonen.

De benodigde informatie is te vinden in de *superglobal* `$_SERVER`. Deze 
bevat onder meer de waarde `$_SEVER['REQUEST_URI']`, waarin het pad van een 
request te vinden is. Als bijvoorbeeld de URL
`http://localhost:8000/foo/bar/baz.php` aangeroepen wordt, zal deze waarde 
gelijk zijn aan `/foo/bar/baz.php`. Dit begint dus altijd met een *slash*.

Als de URL ook een *query string* bevat, dus bijvoorbeeld 
`http://localhost:8000/foo.php?q=test`, dan zal die ook onderdeel zijn van 
`$_SEVER['REQUEST_URI']`. In dit geval zal de waarde daarvan dus
`/foo.php?q=test` zijn. Omdat we echter op dit moment alleen geïnteresseerd 
zijn in het pad zelf, moet alles vanaf het vraagteken nog verwijderd worden. 
Hier zijn meerdere mogelijkheden voor, zoals
[`explode`](https://www.php.net/manual/en/function.explode.php),
[`parse_url`](https://www.php.net/manual/en/function.parse-url.php) en,
vanaf PHP 8.5, de klasse
[`Uri\WhatWg\Url`](https://www.php.net/releases/8.5/en.php#new-uri-extension).