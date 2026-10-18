# **Topic 3: Inline elements and block elements**

## **1. Introduction**

In HTML, elements are divided into two large categories according to their behavior on the web page:

- **Block elements**: They occupy the entire available width and start on a new line.
- **Inline elements**: They only take up the necessary space and do not force a line break.

Understanding this difference is essential to correctly structure a web page and improve its design.

---

## **2. Block elements**

Block elements generate a new block of content on the page. By default, they take up the entire available width and start on a new line.

### **Characteristics of block elements:**

- They expand across the width of their container.
- They start on a new line.
- They can contain other block and inline elements.

### **Common examples:**

- **Headers:** `h1`, `h2`, `h3`, `h4`, `h5`, `h6`
- **Paragraphs:** `p`
- **Lists:** `ul`, `ol`, `li`
- **Divisions or containers:** `div`
- **Structured content boxes:** `section`, `article`, `aside`, `header`, `footer`

### **Practical example:**

Imagine that you are structuring an article on a blog. You will use block elements to separate the sections.

```HTML
<article>
    <h1>Cómo mejorar tu código HTML</h1>
    <p>Es importante seguir buenas prácticas al escribir HTML para mejorar la accesibilidad y el SEO.</p>
</article>
```

In this case:

- `h1` occupies the entire line.
- `p` also generates a separate block.

---

## **3. Inline elements**

Inline elements do not generate a new block of content, but rather remain on the same line with other elements.

### **Characteristics of online elements:**

- They only take up the necessary space.
- They do not generate a line break.
- Can only contain text or inline elements (cannot contain block elements).

### **Common examples:**

- **Links:** `a`
- **Bold and italics:** `strong`, `em`
- **Text format:** `span`, `mark`, `code`
- **Images:** `img`
- **Small buttons within a text:** `button`

### **Practical example:**

Suppose in a blog article we want to highlight a word in bold and link to an important term.

```HTML
<p>Para aprender más sobre HTML, visita <a href="https://developer.mozilla.org/">Mozilla Developer Network</a> y revisa los elementos <strong>semánticos</strong>.</p>
```

In this case:

- `a` is a link that remains on the same line.
- `strong` emphasizes the word without affecting the layout of the text.

---

## **4. Key Differences Between Block and Inline Elements**

| Feature | Block elements | Online elements |
| ---------------------------------------- | ------------------- | --------------------------- |
| Occupies the entire line | Yes | No |
| Start on new line | Yes | No |
| May contain other block elements | Yes | No |
| Common use | Structure and design | Text and link formatting |

---

## **5. Combination of block and inline elements**
It is possible to combine both types of elements in a web design. For example, within an `div` (block), `span` (inline) can be included to highlight certain words.

```HTML
<div>
    <p>En este artículo explicamos la diferencia entre <span style="color:blue;">elementos en línea</span> y <span style="color:red;">elementos en bloque</span>.</p>
</div>
```

In this case:

- `div` is a block element that wraps the entire content.
- `span` is an inline element that allows you to apply styles without altering the structure.

---

[![Text and Elements in Line and in Block](https://img.youtube.com/vi/KBw2fd5BbCU/0.jpg)](https://www.youtube.com/watch?v=KBw2fd5BbCU&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **6. Good practices**

- Use **block elements** to define the structure of the page.
- Use **inline elements** to apply styling or add interactivity without modifying the layout of the content.
- Avoid enclosing block elements within inline elements, as this can cause display errors.
- Leverages HTML5 semantic tags (`section`, `article`, `aside`, etc.) to improve accessibility and search engine optimization (**SEO**).

---

In the next topic, we will learn about **text tags in HTML** and their impact on the structure of a web page.
