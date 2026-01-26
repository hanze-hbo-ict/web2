# Oefeningen

Hoewel we ons bij de eindopdracht meer met de backend dan met de frontend bezighouden, is het natuurlijk wel van belang dat je weet *wat* je met die backend op moet leveren. Gebruik de onderstaande oefenignen om een beeld te krijgen van hoe die frontend-tecnieken werken.


## 1. De favorieten docenten

Maak een pagina waarin je de gegevens van je favoriete Hanze-docenten weergeeft. Omdat dit een lijstje betreft, is het logisch om deze gegevens in een `ul`-tag te zetten. De gegevens van de docenten zitten dan in geneste `li`'s. 

Zorg ervoor dat je elke docent van een plaatje voorziet, dat dit plaatje fatsoenlijke afmetingen heeft en dat de gegevens van de docent rechts van het plaatje staan. Over het algemeen is het een goed idee om die verschillende onderdelen (het plaatje, de gegevens) in separate tags te zetten (bijvoorbeeld `div`s).

Zie de afbeelding hieronder voor een mogelijk resultaat tot dusver.

![Voorbeeld van het resultaat tot dusver](../images/2.1-voorbeeld1.jpeg)


## 2. Betere stilering

De site is nu nog wel erg lelijk en onaantrekkelijk. Geeft de `div`s waarin de gegevens van de docenten staan een `class`-attribuut en gebruik vervolgens CSS om de volgende eisen te realiseren:

- maak het font schreefloos (bijvoorbeeld Calibri of Verdana). Zorg er daarbij voor dat wanneer de bezoeker het specifieke font dat je opgeeft niet heeft er wordt teruggevallen op het standaard schreefloze font van het OS.

- zorg ervoor dat de `div`s met de gegevens van de docenten wat verder van elkaar af komen te staan; geef ze wat ruimte links en boven.

- zorg er daarbij wel voor dat de plaatjes binnen de `border` van de betreffende `div` komen te liggen.

- maak wat afstand tussen het plaatje en de tekst.

- voorzie deze `div`s van een `border`, zodat duidelijk is welke gegevens waarbij horen.

Ziet het onderstaande plaatje voor een voorbeeld:


![Voorbeeld van het resultaat tot dusver](../images/2.1-voorbeeld2.jpeg)

## 3. Wat *fancier* vormgeving

Het geheel kan nog wel wat fancy-er worden vormgegeven. Het is natuurlijk helemaal hip om avatars rond te maken, dus dat gaan we hier nu ook doen: gebruik het css-attribuut [`border-radius`](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/border-radius) om dat voor elkaar te krijgen. Zorg er daarbij wel voor dat de afbeeldingen vierkant worden (dus even breed als hoog zijn). 

Verder vinden we de kaartjes van de docenten wel erg breed en *in your face*: maak deze kaartje wat smaller en geef de `border` een wat fijner kleurtje en een schaduw.

![Voorbeeld van het resultaat tot dusver](../images/2.1-voorbeeld3.jpeg)


## 4. Klikbaar

Maak nu van de hele `li` (de kaart van de docent) een grote hyperlink. Als je op die kaart klikt, moet je mail-client opstarten met het adres van de betreffende docent in een nieuwe mail. Om aan de bezoeker duidelijk te maken dat je op zo'n kaart kunt klikken, moet de achtergrondkleur van de `div` veranderen op het moment dat je er met je muis overheen gaat.

Mogelijk onderstreept je browser nu de gehele tekst van de `div`, omdat er een link van is gemaakt. Gebruik je stylesheet om deze understreping weer weg te halen.


![Voorbeeld van het resultaat tot dusver](../images/2.1-voorbeeld4.jpeg)

## 5. De *beste* docent

Hoewel alle docenten van de HG natuurlijk goed zijn, kan er maar één de beste zijn. Voorzie de kaart van de allerbeste docent van een extra plaatje of een emoticon om dat aan de bezoekers van je site duidelijk te maken. Gebruik vervolgens je stylesheet om het lettertype van die specifiek `div` wat extra aandacht te geven.


![Voorbeeld van het resultaat tot dusver](../images/2.1-voorbeeld5.jpeg)

## 6. Verticaal centreren

Een lastig ding in HTML/CSS is (nog steeds, hoewel het langzaamaan beter te doen is) het *verticaal centreren* van blocklevel-elementen (wat eigenlijk absurd is wanneer je bedenkt dat [Donald Knuth](https://en.wikipedia.org/wiki/Donald_Knuth) al in de jaren tachtig [`\vfill`](https://www.codespeedy.com/vertically-center-a-text-on-a-page-in-latex/) bedacht had, maar soit). Bestudeer [deze site](http://phrogz.net/CSS/vertical-align/index.html) om een goede uitleg te krijgen van wat het probleem is en hoe het (min of meer) te omzeilen. 

Gelukkig is er tegenwoordig de optie om de display van een div op `flex` te zetten; dat maakt dit allemaal wat makkelijker. Bekijk [deze site](https://css-tricks.com/snippets/css/a-guide-to-flexbox/) om te zien hoe dat werkt. Zorg ervoor dat de tekst van je favoriete docenten nu vertikaal in de `div` komt te staan. In module webtechnologie 3 gaan we nog wat verder in op de flexbox.

![Voorbeeld van het resultaat tot dusver](../images/2.1-voorbeeld6.jpeg)