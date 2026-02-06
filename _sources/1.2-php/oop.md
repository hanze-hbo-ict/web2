# Object-georiënteerd programmeren

PHP biedt sinds versie 5 de mogelijkheid om
[object-georiënteerd](https://www.php.net/manual/en/language.oop5.php)
te programmeren. De implementatie hiervan is door Java geïnspireerd; veel van 
de keywords zullen de Java-programmeur dan ook bekend voorkomen.

## Klassen en objecten

In PHP worden klassen gemaakt met het keyword `class`. Objecten worden 
gemaakt door gebruik te maken van het keyword `new`. Hierbij wordt een 
[constructor](https://www.php.net/manual/en/language.oop5.decon.php)
aangeroepen; dit is de methode met de naam `__construct`. Aangezien in PHP 
functies en methoden niet overloaded kunnen worden, kan er maar één 
constructor zijn. Bijzonder aan het gebruik van het keyword `new` is dat dit 
ook gevolgd mag worden door een variabele; in dat geval wordt de 
stringwaarde van die variabele als klassenaam gezien en wordt die klasse 
geïnstantieerd. Zo is het effect onderstaand stukje code gelijk aan `$obj = 
new Test();`. 

```php
$class = 'Test';
$obj = new $class();
```

Je kan de naam van een klasse als string krijgen door hier 
`::class` achter te zetten; zo is `Test::class` gelijk aan de string `Test`. 
Dit lijkt hier niet handig, maar we zullen nog zien dat klassen in zogeheten 
namespaces kunnen staan, en dan is dit een goede mogelijkheid om de 
volledige klassenaam te verkrijgen.

Naast een constructor kan een klasse methoden en instantievariabelen 
bevatten. Instantievariabelen worden binnen een klasse gedeclareerd door 
de variabelenaam met dollarteken te laten voorafgaan door één van de drie 
keywords voor
[zichtbaarheid](https://www.php.net/manual/en/language.oop5.visibility.php),
`public`, `protected` en `private`. Een variabele die `private` is, is 
alleen toegankelijk vanuit de klasse zelf, een `protected` variabele is 
daarna ook toegankelijk vanuit subklassen van deze klasse en een `public` 
variabele is altijd toegankelijk. Het is toegestaan en aan te bevelen om na 
dit keyword een typedeclaratie op te nemen die betekent dat de variabele 
altijd een waarde van dat type moet bevatten. Een voorbeeld van een 
volledige declaratie is `protected string $value`. Methoden worden met het 
keyword `function` gedeclareerd en werken verder op dezelfde manier als 
functies. Ook methoden kunnen worden voorafgegaan door `public`, `protected` 
en `private`.

Daarnaast kunnen methoden en instantievariabelen
[`static`](https://www.php.net/manual/en/language.oop5.static.php) worden 
gedefinieerd en betekent dit dat de betreffende methoden en variabelen 
beschikbaar zijn op de klasse op zich, niet op specifieke objecten van die 
klassen. De huidige klasse kan hierbij worden aangegeven met het keyword 
`self`, maar mag ook gewoon worden aangegeven met zijn klassenaam.

Een belangrijk verschil is dat PHP geen punt gebruikt om methoden en 
instantievariabelen aan te roepen zoals Java en Python dat doen. Deze operator
wordt in PHP immers gebruikt voor stringconcatenatie. In plaats daarvan 
wordt de pijl `->` gebruikt, hetgeen doet denken aan de syntax van C++. 
Bovendien staat het dollarteken dat normaal voor een variabelenaam staat 
alleen voor de verwijzing naar het object, en wordt deze niet herhaald na 
de pijl. Een instantievariabele `$var` van een object `$this` wordt dus 
aangesproken als `$this->var`. Als in plaats daarvan `$this->$var` gebruikt 
zou worden, wordt de waarde van de lokale variabele `$var` gezien als naam 
van de instantievariabele die gevraagd wordt. Anders gezegd, `$test = 'var'; 
echo $this->$test;` drukt de waarde `$this->var` af. Bij statische methoden 
en variabelen wordt in plaats van een pijl een dubbele dubbele punt `::` 
gebruikt. Bovendien wordt bij statische variabelen wél een dollarteken 
gebruikt, bijvoorbeeld `Test::$var`. Enkele voorbeelden zijn hieronder te zien.

```php
class Test {
    private int $property;
    public static string $staticProperty = "abc";
    
    public function __construct()
    {
        $this->property = 5;
    }
    
    private static staticTest() {
        echo Test::$staticProperty, PHP_EOL;
    }
    
    public function test()
    {
        echo $this->property, PHP_EOL;
        self::staticTest();
    }
}
```

Bij complexere objectstructuren, of in situaties waar een object optioneel 
als argument wordt meegegeven en dus ook `null` kan zijn, zul je vaak code 
zien als hieronder.

```php
if (isset($foo)) {
    if (isset($foo->bar)) {
        $x = $foo->bar->baz;
    } else {
        $x = null;
    }
} else {
    $x = null;
}   
```

Dit is natuurlijk erg omslachtig; PHP heeft voor dit geval een speciale 
operator, de
[nullsafe operator](https://www.php.net/manual/en/language.oop5.basic.php#language.oop5.basic.nullsafe)
`?->`, die in principe hetzelfde werkt als `->`, maar waarmee het object alleen 
aangesproken wordt als het niet `null` is; als het wel `null` is, is het 
resultaat van de expressie `null`. Bovenstaande code kan met deze operator 
op de volgende manier veel korter en duidelijker geschreven worden.

```php
$x = $foo?->bar?->baz;
```

## Overerving

Net als in Java kunnen in PHP klassen andere klasse uitbreiden door middel van
[overerving](https://www.php.net/manual/en/language.oop5.inheritance.php)
met het keyword `extends`. Hierbij kan, net als bij Java, een klasse slechts 
van één klasse overerven; meervoudige overerving is niet mogelijk. Een 
subklasse heeft de beschikking over de methoden en instantievariabelen van 
zijn superklasse, behalve als die `private` zijn, en kan zelf nieuwe 
methoden en instantievariabelen declareren of bestaande methoden overschrijven.

In PHP is het ook mogelijk om, als een methode in een subklasse overschreven 
wordt, de methode uit de superklasse aan te roepen. Dit kan door het keyword 
`super` te gebruiken, gevolgd door een dubbele dubbele punt en de 
methodenaam. Dit is ook mogelijk in de constructor. Anders dan in Java, is 
het in PHP niet vereist, maar overigens wel verstandig, om de constructor 
van de superklasse aan te roepen. Bovendien wordt, als de constructor in een 
subklasse niet gedefinieerd is, de constructor uit de superklasse gebruikt. 
Het is dus niet nodig om een constructor te maken waarin alleen de 
constructor van de superklasse wordt aangeroepen, hetgeen in Java wel 
gebruikelijk is. In onderstaande code zijn hiervan enkele voorbeelden te zien.

```php
class Super {
    public function __construct(private int $a)
    {
    }

    public function test()
    {
        echo 'In Super ', $this->a, PHP_EOL;
    }
}

class Sub extends Super{
    public function __construct(int $a, private int $b)
    {
        super::__construct($a);
    }

    public function test()
    {
        super::test();
        echo 'In Sub ', $this->b, PHP_EOL;
    }
}

new Sub(1, 2)->test();
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

## Interfaces

PHP kent naast reguliere klassen ook
[interfaces](https://www.php.net/manual/en/language.oop5.interfaces.php) en 
[abstracte klassen](https://www.php.net/manual/en/language.oop5.abstract.php)
en gebruikt hiervoor dezelfde keywords als Java. Dit zijn 
`interface`, `implements` en `abstract`. Dit werkt verder in beginsel op 
dezelfde manier als Java; een klasse kan weliswaar maar van één klasse 
overerven, maar kan meerdere interfaces implementeren. Hieronder is een 
voorbeeld te zien van het gebruik van abstracte klassen en interfaces.

```php
interface TestInterface {
    function test(): void;
}

abstract class AbstractTest {
    protected abstract function abstractTest(): void;
}

class Test extends AbstractTest implements TestInterface {
    private AbstractTest $other;
    
    public function __construct(AbstractTest $other)
    {
        $this->other = $other;
    }
    
    public function test(): void
    {
        $this->other->abstractTest();
    }

    protected function abstractTest(): void
    {
    }
}
```

Zoals bekend heeft het in het algemeen de voorkeur om tegen interfaces te 
programmeren, en niet tegen implementaties. Een gevolg hiervan is dat het 
beter is om interfaces als typedeclaratie te gebruiken dan klassen. Een 
ander principe is echter dat interfaces niet meerdere taken moeten vervullen.
Soms kan het daarom vereist zijn dat een parameter van een bepaalde functie 
aan meerdere interfaces voldoet. Zo heeft PHP bijvoorbeeld de interface 
[`Countable`](https://www.php.net/manual/en/class.countable.php)
met de methode `count` en de interface
[`Traversable`](https://www.php.net/manual/en/class.traversable.php)
die markeert dat een object met `foreach` werkt. Zou je een functie willen 
schrijven die een parameter accepteert die zowel in een `foreach`-lus 
gebruikt kan worden en ook de methode `count` aanbiedt, dan kan je een 
typedeclaratie `Countable&Traver`

```php
function count_and_traverse(Countable&Traversable $list): void {
    echo {$list->count()}, ' elements:', PHP_EOL;
    foreach ($list as $element) {
        echo $element, PHP_EOL;
    }
}
```

De klasse
[`ArrayIterator`](https://www.php.net/manual/en/class.arrayiterator.php)
is een voorbeeld van een klasse die beide interfaces implementeert; de 
aanroep `count_and_traverse(new ArrayIterator([1, 2, 3])` is dus een geldige 
aanroep.

## *Constructor promotion*

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
        echo $this->var, PHP_EOL;
    }
}
```

Net als Java heeft PHP de mogelijkheid om te definiëren op welke manier een 
object als string wordt afgedrukt, bijvoorbeeld als `echo $obj;` wordt 
uitgevoerd. In Java heet deze magische methode `toString`. In PHP beginnen 
alle magische methoden met twee underscores, zoals we al zagen bij 
`__construct`. De methode om een object om te zetten in een string heet dan 
ook `__toString`. Deze methode krijgt geen parameters mee en geeft een 
string terug; hieronder zie je hoe deze methode gedefinieerd wordt.

```php
public function __toString(): string;
```

PHP heeft enkele mogelijkheden om het aanpassen en overerven van klassen te 
beperken. Methoden en klassen kunnen als
[`final`](https://www.php.net/manual/en/language.oop5.final.php) worden
gemarkeerd door dit keyword voor de methode- of klassedefinitie te zetten. 
Een `final` methode kan niet overschreven worden in een afgeleide klasse, dus 
een subklasse kan die methode niet implementeren. Een `final` klasse kan 
niet overgeërfd worden, dus een dergelijke klasse kan in het geheel geen 
subklassen hebben. 

Daarnaast kunnen de waardes van een klasse
[`readonly`](https://www.php.net/manual/en/language.oop5.properties.php#language.oop5.properties.readonly-properties)
gemaakt worden. Als een instantievariabele `readonly` gemarkeerd is, kan 
deze één keer geïnitialiseerd worden en daarna niet meer aangepast worden. 
Als een klasse `readonly` is, betekent dit dat alle instantievariabelen in de 
klasse `readonly` zijn. Daarnaast heeft PHP de mogelijkheid om in een klasse
[constanten](https://www.php.net/manual/en/language.oop5.constants.php) te 
definiëren. Het verschil tussen `readonly` instantievariabelen en constanten 
is dat instantievariabelen een andere waarde kunnen hebben per object en bij 
het aanmaken van een object een waarde krijgen. Een constante daarentegen 
hoort bij een klasse, vergelijkbaar met een `static` waarde, en de waarde 
is *hardcoded* in de definitie. Een constante wordt gemaakt door in een 
klasse het keyword `const` te zetten gevolgd door de naam van de constante; 
anders dan variabelen beginnen namen van constanten beginnen niet met een 
dollarteken. Eventueel kan je de zichtbaarheid instellen door `public`, 
`protected` of `private` voor het keyword `const` zetten, of een type voor 
de naam, zoals in onderstaand voorbeeld.

```php
private const int FOO = 1;
```

Constanten worden gebruikt door de klassenaam, gevolgd door een dubbele 
dubbele punt en de naam van de constante te gebruiken, zoals bijvoorbeeld 
`Test::FOO`.

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