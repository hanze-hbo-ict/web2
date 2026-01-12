# HTTP

Webservers maken gebruik van het Hypertext Transfer Protocol,
[HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP). Dit is een op
tekst gebaseerd protocol waarin clients, meestal browsers, verzoeken of
requests doen aan een server. De server reageert met een response die door
de browser afgehandeld wordt, bijvoorbeeld door een HTML-pagina te tonen.

De details van het protocol worden in een volgend hoofdstuk nog besproken.
Wat op dit moment belangrijk is om te begrijpen is dat het protocol uitgaat
van losse requests die individueel afgehandeld worden en op protocolniveau
geen relatie met andere requests hebben. We zullen nog zien dat we dit, door
slimme keuzes te maken in hoe de applicatie gebouwd wordt, we dit op
applicatieniveau wel kunnen doen, maar op protocolniveaun zijn alle requests
op zichzelf staand. Deze eigenschap van het HTTP-protocol wordt
*statelessness* genoemd: het protocol houdt geen *state*, of toestand, bij.
Veel andere protocollen houden wel een state bij; protocollen als FTP of SSH
staan een gebruiker toe om bijvoorbeeld van actieve directory te wijzigen;
volgende commando's worden vanuit die directory uitgevoerd.

Een andere relevante eigenschap is dat een enkele gerenderde HTML-pagina
vaak een veelvoud aan requests vereist. De browser heeft immers naast de
HTML van de pagina mogelijk ook stylesheets, afbeeldingen en Javascript
nodig. In veel gevallen worden de HTML-pagina's dynamisch gegenereerd, maar
zijn andere assets statisch aanwezig als bestanden op de webserver en hoeven
requests hiervoor dus niet door PHP afgehandeld te worden.

