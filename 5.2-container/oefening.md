# Oefeningen

Gegeven zijn onderstaande PHP-klassen.

```php
class A
{
}

class B
{
}

class Test
{
    public function __construct(public A $a, public B $b)
    {
    }
}
```

## Reflectie

Gebruik reflectie om een nieuw object van de klasse `Test` te instantiëren. 
Je mag het keyword `new` alleen gebruiken om een object van de klasse 
[`ReflectionClass`]()
te maken; overige objecten moet je via reflectie 
instantiëren. Als je het object dumpt, krijg je ongeveer onderstaande uitvoer.

```
object(Test)#1 (2) {
  ["a"]=>
  object(A)#2 (0) {
  }
  ["b"]=>
  object(B)#3 (0) {
  }
}
```

## Constructorparameters

Probeer, als dit gelukt is, om de constructorparameters van `Test` niet te 
hardcoden, maar via reflectie te onderzoeken. Dit betekent dat je de methode z
[`ReflectionClass::getConstructor`]()
moet gebruiken om informatie te kunnen verkrijgen over de constructor, en 
dat je via reflectie een lijst van de parameters van de constructor en de 
bijbehorende types moet verkrijgen. Je mag er op dit moment vanuit gaan dat 
de klassen `A` en `B` géén constructorparameters hebben.

## Recursieve reflectie

Verander, als dit ook gelukt is, de definitie van de klasse `B` als volgt.

```php
class B
{
    public function __construct(public A $a)
    {
    }
}
```

Gebruik nu reflectie om een object van het type `Test` te maken. Omdat `B` 
nu ook constructorparameters heeft, moet je ook hier reflectie toepassen om 
de parameters te verkrijgen. Je zult zien dat hier een recursieve structuur 
ontstaat; je moet een object van type `A` maken, om een object van type `B` 
te maken, om een object van type `Test` te maken.

Als je deze oefeningen allemaal hebt afgerond, heb je al een aanzet voor een 
IoC container geschreven. Je kan deze code dan ook gebruiken voor de opdracht.