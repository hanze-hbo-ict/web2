# Opgave

## Template

Deze week werk je aan de templates en de template-engine. Maak in je project een separate directory `templates`, waarin je de html-bestanden zet die je [in week 2 hebt gemaakt](../2.1-html/opdracht.md).

De #router* die je [in week 3 hebt gemaakt](../3.2-routing/interface.md#routerinterface) gaf tot nu toe een *callable* terug. Nu we met templates kunnen werken, is het de bedoeling dat aan call naar de methode `route` een `TemplateEngineInterface` teruggeeft. Zoals je kunt zien heeft deze interface maar één methode: `render`: instanties van klassen die deze interface implementeren moeten dus deze methode hebben, die een string teruggeeft. Het is deze string die de body van de *response* zal gaan vormen.

Maak een klasse `TemplateEngine` die deze interface implementeert. Zorg ervoor dat klasse een logische realisatie heeft van de methode `render`.

