# Autoloader

Zoals je nu en eerder gezien hebt is het in PHP nodig om de bestanden waar 
klassen die je wilt gebruiken in staan handmatig te laden met `require_once`.
Dit is anders dan bijvoorbeeld Java, waar het systeem klassen automatisch 
kan vinden omdat de bestandsnamen een standaard formaat hebben.

Het is echter wel mogelijk om PHP zodanig te configureren dat klassen 
automatisch gevonden worden. Dit kan door een
[autoloader](https://www.php.net/manual/en/language.oop5.autoload.php) te 
gebruiken. Een autoloader is een functie die door PHP wordt aangeroepen elke 
keer als PHP een klasse or interface nodig heeft die nog niet gedefinieerd is. 
PHP zal dan de naam van die onbekende klasse meegeven aan de autoloader, en 
het is de taak van de autoloader om te zorgen dat deze klasse geladen wordt, 
bijvoorbeeld door het uitvoeren van een geschikte `require_once`. Om PHP te 
vertellen dat deze functie gebruikt moet worden als autoloader wordt de 
functie
[`spl_autoload_register`](https://www.php.net/manual/en/function.spl-autoload-register.php)
gebruikt. Deze functie geef je één argument mee, een string met de naam van de 
functie die je als autoloader wilt gebruiken.

Dit ziet er ongeveer als volgt uit.

```php
<?php

function autoload(string $class): void
{
    // autoloader
}

spl_register_autoload('autoload.php');
```

Als je deze code in een bestand `autoload.php` in de rootdirectory van je 
project zet, dus buiten de document root, kan je aan het begin van alle 
scripts het commando `require_once __DIR__.'/../autoload.php` zetten zodat de 
autoloader geladen en geïnstalleerd wordt. Het is daarna niet meer nodig om 
handmatig `require_once` te gebruiken om een klasse te laden.

De volgende vraag is wat de inhoud van de functie `autoload` moet zijn. 
Anders gezegd, hoe kan je automatisch bepalen welke klasse in welk bestand 
staat. In Java is dat eenvoudig; zo staat een klasse `nl.hanze.Main` altijd 
in het bestand `nl/hanze/Main.java` in de broncodedirectory van het project. 
Iets vergelijkbaars zullen we hier doen. Hier is al op voorgesorteerd door 
de eerdere keuzes voor bestandsnamen van klassen en interfaces.

We zullen bestanden met klassen en interfaces altijd in de directory `src` 
in het project zetten. Hierdoor staan ze buiten de document root `public` 
zodat ze niet door een browser opgevraagd kunnen worden. Vervolgens zullen 
namespaces corresponderen met directory's en zal de klassenaam de 
bestandsnaam worden, waarbij natuurlijk de extensie `.php` gebruikt wordt. 
Zo zal de interface `Framework\Kernel\KernelInterface` te vinden zijn in het 
bestand `src/Framework/Kernel/KernelInterface.php`.

Hierbij zijn twee dingen 
van belang. In de eerste plaats is het zo dat de directory separator in 
Windows een backslash is, net als de namespace separator in PHP. Hierdoor 
wordt het heel verleidelijk om de autoloader als volgt te implementeren.

```php
function autoload(string $class): void
{
    require_once __DIR__.'\\src\\'.$class.'.php';
}
```

Merk op dat hierboven gesuggereerd is om de autoloader in de root van je 
project te zetten. Dat is de directory waar de constante `__DIR__` naar 
verwijst; omdat de andere PHP-bestanden in de directory `src` staan, moet 
die directory ook worden opgenomen in de aanroep van `require_once` zodat de 
klassen in de juiste directory gezocht worden.

Deze autoloader werkt in principe op Windows-systemen. Bedenk echter dat 
productieomgevingen vaak Linux zijn en veel ontwikkelaars op Linux of macOS 
werken. In die besturingssystemen is de directory separator een slash en zal 
deze code niet werken. Het is dus nodig om de backslashes in de klassenaam 
om te zetten in slashes, of hiervoor zelfs de constante 
`DIRECTORY_SEPARATOR` te gebruiken. Slashes werken overigens ook op Windows, 
dus die optie werkt op alle gangbare besturingssystemen.

Een ander probleem is gelegen in de omstandigheid dat klassenamen in PHP 
*case insensitive* zijn. Dit betekent dat `HelloWorldKernel`, 
`HELLOWORLDKERNEL` en `helloworldkernel` als dezelfde klassen gezien worden. 
De variant die de autoloader krijgt is de variant die als eerste gebruikt 
wordt. Dit is in beginsel geen probleem in Windows en macOS, omdat die 
besturingssystemen normaal gesproken een case instensitive bestandssysteem 
gebruiken. Linux, en dus de meeste productieomgevingen, heeft echter normaal 
gesproken een case sensitivie bestandssysteem. Wordt dus `HelloWorldKernel` 
als eerste aangeroepen dan wordt het bestand `HelloWorldKernel.php` gezocht, 
maar als `helloworldkernel` toevallig het eerste voorkomen van die klasse is,
dan wordt `helloworldkernel.php` gezocht, wat op een Linux-systeem in 
principe niet hetzelfde bestand is. Het is dan ook belangrijk om consistent 
te zijn in hoe je een klassenaam schrijft.
