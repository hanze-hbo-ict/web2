# Interfaces

Onderstaande interface is ontleend aan
[PSR-7](https://www.php-fig.org/psr/psr-7);
het commentaar bij de interface is hier ook grotendeels aan ontleend en is, 
waar nodig, aangepast.

## `ResponseInterface`

```php
<?php

namespace Framework\Http;

/**
 * Representation of an outgoing, server-side response.
 *
 * Per the HTTP specification, this interface includes properties for
 * each of the following:
 *
 * - Status code and reason phrase
 * - Headers
 * - Message body
 *
 * Responses are considered immutable; all methods that might change state MUST
 * be implemented such that they retain the internal state of the current
 * message and return an instance that contains the changed state.
 */
interface ResponseInterface extends MessageInterface
{
    /**
     * Gets the response status code.
     *
     * The status code is a 3-digit integer result code of the server's attempt
     * to understand and satisfy the request.
     *
     * @return int Status code.
     */
    function getStatusCode(): int;

    /**
     * Return an instance with the specified status code.
     *
     * This method MUST be implemented in such a way as to retain the
     * immutability of the message, and MUST return an instance that has the
     * updated status.
     *
     * @see http://tools.ietf.org/html/rfc7231#section-6
     * @see http://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml
     * @param int $code The 3-digit integer result code to set.
     * @return static
     * @throws \InvalidArgumentException For invalid status code arguments.
     */
    public function withStatusCode(int $code): static;

    /**
     * Gets the body of the response.
     *
     * @return string Returns the body as a string.
     */
    public function getBody(): string;

    /**
     * Return an instance with the specified response body.
     *
     * This method MUST be implemented in such a way as to retain the
     * immutability of the message, and MUST return a new instance that has the
     * new body stream.
     *
     * @param string $body Body.
     * @return static
     */
    public function withBody(string $body): static;
}
```

## `KernelInterface`

De returnwaarde van de methode `handle` in `Framework\Kernel\KernelInterface` kan nu worden vervangen door een instantie van `Framework\Http\ResponseInterface`.  Als de interfaces uit PSR-7 worden gebruikt, kan deze interface in zijn geheel worden vervangen door `Psr\Http\Server\RequestHandlerInterface`.

```php
<?php

namespace Framework\Kernel;

use Framework\Http\RequestInterface;
use Framework\Http\ResponseInterface;

/**
 * Handles a server request and produces a response.
 *
 * A kernel processes an HTTP request in order to produce an
 * HTTP response.
 */
interface KernelInterface
{
    /**
     * Handles a request and produces a response.
     *
     * May call other collaborating code to generate the response.
     * 
     * @param RequestInterface $request The server request. 
     * @return ResponseInterface The response.
     */
    public function handle(RequestInterface $request): ResponseInterface;
}
```

## `RouterInterface`

De `callable`s die door `RouterInterface::route` worden teruggegeven geven nu 
instanties van `ResposneInterface` terug in plaats van `string`s.