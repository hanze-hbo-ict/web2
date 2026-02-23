# Oefeningen

## Callables

1. Sorteer een array van strings aan de hand van de lengte van de strings.
   Gebruik hiervoor de functie `usort` en een callable. Je kan in de 
   callable ook gebruik maken van de 
   [spaceshipoperator](https://www.php.net/manual/en/migration70.new-features.php#migration70.new-features.spaceship-op)
   `<=>`, maar dat hoeft niet.

   ```php
   $array = ['Foo', 'Woord', 'Test'];
   usort($array, /* ... */);
   assert($array == ['Foo', 'Test', 'Woord']);
   ```
   
2. Tel het aantal elementen van een array. Gebruik hierbij de functie 
   `array_map` en een anonieme functie, waarbij de anonieme functie een lokale 
   variabele *by reference* bindt zodat deze variabele in de callable steeds 
   opgehoogd kan worden om zo het aantal te tellen.

   ```
   $array = ['Foo', 'Woord', 'Test'];
   $k = 0;
   array_map(/* ... */, $array);
   assert($k == 3);
   ```
   
3. Maak een klasse AddN die een instantievariabele heeft die een integer 
   bevat, en een methode die een closure teruggeeft waarmee je dat getal bij
   je eigen getal kan tellen.

   ```php
   class AddN {
      public function __construct(public int $n) {}
      public function getCalculation(): callable { /* ... */ }
   }
   $add5 = new AddN(5)->getCalculation();
   assert($add5(3) == 8);
   ```

Naast deze oefeningen kan je ook kijken bij de kata's over PHP-functies op
[CodeWars](https://www.codewars.com/collections/php-functions), met name die 
over *Anonymous Functions (aka Closures)* en *The "Use" Keyword*.

## Reguliere expressies

Reguliere expressies zijn een uitgebreid onderwerp, waarbij oefening 
essentieel is om een begrip te krijgen van de mogelijkheden. Op de site
[RegexOne](https://regexone.com) staan ruim twintig oefeningen om je kennis 
van reguliere expressies op te bouwen.

Daarnaast kan je op de website van
[w3resource](https://www.w3resource.com/php-exercises/php-regular-expression-exercises.php)
een aantal oefeningen vinden om reguliere expressies toe te passen in PHP.
