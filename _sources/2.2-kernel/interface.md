# Interfaces

Onderstaande interface is ontleend aan
[PSR-15](https://www.php-fig.org/psr/psr-15);
het commentaar bij de interface is hier ook grotendeels aan ontleend en is, 
waar nodig, aangepast.

Deze interface zal later nog worden aangepast.

## `KernelInterface`

```php
<?php

namespace Framework\Kernel;

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
     * @param array $get The contents of the $_GET superglobal. 
     * @param array $post The contents of the $_POST superglobal. 
     * @return string The response as a string.
     */
    public function handle(array $get, array $post): string;
}
```
