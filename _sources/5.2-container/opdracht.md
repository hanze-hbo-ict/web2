# Opdracht

## IoC container

Op dit moment gebruik je handmatige dependency injection om je objectgraaf 
te bouwen. Een vervolgstap is het gebruik van een IoC container om 
dependency injection te automatiseren.

De IoC container maakt gebruik van de interface
`Psr\Container\ContainerInterface` uit
[PSR-11](https://www.php-fig.org/psr/psr-11). Deze interface beschrijft 
echter alleen hoe je een object kan verkrijgen uit een al geconfigureerde 
container, maar niet hoe de container geconfigureerd kan worden.

Implementeer een IoC container die de PSR-11-interface implementeert en 
bedenk hoe je deze kan configureren. Je kan hierbij de besproken technieken 
en algoritmes gebruiken om met behulp van reflectie autowiring toe te passen,
of je kan voor een andere aanpak kiezen.