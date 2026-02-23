# Dependency injection

Zoals al benoemd is het gebruik van het singleton pattern om meerdere 
redenen onwenselijk. Eén van de genoemde redenen is dat hierdoor verborgen 
afhankelijkheden ontstaan tussen verschillende componenten. Hierdoor wordt 
de [*coupling*](https://en.wikipedia.org/wiki/Coupling_(computer_programming))
tussen deze componenten vergroot; het hebben van *loose coupling*, waarbij 
componenten grotendeels onafhankelijk van elkaar kunnen functioneren, is 
echter in het algemeen zeer wenselijk.

Niet alleen het singleton pattern vergroot echter de coupling. Ook het 
aanmaken van service-objecten binnen een ander component vergroot deze 
coupling. Hierdoor ontstaat immers ook een verborgen afhankelijkheid. Als je 
bijvoorbeeld de template engine in een controller wilt gebruiken en die 
template engine binnen de controller zou instantiëren met het keyword `new`, 
dan is de controller afhankelijk van de implementatie van de template engine,
zoals in onderstaand voorbeeld.
Deze afhankelijkheid is onzichtbaar en kan bovendien niet worden gewijzigd.

```php
class Controller
{
    public function handle(RequestInterface $request): ResponseInterface
    {
        // ...
        $template_engine = new TemplateEngine();
        $html = $template_engine->render('view.html', $params);
        return new Response($html);
    }
}
```

Hier zien we dat twee manieren, waarvan we misschien intuïtief gebruik zouden 
willen maken om het ene component te gebruiken binnen het andere component, 
toch tot problemen kunnen leiden. Er is dus een andere manier nodig om 
componenten aan elkaar te koppelen.

## Inversion of control

Aangezien verborgen afhankelijkheden problematisch blijken te zijn, kan je 
aannemen dat het verstandig is om afhankelijkheden expliciet te maken. De 
techniek die je hiervoor kan gebruiken heet
[*dependency injection*](https://nl.wikipedia.org/wiki/Dependency_injection).
Dit is een techniek waarbij de afhankelijkheden van een klasse expliciet 
worden meegegeven aan de klasse, in plaats van dat de klasse ze zelf ophaalt 
of maakt.

Dependency injection is een vorm van een meer algemeen concept dat
[*inversion of control*](https://en.wikipedia.org/wiki/Inversion_of_control)
heet. Als een applicatie een bepaalde library gebruikt, is het meestal zo dat 
die applicatie functies in de library aanroept; de *flow of control* is dus 
van de applicatie naar de library. Bij inversion of control is dat omgekeerd.
Dit speelt met name bij het gebruik van *frameworks*. Kenmerkend daaraan is 
dat het entry point van de applicatie in het framework ligt, en dat het het 
framework is dat functies van de applicatie aanroept. De flow of control is 
dus van het framework naar de applicatie. Ook browsers en game engines zijn 
voorbeelden hiervan; in beide gevallen is er een generieke *event loop* die 
applicatiefuncties aanroept als bepaalde events optreden.

## Constructor injection

De meest gebruikelijk vorm van dependency injection is *constructor 
injection*. Hierbij worden alle afhankelijkeden die een klasse nodig heeft 
meegegeven aan de constructor. Deze afhankelijkheden zijn dus expliciet 
zichtbaar in de definitie van die constructor en worden bovendien niet door 
de component zelf beheerd. Als voor de constructorparameters interfaces 
worden gebruikt, is het bovendien eenvoudig om de implementatie van de 
afhankelijkheid uit te wisselen voor een andere implementatie, mits die maar 
aan de gevraagde interface voldoet.

Het hierboven genoemde voorbeeld, waarbij een controller een template engine 
gebruikt, kan als volgt worden herschreven om gebruik te maken van 
constructor injection.

```php
class Controller
{
    public function __construct(private TemplateEngineInterface $template_engine)
    {
    }
    
    public function handle(RequestInterface $request): ResponseInterface
    {
        // ...
        $html = $this->template_engine->render('view.html', $params);
        return new Response($html);
    }
}
```

Het is hiermee mogelijk geworden om een andere implementatie te gebruiken 
voor de interface `TemplateEngineInterface`, waarbij in de eerder getoonde 
code de klasse hard gekoppeld was aan de implementatie in `TemplateEngine`. 
Merk bovendien op dat niet elke klasse-instantiatie met `new` problematisch 
is. Het aanmaken van de response blijft via dit keyword gebeuren. Het 
verschil is gelegen in de constatering dat `Response` geen service is, maar 
een *value object*. Het zou niet logisch zijn om deze van buiten te injecten,
aangezien het de taak van de controller is om dit object te maken.

## Setter injection

Een potentieel nadeel aan constructor injection is dat het al bij het 
aanmaken van de component nodig is om alle afhankelijkheden te maken en dat 
deze naderhand niet gewisseld kunnen worden. Als dit bezwaarlijk is, dan kan 
gebruik gemaakt worden van *setter injection*. Hierbij wordt een 
setter-methode toegevoegd aan de klasse waarmee de afhankelijkheid ingesteld 
kan worden. Dit zou bijvoorbeeld gebruikt kunnen worden om een logger in te 
stellen; de logger hoeft niet ingesteld te worden als loggen niet gewenst is 
en bovendien zou het zo kunnen zijn dat loggen op een gegeven moment op een 
andere manier gedaan moet worden. Aan deze beschrijving is al te zien dat 
setter injection een variant van het
[*strategy pattern*](https://refactoring.guru/design-patterns/strategy) is. 
Merk wel op dat dit een methode is die maar zelden gebruikt hoeft te worden; 
vrijwel altijd zal constructor injection de voorkeur hebben.
