# Interfaces

De interfaces hieronder maken intensief gebruik van de `@template T`-notatie in de *DocBlock*. Bestudeer [de tekst hierover](generics.md) om te bekijken hoe dat exact werkt.

## `DataMapperInterface`

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
    function get(int $id): object;

    /**
     * Select a number of objects with a query.
     * @param string $query Query with placeholders.
     * @param mixed ...$params Parameters for the query.
     * @return array<T>
     */
    function select(string $query, mixed ...$params): array;

    /**
     * Insert a new object in the database.
     * @param T $object
     */
    function insert($object): void;

    /**
     * Update an existing object in the database.
     * @param T $object
     */
    function update($object): void;

    /**
     * Delete an object from the database.
     * @param T $object
     */
    function delete($object): void;
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
    function get(int $id): object;

    /**
     * Store a new or existing object in the repository.
     * @param T $object
     */
    function save(object $object): void;

    /**
     * Remove an object from the repository.
     * @param T $object
     */
    function remove($object): void;
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
    function has(int $id): bool;

    /**
     * Checks whether the given object exists in the identity map.
     * @param T $object
     */
    function contains($object): bool;

    /**
     * Get an object from the identity map by its id.
     * @param int $id
     * @return T
     */
    function get(int $id): object;

    /**
     * Add an object with a given id to the identity map.
     * @param int $id
     * @param T $object
     */
    function add(int $id, $object): void;

    /**
     * Remove an object from the identity map.
     * @param T $object
     */
    function remove($object): void;
}
```