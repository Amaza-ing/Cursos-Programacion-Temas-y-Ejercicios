# **Topic 3: Inline elements and block elements**

## **1. Introduction**

In HTML, elements are divided into two broad categories according to how they behave on the web page:

- **Block elements**: They take up the full available width and start on a new line.
- **Inline elements**: They only take up the space they need and don't force a line break.

Understanding this difference is essential for structuring a web page correctly and improving its design.

---

## **2. Block elements**

Block elements create a new block of content on the page. By default, they take up the full available width and start on a new line.

### **Characteristics of block elements:**

- They stretch across the full width of their container.
- They start on a new line.
- They can contain other block and inline elements.

### **Common examples:**

- **Headings:** `h1`, `h2`, `h3`, `h4`, `h5`, `h6`
- **Paragraphs:** `p`
- **Lists:** `ul`, `ol`, `li`
- **Divisions or containers:** `div`
- **Structured content boxes:** `section`, `article`, `aside`, `header`, `footer`

### **Practical example:**

Imagine you're structuring a blog article. You'll use block elements to separate the sections.

```HTML
<article>
    <h1>Cómo mejorar tu código HTML</h1>
    <p>Es importante seguir buenas prácticas al escribir HTML para mejorar la accesibilidad y el SEO.</p>
</article>
```

In this case:

- `h1` takes up the whole line.
- `p` also creates a separate block.

---

## **3. Inline elements**

Inline elements don't create a new block of content; instead, they stay on the same line alongside other elements.

### **Characteristics of inline elements:**

- They only take up the space they need.
- They don't create a line break.
- They can only contain text or inline elements (they can't contain block elements).

### **Common examples:**

- **Links:** `a`
- **Bold and italics:** `strong`, `em`
- **Text formatting:** `span`, `mark`, `code`
- **Images:** `img`
- **Small buttons within text:** `button`

### **Practical example:**

Suppose that in a blog article we want to highlight a word in bold and link an important term.

```HTML
<p>Para aprender más sobre HTML, visita <a href="https://developer.mozilla.org/">Mozilla Developer Network</a> y revisa los elementos <strong>semánticos</strong>.</p>
```

In this case:

- `a` is a link that stays on the same line.
- `strong` emphasizes the word without affecting the layout of the text.

---

## **4. Key differences between block and inline elements**

| Feature                                  | Block elements       | Inline elements          |
| ---------------------------------------- | -------------------- | ------------------------ |
| Takes up the whole line                  | Yes                  | No                       |
| Starts on a new line                     | Yes                  | No                       |
| Can contain other block elements         | Yes                  | No                       |
| Common use                               | Structure and design | Text and link formatting |

---

## **5. Combining block and inline elements**

You can combine both types of elements in a web design. For example, inside a `div` (block), you can include `span` elements (inline) to highlight certain words.

```HTML
<div>
    <p>En este artículo explicamos la diferencia entre <span style="color:blue;">elementos en línea</span> y <span style="color:red;">elementos en bloque</span>.</p>
</div>
```

In this case:

- `div` is a block element that wraps all the content.
- `span` is an inline element that lets you apply styles without altering the structure.

---

[![Text and inline and block elements](https://img.youtube.com/vi/KBw2fd5BbCU/0.jpg)](https://www.youtube.com/watch?v=KBw2fd5BbCU&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **6. Good practices**

- Use **block elements** to define the structure of the page.
- Use **inline elements** to apply styles or add interactivity without changing the layout of the content.
- Avoid wrapping block elements inside inline elements, as this can cause display errors.
- Take advantage of HTML5 semantic tags (`section`, `article`, `aside`, etc.) to improve accessibility and search engine optimization (**SEO**).

---

In the next topic, we'll learn about **text tags in HTML** and their impact on the structure of a web page.
