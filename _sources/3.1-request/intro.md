# Request, Response en Message

## Introductie

Zoals we [hebben kunnen lezen](../2.2-kernel/kernel.md) is het de taak van een webapplicatie om een *verzoek* van een client (in de regel de webbrowser) om te zetten in een *antwoord*: de client stuurt een `Request` en de webapplicatie (de *server*) zet die om in een `Response`. Zowel de `Request` als de `Response` zijn *berichten* (*messages*) die (met behulp van [het http](../2.2-kernel/http.md)) over de lijn verstuurd worden. Deze berichten hebben een eigen interne semantiek en payload die vrij uitgebreid [in RFC 7230 beschreven wordt](https://datatracker.ietf.org/doc/html/rfc7230) (ook [op MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Messages) kun je hier het nodige over terugvinden, overigens).

Wanneer we dus een *request* in een *response* om willen zetten, dienen we ons te realiseren dat dit beide *messages* zijn. In [PSR 7 ](https://www.php-fig.org/psr/psr-7) staat uitgebreid beschreven wat de verhouding is tussen de `Message`, de `Request` en de `Response`: de laatste twee zijn *uitbreidingen* (*extentions*) van het eerste.

Zie het onderstaande diagram. Onderin hebben we de concrete klassen `Request` en `Response`, die respectievelijk de `RequestInterface` en de `ResponseInterface` implementeren. Deze beide interfaces implementeren op hun beurt weer de `MessageInterface`, wat, gezien de bespreking hierboven logisch is.

![De verhouding tussen `Request`, `Response` en `Message`](../images/psr-7-deels.jpeg)

```{admonition} Request en ServerRequest
:class: warning

De [PSR in kwestie](https://www.php-fig.org/psr/psr-7) maakt onderscheid tussen [`RequestInterface`](https://www.php-fig.org/psr/psr-7/#32-psrhttpmessagerequestinterface) en [`ServerRequestInterface`](https://www.php-fig.org/psr/psr-7/#321-psrhttpmessageserverrequestinterface). Het grote verschil tussen deze twee is dat de eerste interface een *uitgaand* bericht is (dus gezien vanuit de client), terwijl de tweede een *inkomend* bericht is (dus bezien vanuit de server). Beide berichten bevatten de meest voor de hand liggende informatie van het *request*, zoals protocol-versie en http-headers, maar alleen de `ServerRequest` bevat ook nog extra informatie vanuit de php-omgeving of de CGI. 

Voor de opdracht is het evenwel voldoende om je te richten op de *request* zoals deze er aan de serverkant uit ziet (dus feitelijk de `ServerRequestInterface`).
```

## Headers en payload

De vormen van de *request* en de *response* lijken heel erg op elkaar: in beide gevallen is er sprake van een *header* en een eventuele *payload*. In de *header* staat informatie *over* het bericht, in de *payload* staat, tja, de *data* van het bericht. Je kunt de *header* een beetje vergelijken met een *enveloppe* (van vroeger, toen we nog brieven schreven en die in enveloppen deden), terwijl de *payload* in die vergelijking de brief zelf is.

In beide gevallen is het bericht gewoon een stuk tekst, waarin de *header* door een witregel wordt gescheiden van de *payload*. Zie het onderstaande schema (in dit specifieke geval is de *payload* van de *request* leeg):

![Overzicht van de request en de response](../images/http-messages.jpeg)

Feitelijk zijn de *headers* een set van afspraken aan de hand waarvan de *client* en de *server* weten wat ze moeten doen, hoe de verhouding tussen deze beide is, en waar ze zitten in hun conversatie. Er zijn tientallen van dergelijke *headers* beschreven in [RFC7230](https://www.rfc-editor.org/rfc/rfc7230).

Op [de volgende pagina](request.md) bespreken we uitgebreid de *request* en de bijhorende technieken, daarna gaan we in op [de *response*](../3.2-response/response.md).


