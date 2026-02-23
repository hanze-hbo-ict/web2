# Interfaces

De router maakt gebruik van de onderstaande interface.

## `RouterInterface`

```php
<?php

namespace Framework\Routing;

use Framework\Http\RequestInterface;

/**
 * A service that maps requests to request handlers.
 */
interface RouterInterface
{
    /**
     * Find a suitable request handler for the current request.
     * 
     * @return callable A request handler configured to correctly pass any 
     *     routing parameters. This callable should accept a single parameter
     *     containing the request and return the appropriate response.
     *
     * @throws \DomainException If no route was found for the request.
     */
    function route(RequestInterface $request): callable;
}
```

De `callable` die teruggegeven wordt door de methode `route` krijgt
een `RequestInterface` mee als parameter en moet op dit moment een string 
met de response teruggeven. Dit laatste zal nog veranderen.

Als je PSR-7 gebruikt kan je `RequestInterface` hier vervangen door
`Psr\Http\Message\ServerRequestInterface` en kan je 
`Psr\Http\Message\ResponseInterface` gebruiken als returnwaarde voor de 
`callable`s die door `route` worden teruggegeven.