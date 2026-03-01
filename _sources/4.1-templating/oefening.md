# Oefening

## Een eenvoudige template

Gegeven het onderstaande stukje eenvoudige html:

```html
<h1><?= htmlspecialchars($title) ?></h1>
<p><?= htmlspecialchars($content) ?></p>
```

Schrijf een functie `function render(string $template, array $data): string` die deze html als template meekrijgt (eerste parameter) en een associatieve array (tweede parameter) in de vorm `["title" => "interessante titel", "content" => "allemaal interessante dingen"]`. Maak gebruik van [de methode `extract`](https://www.php.net/manual/en/function.extract.php) om de waarden uit deze array te halen. Let op dat deze functie een *string* teruggeeft, dus niets uitprint. 

Je kunt onderstaande code gebruiken om je realisatie te testen:

```php
<?php
 $template = '?><h1><?= htmlspecialchars($title) ?></h1> <p><?= htmlspecialchars($content) ?></p>';
  $ar = array("title" => "interessante titel", "content" => "allemaal interessante dingen");

  echo render($template, $ar);
```

## Globale variabelen

Voeg nu een variabele `demo = 42;` toe aan de testcode hierboven. Probeer vervolgens die variabele te bruiken in je template, bijvoorbeeld door de code `<p>De waarde van demo is <?= $demo ?>` hieraan toe te voegen.

Je zult zien dat dit niet werkt. Waarom is dat, denk je? Hoe zou je `demo` toch in de template kunnen gebruiken?

## Template compositie

Gegeven de onderstaande twee templates:

```html
<!-- template main.html -->
<html>
<body>
<?= $content ?>
</body>
</html>
```

```html
<!-- template page.html -->
<h1><?= htmlspecialchars($title) ?></h1>
```

Pas je functie `render` aan zodat de template `page` als `content` in de template `main` wordt geïnjecteerd. Render hiervoor *eerst* `page.html` en gebruik de output daarvan als input voor `main`.

## XSS 

Verwijder de call naar `htmlspecialchars` in de tempate hierboven. Gebruik nu de onderstaande array in je call naar `render`:

```php
<?php
  $data = [
    "title" => "<script>alert(1)</script>", 
    "concent" => "allemaal interessante dingen"
  ];
```

Verklaar het resultaat en waarom dit gevaarlijk is. 