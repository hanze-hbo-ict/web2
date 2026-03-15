# Interfaces

Voor het werken met een database hebben we natuurijk een connectie met die database nodig. Die connectie wordt verzorgd door de implementatie van de `ConnectionInterface`. Merk op dat deze interface een verschil maakt tussen `query` en `execute`: de eerste is alleen voor het *bevragen* (`R`) van de data, terwijl de tweede de data werkelijk kan *aanpassen* (`CUD`). 

```php
<?php

namespace Framework\Database;

/**
 * A service that allows executing of SQL queries on a database.
 */
interface ConnectionInterface
{
    /**
     * Execute a parametrised query.
     * @param string $query Query string.
     * @param mixed ...$params
     * @return array An associative array with the results using the column names as keys.
     */
    public function query(string $query, mixed ...$params): array;

    /**
     * Execute a parametrised statement.
     * @param string $query Query string.
     * @param mixed ...$params
     * @return int The number of affected rows.
     */
    public function execute(string $query, mixed ...$params): int;

    /**
     * Get the most recent automatically generated id.
     * @return int
     */
    public function getLastInsertId(): int;
}
```