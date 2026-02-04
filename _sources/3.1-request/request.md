# Request

## Van HTTP naar PHP

Het HTTP is alleen maar een *transport-protocol*: wanneer we iets ingewikkelders willen doen dan alleen maar data heen en weer sturen, zullen we gebruik moeten maken van een programmeertaal – PHP in ons geval.

Dat houdt evenwel in dat we met twee verschillende paradigmata te maken hebben: aan de ene kant de wereld van het *transport* en aan de andere kant de wereld van het *programma*. Om te voorkomen dat we deze twee werelden te veel met elkaar mixed, is het van belang dat we een *vertaling* van het één in het ander maken. Op die manier kunnen we onze programmacode helemaal loskoppelen van de wereld van het HTTP, wat de transfereerbaarheid, onderhoudbaarheid en testbaarheid vanzelfsprekend ten goede komt.

Bekijk de onderstaande afbeelding. Hier wordt de vertaling van de HTTP-wereld naar de PHP-wereld (en vice versa) grafisch uitgebeeld. Aan de linkerkant komt een *request* onze PHP-wereld binnen, de *applicatie* doet van alles met dit *request*, genereert uiteindelijk een *response*, die weer aan de HTTP-wereld wordt teruggegeven.

![De vertaling van HTTP naar PHP en vice versa](../images/http-php.jpeg)

Het is de klasse `Request` die de vertaling van de HTTP- naar de PHP-wereld maakt, en de klasse `Response` die het omgekeerde doet.

## De kernel en de request

[In een eerder onderdeel](../2.2-kernel/kernel.md#klasse-als-kernel) hebben we het gehad over de `KernelInterface` die een methode `handle` heeft. Zoals je daar kunt zien, verwacht deze methode op dit moment twee parameters: `array $get` en `array $post`. Deze twee parameters werden gevuld door het script `hello.php`.

Je ziet hier direct al twee problemen met deze aanpak. Allereerst schaalt het niet heel lekker. Er is nu rekening gehouden met twee superglobals die gevuld worden vanuit de PHP-omgeving, maar er zijn er natuurlijk [nog meer](https://www.php.net/manual/en/language.variables.superglobals.php): `$_FILES`, `$_COOKIE`, of `$_SESSION`, om er maar drie te noemen.

Een tweede punt van aandacht is dat we op deze manier de hele tijd superglobals door onze applicatie heen sturen. Globale variabele zijn sowieso altijd verdacht, maar zeker superglobals. Bovendien zijn zowel `$_GET` als `$_POST` eenvoudige associatieve arrays, dus onze IDE kan op niet helpen met het uitzoeken van wat we hier allemaal mee kunnen doen.

Om deze reden is het beter om de superglobal `$_GET` om te zetten in een instantie van de klasse `Request` en die verder in de applicatie te gebruiken. Dit object *encapsuleert* dan de superglobal.

Als je [de betreffende paragraaf van PSR-7 bekijkt](https://www.php-fig.org/psr/psr-7/#3-interfaces) zie je dat `Message`, `Request` en `ServerRequest` gedrieën alle zaken encapsuleren die we [in de vorige paragraaf besproken hebben](intro.md). Zo is er een methode om het *target* van de request op te vragen (`getRequestTarget()`), een methode om het gebruikte HTTP-werkwoord op te vragen (`getMethod()`), of een methode om de *query parameters* op te vragen (`getQueryParams()`). 

Verder kun je zien dat we in de implementaties van deze methoden de waarden uit de superglobals kunnen (moeten) aanpassen, waardoor het werken hiermee verderop in onze applicatie een stuk makkelijker wordt. Zo hoeven we bijvoorbeeld niet te weten hoe *query parameters* over de lijn worden verstuurd, omdat ze in onze `Request` worden omgezet in een standaard php-array.

## Het maken van de `Request` klasse

We maken de klasse `Request` (net als de klasse `Response`) in de namespace `Message`: maak in de directory `App` een nieuwe directory `Message` om dit voorbeeld te kunnen volgen.

```{admonition} Alleen $_GET
Voor deze discussie maken we alleen gebruik van de `$_GET`-superglobal; het werken met de rest wordt overgelaten aan de oefeningen en de opdracht.
```

Om de `$_GET` superglobal te kunnen encapsuleren, moeten we deze natuurlijk opslaag in de *scope* van de instantie van de betreffende klasse. Die lokale representatie zouden we dan kunnen vullen met behulp van [contructor promotion](../1.2-php/oop.md#constructor-promotion). In de methode `getQueryParams` retourneren we dit veld dan:

```php
<?php
namespace Framework\Message;

class Request
{
    public function __construct(private array $get) {}

    public function getQueryParams(): array
    {
        return $this->get;
    }
}
```

Omdat we nu met deze klasse alle eigenschappen van het *request* in één object kunnen opslaan, kunnen we de signature van `handle` in de `KernelInterface` kunnen aanpassen:

```php
<?php
    //andere code weggelaten
    public function handle(Request $request): string;
```

En dan moeten we, vanzelfsprekend, ook de implementatie hiervan `HelloKernel` navenant aanpassen:

```php
<?php
  //andere code weggelaten
  public function handle(Request $request): string
  {
    $name = $request->getQueryParams()['name'];
    return "Hello, $name";
  }
```

In het script `hello.php` moeten we dan een instantie maken van de `Request`-klasse. Het volledige script wordt dan als volgt:

```{code-block} php
---
name: hello-script
linenos: True
---
<?php

use App\HelloKernel;
use Framework\Message\Request;

require_once ('vendor/autoload.php');

$kernel = new HelloKernel();
$request = new Request($_GET);
echo $kernel->handle($request);
```

## Een kleine *refactoring*

Hoewel dit op zich werkt, is het nog niet helemaal lekker. In verband met de *life cycle* van de *request* is het ongewenst dat we hier zonder meer nieuwe instanties van kunnen maken. Voor nu voert het wat te ver om dat volledig toe te lichten, maar het is beter om de verantwoordelijkheid van het aanmaken van instanties van deze klasse bij de klasse zelf te beleggen. Om dit te bewerkstelligen maken we de *constructor* van de klasse privaat en breiden we de API uit met een *statische methode* die een instantie van de klasse teruggeeft:

```php
<?php
    //andere code weggelaten
    private function __construct(private array $get) {}
    
    public static function fromGlobals():self
    {
        return new Request($_GET); 
    }
```

De manier waarop we de instantie van `Request` aanmaken is dan ook anders (regel 9 in het script hierboven):

```php
<?php
  //andere code weggelaten

  $request = Request::fromGlobals();
  echo $kernel->handle($request);
```

Je ziet dat we *alleen* in de statische methode `fromGlobals()` met de superglobals te maken hebben; in de rest van onze applicatie werken we eenvoudig met php-objecten en constructies. Dit zal zo blijven, totdat we de boel uiteindelijk om gaan zetten in een instantie van de klasse `Response`, die we weer de HTTP-wereld insturen.


