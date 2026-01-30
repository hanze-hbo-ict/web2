# Opdracht

## Composer

Voeg een bestand `composer.json` toe aan de root directory van je project en 
zorg ervoor dat de autoloader hierin goed geconfigureerd wordt, zodat in 
ieder geval klassen in de namespaces `Framework` en `App` in de directory 
`src` gezocht worden. Zorg ervoor dat Composer de juiste bestanden genereert 
door het commando `composer install` te gebruiken, zoals beschreven in het 
hoofdstuk over Composer.

## Kernel

Refactor de PHP-scripts die in de document root staan zodat ze gebruik maken 
van kernelobjecten. Gebruik hiervoor een basisklasse die de 
onderstaande interface `Framework\Kernel\KernelInterface` implementeert, en 
laat de kernels voor verschillnde pagina's hiervan extenden.

```php
<?php

namespace Framework\Kernel;

interface KernelInterface
{
    function handle(array $get, array $post): string;
}
```


Zorg ervoor dat de kernels in het juiste bestand staan zodat de autoloader 
ze kan vinden en zorg er ook voor dat de bestanden in de document root de 
autoloader van Composer gebruiken.
