# Generics

In de [interfaces van deze week](interface.md) maken we regelmatig gebruik van `@template T`. Dit is een zogenaamde *generic*, die we ook al in Java tegen zijn gekomen (`List<String>` bijvoorbeeld, of `Map<String, User>`). Eigenlijk heeft php zelf geen *generics*, dus wordt dat in de *DocBlocks* geregeld.

Een generic biedt de mogelijkheid om het exacte type van een klasse of het return-type van een methode later in te vullen. Als php zelf generics zou hebben, zou je code zoals hieronder kunnen verwachten. In dat geval maak je dus een `Entry` aan, waarbij het `KeyType` een 'int' is, en het `ValueType` een `string`.

```php
<?php
class Entry<KeyType, ValueType>
{
    // ...
}

$entry = new Entry<int, string>(1, 'test');
```

Maar dit is dus niet mogelijk. Dat betekent dat je bij return-types gehouden bent aan iets als `object` of `mixed`. Maar dat houdt weer in dat je niet in *compile time* weet welke methoden je op het geretourneerde object kunt aanroepen (de compiler kan immers niet weten of je een `User` of een `Animal` terugkrijgt: het enige wat bekend is dat er een `object` is teruggegeven).

Door gebruik te maken van de `@template`-annotatie in je *DocBlock*, introduceer je een type dat je vervolgens kunt gebruiken in je `@param` of `@return` tags. De *naam* van het type kan feitelijk alles zijn, maar het is gebruikelijk om een hoofdletter te gebruiken.

```php
<?php
/**
 * Een klasse die een lijst van typen opslaat
 * @template T
 */
class List
{
    // methode om data aan de lijst toe te voegen
    // @param T
    public function insert($object):void {
        ///
    }

    // methode om een T op een specifieke positie op te halen
    // @param int $pos
    // @return T
    public function get(int $pos):object {
        ///
    }

    // methode om alle waarden uit de lijst op te halen
    // @return array<T>
    public function getAll(): array {
        ///
    }
}

$entry = new Entry<int, string>(1, 'test');
```

Bekijk voor meer informatie over generics in php de [State of Generics and Collections](https://thephp.foundation/blog/2024/08/19/state-of-generics-and-collections/).