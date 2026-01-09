# De router

Een enkele webapplicatie zal normaal gesproken uit een veelvoud van pagina's 
bestaan, waarbij aan de hand van de URL bekeken moet worden welke pagina 
getoond moet worden. Dit zou met een groot `if`-statement geschreven kunnen 
worden, maar dat is natuurlijk niet onderhoudbaar. Daarom zullen we de 
logica voor de verschillende pagina's willen scheiden ven elkaar. Om dit
mogelijk te maken, bevat de applicatie een component die de 
*router* genoemd wordt. Deze component bekijkt de URL, en eventueel andere 
aspecten van het request, en selecteert vervolgens de geschikte logica om de 
request verder af te handelen. Omdat webapplicaties vaak 
volgens een model-view-controllerarchitectuur worden opgezet, worden de 
klasses die deze logica implementeren in het algemeen *controllers* genoemd. 
Zo zou er een klasse `IndexController` kunnen zijn die de homepage toont, of 
een klasse `LoginController` die een login-pagina toont.

De router in het framework dat wij ontwikkelen moet voldoen aan de interface 
`Framework\Routing\RouterInterface`, die er als volgt uitziet.

```php
namespace Framework\Routing;

use Framework\Http\RequestInterface;

interface RouterInterface
{
    function route(RequestInterface $request): callable;
}
```

Het type `callable` wordt hieronder nog toegelicht. Kort gezegd bevat dit 
type een verwijzing naar een functie die uitgevoerd kan worden. De router 
heeft dus als taak om, gegeven een request, een functie te vinden die dit 
request kan afhandelen. Het is in PHP niet mogelijk om de signatuur van een 
callable vast te leggen in de typehint; de bedoeling is echter dat de 
functie die het request afhandelt geen parameters heeft en een instantie van 
`Framework\Http\ResponseInterface` teruggeeft. Variaties hierop zijn ook 
toegestaan; zo zou je eventueel ook het requestobject als parameter aan de 
functie kunnen meegeven. We zullen nog zien dat dit echter niet direct 
noodzakelijk is om toch over het requestobject te kunnen beschikken.

[TODO architectuurplaatje]

## Parameters in de URL

In vrijwel alle gevallen zal een applicatie veel URL's bevatten die op 
elkaar lijken en volgens een vast stramien geformatteerd worden. Zo zal 
alleen de URL `http://localhost:8000/` naar de homepage moeten leiden, maar 
zullen alle URL's die beginnen met `http://localhost:8000/blog/` en eindigen 
op een getal wellicht een blogpost moeten tonen. Hierbij moet het getal 
gezien worden als de id van een blogpost in de database, dus alleen als dit 
getal ook een geldige id is is op deze URL een pagina beschikbaar.

Het spreekt voor zich dat al deze blogpagina's in beginsel door dezelfde 
controller afgehandeld moeten worden. Het moet dus mogelijk zijn dat de 
router dit URL-formaat herkend, de bijbehorende controller laat aanroepen en 
ook het getal dat in de URL stond door kan geven aan de controller zodat de 
goede blogpost gevonden kan worden. Er is een veelvoud aan oplossingen 
denkbaar, maar in ieder geval zou gedacht kunnen worden aan *reguliere 
expressies*, die hieronder nog besproken worden.

Merk op dat het in beginsel mogelijk is om dergelijke ids in de *query 
string* te zetten. De URL zou dan bijvoorbeeld
`http://localhost:8000/blog?id=5` worden. Dit heeft echter in het algemeen 
niet de voorkeur; dergelijke URL's worden als minder leesbaar beschouwd en 
vanwege zoekmachineoptimalisatie heeft een URL als 
`http://localhost:8000/blog/5` dan de voorkeur.
