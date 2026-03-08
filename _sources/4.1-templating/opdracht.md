# Opdracht

## Template

Deze week werk je aan de templates en de template-engine. Maak in je project een separate directory `templates`, waarin je de html-bestanden zet die je [in week 2 hebt gemaakt](../2.1-html/opdracht.md).

De *router* die je
[in week 3 hebt gemaakt](../3.2-routing/interface.md#routerinterface) geeft 
een *callable* terug. Dit is de controller. Nu we een template engine 
hebben, kunnen we deze controller hiervan gebruik laten maken, waardoor de 
presentatie gescheiden wordt van de logica. De flow van de controller zal nu 
in het algemeen zo worden dat eerst de relevante domeinlogica wordt 
uitgevoerd, en hieruit een aantal waarden volgen die in een template 
gerenderd worden. De template engine geeft die je hiervoor gebruikt geeft 
een string terug die de body van de *response* zal gaan vormen.

Maak een klasse `TemplateEngine` die de interface `TemplateEngineInterface` 
implementeert. Zorg ervoor 
dat klasse een logische realisatie heeft van de methode `render`.

