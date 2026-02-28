# Opdracht

## Dependency injection

Pas je applicatie zo aan dat er geen gebruik wordt gemaakt van het 
singleton pattern of andere verborgen afhankelijkheden. Maak deze 
afhankelijkheden expliciet door constructorparamerters toe te voegen en maak 
een composition root die alle objecten in je applicatie op de goede manier 
instantieerd. Maak vervolgens in je front controller gebruik van deze 
composition root om de kernel te instantiëren die je gebruikt om het request 
af te handelen.