# **Topic 4: Headings, paragraphs and text in HTML**

## **1. Introduction**

Text is one of the most important elements on any web page. HTML provides various tags to structure textual content appropriately. In this topic, we will explore headings, paragraphs, and other text-related elements in HTML.

---

## **2. HTML headers**

Headers (`h1` to `h6`) are used to define titles and subtitles on a web page. They are block elements and play a fundamental role in the content hierarchy.

### **Example of using headers:**

```HTML
<h1>Título Principal</h1>
<h2>Subtítulo Nivel 2</h2>
<h3>Subtítulo Nivel 3</h3>
<h4>Subtítulo Nivel 4</h4>
<h5>Subtítulo Nivel 5</h5>
<h6>Subtítulo Nivel 6</h6>
```

### **Header characteristics:**

- `h1` is the main title of the page and should be used only once.
- `h2` to `h6` represent subtitles with lower importance.
- They improve accessibility and SEO (search engine optimization).

---

## **3. Paragraphs and line breaks**

Text within a web page is grouped into paragraphs using the `<p>` tag. If a line break is needed without starting a new paragraph, `<br>` is used.

### **Example of paragraphs and line breaks:**

```HTML
<p>Este es un párrafo de ejemplo. Se usa para organizar el texto en bloques.</p>
<p>Este es otro párrafo. <br> Aquí se usa un salto de línea dentro del mismo párrafo.</p>
```

### **Features:**

- `<p>` generates a new text block.
- `<br>` does not generate a new block, only a line break within the same text.

---

## **4. Other text-related block elements**

In addition to headings and paragraphs, there are other useful block elements for structuring textual content:

### **Appointment Blocks (`<blockquote>`)**

Used to highlight long text quotes.

```HTML
<blockquote>
    "La educación es el arma más poderosa que puedes usar para cambiar el mundo." - Nelson Mandela
</blockquote>
```

### **Preformatted (`<pre>`)**

Displays text with predefined format, respecting spaces and line breaks.

```HTML
<pre>
Texto con espacios y saltos de línea
    exactamente como fue escrito.
</pre>
```

### **Content divisions (`<div>`)**

It is used to group content into blocks without a specific semantic meaning.

```HTML
<div>
    <h2>Sección de Noticias</h2>
    <p>Últimas actualizaciones sobre tecnología y ciencia.</p>
</div>
```

---

[![Text and Elements in Line and in Block](https://img.youtube.com/vi/KBw2fd5BbCU/0.jpg)](https://www.youtube.com/watch?v=KBw2fd5BbCU&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **5. Best practices when working with HTML text**

- Use **headers correctly** to prioritize the information.
- Do not abuse **line breaks (`<br>`)**, it is better to use paragraphs when necessary.
- Use **semantic tags** such as `<blockquote>` and `<pre>` instead of `<div>` when the content requires it.
- Maintain a clear and orderly structure in the code.

---

In the next topic, we will explore HTML lists, both ordered and unordered, and their importance in organizing information on a web page.
