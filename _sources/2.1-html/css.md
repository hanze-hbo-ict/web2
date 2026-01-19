# 2.1 CSS: Introductie

## CSSOM

Waar HTML feitelijk de *data* van onze website is, wordt de *vormgeving* bepaald door de *Cascading Style Sheets* (*CSS*). Om dit voor elkaar te krijgen, maakt de browser behalve een DOM-tree ook een [*CSS-Object-Model*](https://developer.mozilla.org/en-US/docs/Web/Performance/Guides/How_browsers_work#parsing) die voor het renderen van de HTML gebruikt wordt. Let op dat *alles* wat je op het scherm ziet uiteindelijke gestileerd wordt aan de hand van een stylesheet: wanneer je een element niet zelf van een stijl voorziet, wordt de interne stylesheet van de browser gebruikt (zoals te zien is in onderstaande schermafbeelding):

![Wanneer je geen expliciete stijl geeft, wordt de interne stylesheet gebruikt](../images/2.1-opgave.jpeg)


Het proces van laden van de HTML tot het weergeven van de pagina op het scherm doorloopt de onderstaande stappen:

![Het volledige render-proces zoals dat door de browser wordt doorlopen](../images/render-process.jpeg).


```{admonition} Uitgebreide werking van browsers
:class: tip

In webtechnologie 3 gaan we redelijk uitgebreid in op de werking van de browser. Voor de huidige module volstaat het hier wat parate kennis van te hebben.
```

## Selectors en Style-rules

Om onderdelen van onze webpagina van een specifieke stijl te kunnen voorzien, moeten we de browswer natuurlijk laten weten *welk* onderdeel van de DOM we van *welke* stijl willen voorzien. Hiervoor zijn dus twee technieken nodig. Het bepalen van het element uit de DOM doen we met *selectors* en het definiëren van de stijl doen we met *style-rules*.

We kunnen een node in de DOM selecteren op basis van drie eigenschappen: de *naam* van de node, de (waarde van) verschillende *attributen* van die node, of de *positie* van de node binnen de hele DOM-tree. De algemene syntax is als volgt:

- `tagname` selecteert de tags met `tagname`;
- `tagname.classname` selecteert de tags `tagname` waarbij `class="classname"`;
- `tagname[attr='value']` selecteert de tags `tagname` waarbij `attr="value"`.

Zie de onderstaande HTML:

```{code-block} html
---
name: html-demo
linenos: True
---

<html>
    <head>
        <title>DOMdemo</title>
        <link rel="stylesheet" href="./style.css">
    </head>
    <body>
        <div class="container" id="main">
          <h1 lang="NL-nl">Awesome dingen</h1> 
          <p class="container">De beste paragraaf ooit.</p>
        </div>
    </body>
</html>
```

selector | omschrijving
---|---
`div` | Selecteert de `div` die op regel 7 wordt geopend.
`h1` | Selecteert de `h1` op regel 8.
`div.container` | Selecteert dezelfde div, alleen nu op de waarde van het attribuut `class`.
`p.container` | Selecteert de `p` die op regel 9 staat.
`.container` | Selecteert de `div` op regel 7, maar ook de `p` op regel 9; dit omdat er geen specifieke tag vóór de `.` staat.
`h1, p` | Selecteert zowel de `h1` als de `p`.
`div p` | Selecteert de `p` (omdat dat een nakomeling is van de `div`).
`div > p` | Selecteert dezelfde `p`, maar alleen omdat dat een *directe* nakomeling van de `div` is.
`h1[lang]` | Selecteert *elke* `h1` waarbij het attribuut `lang` is ingesteld.
`h1[lang='NL-nl']` | Selecteert *elke* `h1` waarvan het attribuut `lang` de waarde`NL-nl` heeft.





## Media-queries

