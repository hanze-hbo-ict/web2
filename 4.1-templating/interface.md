# Interfaces


De router maakt gebruik van de onderstaande interface.

## `TemplateEngineInterface`

```php
<?php

namespace Framework\Templating;

/**
 * A service that renders templates with parameters as strings.
 */
interface TemplateEngineInterface
{
    /**
     * Render a view with a given set of parameters.
     * 
     * @param string $template A reference to the template to use.
     * @param mixed ...$params The parameters to pass to the template.
     * @return string The rendered template.
     */
    public function render(string $template, mixed ...$params): string;
}
```