# Opdracht

## Gebruikers

Voor het toepassen van RBAC heb je nodig dat van elke gebruiker bekend is 
welke rollen deze heeft. Pas daarom je implementatie van `UserInterface` en 
de bijbehorende repository zo aan, dat de methode `getRoles` geïmplementeerd 
wordt.

## Autorisatieservice

Implementeer de interface `AuthorizationInterface` en voeg deze waar nodig 
aan controllers en andere klassen toe. Pas hierbij RBAC of ABAC toe; het zal 
in ieder geval nodig zijn om de rol van de gebruiker te controleren.

## Firewallservice

Implementeer de interface `FirewallInterface` en laat deze aanroepen door de 
kernel. Als een request niet toelaatbaar is, toon dan een gechikte foutpagina.

## Micdleware

Vermoedelijk roep je op dit moment een aantal services expliciet aan in de 
kernel. Pas de kernel aan zodat deze middleware met het *chain of 
responsibility pattern* gebruikt en gebruik dit voor de services die je 
voorafgaand aan het aanroepen van de controller aanroept.

Het zal nodig zijn om
[adapterklassen](https://refactoring.guru/design-patterns/adapter)
te schrijven waarmee je services de interface `MiddlewareInterface` 
implementeren. Bovendien is het nodig om een manier te bedenken waarop elke 
middleware de volgende middleware kan aanroepen. Je kan bijvoorbeeld de 
kernel gebruiken hiervoor en een integer bijhouden die de index van de 
volgende middleware onthoudt.