# Opdracht

## Sessies

Implementeer de interface `SessionInterface`, en maak deze ofwel beschikbaar 
als service via dependency injection, of als attribuut in het request.

## Gebruikers

Implementeer de interfaces `UserInterface` en `UserProviderInterface`. Het 
is het meest logisch om een databasemodelklasse te gebruiken als klasse voor 
gebruikersobjecten en de bijbehorende *repository* als user provider.

## Authenticatie

Implementeer de interface `AuthenticationInterface` en zorg dat deze 
aangeroepen wordt in de kernel, en dat de gebruiker die door de 
authenticatieservice gevonden wordt als attribuut in het request gezet wordt.

Bedenk dat er twee manieren zijn om een gebruiker te authenticeren. Aan de 
ene kant heb je een *login controller* nodig met bijbehorende route in de 
router. Het gevolg daarvan is dat de gebruikersnaam en wachtwoord 
beschikbaar zijn in het request; maak gebruik van de 
password-hashingfuncties van PHP om het ingevoerde wachtwoord te controleren 
met het wachtwoord dat is opgeslagen in de database.

Als een gebruiker succesvol is ingelogd, is het nodig om de gebruikersnaam in 
de sessie te zetten. Je kan in een later request dan ook in de sessie kijken 
of daar misschien een gebruikersnaam in staat. Als dat zo is, kan je de 
bijbehorende gebruiker uit de database laden en deze teruggeven uit de 
authenticatieservice.

Je kan ook nog een logoutcontroller maken. Hierbij is het slim om de hele 
sessie te wissen; dan is de gebruiker ook meteen uitgelogd. Daarnaast kan je 
een controller voor het registreren van gebruikers maken. Denk er dan wel 
aan dat je het wachtwoord gehasht moet opslaan in de database.