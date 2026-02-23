# Services

Complexere webapplicaties kunnen veelal opgedeeld worden in een aantal 
componenten. Deze componenten worden vaak *services* genoemd, omdat ze een 
dienst aanbieden aan de rest van de applicatie. We hebben al een aantal 
services gezien, te weten de kernel, de router en de template engine. Een 
ander voorbeeld wat we nog zullen zien is een databaseverbinding.

Kenmerkend aan deze services is dat er meestal maar één instantie van hoeft 
te zijn. Dit is met name het geval als de service externe resources gebruikt;
als er bijvoorbeeld in een applicatie meerdere databaseverbindingen worden 
opgezet, beperkt dit het aantal verzoeken dat tegelijk kan worden uitgevoerd 
kleiner zal zijn dan als er steeds maar één verbinding wordt opgezet. Bij 
andere services is dit minder van belang, maar is er nog steeds geen 
noodzaak om meerdere instanties van de service te hebben. Het is dus handig 
om de applicatie zo op te zetten dat ervoor gezorgd wordt dat van elke 
service slechts een enkele instantie wordt gemaakt.

## Singleton pattern

Een klasse waarvan slechts een enkele instantie bestaat wordt een
*singleton* genoemd. Historisch wordt dit vaak afgedwongen door 
toepassing van het
[*singleton pattern*](https://refactoring.guru/design-patterns/singleton),
een design pattern waarbij de constructor van een klasse *private* is, en je 
de singleton-instantie van het object kan verkrijgen door middel van een 
statische methode.

Dit pattern wordt veelal gezien als *anti-pattern*, een design pattern met 
nadelige gevolgen, omdat het gebruik van dit pattern verborgen 
afhankelijkheden worden geïntroduceerd in de code. Je kan namelijk niet aan 
de definities van de constructor en de andere methodes in de klassen zien 
dat bijvoorbeeld de database gebruikt wordt; daarvoor moet je de code zelf 
lezen om te zien waar de singleton gebruikt wordt.

Bovendien is het niet mogelijk om de singleton te vervangen, bijvoorbeeld 
voor het schrijven van een test. Bij het testen van de code, met name bij 
unit tests, is het van belang om externe afhankelijkheden te vermijden; het 
doel is immers het testen van de methode zelf. Externe afhankelijkheden 
worden daarom vervangen door zogeheten *mockobjecten*, objecten die wel aan 
de interface van de externe afhankelijkheid voldoen maar voorgeprogrammeerde 
resultaten geven en kunnen bijhouden of de juiste aanroepen worden gedaan. 
Het vervangen van een singleton door een mock is erg lastig of zelfs 
onmogelijk als gebruik wordt gemaakt van het singleton pattern.

Het singleton pattern schendt ten slotte het
[*single-responsibility principle*](https://en.wikipedia.org/wiki/Single-responsibility_principle).
De singletonklasse heeft nu immers twee verantwoordelijkheden. De eerste is 
de verantwoordelijkheid die er al was, zoals in het geval van een 
databaseservice het regelen van een koppeling met een database. Maar 
aanvullend heeft de klasse nu de verantwoordelijkheid om ervoor te zorgen 
dat er maar één instantie van de klasse bestaat.

Samenvattend is de conclusie dat het singleton pattern niet de juiste 
oplossing is om ervoor te zorgen dat er maar een enkele instantie van een 
klasse is. Dit betekent niet dat de wens om een klasse een singleton te 
laten zijn onjuist is; die wens is prima, om de redenen die al genoemd zijn. 
Het singleton pattern is echter niet de juiste manier om dat doel te bereiken.

