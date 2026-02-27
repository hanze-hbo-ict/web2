# Response

Wanneer we een `Request` hebben afgehandeld, is het natuurlijk zaak om een *response* af te maken, die uiteindelijk naar de machine die het request heeft gedaan, de *client*, teruggestuurd kan worden. Tot nu toe hebben we gewoon in [de *kernel*](../2.2-kernel/kernel.md#klasse-als-kernel) gewoon het resultaat van de applicatie afgedrukt (`echo $kernel->handle($_GET, $_POST)`), maar net zoals we een *request* willen encapsuleren in [z'n eigen klasse](request.md), is het ook beter om de *response* te encapsuleren in een separate klasse. Dat is de klasse `Response` (je verwacht het niet).

## HTTP headers

Bekijk nog een keer de verhouding tussen de verschillende klassen, die je hieronder kunt vinden. 

![De verhouding tussen de verschillende onderdelen](../images/psr-7-deels.jpeg)

Net als de `Request`, is de `Response` een instantie van `Message`. Als je [de documentatie van deze interface](https://www.php-fig.org/psr/psr-7/) bekijkt, zie je dat de methoden van `MessageInterface` feitelijk om drie dingen gaan: het *protocol*, de *headers*, en de *body*. Dat betekent dat zowel de *request* als de *response* eveneens deze drie elementen bevatten.

Denk nog even terug aan [de vorm van een request-response-cyclus](intro.md#headers-en-payload). In het plaatje dat je daar hebt gezien, zag je deze drie elementen ook terugkomen. De *conversatie* die de *client* met de *server* voert, maakt gebruik van deze drie elementen. De *client* vraagt een bepaald document bij de *server, en de *server* antwoordt met een bepaalde versie van dit document. Of de *client* geeft behaalde data aan de *server*, waar deze laatste iets mee moet doen, en de *server* reageert eventueel met bepaalde gegevens. Al deze opties zijn vastgelegd in de *headers*.

Met deze informatie kunnen we het onderstaande overzicht maken:

- Een *get-request* heeft een `Accept`-header; de corresponderende *header* van de *response* is `Content-Type`.
- De *body* van een *get-request* is in de regel leeg; de *body* van de *response* bevat in dit geval de opgevraagde data.
- De *body* van een *post-request* bevat in de regel de data die de *client* naar de *server* wil sturen; de *body* van de *response* is in dit geval meestal leeg.

## De klasse `Response`

Het voor deze discussie meest interessante van [de `ResponseInterface`](interface.md#responseinterface) is de methode `getBody()`. Deze methode geeft een *string* terug die de *body* van de *response* is – feitelijk de tekst die we voorheen eenvoudig vanuit de *front controller* werd afgedrukt. Door de encapsulatie kunnen we echter voordat we de response daadwerkelijk uitrpinten nog verrijken met eventuele extra *headers* of nog iets aan de body toevoegen.

Met de kennis die we nu hebben, kunnen we de hele *request life-cycle* beschrijven:

1. De [*front controller*](../3.2-routing/frontcontroller.md) ontvangt een *request*.
2. Op basis hiervan wordt een `Request` gemaakt.
3. De `Router` bepaalt welke *controller* bij dit specifieke `Request` hoort.
4. Deze *controller* maakt, eventueel met behulp van templates, de `Response`.
5. Deze `Response` wordt naar de *client* teruggestuurd.

Grofweg komt dit overeen met het onderstaande sequentie-diagram.

![Complete life-cycle](../images/request-response-sequence.svg)