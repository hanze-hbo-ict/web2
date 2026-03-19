# Interfaces

Voor autorisatie worden onderstaande interfaces gebruikt. Merk op dat, als 
je PSR-7 gebruikt, je verwijzingen naar `Framework\Http\RequestInterface` 
moet vervangen door `Psr\Http\Message\ServerRequestInterface`.

## `AuthorizationInterface`

```php
<?php

namespace Framework\AccessControl;

/**
 * A service that can authorize access to permissions to certain users.
 */
interface AuthorizationInterface
{
    /**
     * Checks whether the user has the given permission, optionally with parameters.
     * @param UserInterface $user
     * @param string $permission
     * @param mixed ...$parameters
     * @return bool
     */
    function isGranted(UserInterface $user, string $permission, mixed ...$parameters): bool;

    /**
     * Throws an exception unless the user has the given permission, optionally with parameters.
     * @param UserInterface $user
     * @param string $permission
     * @param mixed ...$parameters
     */
    function denyUnlessGranted(UserInterface $user, string $permission, mixed ...$parameters): void;
}
```

## `FirewallInterface`

```php
<?php

namespace Framework\AccessControl;

use Framework\Http\RequestInterface;

/**
 * A service that can block unauthorized users from accessing parts of the website.
 */
interface FirewallInterface
{
    /**
     * Checks whether the user is allowed to perform the request.
     * @param RequestInterface $request
     * @param UserInterface $user
     * @return bool
     */
    function accepts(RequestInterface $request, UserInterface $user): bool;
}
```

## `UserInterface`

Voor role-based access control is het noodzakelijk dat van een user bekend 
is welke rollen deze heeft. `UserInterface` wordt daarom uitgebreid met een 
methode `getRoles`.

```php
<?php

namespace Framework\AccessControl;

/**
 * A user, either a logged-in user or an anonymous user.
 */
interface UserInterface
{
    /**
     * Get the user's username.
     * @return string
     */
    function getUsername(): string;

    /**
     * Get the user's hashed password.
     * @return string
     */
    function getPasswordHash(): string;

    /**
     * Get the user's roles.
     * @return array<string>
     */
    function getRoles(): array;

    /**
     * Get whether the user is an anonymous user, as opposed to a logged in user.
     * @return bool
     */
    function isAnonymous(): bool;
}
```

## `MiddlewareInterface`

De middleware maakt gebruik van onderstaande, aan
[PSR-15](https://www.php-fig.org/psr/psr-15) ontleende interface. Het 
commentaar bij de interface is hier ook aan ontleend. Als de interfaces uit 
PSR-7 worden gebruikt, kan deze interface in zijn geheel worden vervangen door 
`Psr\Http\Server\MiddlewareInterface`.

```php
namespace Framework\Kernel;

use Framework\Http\ResponseInterface;
use Framework\Http\RequestInterface;

/**
 * Participant in processing a server request and response.
 *
 * An HTTP middleware component participates in processing an HTTP message:
 * by acting on the request, generating the response, or forwarding the
 * request to a subsequent middleware and possibly acting on its response.
 */
interface MiddlewareInterface
{
    /**
     * Process an incoming server request.
     *
     * Processes an incoming server request in order to produce a response.
     * If unable to produce the response itself, it may delegate to the provided
     * request handler to do so.
     */
    function process(RequestInterface $request, RequestHandlerInterface $handler): ResponseInterface;
}
```

## `RequestHandlerInterface`

Als een bepaalde middlewarelaag het request niet kan afhandelen, wordt dit 
doorgestuurd naar de volgende request handler met onderstaande interface, 
die is ontleend aan [PSR-15](https://www.php-fig.org/psr/psr-15); ook het 
commentaar is hieraan ontleend. Als de interfaces uit PSR-7 worden gebruikt,
kan deze interface in zijn geheel worden vervangen door 
`Psr\Http\Server\RequestHandlerInterface`.

```php
<?php

namespace Framework\Kernel;

use Framework\Http\RequestInterface;
use Framework\Http\ResponseInterface;

**
 * Handles a server request and produces a response.
 *
 * An HTTP request handler process an HTTP request in order to produce an
 * HTTP response.
 */
interface RequestHandlerInterface
{
    /**
     * Handles a request and produces a response.
     *
     * May call other collaborating code to generate the response.
     * 
     * @param RequestInterface $request The request. 
     * @return ResponseInterface The response.
     */
    function handle(RequestInterface $request): ResponseInterface;
}
```

## `KernelInterface`

`KernelInterface` is dezelfde interface als `RequestHandlerInterface` en kan 
dus deze interface op onderstaande manier extenden. Als 
de interfaces uit PSR-7 worden gebruikt, is deze interface eerder al vervangen 
door `Psr\Http\Server\RequestHandlerInterface`. 

```php
<?php

namespace Framework\Kernel;

/**
 * Handles a server request and produces a response.
 *
 * A kernel processes an HTTP request in order to produce an
 * HTTP response.
 */
interface KernelInterface extends RequestHandlerInterface
{
}
```