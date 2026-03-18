# Cookies en sessies

Zoals al eerder genoemd is HTTP een *stateless* protocol. Dit betekent dat, 
voor zover het de server aangaat, elk request op zich staat en geen kennis 
heeft van andere requests. Dit in tegenstelling tot protocollen zoals FTP of 
SSH, waarbij de client een dialoog aangaat met de server en de server 
daarbij informatie bijhoudt over de sessie van de client, zoals bijvoorbeeld 
wat de huidige directory is waarin de client zich bevindt.

Deze statelessness maakt HTTP een eenvoudig protocol, maar is problematisch 
voor webapplicaties waarin we juist wel graag willen dat de server kan 
bijhouden wie de applicatie gebruikt, bijvoorbeeld om zo de toegang tot 
zekere pagina's te kunnen ontzeggen aan niet-geautoriseerde gebruikers, en 
kan bijhouden wat een gebruiker allemaal gedaan heeft, bijvoorbeeld om in 
een webshop bij te houden welke producten de gebruiker in diens winkelwagentje 
heeft gedaan.

## Cookies

De oplossing voor dit probleem maakt gebruik van de mogelijkheid van het 
HTTP-protocol om arbitraire headers mee te geven. De server vertelt 
eenvoudigweg aan de client wat de server graag onthouden wil zien. Als de 
client dan deze informatie steeds maar weer aan de server vertelt, dan kan 
de server hierop acteren. Dit is het principe achter
[*cookies*](https://nl.wikipedia.org/wiki/Cookie_(internet)).

Bij het gebruik van cookies stuurt de server, als deze informatie wil 
bijhouden over de huidige gebruiker, deze informatie als *cookie* naar de 
client door gebruik te maken van de responseheader
[`Set-Cookie`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Set-Cookie).
De client slaat deze informatie vervolgens op in de zogeheten *cookie jar*, 
waarbij in beginsel per domein apart gegevens opgeslagen kunnen worden in 
een key-valuestore. De server kan dus meerdere cookies met verschillende 
namen gebruiken die allemaal opgeslagen worden.

De client stuurt vervolgens bij elk request alle relevante cookies naar de 
server, door middel van de requestheader
[`Cookie`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Cookie).
Hierbij worden dus alleen cookies voor het bij het request behorende domein 
meegestuurd, zodat de server geen informatie krijgt over andere domeinen.

In PHP hoef je niet zelf deze headers te zetten. De binnenkomende cookies 
worden door PHP in de superglobal `$_COOKIE` gezet, die in onze 
`RequestInterface` beschikbaar wordt gemaakt via de methode 
`getCookieParams`. Deze superglobal kan weliswaar aangepast worden, maar is 
conceptueel wel read-only. Dat wil zeggen dat het aanpassen van deze 
variabele niet leidt tot het instellen van een nieuw cookie. Om een 
nieuw cookie te maken, of een cookie aan te passen, wordt de PHP-functie
[`setcookie`](https://www.php.net/manual/en/function.setcookie.php)
gebruikt. Hierbij kan als derde parameter worden meegegeven wanneer het 
cookie moet komen te vervallen; na dat tijdstip zal de client het cookie 
niet meer naa de server sturen.

Cookies kunnen ook in JavaScript worden uitgelezen via de variabele
[`document.cookie`](https://developer.mozilla.org/en-US/docs/Web/API/Document/cookie).
Via een XSS-aanval kan het mogelijk zijn dat deze waarde naar een derde 
partij gestuurd wordt, hetgeen het risico met zich mee brengt dat die derde 
partij de sessie van de gebruiker kan overnemen door dit cookie te gebruiken, 
het zogeheten
[*session hijacking*](https://nl.wikipedia.org/wiki/Session_hijacking). Om 
dit risico te mitigeren is het mogelijk om bij het zetten van het cookie aan 
te geven dat deze niet gelezen mag worden met JavaScript via de vlag 
*HttpOnly*. In PHP kan deze vlag via de parameter `$httponly` in de aanroep 
van `setcookie` ingesteld worden.

Het is bovendien mogelijk om af te dwingen dat een cookie alleen via een 
HTTPS-verbinding verstuurd mag worden, zodat deze nooit onversleuteld 
verstuurd wordt. Dit kan via de vlag `Secure`, die in PHP via de parameter 
`$secure` van de functie `setcookie` ingesteld kan worden.

## Sessies

Het gebruik van cookies voor authenticatie heeft het kritieke probleem dat 
de gegevens van de cookie voor de browser zichtbaar zijn en dus in principe 
aangepast kunnen worden. Immers, we vertrouwen erop dat de client netjes de 
cookies die we meegeven terug zal sturen, maar het is onmogelijk om dit te 
garanderen. Als we dus een gebruikers-id in een cookie zouden zetten en 
daarop zouden vertrouwen om de identiteit van de gebruiker vast te stellen, 
kan een client zich eenvoudig voordoen als een andere gebruiker door een 
ander id mee te sturen.

Voor dit probleem zijn in grote lijnen twee oplossingsrichtingen. De eerste 
aanpak is om naast de gegevens zelf ook een cryptografisch ondertekende hash 
van deze gegevens mee te sturen. Als de client dan het cookie aanpast, kan 
de server dit herkennen omdat de ondertekening niet klopt. Deze aanpak wordt 
bijvoorbeeld gebruikt door
[*JSON Web Tokens*](https://en.wikipedia.org/wiki/JSON_Web_Token),
vaak kortweg JWT's genoemd. Potentieel bezwaar aan deze methode is wel dat 
de client nog steeds de waarde van het cookie kan lezen; als die gegevens 
niet ingezien mogen worden door de client is deze methode niet geschikt.

De andere oplossingsrichting is het gebruik van
[*sessions*](https://en.wikipedia.org/wiki/Session_ID).
De gedachte hierbij is dat de gegevens die je over een gebruiker wilt 
opslaan op de server worden opgeslagen en dat je vervolgens alleen een 
unieke id die correspondeert met deze gegevens als cookie naar de client 
stuurt. Door deze id voldoende lang te maken en willekeurig te kiezen is het 
vrijwel onmogelijk om deze te raden. De client kan dus niet zien wat er over 
de gebruiker is opgeslagen, alleen dat de server een sessie bijhoudt.

In PHP werken sessies via de superglobal
[`$_SESSION`](https://www.php.net/manual/en/reserved.variables.session.php).
Deze variabele kan, anders dan `$_COOKIE`, aangepast worden om de sessie van 
de gebruiker bij te werken. Anders dan `$_COOKIE` is `$_SESSION` bovendien 
niet automatisch beschikbaar. Pas na een aanroep van de functie
[`session_start`](https://www.php.net/manual/en/function.session-start.php)
kan de sessie gebruikt worden. Door het aanroepen van deze functie wordt, 
als er nog geen session id is, een cookie gestuurd met een nieuwe session id.

Omdat deze informatie strikt genomen niet via de request en response 
verstuurd wordt, is hiervoor geen faciliteit in `RequestInterface` aanwezig. 
Om echter gebruik van deze superglobal te beperken, zullen we een 
implementatie van de interface `Framework\Http\SessionInterface` maken die 
de aanroepen naar de superglobal encapsuleert.

Deze interface extendt de ingebouwde interface
[ArrayAccess](https://www.php.net/manual/en/class.arrayaccess.php),
met vier methodes `offsetGet`, `offsetSet`, `offsetExists` en `offsetUnset` 
voor respectievelijke het lezen van waardes uit de sessie, het schrijven van 
waardes in de sessie, het controleren of een waarde in de sessie aanwezig is 
en het verwijderen van waardes uit de sessie. Een object dat deze interface 
gebruikt kan als een array worden gebruikt, zo zal `$session['foo'] = 'bar'` 
de aanroep `$session->offsetSet('foo', 'bar')` doen als `$session` een 
instantie van `SessionInterface` is. Daarnaast heeft de interface een 
methode `destroy` om de sessie te beëindigen en te verwijderen.

```php
namespace Framework\Http;

interface SessionInterface extends \ArrayAccess
{
    function offsetSet(mixed $offset, mixed $value): void;
    function offsetGet(mixed $offset): mixed;
    function offsetExists(mixed $offset): bool;
    function offsetUnset(mixed $offset): void;
    function destroy(): void;
}
```

Er zijn ruwweg twee manieren om een instantie van deze implementatie, die 
binnen een request een singleton moet zijn, te verkrijgen. De eerste aanpak 
is om `SessionInterface` als service beschikbaar te stellen via dependency 
injection. Elke klasse die deze service nodig heeft, kan deze dan via de 
constructor verkrijgen. Het alternatief is dat de kernel de 
singletoninstantie van `SessionInterface` via 
`RequestInterface::withAttribute` in het request zet, zodat alle klassen die 
het request beschikbaar hebben de sessie kunnen gebruiken.

## Cookiewet

Aan het gebruik van cookies en sessies kleven enkele juridische aspecten. 
Deze zullen niet uitgebreid worden besproken, maar het is goed om ze hier 
kort aan te stippen. Op grond van de zogeheten cookiewet, [artikel 11.7a van 
de Telecommunicatiewet](https://wetten.overheid.nl/jci1.3:c:BWBR0009950&hoofdstuk=11&paragraaf=11.1&artikel=11.7a&z=2025-09-01&g=2025-09-01),
is het gebruik van cookies alleen toegestaan als de gebruiker hier expliciet 
toestemming voor gegeven heeft, of als dit gebruik strikt noodzakelijk is 
voor de technische werking van de website.

Het versturen van een cookie met een session id is niet strikt noodzakelijk 
als de sessie niet wordt gebruikt, dus het is, om in overeenstemming te zijn 
met deze wet, aan te bevelen om de functie `session_start` pas te gebruiken 
als je echt gebruik wilt maken van de sessie, dus als je er een waarde in 
wilt opslaan. Het is echter altijd noodzakelijk om `session_start` aan te 
roepen als je een waarde uit de sessie wilt lezen; je kan echter kijken of 
het cookie met de session id bestaat door in `$_COOKIE` of het equivalent 
in het requestobject te kijken. De functie
[`session_name`](https://www.php.net/manual/en/function.session-name.php)
geeft de naam van het cookie terug, dus als `$_COOKIE[session_name()]` een 
waarde bevat betekent dit dat de sessie al bestaat en je dus veilig 
`session_start` kan aanroepen.