# Repository voor Webtechnologie 2

## Opstarten

We adviseren gebruik te maken van een [virtuele omgeving](https://virtualenv.pypa.io/). Installeer de dependencies op basis van het bijgeleverde `requirements.txt`-document.

```shell
python -m pip install -r requirements.txt
```

Je kan nu de boel bouwen:

```shell
jupyter-book build .
```

De volledige site komt nu in `_build/html/` te staan. In tegenstelling tot bijvoorbeeld [mkdocs](https://www.mkdocs.org/) heeft jupyter-book geen ontwikkelserver, dus het is het handigste om in deze directory een servertje op te starten, bijvoorbeeld met python, zoals hieronder; of, wat gegeven het onderwerp van dit thema logischer is, php – zie eveneens hieronder.

__python:__ 

```shell
python -m http.server
```

__php:__

```shell
php -S localhost:8000
```

Je kunt natuurlijk ook je eigen apache-omgeving opzetten en een `VirtualHost` maken in je lokale apache-config. Bekijk [deze link om te zien hoe je dat doet](https://httpd.apache.org/docs/2.4/vhosts/examples.html). Of een andere optie is natuurlijk [werken met nginx](https://www.paralleldevs.com/blog/creating-virtual-host-nginx-step-step-guide/). Keuzes, keuzes...

In deze repo vind je ook een ruby-scriptje `watch.rb` waarmee je het bouwen van de site en verversen van Chrome telkens wanneer je een markdown-bestand aanpast kunt automatiseren (Ruby, en een stukje AppleScript, want dat is ook wel weer eens leuk om te schrijven). Start de server op in de `_build/html`-directory en start dit ruby-scriptje op:

```shell
ruby watch.rb . localhost
```

Dit scriptje kijkt nu recursief naar alle `.md`-bestanden in de huidige directory. Als één van die bestanden aangepast is bouwt het de site opnieuw en herlaadt de pagina in Chrome.

![Het startscherm van het werkboek](images/startup-screen.png)


![](images/logo-hanze.png) &copy;2026 Hanze
