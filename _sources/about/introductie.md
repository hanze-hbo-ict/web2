# Introductie

Webapplicaties onderscheiden zich van reguliere applicaties doordat uit de 
webomgeving een aantal randvoorwaarden voortvloeien die de architectuur van 
de applicatie beïnvloeden. Zo is de architectuur noodzakelijk gescheiden 
tussen een gedeelte dat op een server draait en een gedeelte dat op de 
browser van de gebruiker draait.

Dit leidt tot een drielaagsarchitectuur met een databaselaag, een 
logicalaag en een presentatielaag. Hierbij kan nog een onderscheid gemaakt 
worden tussen architecturen die uitgaan van *thin clients* en van *thick 
clients*. Dit betreft met name de plaats van de applicatielogica. Bij een 
*thin client* wordt deze applicatelogica uitgevoerd op de server; bij een 
*thick client* in de browser.

Historisch was een *thin client* de enige mogelijkheid voor een webapplicatie, 
zeker voordat Javascript bestond en ook toen de mogelijkheden daarvan nog 
in de kinderschoenen stonden. Er was simpelweg geen mogelijkheid om logica 
uit te voeren in de browser. De communicatie tussen server en browser 
bestaat er dan uit dat de server complete HTML-pagina's naar de browser 
stuurt, dat de browser die aan de gebruiker toont en dat vervolgens de 
gebruiker een actie uitvoert waardoor een volledig nieuwe HTML-pagina 
opgevraagd wordt. Dit is de interactie die in dit vak aan bod komt; er is 
dus sprake van een focus op de backend van de applicatie.

Een alternatief hiervoor, dat in het hieropvolgende vak Webtechnologie III 
aan bod zal komen, is dat applicatielogica uitgevoerd wordt in de browser. 
De communicatie met de server is dan beperkt tot het opvragen en opslaan van 
gegevens; de server dient feitelijk alleen als database. In dat geval is er 
dus sprake van een focus op de frontend van de applicatie.

Zoals gezegd ligt de focus in dit vak op de backend. Hierbij zullen we 
bekijken hoe een architectuur van een webapplicatie er uit kan zien en welke 
componenten hierbij betrokken zijn. Om hier een beter begrip van te krijgen 
zul je een eenvoudig webframework ontwikkelen waar deze componenten in naar 
voren komen. Zo krijgt je een beter inzicht van de mogelijkheden, afwegingen 
en beperkingen van een webapplicatie.

Waar een frontendapplicatie vrijwel altijd in Javascript geschreven zal zijn,
omdat dat de enige programmeertaal is die standaard aanwezig is in browsers, 
kan een backendapplicatie feitelijk in elke taal geschreven worden. Het 
enige dat nodig is, is dat het nog te bespreken protocol HTTP 
geïmplementeerd wordt. In dit vak is ervoor gekozen om met de taal PHP te 
werken; PHP biedt standaard ondersteuning voor HTTP en kan dan ook gezien 
worden als een domeinspecifieke taal voor het web. PHP wordt bovendien in de 
praktijk op grote schaal gebruikt voor het ontwikkelen van websites en 
webapplicaties.
