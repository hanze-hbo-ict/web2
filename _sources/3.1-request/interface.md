# Interfaces

Onderstaande interfaces zijn ontleend aan
[PSR-7](https://www.php-fig.org/psr/psr-7);
het commentaar bij de interfaces is hier ook grotendeels aan ontleend en is, 
waar nodig, aangepast.

## `MessageInterface`
`
```
<?php

namespace Framework\Http;

/**
 * HTTP messages consist of requests from a client to a server and responses
 * from a server to a client. This interface defines the methods common to
 * each.
 *
 * Messages are considered immutable; all methods that might change state MUST
 * be implemented such that they retain the internal state of the current
 * message and return an instance that contains the changed state.
 *
 * @see http://www.ietf.org/rfc/rfc7230.txt
 * @see http://www.ietf.org/rfc/rfc7231.txt
 */
interface MessageInterface
{
    /**
     * Retrieves all message header values.
     *
     * The keys represent the header name, and each value is a string associated
     * with the header.
     *
     * @return string[] Returns an associative array of the message's headers.
     *     Each key MUST be a header name, and each value MUST be a string
     *     containing that header.
     */
    function getHeaders(): array;

    /**
     * Checks if a header exists by the given case-insensitive name.
     *
     * @param string $name Case-insensitive header field name.
     * @return bool Returns true if any header names match the given header
     *     name using a case-insensitive string comparison. Returns false if
     *     no matching header name is found in the message.
     */
    function hasHeader(string $name): bool;

    /**
     * Retrieves string with the value of a single header.
     *
     * If the header does not appear in the message, this method MUST return
     * an empty string.
     *
     * @param string $name Case-insensitive header field name.
     * @return string A string of values as provided for the given header
     *    concatenated together using a comma. If the header does not appear in
     *    the message, this method MUST return an empty string.
     */
    function getHeader(string $name): string;

    /**
     * Return an instance with the provided value replacing the specified header.
     *
     * This method MUST be implemented in such a way as to retain the
     * immutability of the message, and MUST return an instance that has the
     * new and/or updated header and value.
     *
     * @param string $name Case-insensitive header field name.
     * @param string $value Header value(s).
     * @return static
     * @throws \InvalidArgumentException for invalid header names or values.
     */
    function withHeader(string $name, string $value): static;

    /**
     * Return an instance without the specified header.
     *
     * Header resolution MUST be done without case-sensitivity.
     *
     * This method MUST be implemented in such a way as to retain the
     * immutability of the message, and MUST return an instance that removes
     * the named header.
     *
     * @param string $name Case-insensitive header field name to remove.
     * @return static
     */
    function withoutHeader(string $name): static;
}
```

## `RequestInterface`

```php
<?php

namespace Framework\Http;

use Uri\Rfc3986\Uri;

/**
 * Representation of an incoming, server-side HTTP request.
 *
 * Per the HTTP specification, this interface includes properties for
 * each of the following:
 *
 * - HTTP method
 * - URI
 * - Headers
 * - Message body
 *
 * Additionally, it encapsulates all data as it has arrived at the
 * application from the CGI and/or PHP environment, including:
 *
 * - The values represented in $_SERVER.
 * - Any cookies provided (generally via $_COOKIE)
 * - Query string arguments (generally via $_GET, or as parsed via parse_str())
 * - Upload files, if any (as represented by $_FILES)
 * - Deserialized body parameters (generally from $_POST)
 *
 * Additionally, this interface recognizes the utility of introspecting a
 * request to derive and match additional parameters (e.g., via URI path
 * matching, decrypting cookie values, deserializing non-form-encoded body
 * content, matching authorization headers to users, etc). These parameters
 * are stored in an "attributes" property.
 *
 * Requests are considered immutable; all methods that might change state MUST
 * be implemented such that they retain the internal state of the current
 * message and return an instance that contains the changed state.
 */
interface RequestInterface extends MessageInterface
{
    /**
     * Retrieves the HTTP method of the request.
     *
     * @return string Returns the request method.
     */
    function getMethod(): string;

    /**
     * Retrieves the URI instance.
     *
     * @see http://tools.ietf.org/html/rfc3986#section-4.3
     * @return Uri Returns a Uri instance
     *     representing the URI of the request.
     */
    function getUri(): Uri;

    /**
     * Retrieve server parameters.
     *
     * Retrieves data related to the incoming request environment,
     * typically derived from PHP's $_SERVER superglobal. The data IS NOT
     * REQUIRED to originate from $_SERVER.
     *
     * @return array
     */
    function getServerParams(): array;

    /**
     * Retrieve cookies.
     *
     * Retrieves cookies sent by the client to the server.
     *
     * The data MUST be compatible with the structure of the $_COOKIE
     * superglobal.
     *
     * @return array
     */
    function getCookieParams(): array;
    
    /**
     * Retrieve query string arguments.
     *
     * Retrieves the deserialized query string arguments, if any.
     *
     * @return array
     */
    function getQueryParams(): array;

    /**
     * Retrieve file upload data.
     *
     * This method returns upload metadata as an array of instances of
     * Framework\Http\UploadedFileInterface.
     *
     * These values MUST be prepared from $_FILES during instantiation.
     *
     * This method MAY ignore or otherwise fail to handle nested arrays in the
     * $_FILES array.
     *
     * @return array An array of UploadedFileInterface instances; an empty
     *     array MUST be returned if no data is present.
     */
    function getUploadedFiles(): array;

    /**
     * Retrieve any parameters provided in the request body.
     *
     * If the request method is POST, this method MUST
     * return the contents of $_POST.
     *
     * Otherwise, this method MUST return null.
     *
     * @return null|array The deserialized body parameters as an array, if any.
     */
    function getParsedBody(): null|array;

    /**
     * Retrieve attributes derived from the request.
     *
     * The request "attributes" may be used to allow injection of any
     * parameters derived from the request: e.g., the results of path
     * match operations; the results of decrypting cookies; the results of
     * deserializing non-form-encoded message bodies; etc. Attributes
     * will be application and request specific, and CAN be mutable.
     *
     * @return mixed[] Attributes derived from the request.
     */
    function getAttributes(): array;

    /**
     * Retrieve a single derived request attribute.
     *
     * Retrieves a single derived request attribute as described in
     * getAttributes(). If the attribute has not been previously set, returns
     * the default value as provided.
     *
     * This method obviates the need for a hasAttribute() method, as it allows
     * specifying a default value to return if the attribute is not found.
     *
     * @see getAttributes()
     * @param string $name The attribute name.
     * @param mixed $default Default value to return if the attribute does not exist.
     * @return mixed
     */
    function getAttribute(string $name, mixed $default = null): mixed;

    /**
     * Return an instance with the specified derived request attribute.
     *
     * This method allows setting a single derived request attribute as
     * described in getAttributes().
     *
     * This method MUST be implemented in such a way as to retain the
     * immutability of the message, and MUST return an instance that has the
     * updated attribute.
     *
     * @see getAttributes()
     * @param string $name The attribute name.
     * @param mixed $value The value of the attribute.
     * @return static
     */
    function withAttribute(string $name, mixed $value): static;

    /**
     * Return an instance that removes the specified derived request attribute.
     *
     * This method allows removing a single derived request attribute as
     * described in getAttributes().
     *
     * This method MUST be implemented in such a way as to retain the
     * immutability of the message, and MUST return an instance that removes
     * the attribute.
     *
     * @see getAttributes()
     * @param string $name The attribute name.
     * @return static
     */
    function withoutAttribute(string $name): static;
}
```

Merk op dat `Uri\Rfc3986\Uri` beschikbaar is vanaf PHP 8.5 en vereist dat de 
extensie `uri` wordt aangezet. Als je een oudere PHP-versie gebruikt, mag je 
de package
[`league/uri-polyfill`](https://packagist.org/packages/league/uri-polyfill)
gebruiken om deze klasse te kunnen gebruiken.

## `UploadedFileInterface`

```php
<?php

namespace Framework\Http;

/**
 * Value object representing a file uploaded through an HTTP request.
 *
 * Instances of this interface are considered immutable; all methods that
 * might change state MUST be implemented such that they retain the internal
 * state of the current instance and return an instance that contains the
 * changed state.
 */
interface UploadedFileInterface
{
    /**
     * Move the uploaded file to a new location.
     *
     * Use this method as an alternative to move_uploaded_file().
     *
     * $targetPath MUST be an absolute path.
     *
     * The original file or stream MUST be removed on completion.
     *
     * If this method is called more than once, any subsequent calls MUST raise
     * an exception.
     *
     * When writing files via moveTo(), is_uploaded_file() and
     * move_uploaded_file() SHOULD be used to ensure permissions and upload
     * status are verified correctly.
     *
     * @see http://php.net/is_uploaded_file
     * @see http://php.net/move_uploaded_file
     * @param string $targetPath Path to which to move the uploaded file.
     * @throws \InvalidArgumentException if the $targetPath specified is invalid.
     * @throws \RuntimeException on any error during the move operation.
     * @throws \RuntimeException on the second or subsequent call to the method.
     */
    public function moveTo(string $targetPath): void;

    /**
     * Retrieve the file size.
     *
     * Implementations SHOULD return the value stored in the "size" key of
     * the file in the $_FILES array if available, as PHP calculates this based
     * on the actual size transmitted.
     *
     * @return int|null The file size in bytes or null if unknown.
     */
    public function getSize(): ?int;

    /**
     * Retrieve the error associated with the uploaded file.
     *
     * The return value MUST be one of PHP's UPLOAD_ERR_XXX constants.
     *
     * If the file was uploaded successfully, this method MUST return
     * UPLOAD_ERR_OK.
     *
     * Implementations SHOULD return the value stored in the "error" key of
     * the file in the $_FILES array.
     *
     * @see http://php.net/manual/en/features.file-upload.errors.php
     * @return int One of PHP's UPLOAD_ERR_XXX constants.
     */
    public function getError(): int;

    /**
     * Retrieve the filename sent by the client.
     *
     * Do not trust the value returned by this method. A client could send
     * a malicious filename with the intention to corrupt or hack your
     * application.
     *
     * Implementations SHOULD return the value stored in the "name" key of
     * the file in the $_FILES array.
     *
     * @return string|null The filename sent by the client or null if none
     *     was provided.
     */
    public function getClientFilename(): ?string;

    /**
     * Retrieve the media type sent by the client.
     *
     * Do not trust the value returned by this method. A client could send
     * a malicious media type with the intention to corrupt or hack your
     * application.
     *
     * Implementations SHOULD return the value stored in the "type" key of
     * the file in the $_FILES array.
     *
     * @return string|null The media type sent by the client or null if none
     *     was provided.
     */
    public function getClientMediaType(): ?string;
}
```

## `KernelInterface`

De parameters van `Framework\Kernel\KernelInterface` kunnen nu worden 
vervangen door een instantie van `Framework\Http\RequestInterface`.
Als de interfaces uit PSR-7 worden gebruikt, kan deze interface in zijn 
geheel worden vervangen door `Psr\Http\Server\RequestHandlerInterface`.

```php
<?php

namespace Framework\Kernel;

use Framework\Http\RequestInterface;

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
     * @return string The response as a string.
     */
    public function handle(RequestInterface $request): string;
}
```
