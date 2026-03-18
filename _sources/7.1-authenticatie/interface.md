# Interfaces

Voor authenticatie worden onderstaande interfaces gebruikt. Merk op dat, als 
je PSR-7 gebruikt, je verwijzingen naar `Framework\Http\RequestInterface` 
moet vervangen door `Psr\Http\Message\ServerRequestInterface`.

## `AuthenticationInterface`

```php
<?php

namespace Framework\AccessControl;

use Framework\Http\RequestInterface;

/**
 * A service that can authenticate a user based on information in the current request.
 */
interface AuthenticationInterface
{

    /**
     * Authenticate the given request.
     * @param RequestInterface $request
     * @return UserInterface The user that was found in the request, or an anonymous user if no user was found.
     */
    function authenticate(RequestInterface $request): UserInterface;
}
```

## `UserInterface`

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
     * Get whether the user is an anonymous user, as opposed to a logged in user.
     * @return bool
     */
    function isAnonymous(): bool;
}
```

## `UserProviderInterface`

```php
<?php

namespace Framework\AccessControl;

/**
 * A service which can find users by their username.
 */
interface UserProviderInterface
{
    /**
     * Get a user by their username.
     * @param string $username
     * @return UserInterface The user matching the username, or an anonymous user if none could be found.
     */
    function get(string $username): UserInterface;
}
```

## `SessionInterface`

```php
<?php

namespace Framework\Http;

/**
 * A service that allows access to the global session.
 * Session cookies SHOULD not be created unless the session is actively being used.
 */
interface SessionInterface extends \ArrayAccess
{
    /**
     * Destroy the session, its cookie and its contents.
     */
    function destroy(): void;
}
```