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

De volledige site komt nu in `_build/html` te staan. In tegenstelling tot [mkdocs]() heeft jupyter-book geen ontwikkelserver, dus het is het handigste om in deze directory een servertje op te starten (bijvoorbeeld met python, zoals hieronder), of om een `VirtualHost` te maken in je lokale apache-config. 

```shell
python -m http.server
```

![Het startscherm van het werkboek](images/startup-screen.png)


&copy;2025 Hanze
