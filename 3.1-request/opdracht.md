# Opdracht

## Maak de klasse `Request`

Bekijk [de `RequestInterface`](interface.md#requestinterface), en met name het daarbijhorende commentaar. Maak een klasse `Request` (in `/Framework/Http/`) die deze interface implementeert. Geef de betreffende methoden de relavante functionaliteit.

Het is van belang dat er niet zonder meer instanties van deze klasse kunnen worden gemaakt. Om dit te kunnen controlleren wordt de verantwoordelijkheid voor het maken van dergelijke instanties bij de klasse zelf belegd – een techniek die bekend staat onder [*named constuctors*](https://softwarecrafts.eu/static-factory-methods-aka-named-constructors/). 

Bij een dergelijke opbouw maken we gebruik van een *statische methode* die een instantie van de klasse in kwestie teruggeeft. Natuurlijk kunnen we deze methode elke naam geven die we willen, maar omdat dit feitelijk het punt is waar we de http-wereld in de php-wereld omzetten, ligt een naam als `fromGlobals` of `createFromGlobals` voor de hand.

Bekijk het onderstaande voorbeeld. We schermen de constructor van de klasse af door deze *private* te maken; vervolgens roepen we deze constructor aan via de statische methode `fromGlobals`.

```php
<?php
class Request impements RequestInterface {
    private function __construct(
        private array $get,
        private array $post = [],
        private array $files = []
    ) {}

    static public function fromGlobals(): self 
    {
        return new Request(
            $_GET,
            $_POST,
            $_FILES
        );
    }
}
```

Merk op dat we hier drie globale variabelen meegeven aan de constructor. Vanzelfsprekend zul je dit gedurende het project nog moeten aanpassen en uitbreiden.

## Sequentiële opbouw

Om de boel enigszins beheersbaar te houden, kun je beginnen met de meest voor de hand liggende methoden en de overige methoden pas realiseren wanneer je deze nodig hebt. Om te kunnen bepalen welke *controller* je nodig hebt, moet je natuurlijk de *uri* van de *request* weten, dus de methode `getUri` heb je al snel nodig. Hetzelfde geldt voor de methode (het http-werkwoord) van de request.

Vervolgens heb je de *request parameters* (`?name=Ralf&vierlettercode=BRRA`) nodig, dus implementeer je de methode `getQueryParams()`. Daarna kun je de *body* van de request parseren. Uiteindelijk kun je de bestanden en andere attributen van de *request* realiseren.