# Autorisatie

Waar authenticatie de vraag naar de identiteit van de gebruiker is, is 
autorisatie de vraag naar de rechten van een gebruiker. Dit is dus, anders 
dan authenticatie, noodzakelijkerwijs applicatiespecifiek.

Bij autorisatie zijn in beginsel twee entiteiten betrokken. Aan de ene kant 
is er het *subject*, de gebruiker die een bepaalde actie wil uitvoeren of een 
bepaalde resource wil aanspreken. Aan de andere kant is er het *object*, de 
resource die de gebruiker wil aanspreken. Het autorisatiesysteem moet 
beoordelen of het subject de gewenste actie mag uitvoeren op het gevraagde 
object, en eventueel onder welke voorwaarden.

## Autorisatieservice

Een natuurlijk punt om autorisatie uit te voeren is in de controller. Hier 
is immers bekend welke actie een gebruiker wil uitvoeren en ook wat het 
object is. De controller kan nu de autorisatieservice gebruiken, een 
instantie van `AuthorizationInterface`, die zal kijken of de gevraagde actie 
toelaatbaar is. Hierbij zijn twee varianten beschikbaar. Met `isGranted` 
krijgt de controller een boolean terug waaraan gezien kan worden of de actie 
toelaatbaar is; `denyUnlessGranted` doet niets als de actie toelaatbaar is 
maar zal een exceptie gooien als de actie niet toelaatbaar is.

```php
namespace Framework\AccessControl;

interface AuthorizationInterface
{
    function isGranted(UserInterface $user, string $permission, mixed ...$parameters): bool;
    function denyUnlessGranted(UserInterface $user, string $permission, mixed ...$parameters): void;
}
```

In beide gevallen moet de gebruiker en de gevraagde actie, in de vorm van 
een string die meestal de gevraagde *permission* wordt genoemd, worden 
meegegeven. Eventueel kunnen extra parameters worden meegegeven waarmee het 
object kan worden beschreven; denk hierbij bijvoorbeeld aan het id van een 
blogpost.

Naast de controller kan deze service bijvoorbeeld ook gebruikt worden in een 
repository in het ORM. Hiermee kan afgedwongen worden dat een gebruiker die 
geen rechten op een bepaalde tabel heeft deze tabel ook nooit kan aanspreken.
Dit gebruik is complementair aan het gebruik in de controller, en maakt 
onderdeel uit van een strategie die
[*defense in depth*](https://en.wikipedia.org/wiki/Defense_in_depth_(computing))
wordt genoemd.

## Firewall

Vaak kan al vrij vroeg in het request gezien worden dat een bepaalde 
gebruiker geen rechten heeft op de gevraagde pagina. Denk bijvoorbeeld aan 
een website waarbij alleen ingelogde gebruikers pagina's waarvan de URL met
`/secret` begint, mogen benaderen. Het is dan niet nodig om te wachten tot 
de controller aangeroepen wordt om de gebruiker te weigeren, dit kan dan al 
eerder.

Een mogelijke oplossing hiervoor is het gebruik van een service die we hier 
een *firewall* zullen noemen, aangezien dit de eerste beveiligingsgrens is 
tussen de af te schermen onderdelen van de applicatie en de buitenwereld.

De interface voor de firewallservice heeft een enkele methode `accepts` die 
een request en een gebruiker meekrijgt en beoordeelt of deze gebruiker 
toegang mag hebben tot dit request.

```php
namespace Framework\AccessControl;

interface FirewallInterface
{
    function accepts(RequestInterface $request, UserInterface $user): bool;
}
```

Hierbij geldt dat, als nadere informatie nodig zou zijn om deze beslissing 
te nemen, de firewall de gebruiker moet doorlaten. Later wordt immers de 
autorisatieservice nog gebruikt om te controleren of de gebruiker 
daadwerkelijk toegang heeft. Ook hier zien we dus weer de toepassing van 
*defense in depth*.

Anders dan de autorisatieservice kan de firewallservice wel vanuit de kernel 
worden aangeroepen, waardoor het dus vaak al mogelijk kan zijn om een 
gebruiker te weigeren nog voordat routing wordt uitgevoerd.
