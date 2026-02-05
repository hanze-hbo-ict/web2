# Oefeningen

## Autoloader

Schrijf een functie `autoload` die een enkele stringparameter meekrijgt en 
deze afdrukt. Registreer deze functie vervolgens als autoloader met 
`spl_autoload_register`. Kijk wat er gebeurt als je een niet-bestaande 
klasse probeert te laden.

Maak nu een paar klassen aan, bijvoorbeeld `TestA` en `TestB`, die in 
corresponderende PHP-bestanden `TestA.php` en `TestB.php` staan. Maak ook 
een klasse met een namespace, bijvoorbeeld `App\Test.php`, aan in een 
corresponderend PHP-bestand, hier `Test.php` in de directory `App`.

Pas vervolgens de autoloaderfunctie aan zodat deze de meegegeven klassenaa 
omzet naar een bestandsnaam volgens de
[PSR-4-standaard](https://www.php-fig.org/psr/psr-4/). De autoloader 
moet vervolgens dit bestand inladen met `require_once`. Gebruik deze 
autoloader om instanties te maken van de klassen die je hiervoor gemaakt 
hebt, zonder handmatig de bestanden waar die klassen instaan in te laden.

## Composer

Maak voor deze opdracht een nieuw PHP-project aan. Voeg een bestand 
`composer.json` toe waarin je het package `symfony/finder` vereist. Het 
versienummer hiervan moet ten minste 8.0.1 zijn, maar versie 9 mag niet 
gebruikt worden. Definieer in dit bestand ook een regel voor de autoloader die 
inhoudt dat alle klassen in de namespace `App` gezocht moeten worden in de 
directory `src`. Gebruik hiervoor de autoloaderstijl PSR-4. Gebruik Composer 
om deze library en autoloader te installeren.

Maak vervolgens een directory `src` met daarnaast een 
bestand `FinderTest.php`. Dat bestand moet een klasse `App\FinderTest` 
bevatten; het bestand moet dus beginnen met de namespacedeclaratie 
`namespace App` en de klassedeclaratie `class FinderTest`. In deze klasse 
moet een enkele statische methode `test` met een enkele parameter `$dir` staan, 
die onderstaande code bevat.

```php
$finder = new Finder();
$finder->files()->in($dir);
if ($finder->hasResults()) {
    foreach ($finder as $file) {
        echo $file->getRelativePathname(), PHP_EOL;
    }
}
```

Hiervoor moet je ook een `use`-statement tussen de namespace- en 
klassedeclaratie zetten voor de klasse `Symfony\Component\Finder\Finder`.

Maak ten slotte een bestand `test.php` in de root van het project. Hierin 
moet je de autoloader van Composer laden en vervolgens de onderstaande 
aanroep van `FinderTest::test` uitvoeren. Zorg dat er een geschikt 
`use`-statement is zodat je de klasse uit de namespace `App` gebruikt.

```php
FinderTest::test(__DIR__);
```

Als alles werkt, zou je alle bestanden in je project moeten zien, zoals 
`test.php`, `composer.json`, `composer.lock`, `src/FinderTest.php` en alle 
bestanden in de directory `vendor`.