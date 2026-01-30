# Kernel

De taak van de webapplicatie is om een HTTP request af te handelen en een 
response te genereren. PHP regelt het omzetten van HTTP requests in 
superglobals en andere invoer voor de applicatie en zal bovendien alle 
uitvoer die de applicatie genereert als response naar de client sturen. 
Diepe kennis van HTTP is hier dus niet voor nodig. Enige kennis van het 
protocol is wel handig, maar dat zal in latere hoofdstukken waar nodig 
besproken worden.

In principe kan een PHP-script de hiervoor besproken flow prima uitvoeren. 
Immers, we hebben al gezien dat als we een php-bestand in de document root 
zetten, we deze kunnen laten uitvoeren door de server. Dit is echter geen 
ideale situatie. We hebben namelijk op deze manier maar weinig controle over 
de applicatie; het wordt ook lastig om, als we dat zouden willen, tests te 
schrijven voor de applicatie. Bovendien zullen we steeds meer features, 
zoals bijvoorbeeld authenticatie, willen schrijven die op meer pagina's 
gebruikt worden en ook hiervoor is het handig een nettere flow te hebben.

In PHP-frameworks als Symfony en Laravel is het gebruikelijk om de component 
die verantwoordelijk is voor het afhandelen van request de *kernel* te 
noemen. Die terminologie zullen we hier ook aanhouden.

## Functie als kernel

We hebben gezien dat Flask requests laat afhandelen door een functie. Deze 
aanpak kunnen we ook in PHP kiezen. We maken bijvoorbeeld een bestand 
`hello_kernel.php` waarin we een functie zetten die als kernel fungeert, zoals 
hieronder. Dit bestand zal normaal gesproken niet in de document root staan, 
maar bijvoorbeeld in een directory `src`.

```php
<?php

function hello_kernel(array $get): string
{
    return "Hello, {$get['name']}!";
}
```

Vervolgens importeren we deze functie in het php-bestand dat wel in de 
document root staat en roepen we deze functie aan.

```php
<?php

require_once __DIR__'/../src/hello_kernel.php';

echo hello_kernel($_GET);
```

In dit voorbeeld worden de GET-parameters ook doorgegeven aan de kernel; dit 
kan natuurlijk ook met andere superglobals. Je ziet ook dat het een 
functie is die een string teruggeeft; de functie zelf regelt dus niet dat de 
uitvoer naar de browser geschreven wordt, dat wordt in het php-bestand in de 
document root gedaan. Op deze manier is de communicatie met de client geheel 
gescheiden van de logica in de kernel.

## Klasse als kernel

Functies zijn niet ideaal om te gebruiken als kernel. Het is handiger om 
hiervoor een object te gebruiken, omdat deze dan interne state kan bijhouden.
Op dit moment is dat nog niet noodzakelijk, maar we zullen later zien dat 
dat handig is. Bovendien zullen we ook nog zien dat we dan de kernel niet 
meer handmatig hoeven te includen maar dat dit automatisch kan.

Bovendien kunnen we nu een interface definiëren waaraan de kernel moet 
voldoen. We zullen nu een voorlopige interface 
`Framework\Kernel\KernelInterface` definiëren; in het volgende hoofdstuk 
wordt deze nog aangepast.

```php
<?php

namespace Framework\Kernel;

interface KernelInterface
{
    public function handle(array $get, array $post): string;
}
```

Deze code zetten we in een bestand `KernelInterface.php` in de directory 
`src/Framework/Kernal`. Hierdoor zal het later mogelijk worden om het 
bestand automatisch te vinden.

We kunnen nu een simpele kernel maken die deze interface gebruikt. Merk op 
dat op dit moment, elk soort pagina zijn eigen kernelimplementatie krijgt 
die aangroepen wordt vanuit een php-bestand in de document root.

```php
<?php

namespace App;

require_once __DIR__.'/../Framework/Kernel/KernelInterface.php';

use Framework\Kernel\KernelInterface;

class HelloKernel implements KernelInterface
{
    public function handle(array $get, array $post): string
    {
        return "Hello, {$get['name']}!";
    }
}
```

Je ziet dat hier de namespace `App` gebruikt is. Het is slim om de 
applicatiespecifieke klassen een andere namespace te geven dan de klassen 
van het framework. Dit bestand `HelloKernel.php` plaats je dan ook in een 
directory `App` in je `src`-directory.

Je kunt deze kernel nu gebruiken door in de document root hier een instantie 
van te maken en deze te gebruiken. Als je deze code bijvoorbeeld in
`hello.php` zet, kan je de pagina tonen via de URL 
`http://localhost:8000/hello.php`.

```php
<?php

require_once __DIR__.'/../src/App/HelloKernel.php';

$kernel = new App\HelloKernel();
echo $kernel->handle($_GET, $_POST);
```

[TODO architectuurplaatje]

[TODO basiskernel, exceptiehandling e.d.]