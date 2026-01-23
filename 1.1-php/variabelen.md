# Variabelen

[TODO]

Variabelen worden in PHP altijd voorafgegaan door het teken `$`. Daarnaast 
hebben variabelen in PHP in principe geen vastgesteld type; PHP is een 
dynamisch getypeerde taal, net als bijvoorbeeld Python. Dit betekent dat een 
variabele bijvoorbeeld eerst een getal en daarna een string kan bevatten. 
Ook kent PHP de gangbare wiskunde operatoren `+`, `-`, `*`, `/`, `**` voor 
machtsverheffen en `%` als modulo-operator.

```php
$a = 5;
$b = 2.5;
$c = $a * $b;
echo($c);
```

Bovenstaande code zal het getal `12.5` afdrukken.

Net als Python kunnen `+=`, `-=` en zo verder gebruikt worden als gecombineerde 
berekening en toekenning. `$a += 5` is functioneel gelijk aan `$a = $a + 5`. 
Daarnaast bestaan de operatoren `++` en `--` op dezelfde 

* variabelen
* types: int, float, bool
* null
* Operators
* var_dump
* variabele variabelen?
* define

# Dynamische webpagina's

Op dit moment kunnen we met PHP-programma's alleen nog maar statische 
content genereren; het heeft nu dus nog geen toegevoegde waarde ten opzichte 
van 'kale' HTML-bestanden.

PHP heeft echter natuurlijk genoeg functionaliteiten om wel degelijk een 
meerwaarde te hebben. In dit hoofdstuk zullen we zien dat PHP variabelen 
heeft, en zoals elke imperatieve taal commando's sequentieel kan 
uitvoeren en conditionele statements en lusconstructies kent.

