# Reflectie

Om het mogelijk te maken om automatisch te bepalen welke services meegegeven 
moeten worden aan een constructor, is het nodig om PHP te kunnen bevragen 
over de constructorparameters. De techniek die we hiervoor gebruiken heet
[*reflectie*](https://en.wikipedia.org/wiki/Reflective_programming);
dit is een voorbeeld van een techniek die gebruikt kan worden voor
[*metaprogrammeren*](https://en.wikipedia.org/wiki/Metaprogramming),
een programmeertechniek waarbij een programma zichzelf of andere programma's 
als data kan beschouwen.

PHP biedt
[een aantal klassen](https://www.php.net/manual/en/book.reflection.php)
aan die gebruikt kunnen worden voor reflectie. In het navolgende zullen we 
ons beperken tot reflectie van klassen en de daarbij behorende eigenschappen,
maar ook bijvoorbeeld functies kunnen worden onderzocht met reflectie.

## `ReflectionClass`

Om reflectie toe te kunnen passen op een klasse, is een instantie van de klasse
[`ReflectionClass`](https://www.php.net/manual/en/class.reflectionclass.php)
vereist. Deze klasse bevat alle informatie over de te onderzoeken klasse en 
hiermee kan je verwijzingen verkrijgen naar informatie over onder meer 
constructors, methodes en instantievariabelen. Je kan de klassenaam of een 
instantie van de klasse meegeven aan de constructor van `ReflectionClass`. 
In beide gevallen krijg je een reflectie-object dat een klasse beschrijft.

Je kan het reflectie-object bijvoorbeeld vragen om de naam van de klasse met
[`getName`](https://www.php.net/manual/en/reflectionclass.getname.php),
of om de naam zonder namespaces met
[`getShortName`](https://www.php.net/manual/en/reflectionclass.getshortname.php).
Bovendien kan je de superklasse en de interfaces die de klasse implementeert 
vinden met
[`getParentClass`](https://www.php.net/manual/en/reflectionclass.getparentclass.php)
en [`getInterfaces`](https://www.php.net/manual/en/reflectionclass.getinterfaces.php).

Voor ons relevanter is dat je een instantie van het object kan maken. Dit 
kan op twee manieren. In de eerste plaats kan je de constructor aanroepen 
door gebruik te maken van
[`newInstance`](https://www.php.net/manual/en/reflectionclass.newinstance.php) of
[`newInstanceArgs`](https://www.php.net/manual/en/reflectionclass.newinstanceargs.php).
Onderstaande drie aanroepen hebben bijvoorbeeld hetzelfde resultaat.

```php
$object = new TestClass(1, 2, 3);
$object = new ReflectionClass('TestClass')->newInstance(1, 2, 3);
$object = new ReflectionClass('TestClass')->newInstanceArgs([1, 2, 3]);
```

Daarnaast kan je de constructor overslaan door gebruik te maken van
[`newInstanceWithoutConstructor`](https://www.php.net/manual/en/reflectionclass.newinstancewithoutconstructor.php).
Hiermee maak je een nieuw object van de onderzochte klasse, maar zonder de 
constructor aan te roepen. Dit kan natuurlijk tot allerlei problemen leiden, 
maar het is wel een voorbeeld van een toepassing van reflectie waarbij je 
resultaten kan bereiken die je zonder reflectie niet kan bereiken. Dit 
specifieke voorbeeld zou bijvoorbeeld gebruikt kunnen worden om 
databaseobjecten te maken, waarbij je de attributen van het object expliciet 
instelt op waardes die uit de database komen.

Om te weten welke parameters meegegeven moeten worden aan `newInstance`, is 
het noodzakelijk om informatie te kunnen verkrijgen over de constructor. Je 
kan een verwijzing naar de reflectie-informatie over de constructor 
verkrijgen via
[`getConstructor`](https://www.php.net/manual/en/reflectionclass.getconstructor.php).
Deze methode geeft een object van het type `ReflectionMethod` terug. Ook van 
de andere methodes van een klasse kan een instantie van `ReflectionMethod` 
verkregen worden via de methode
[`getMethod`](https://www.php.net/manual/en/reflectionclass.getmethod.php).

## `ReflectionMethod`

Instanties van
[`ReflectionMethod`](https://www.php.net/manual/en/class.reflectionmethod.php)
beschrijven een methode in een klasse. Met
[`getDeclaringClass`](https://www.php.net/manual/en/reflectionmethod.getdeclaringclass.php)
en
[`getName`](https://www.php.net/manual/en/reflectionfunctionabstract.getname.php)
kan je de klasse en naam van de methode verkrijgen.

Je kan de methode die beschreven wordt door een instantie hiervan aanroepen
via [`invoke`](https://www.php.net/manual/en/reflectionmethod.invoke.php) of
[`invokeArgs`](https://www.php.net/manual/en/reflectionmethod.invokeargs.php),
waarbij in beide gevallen het object waarop de methode moet worden 
aangeroepen als eerste parameter wordt meegegeven. De constructor ven een 
klasse wordt niet op deze manier aangeroepen; hiervoor gebruik je de methode 
`ReflectionClass::newInstance`, zoals hierboven besproken.

Je kan ook een functieverwijzing verkrijgen in de vorm van een `Closure` die 
je later kan gebruiken via
[`getClosure`](https://www.php.net/manual/en/reflectionmethod.getclosure.php);
ook hier geeft je het object mee als parameter.

Bij een methode zullen we meestal met name geïnteresseerd zijn in zijn 
parameters en returntype. Je kan de parameters verkrijgen met
[`getParameters`](https://www.php.net/manual/en/reflectionfunctionabstract.getparameters.php);
deze functie geeft een array met instanties van `ReflectionParameter` terug,
die informatie geven over de parameterlijst van de methode.
Om het returntype te verkrijgen gebruik je
[`getReturnType`](https://www.php.net/manual/en/reflectionfunctionabstract.getreturntype.php),
die een instantie van `ReflectionType` met informatie over het returntype 
teruggeeft.

## `ReflectionParameter`

De klasse
[`ReflectionParameter`](https://www.php.net/manual/en/class.reflectionparameter.php)
beschrijft een parameter van een functie. In de eerste plaats kan je de naam
van de parameter verkrijgen met
[`getName`](https://www.php.net/manual/en/reflectionparameter.getname.php);
hierbij moet bedacht worden dat deze naam zonder dollarteken is. Je kan de 
naam gebruiken om de parameter te vullen in een aanroep van de methode. 
Alternatief kan je de positie van de parameter in de parameterlijst 
verkrijgen met
[`getPosition`](https://www.php.net/manual/en/reflectionparameter.getposition.php).

Ook het type van een parameter kan je ophalen, met
[`getType`](https://www.php.net/manual/en/reflectionparameter.gettype.php).
Deze informatie is natuurlijk zeer handig als je autowiring wilt toepassen 
in een IoC container. De methode geeft een instantie van `ReflectionType` 
terug met informatie over het type; deze klasse wordt hieronder nog 
besproken.

Ten slotte zijn er nog een aantal handige booleanmethoden die je kan 
gebruiken. Zo geeft
[`isOptional`](https://www.php.net/manual/en/reflectionparameter.isoptional.php)
aan of de parameter optioneel is, dus niet meegegeven hoeft te worden. In 
dat geval kan je de defaultwaarde van de parameter ophalen met
[`getDefaultValue`](https://www.php.net/manual/en/reflectionparameter.getdefaultvalue.php).
Daarnaast geeft
[`isVariadic`](https://www.php.net/manual/en/reflectionparameter.isvariadic.php)
aan of de parameter variadisch is, dat wil zeggen dat deze gedeclareerd is 
met een beletselteken `...` zodat alle overgebleven parameters aan deze 
parameter worden toegekend.

## `ReflectionType`

Een aantal hierboven besproken methodes geven informatie over een type terug.
Deze informatie wordt teruggegeven als instanties van het type
[`ReflectionType`](https://www.php.net/manual/en/class.reflectiontype.php).
Dit is een abstracte klasse, dus feitelijk worden altijd subklassen van dit 
type gebruikt. Er zijn drie subklassen, `ReflectionNamedType`, 
`ReflectionUnionType` en `ReflectionIntersectionType`.

De subklasse
[`ReflectionNamedType`](https://www.php.net/manual/en/class.reflectionnamedtype.php) 
is met name relevant aangezien deze subklasse reguliere typedeclaraties 
beschrijft. De klasse heeft drie voor ons relevante methodes;
[`getName`](https://www.php.net/manual/en/reflectionnamedtype.getname.php)
geeft de naam van het type, zoals bijvoorbeeld een klassenaam, terug. 
Daarnaast kan je nagaan of het type ingebouwd is met
[`isBuiltin`](https://www.php.net/manual/en/reflectionnamedtype.isbuiltin.php)
en of het toegestaan is om `null` als waarde te gebruiken met
[`allowsNull`](https://www.php.net/manual/en/reflectiontype.allowsnull.php).

De andere twee subklassen beschrijven complexere typedeclaraties;
[`ReflectionUnionType`](https://www.php.net/manual/en/class.reflectionuniontype.php)
beschrijft een typedeclaratie die meerdere verschillende types toestaat, 
zoals bijvoorbeeld `int|float`, en
[`ReflectionIntersectionType`](https://www.php.net/manual/en/class.reflectionintersectiontype.php)
beschrijft een typedeclaratie die vereist dat de waarde die meegegeven 
wordt meerdere superklassen of interfaces heeft, zoals bijvoorbeeld 
`Countable&Traversable`. Deze beide klassen hebben een methode
[`getTypes`](https://www.php.net/manual/en/reflectionuniontype.gettypes.php)
om de onderliggende types te verkrijgen en hebben ook de al beschreven 
methode `allowsNull`.

## Voorbeeld

Het onderstaande voorbeeld drukt alle parameters van de constructor van een 
klasse en hun types af.

```php
$reflection = new ReflectionClass($class);
$constructor = $reflection->getConstructor();
foreach ($constructor->getParameters() as $param) {
    $type = $param->getType();
    echo $type->getName(), ' $', $param->getName(), PHP_EOL;
}
```

