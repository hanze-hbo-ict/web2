# Oefeningen

## De klasse `Response`

Maak een functie `handle`, conform de onderstaande definitie:

```php
<?php
function handle(RequestInterface $request): ResponseInterface
```

Maak nu een klasse `Response` die [de `ResponseInterface`](interface.md#responseinterface) implementeert. Realiseer in je klasse in ieder geval de methoden `withStatusCode()` en `getBody()`. Zorg ervoor dat je response de volgende functionaliteit heeft:

Request | Response status code | Response body
---|---|---
`GET /ping` | 200 Ok | 'pong'
`GET /coffee` | 218 I'm a teapot | -
`POST /echo` | 200 Ok | body van de request
ander | 404 Not found | -

Maak gebruik van [`spl_object_id()`](https://www.php.net/manual/en/function.spl-object-id.php) om de bewijzen dat `withStatusCode()` het oorspronkelijke object niet heeft aangepast.
