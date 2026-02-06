# Opdracht

## Composer

Voeg een bestand `composer.json` toe aan de root directory van je project en 
zorg ervoor dat de autoloader hierin goed geconfigureerd wordt, zodat in 
ieder geval klassen in de namespaces `Framework` en `App` in de directory 
`src` gezocht worden. Zorg ervoor dat Composer de juiste bestanden genereert 
door het commando `composer install` te gebruiken, zoals beschreven in het 
hoofdstuk over Composer.

Je zult voor het debuggen van je applicatie vaak `var_dump` gebruiken om 
variabelen te inspecteren. Dit is niet altijd even leesbaar in een browser. 
Het is daarom toegestaan om de component
[VarDumper](https://symfony.com/doc/current/components/var_dumper.html)
van [Symfony](https://symfony.com) te gebruiken, die een aantal extra 
functionaliteiten biedt om var dumps beter leesbaar te maken. Je kan, als je 
hiervan gebruik wilt maken, deze in `composer.json` toevoegen aan de 
afhankelijkheden van je project, bijvoorbeeld met `composer require`.

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


Zorg ervoor dat de kernels in de juiste bestanden staan zodat de autoloader 
ze kan vinden en zorg er ook voor dat de bestanden in de document root de 
autoloader van Composer gebruiken.
