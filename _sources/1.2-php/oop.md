# Object-georiënteerd programmeren

PHP biedt sinds versie 5 de mogelijkheid om
[object-georiënteerd](https://www.php.net/manual/en/language.oop5.php)
te programmeren. De implementatie hiervan is door Java geïnspireerd; veel van 
de keywords zullen de Java-programmeur dan ook bekend voorkomen.

In PHP worden klassen gemaakt met het keyword `class`. Objecten worden 
gemaakt door gebruik te maken van het keyword `new`. Hierbij wordt een 
constructor aangeroepen; dit is de methode met de naam `__construct`. 
Aangezien in PHP functies en methodes niet overloaded kunnen worden, kan 
er maar één constructor zijn. Net als in Java kunnen instantievariabelen en 
methodes `public`, `protected` en `private` zijn en kunnen klassen andere 
klassen uitbreiden met het keyword `extends`. PHP kent ook interfaces en 
abstracte klassen en gebruikt hiervoor dezelfde keywords als Java. Dit zijn 
`interface`, `implements` en `abstract`.

Een belangrijk verschil is dat PHP geen punt gebruikt om methodes en 
instantievariabelen aan te roepen zoals Java en Python dat doen. Deze operator
wordt in PHP immers gebruikt voor stringconcatenatie. In plaats daarvan 
wordt de pijl `->` gebruikt, hetgeen doet denken aan de syntax van C++. 
Bovendien staat het dollarteken dat normaal voor een variabelenaam staat 
alleen voor de verwijzing naar het object, en wordt deze niet herhaald na 
de pijl. Een instantievariabele `$var` van een object `$this` wordt dus 
aangesproken als `$this->var`. Enkele voorbeelden zijn hieronder 
te zien.

```php
interface TestInterface {
    function test(): void;
}

abstract class AbstractTest {
    protected abstract function abstractTest(): void;
}

class Test extends AbstractTest implements Test {
    private string $property;
    
    public function __construct()
    {
        $this->property = 5;
    }
    
    public function test()
    {
        $other = nww Test();
        $other->abstactTest();
    }

    protected function abstractTest()
    {
    }
}
```

Aangezien, anders dan in Java, 
variabelen dynamisch gemaakt kunnen worden, is het in PHP altijd 
noodzakelijk om instantievariabelen aan te spreken via de variabele `$this`, 
de verwijzing naar het huidige object. In onderstaand voorbeeld is dit niet 
gedaan. Het effect hiervan is dat in de constructor de lokale variabele 
`$var` wordt gemaakt, terwijl bedoeld is dat de instantievariabele 
`$this->var` wordt gevuld. Dit laatste wordt bereikt door de toekenning te 
vervangen door `$this->var = $v`.

```php
class Test {
    protected string $var;
    
    public function __construct(string $v)
    {
        $var = $v;
    }
}
```

Zoals gezegd hoeven lokale variabelen in PHP niet gedeclareerd te worden. 
Strikt genomen geldt dit ook voor instantievariabelen; onderstaande code 
geeft geen foutmelding en zal de waarde van `$v` toekennen aan de 
instantievariabele `$this->var`. Dergelijke instantievariabelen worden
[*dynamic properties*](https://www.php.net/manual/en/language.oop5.properties.php#language.oop5.properties.dynamic-properties)
genoemd; deze zijn echter sinds versie 8.2 *deprecated* en zullen vanaf PHP 9 
niet meer ondersteund worden. Het is daarom verstandig om alle gebruikte 
instantievariabelen te declareren, zoals in het voorbeeld hierboven.

```php
class Test {
    public function __construct(string $v)
    {
        $this->var = $v;
    }
}
```

De constructorstructuur zoals hierboven getoond is erg gangbaar. Vaak is het 
immers zo dat een constructor wordt gebruikt om een aantal waardes van het 
object op te slaan in instantievariabelen. PHP heeft hiervoor een kortere 
syntax die
[*constructor promotion*](https://www.php.net/manual/en/language.oop5.decon.php#language.oop5.decon.constructor.promotion)
wordt genoemd. In deze syntax wordt een parameter in de constructor vooraf 
gegaan door `private`, `protected` of `public`. Een parameter die op die 
manier wordt gemarkeerd zal automatisch worden opgeslagen als 
instantievariabele; de instantievariabele hoeft bovendien niet apart 
gedefinieerd te worden. In onderstaand voorbeeld wordt de eerste parameter 
van de constructor dus automatisch opgeslagen als een instantievariabele, en 
zal de methode `test` deze waarde dus ook afdrukken.

```php
class Test {
    public function __construct(private string $var)
    {
    }
    
    public function test(): void
    {
        echo $this->var;
    }
}
```

[TODO __toString]
[TODO static]
[TODO? const, anonieme klasses, final]

## Namespaces

In Java is het gebruikelijk om klassen in te delen in *packages*. Zo is de 
klasse `ArrayList` te vinden in de package `java.util`. Door in Java het 
statement `import java.util.ArrayList` te gebruiken, kan in de rest van het 
bestand de korte naam `ArrayList` gebruikt worden in plaats van de volledige 
naam `java.util.ArrayList`. Een klasse kan in Java in een package gezet 
worden met het keyword `package`.

PHP biedt een vergelijkbaar systeem. Hierbij wordt in PHP niet gesproken 
van packages, maar van
[*namespaces*](https://www.php.net/manual/en/language.namespaces.php). 
Hiertoe wordt als eerste statement in 
een PHP-bestand het keyword `namespace` gebruikt, gevolgd door de naam van 
de namespace waarin dit bestand moet werken. In Java worden punten gebruikt 
om packagenamen hiërarchisch te ordenen; aangezien de punt in PHP als 
operator voor stringconcatenatie wordt gebruikt, wordt in PHP hiervoor de 
backslash `\` gebruikt.

Als een bestand in een bepaalde namespace staat, verandert dit de betekenis 
van klasse- en functienamen. In beide gevallen kan de klasse of functie uit 
de globale namespace gebruikt worden door hier een enkele backslash voor te 
zetten, vergelijkbaar met absolute paden op een bestandssysteem. Zo 
verwijst de klasse `\Test` altijd naar de klasse `Test` in de globale 
namespace. Het is op deze manier ook mogelijk om naar een willekeurige 
namespace te verwijzen; de klassenaam `\Foo\Bar\Test` verwijst altijd naar 
de klasse `Test` in de namespace `Foo\Bar`, ongeacht de huidige namespace.

Als er echter geen backslash voor staat, wordt de klassenaam 
relatief gezien ten opzichte van de huidige namespace. Als een bestand 
begint met het statement `namespace Foo`, dan wordt de klasse `Test` gelezen 
als de klasse `Test` binnen de namespace `Foo`, oftewel als de klasse 
`Foo\Test`. Ook als de klasse begint met een namespace, maar zonder 
backslash, wordt de verwijzing relatief gelezen. Als de huidige namespace 
`Foo` is, verwijst `Bar\Test` naar de klasse `Foo\Bar\Test`.

Het bovenstaande geldt ook voor functienamen; ook functies kunnen in een 
namespace zitten. Het verschil is wel dat als de relatieve naam `Test` 
gebruikt wordt als klassenaam en deze niet bestaat in de huidige namespace, 
hier een foutmelding voor wordt gegeven. Dit is niet zo bij functienamen; 
als een functienaam niet begint met een backslash, wordt, als de functie 
niet bestaat in de huidige namespace, de functie uit de globale namespace 
gebruikt. Het is dus niet nodig om `\strlen` te schrijven om de globale 
functie `strlen` te gebruiken, ook niet als een namespace actief is. Alleen 
als in de huidige namespace ook een functie `strlen` zou bestaan moet 
`\strlen` gebruikt worden om aan te geven dat de functie uit de globale 
namespace bedoelt wordt. Bij klassenamen is dit dus niet zo; als we de 
standaardklasse `Exception`, die hieronder besproken wordt, willen gebruiken 
terwijl er een namespace actief is, moet altijd `\Exception` geschreven worden.

In het onderstaande voorbeeld worden enkele voorbeelden getoond.

```php
namespace Foo;

function strlen($x) { return $x; }
class Exception {}

var_dump(strlen('abc')); // drukt 'abc' af; de functie Foo\strlen wordt gebruikt
var_dump(\strlen('abc')); // absolute verwijzing, drukt 3 af

var_dump(strtoupper('abc')); // drukt 'ABC' af; gebruikt de globale functie

var_dump(get_class(new Exception())); // relatieve verwijzing, drukt `Exception` af
var_dump(get_class(new \Exception())); // absolute verwijzing, drukt `Foo\Exception` af
```

Door het gebruik van namespaces kunnen klassenamen erg lang worden. Het is 
mogelijk om alleen de korte naam, het gedeelte na de laatste backslash, te 
gebruiken door PHP te vertellen welke klasse daarmee bedoelt wordt. Hiervoor 
wordt het statement `use` gebruikt. Dit is vergelijkbaar met `import` in Java.
Als bijvoorbeeld het statement `use Foo\Bar\Test` gebruikt wordt, zal de 
klassenaam `Test` in de rest van dat bestand verwijzen naar de klasse 
`Foo\Bar\Test`. Als in de huidige namespace ook een klasse `Test` bestaat, 
is deze dus niet meer te bereiken via de verwijzing `Test`. Hiervoor kan wel 
de verwijzing `namespace\Test` worden gebruikt; hierdoor wordt verwezen naar 
de klasse `Test` in de huidige namespace. Het is bovendien met het statement 
`use` mogelijk om een alias te gebruiken voor een klasse; dit kan bijvoorbeeld 
nodig zijn als twee klassen met dezelfde namespace geïmporteerd moeten 
worden. Dit kan door de syntax `use Foo\Bar\Test as Alias` te gebruiken; 
hiermee wordt de klasse `Foo\Bar\Test` bekend onder de lokale naam `Alias`, 
zoals ook te zien in onderstaand voorbeeld.

```php
namespace Foo;

use Bar\Test;
use Baz\Test as Alias;

$a = new Test(); # verwijst naar Bar\Test
$b = new Alias(); # verwijst naar Baz\Test
$c = new namespace\Foo(); # verwijst naar Foo\Test
$d = new namespace\Alias(); # verwijst naar Foo\Alias
$e = new \Foo(); # verwijst naar Foo (uit de globale namespace)
```
