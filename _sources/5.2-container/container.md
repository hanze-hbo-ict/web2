# IoC container

Als je, zoals we tot nu toe gedaan hebben, dependency injection handmatig 
toepast, zul je zien dat je op een gegeven moment vrij veel code krijgt om 
allerlei objecten te maken en mee te geven aan andere objecten. Zeker als 
objecten meerdere services nodig hebben kan dit vrij onoverzichtelijk worden.
Een ander probleem is dat, als een object een nieuwe service nodig heeft, je 
deze wijziging handmatig moet doorvoeren bij het opbouwen van de objectgraaf.

Deze problemen zijn te ondervangen door gebruik te maken van een
*inversion of control container*, of kortweg *IoC container*
Deze naam verwijst naar het feit dat klassen door het gebruik van een 
dergelijke container niet meer zelf verantwoordelijk zijn voor het vinden 
van hun afhankelijkheden, maar dat ze ze door de container krijgen aangeboden.

De container is dus verantwoordelijk voor het instantiëren van de juiste 
objecten om de services die in de applicatie nodig zijn te kunnen 
initialiseren. Om dit te kunnen doen, moet de container zodanig 
geconfigureerd worden dat dit op de juiste manier kan gebeuren. Er zijn dus 
twee relevante aspecten aan de container. In de eerste plaats is er een 
interface nodig om services uit de container op te halen.
[PSR-11](https://www.php-fig.org/psr/psr-11) biedt hier een interface
`Psr\Container\ContainerInterface` voor met een methode `get` om een service 
op te halen en een methode `has` om te controleren of een bepaalde service 
bestaat.

PSR-11 beschrijft echter expliciet geen interface voor het configureren en 
registeren van services. Hierbij is er dus de vrijheid om dit op een 
veelvoud aan manieren te doen. In het hiernavolgende zal een aantal aspecten 
besproken worden waaraan gedacht moet worden om dit te realiseren. Bovendien 
is een skelet van een implementatie van een IoC container beschikbaar, 
waarbij implementatiehints gegeven worden om de daar genoemde methoden te 
implementeren.

## Services en klassen

Zoals gezegd is het de taak van de IoC container om services te instantiëren.
Services zijn in een OOP-applicatie objecten. Services moeten bovendien een 
herkenbare naam hebben, zodat de applicatie weet welke service aangemaakt 
moet worden. Uit beide constateringen volgt dat een natuurlijke naam voor 
een service de klassenaam is van het serviceobject. Dit is in beginsel een 
redelijke keuze en wordt dan ook veel toegepast, maar heeft enkele haken en 
ogen.

In de eerste plaats is het goed mogelijk dat er verschillende services zijn 
die dezelfde klasse gebruiken. Een applicatie die bijvoorbeeld twee 
verschillende databaseverbindingen nodig heeft, bijvoorbeeld om een database 
te migreren, zal normaal gesproken twee instanties van dezelfde klasse 
gebruiken voor de databaseverbindingen. De klassenaam is dan dus niet meer 
onderscheidend genoeg, maar een specifiekere naam is dan noodzakelijk.

In de tweede plaats is het een goed gebruik om services afhankelijk te laten 
zijn van interfaces, niet van een specifieke implementerende klasse. Een 
service is echter altijd een object van een specifieke klasse. Zo kan een 
concrete databaseverbinding een instantie van `MySqlConnection` zijn, als 
het een verbinding met een MySQL-database betreft, maar implementeert die 
klasse wellicht een algemene interface `ConnectionInterface`, en is dat de 
typedeclaratie die in andere services gebruikt worden. We zullen nog zien 
dat het dan handig zal zijn om de service de naam `ConnectionInterface` te 
geven in plaats van `MySqlConnection`, aangezien we dan de service 
automatisch aan de constructorparameter kunnen koppelen.

Deze beide omstandigheden brengen met zich mee dat het noodzakelijk is om 
configureerbaar te maken welke klasse gebruikt wordt om een bepaalde service 
te instantiëren. Het is echter ook handig om de servicenaam hiervoor als 
defaultwaarde te gebruiken.

## Services instantiëren

Nu we weten welke klasse we moeten instantiëren, is het nodig om de 
constructor hiervan aan te roepen. Dit kan via reflectie of het keyword 
`new`, maar in beide gevallen is het nodig om een lijst van 
constructorparameters te hebben.

Eén aanpak is om deze lijst uit de configuratie te halen. We eisen dan dat 
de configuratie voor een service ook de constructorparameters bevat. Dit is 
omslachtig, maar biedt wel volledige controle. Het lost echter niet direct 
het probleem op dat, als een klasse een extra constructorparameter nodig 
heeft, dat hierdoor een wijziging moet plaatsvinden in het opbouwen van de 
objectgraaf. We zullen nog zien dat *autowiring*, wat hieronder besproken 
zal worden, dit probleem oplost.

Dit alles laat onverlet dat het vaak noodzakelijk zal zijn om expliciet 
constructorparameters te configureren. Het zal immers niet altijd zo zijn 
dat de applicatie zelf kan voorspellen welke afhankelijkheden nodig zijn, en 
bovendien kan een service ook anderssoortige parameters hebben, zoals 
bijvoorbeeld verbindingsinformatie voor een database.

Het is dus noodzakelijk dat het bij de configuratie mogelijk is om 
constructorparameters aan te geven. Hierbij is het handig om *named 
parameters* te gebruiken, zodat het niet nodig is om de volgorde van de 
parameters aan te houden.

Bovendien kan het nodig zijn om in de configuratie aan te geven dat een 
bepaalde parameter ingevuld moet worden door een met naam genoemde service. 
Om deze naam te onderscheiden van andere strings kan het handig zijn om 
bijvoorbeeld de conventie te gebruiken dat als een string met een at `@` 
begint, hiermee bedoeld wordt dat de rest van de string de naam van een 
service is die uit de container opgevraagd moet worden. Ook als in een 
arrayparameter strings aanwezig zijn, moet een dergelijke conventie toegepast 
worden. Het kan bijvoorbeeld goed zijn dat een router een array van 
controllers meekrijgt als parameter, die allemaal als service opgezocht 
moeten worden in de container.

Sommige services hebben naast de constructoraanroep een aantal 
methode-aanroepen nodig om volledig geconfigureerd te worden. Ook deze 
aanroepen kunnen opgeslagen worden in de configuratie, zodat ze juist worden 
uitgevoerd. Een alternatief hiervoor kan het gebruik van een factoryfunctie 
zijn. In de configuratie van de service wordt dan een verwijzing naar deze 
functie opgenomen. Als de service geïnitialiseerd moet worden, wordt dan 
deze factoryfunctie aangeroepen en is de returnwaarde de geïnitialiseerde 
service. Hierbij is het gebruikelijk dat de factoryfunctie de beschikking 
krijgt over de container zodat hiermee andere services opgezocht kunnen worden.

## Autowiring

Het is in PHP, en overigens ook in de meeste andere hogere programmeertalen, 
mogelijk om programmatisch informatie te verkrijgen over de klassen die 
gebruikt worden in de applicatie. Deze techniek heet *reflectie*, en 
zal later nog besproken worden. Hiermee is het onder meer mogelijk om de 
parameters van de constructor en hun types uit te lezen.

Door gebruik te maken van reflectie, kunnen we nagaan welke types de 
constructorparameters hebben. Als dit toevallig namen van services zijn, 
zouden we ervoor kunnen kiezen om, als de waarde van de parameter niet 
geconfigureerd is, de bijbehorende service als parameter mee te geven. Dit 
heet *autowiring*.

Je kan nu zien waarom het handig was om de naam van een klasse of interface 
als servicenaam te gebruiken. Als een controller bijvoorbeeld een 
databaseverbinding nodig heeft, heeft hij bijvoorbeeld een constructorparameter 
met als type `ConnectionInterface`. Als er een service met die naam aanwezig 
is, zouden we die kunnen gebruiken in de constructor, en omdat we types en 
servicenamen in overeenstemming hebben gehouden, is die service van het 
juiste type. Dit is dus een redelijke default. Bovendien hoeven we nu de 
configuratie niet aan te passen als een object een extra service nodig heeft,
mits die service bekend is in de container. Hij zal dan immers automatisch 
toegevoegd worden.

We kunnen autowiring implementeren door met reflectie een lijst van 
constructorparameters te vinden, en voor elke parameter te kijken of deze in 
de configuratie staat. De naam van de parameter is hiervoor een geschikte 
zoeksleutel. Als de parameter niet expliciet geconfigureerd is, kan in 
plaats daarvan gekeken worden of het type bekend is als service in de 
container; als dat zo is, kan die service opgehaald worden uit de container 
en gebruikt worden als parameter. Hier is weer het recursieve karakter 
zichtbaar; om die service op te halen zal vermoedelijk immers weer 
autowiring worden toegepast.

## Singletons

Onze bespreking van het onderwerp dependency injection begon met de wens om 
singletonklassen te kunnen hebben, waar maar één instantie van is. Als we 
autowiring naïef zouden toepassen, zou wellicht elke keer dat bijvoorbeeld 
een databaseverbinding nodig is, een nieuwe instantie van de bijbehorende 
klasse worden gemaakt. Dit is duidelijk geen singleton.

Het is daarom handig om alle services die gemaakt worden op te slaan in een 
cache, en om dan, als een service nog een keer gevraagd wordt, eerst te 
kijken of deze al in de cache staat. Zo ja, dan kiezen we ervoor om die al 
gemaakte service te gebruiken. Op deze manier is elke service een singleton.

Soms kan dit gedrag onwenselijk zijn en is het juist wel de bedoeling dat 
elke keer een nieuwe instantie gemaakt wordt. Het is daarom handig om dit 
gedrag configureerbaar te maken.

## Strings

Naast andere services heb je vaak ook bepaalde strings nodig om een service 
te configureren. Denk bijvoorbeeld aan het pad naar de template directory 
voor de template engine of een connectiestring voor een database. Voor zover 
dit gewoon hele strings zijn, kunnen ze als constructorparameter worden 
geconfigureerd.

Het kan echter wenselijk zijn om een dergelijke string op te kunnen bouwen 
uit een configureerbaar deel en een hardcoded deel, met name als het 
configureerbare deel hierdoor herbruikbaar wordt. Stel bijvoorbeeld dat de 
templates in de directory `templates` van het project staan, dan zou het 
handig zijn om de root directory van het project configureerbaar te maken, 
en hierachter de string `/templates` te plaatsen. Dit speelt hier met name, 
omdat de root directory van het project vrij eenvoudig kan veranderen door 
de applicatie ergens anders te deployen.

Door de optie om strings te registreren aan de container toe te voegen kan 
dit mogelijk worden gemaakt. Zo zou de root directory van het project 
geregistreerd kunnen worden als de string `root_dir`. Bij het ophalen van 
constructorparameters kan dan bijvoorbeeld de string `%root_dir%` of `
{root_dir}` vervangen worden door die waarde.

## Configuratie

Zoals we hebben gezien heeft de container een behoorlijk aantal 
configuratieopties nodig. Er zijn in hoofdlijnen twee manieren om deze 
configuratie op te slaan.

De eerste is om een tekstbestand te maken waarin deze configuratie staat, en 
in de containerklasse een statische methode op te nemen die een container 
aanmaakt en het genoemde tekstbestand inlaadt. Hierbij kan worden gedacht aan 
[JSON](https://nl.wikipedia.org/wiki/JSON), dat met
[`json_decode`](https://www.php.net/manual/en/function.json-decode.php)
omgezet kan worden naar een array. Op de plaats waar de container benodigd 
is kan je een deze statische methode aanroepen.

De tweede optie is om gebruik te maken van het `require`-statement. Hierbij 
maak je een PHP-bestand waarin je een containerobject maakt met `new` en 
vervolgens deze container configureert. Ten slotte gebruik je `return` om de 
container terug te geven aan het `require`-statement. Dit lijkt enigszins op 
de manier om de composition root in een apart bestand te zetten. Op de 
plaats waar je de container nodig hebt kan je dan het `require`-statement 
neerzetten.

## Gebruik van de IoC container

Nu we een IoC container hebben is de volgende vraag waar we deze gaan 
gebruiken. Hierbij moet in gedachten worden gehouden dat het de taak van de 
container is om de objectgraaf op te bouwen. De objectgraaf wordt opgebouwd 
in de composition root, dus dit is ook de plaats waar de IoC container wordt 
gebruikt.

De composition root bestond eerst uit het handmatig aanmaken van een aantal 
services, die eventueel als afhankelijkheden aan elkaars constructor werden 
meegegeven. Vervolgens werd een enkele service teruggegeven; dit is de entry 
point van de applicatie, in ons geval de kernel.

Om een IoC container te maken, wordt deze handmatige vorm van dependency 
injection vervangen door het gebruik van de IoC container. Dit bestaat 
conceptueel uit drie stappen.

1. Eerst wordt de IoC container geconfigureerd en alle services 
   geregistreerd in de container.
2. Daarna wordt het entry point van de applicatie opgehaald uit de container.
   Dit is de enige expliciete aanroep van de container; het is nu de taak 
   van de container om de hele objectgraaf op te bouwen.
3. Hierna is de container niet meer nodig en kan de verwijzing naar de 
   container weggegooid worden. In een taal als PHP, waarbij het geheugen 
   van objecten automatisch vrijgegeven wordt als ze niet meer gebruikt 
   worden, is dit geen expliciete stap, maar dit zou wel zo zijn in een taal 
   als C.

Deze drie stappen worden wel aangeduid als het
[register-resolve-release pattern](https://blog.ploeh.dk/2010/09/29/TheRegisterResolveReleasepattern/);
eerst wordt de container geregistreerd (*register*), daarna wordt een object 
opgehaald (*resolve*) uit de container, en daarna wordt de container 
vrijgegeven (*release*).

Merk hierbij op dat in de feitelijke applicatie zelf de container nergens 
meer gebruikt wordt. De container wordt enkel en alleen gebruikt om de 
objectgraaf op te bouwen. Het is erg verleidelijk om de container ook 
tijdens de applicatie beschikbaar te houden zodat objecten hier nog services 
uit kunnen ophalen, het zogeheten
[*service locator pattern*](https://en.wikipedia.org/wiki/Service_locator_pattern),
maar dit is net als het singleton pattern een antipattern aangezien ook 
hierdoor verborgen afhankelijkheden worden geïntroduceerd.

In de praktijk zie je wel dat de container toch beschikbaar wordt gehouden. 
Dit komt omdat bij webapplicaties in PHP, waarbij voor elke request een 
apart proces wordt gestart, het niet altijd nodig is om de volledige 
objectgraaf aan te maken. Immers, in elk request wordt slechts een enkele 
controller gebruikt, en het kan voor de performance gunstig zijn om de 
andere controllers niet te instantiëren. Wat je in dat geval ziet is dat de 
router of een vergelijkbare component de beschikking heeft over de container,
zodat aan de hand van de benodigde route de juiste controller op te halen 
uit de container. Maar ook hier geldt dat dit gebruik van de container 
geminimaliseerd moet worden; als deze variant wordt toegepast, worden in 
principe slechts twee objecten expliciet uit de container gehaald, te weten 
de kernel en de controller die voor dit request nodig is.
