# Opdracht

## Request

We hebben gezien dat het pad van de URL die door de gebruiker is 
aangeroepen beschikbaar is in `$_SERVER['REQUEST_URI']`.

De overige onderdelen van een URI zijn het schema, `http` of `https`, de 
domeinnaam, de gebruikte poort, eventueel een query string en de 
gebruikersnaam en wachtwoord die voor de domeinnaam staan. Al deze 
informatie is ook te vinden in de superglobal
[`$_SERVER`](https://www.php.net/manual/en/reserved.variables.server.php).

Het is met deze informatie mogelijk om de URL te reconstrueren. Het is 
daarom nu mogelijk om de methode `getUri` in
`Framework\Http\RequestInterface` te implementeren. Implementeer deze 
methode nu zodat je die hierna kan gebruiken om de router te schrijven.

## Router

Deze week moet je bezig met de router. De opdracht schrijft voor dat deze 
aan de interface `Framework\Routing\RouterInterface` voldoet, die hieronder 
staat.

```php
namespace Framework\Routing;

use Framework\Http\RequestInterface;

interface RouterInterface
{
    function route(RequestInterface $request): callable;
}
```

Om een begin te maken met de router, is het verstandig om te bedenken 
hoe je bepaalt welke requests door welke functies worden afgehandeld. Je kan 
bijvoorbeeld een associatieve array maken die reguliere expressies mapt op 
klassen, objecten of functies en in je router met behulp van een 
`foreach`-lus bekijken welke reguliere expressie past bij de huidige URL. Je 
kan ook een object maken waarin informatie zit over de URL en eventueel 
andere aspecten van het request, zoals de methode, die je wilt matchen, en 
daarbij informatie over de te gebruiken controller. Deze kan je dan in een 
array zetten waar je ook over kan lussen.

Bedenk ook dat tijdens de runtime 
van de applicatie er geen nieuwe routes bij zullen komen, dus het is prima 
als je deze array als constructorparameter meegeeft. Je hoeft geen methodes 
te hebben om routes toe te voegen aan de router

De interface vereist dat je een callable teruggeeft, maar het is prima dat 
je intern bijvoorbeeld iets als `Framework\Http\RequestHandlerInterface` 
gebruikt als interface voor je controllers; je kan immers altijd een anonieme 
functie maken waarin je je controller aanroept en die anonieme functie 
teruggeven. Daarmee kan je bovendien eventuele URL-parameters binden zodat 
de controller hier de beschikking over heeft.

Het kan slim zijn om de router te proberen met een paar eenvoudige URL's, 
bijvoorbeeld een URL voor de homepage en een URL voor blogpagina's, waarbij 
in het laatste geval een id als parameter in de URL staat. Bedenk dat je 
normaal gesproken alleen het pad in de URL matcht, en dat dat altijd met een 
slash `/` begint.

Bedenk ten slotte dat je de informatie over het request uit het meegegeven 
argument moet halen, het is niet de bedoeling dat je in de router nog kijkt 
naar de superglobals.