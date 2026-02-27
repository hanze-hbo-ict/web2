# Opdracht

## Maak de klasse `Request`

Bekijk [de `RequestInterface`](interface.md#requestinterface), en met name het daarbijhorende commentaar. Maak een klasse `Request` (in `/Framework/Http/`) die deze interface implementeert. Geef de betreffende methoden de relavante functionaliteit.

## Sequentiële opbouw

Om de boel enigszins beheersbaar te houden, kun je beginnen met de meest voor de hand liggende methoden en de overige methoden pas realiseren wanneer je deze nodig hebt. Om te kunnen bepalen welke *controller* je nodig hebt, moet je natuurlijk de *uri* van de *request* weten, dus de methode `getUri` heb je al snel nodig. Hetzelfde geldt voor de methode (het http-werkwoord) van de request.

Vervolgens heb je de *request parameters* (`?name=Ralf&vierlettercode=BRRA`) nodig, dus implementeer je de methode `getQueryParams()`. Daarna kun je de *body* van de request parseren. Uiteindelijk kun je de bestanden en andere attributen van de *request* realiseren.