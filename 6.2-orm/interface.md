# Interfaces

De interfaces hieronder maken intensief gebruik van de `@template T`-notatie in de *DocBlock*. Bestudeer [de tekst hierover](generics.md) om te bekijken hoe dat exact werkt.

## 'QueryInterface`

```php
<?php

namespace Framework\Database;

/**
 * A query that can be used to select objects in a repository.
 */
interface QueryInterface
{
    /**
     * Get the filter to apply to the result set.
     * @return array<string, mixed> An associative array of column names and corresponding values to filter on.
     */
    public function getFilter(): array;

    /**
     * Get the ordering criteria to apply to the result set.
     * @return array<string> An array of column names, optionally suffixed with ASC or DESC as in SQL.
     */
    public function getOrder(): array;

    /**
     * Get the offset to apply to the result set.
     * @return int The offset, or 0 if there is none.
     */
    public function getOffset(): int;

    /**
     * Get the maximum number of results in the result set.
     * @return int The limit, or 0 if there is none.
     */
    public function getLimit(): int;
}
```

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


## IdentityMapInterface

```php
<?php
namespace Framework\Database;

/**
 * A data structure that stores unique objects based on their id.
 * @template T
 */
interface IdentityMapInterface
{
    /**
     * Checks whether an object with the given id exists in the identity map.
     * @param int $id
     * @return bool
     */
    public function has(int $id): bool;

    /**
     * Checks whether the given object exists in the identity map.
     * @param T $object
     */
    public function contains($object): bool;

    /**
     * Get an object from the identity map by its id.
     * @param int $id
     * @return T
     */
    public function get(int $id): object;

    /**
     * Add an object with a given id to the identity map.
     * @param int $id
     * @param T $object
     */
    public function add(int $id, $object): void;

    /**
     * Remove an object from the identity map.
     * @param T $object
     */
    public function remove($object): void;
}
```