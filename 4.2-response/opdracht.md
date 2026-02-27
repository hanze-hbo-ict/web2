# Opgave


## Complete life-cycle

Maak de klasse `Response` in dezelfde *namespace* als waar je `Request` hebt gemaakt. Zorg ervoor dat deze klasse de juiste interface implementeert, en geef de betreffende methoden een relevante implementatie.

Als je [de RFC]() bekijkt, zie je dat een *response* altijd op z'n minst de volgende onderdelen bevat:

- een *Status-Code*
- een 'protocol version
- een lijst van nul of meer *headers*
- een optionele *body*

Het is dus logisch om deze gegevens in de *constructor* van de `Response` mee te geven:

```php
<?php

    public function __construct(
        private int $status_code = 200,
        string $protocol_version = '1.1',
        array $headers = [],
        string $body = null
    ) {}
```

Natuurlijk zul je dit gedurende het project nog moeten aanpassen en uitbreiden.


## Aanpassingen

Pas je `Kernel` aan zodat de methode `handle` een `ResponseInterface` teruggeeft.

Pas je *front controller* aan zodat deze werkt met een `ResponseInterface` in plaats van met een platte string.