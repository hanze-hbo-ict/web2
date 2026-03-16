# Interfaces

## `DatamapperInterface`


```php
<?php

namespace Framework\Database;

/**
 * A service that maps domain objects to database records.
 * @template T
 */
interface DataMapperInterface
{
    /**
     * Select a single object by its primary key.
     * @param int $id
     * @return T
     * @throws NotFoundException if the object was not found.
     */
    public function get(int $id): object;

    /**
     * Select a number of objects with a query.
     * @param QueryInterface $query
     * @return array<T>
     */
    public function select(QueryInterface $query): array;

    /**
     * Insert a new object in the database.
     * @param T $object
     */
    public function insert($object): void;

    /**
     * Update an existing object in the database.
     * @param T $object
     */
    public function update($object): void;

    /**
     * Delete an object from the database.
     * @param T $object
     */
    public function delete($object): void;
}
```

## `RepositoryInterface`

```php
<?php

namespace Framework\Database;

/**
 * A service that allows access to a collection of domain objects.
 * @template T
 */
interface RepositoryInterface
{
    /**
     * Get a single object by its primary key value.
     * @param int $id Primary key value.
     * @return T
     * @throws NotFoundException if the object was not found.
     */
    public function get(int $id): object;

    /**
     * Store a new or existing object in the repository.
     * @param T $object
     */
    public function save(object $object): void;

    /**
     * Remove an object from the repository.
     * @param T $object
     */
    public function remove($object): void;

    /**
     * Find a number of objects in the repository based on a query.
     * @param QueryInterface $query
     * @return array<T>
     */
    public function find(QueryInterface $query): array;

    /**
     * Find a single object in the repository based on a query.
     * @param QueryInterface $query
     * @return T
     * @throws NotFoundException if no matching object was found.
     */
    public function findOne(QueryInterface $query): object;
}
```