# Oefening

## Encapsuleren van een request
Stel dat het volgende request bij de *front controller* binnenkomt:


```text
POST /users?id=42 HTTP/1.1
Host: hanze.nl
Content-Type: application/json
Authorization: Bearer abc123

{"name":"Ralf", "vierlettercode":"BRRA"}
```

Maak een klasse `Request` die de onderstaande methoden bevat:

Methode | verwachte output
---|---
`getMethod()` | 'POST'
`getUri()` | '/users'
`getQueryParams()` | ["id" => 42]
`getHeader('Content-Type')` | 'application/json'
`getHeader('Authorization')` | 'Bearer abc123'
`getParsedBody()` | ["name"=>"Ralf", "vierlettercode"=>"BRRA"]


## Immutabiliteit

Implementeer de methode `withAttribute()` conform [de gegeven interface](interface.md#requestinterface). Extraheer de `id` uit de *query parameters* en maak een nieuw request-object op basis van het eerste, waarbij deze waarde wordt geïnjecteerd:

Maak gebruik van `spl_object_id()` om de bewijzen dat we te maken hebben met twee verschillende objecten (het eerste object is dus niet aangepast).