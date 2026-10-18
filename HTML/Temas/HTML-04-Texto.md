# **Topic 4: Headings, paragraphs and text in HTML**

## **1. Introduction**

Text is one of the most important elements on any web page. HTML provides several tags to structure text content properly. In this topic, we'll explore headings, paragraphs and other text-related elements in HTML.

---

## **2. Headings in HTML**

Headings (`h1` to `h6`) are used to define titles and subtitles on a web page. They are block elements and play a fundamental role in the content hierarchy.

### **Example of using headings:**

```HTML
<h1>Título Principal</h1>
<h2>Subtítulo Nivel 2</h2>
<h3>Subtítulo Nivel 3</h3>
<h4>Subtítulo Nivel 4</h4>
<h5>Subtítulo Nivel 5</h5>
<h6>Subtítulo Nivel 6</h6>
```

### **Characteristics of headings:**

- `h1` is the main title of the page and should be used only once.
- `h2` to `h6` represent subtitles of decreasing importance.
- They improve accessibility and SEO (search engine optimization).

---

## **3. Paragraphs and line breaks**

Text on a web page is grouped into paragraphs using the `<p>` tag. If you need a line break without starting a new paragraph, you use `<br>`.

### **Example of paragraphs and line breaks:**

```HTML
<p>Este es un párrafo de ejemplo. Se usa para organizar el texto en bloques.</p>
<p>Este es otro párrafo. <br> Aquí se usa un salto de línea dentro del mismo párrafo.</p>
```

### **Characteristics:**

- `<p>` creates a new block of text.
- `<br>` doesn't create a new block, just a line break within the same text.

---

## **4. Other text-related block elements**

Besides headings and paragraphs, there are other useful block elements for structuring text content:

### **Quote blocks (`<blockquote>`)**

Used to highlight long quotations.

```HTML
<blockquote>
    "La educación es el arma más poderosa que puedes usar para cambiar el mundo." - Nelson Mandela
</blockquote>
```

### **Preformatted text (`<pre>`)**

Displays text exactly as formatted, preserving spaces and line breaks.

```HTML
<pre>
Texto con espacios y saltos de línea
    exactamente como fue escrito.
</pre>
```

### **Content divisions (`<div>`)**

Used to group content into blocks with no specific semantic meaning.

```HTML
<div>
    <h2>Sección de Noticias</h2>
    <p>Últimas actualizaciones sobre tecnología y ciencia.</p>
</div>
```

---

[![Text and inline and block elements](https://img.youtube.com/vi/KBw2fd5BbCU/0.jpg)](https://www.youtube.com/watch?v=KBw2fd5BbCU&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **5. Best practices when working with text in HTML**

- Use **headings correctly** to create a hierarchy for the information.
- Don't overuse **line breaks (`<br>`)**; it's better to use paragraphs when needed.
- Use **semantic tags** such as `<blockquote>` and `<pre>` instead of `<div>` when the content calls for it.
- Keep a clear, orderly structure in your code.

---

In the next topic, we'll explore **lists in HTML**, both ordered and unordered, and why they matter for organizing information on a web page.
