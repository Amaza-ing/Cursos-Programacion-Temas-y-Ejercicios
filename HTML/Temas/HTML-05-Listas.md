# **Topic 5: Lists in HTML**

## **1. Introduction**

Lists in HTML let you organize information in an ordered or unordered structure. They are widely used for navigation menus, to-do lists, categories and other organizational elements on a web page.

There are three types of lists in HTML:

- **Unordered lists (`<ul>`)**
- **Ordered lists (`<ol>`)**
- **Description lists (`<dl>`)**

---

## **2. Unordered lists (`<ul>`)**

Unordered lists show their items in no specific order, using bullets or markers by default.

### **Example of an unordered list:**

```HTML
<ul>
    <li>Manzana</li>
    <li>Banana</li>
    <li>Naranja</li>
</ul>
```

### **Characteristics:**

- Defined with `<ul>` (unordered list).
- Each item in the list is defined with `<li>` (list item).
- The marker style can be changed with CSS.

---

## **3. Ordered lists (`<ol>`)**

Ordered lists display their items in numerical or alphabetical order.

### **Example of an ordered list:**

```HTML
<ol>
    <li>Primer paso</li>
    <li>Segundo paso</li>
    <li>Tercer paso</li>
</ol>
```

### **Characteristics:**

- Defined with `<ol>` (ordered list).
- Each item is represented with `<li>`.
- The numbering type can be changed with the `type` attribute (`1`, `A`, `a`, `I`, `i`).

### **Example with a different numbering type:**

```HTML
<ol type="A">
    <li>Opción A</li>
    <li>Opción B</li>
    <li>Opción C</li>
</ol>
```

---

## **4. Nested lists**

Lists can contain other lists inside their items, which lets you build more complex structures.

### **Example of a nested list:**

```HTML
<ul>
    <li>Frutas
        <ul>
            <li>Manzana</li>
            <li>Banana</li>
            <li>Naranja</li>
        </ul>
    </li>
    <li>Verduras
        <ul>
            <li>Zanahoria</li>
            <li>Lechuga</li>
        </ul>
    </li>
</ul>
```

### **Characteristics:**

- Lists can be nested inside `<li>`.
- `<ul>` can be combined with `<ol>` as needed.

---

## **5. Description lists (`<dl>`, `<dt>`, `<dd>`)**

Description lists are used to define terms and their descriptions.

### **Example of a description list:**

```HTML
<dl>
    <dt>HTML</dt>
    <dd>Lenguaje de marcado para la creación de páginas web.</dd>

    <dt>CSS</dt>
    <dd>Lenguaje de estilos utilizado para diseñar páginas web.</dd>
</dl>
```

### **Characteristics:**

- Defined with `<dl>` (description list).
- `<dt>` represents the term.
- `<dd>` is the description associated with the term.

---

[![Lists in HTML](https://img.youtube.com/vi/_eyqw1twuP0/0.jpg)](https://www.youtube.com/watch?v=_eyqw1twuP0&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **6. Good practices when working with lists**

- Use **ordered lists** when the order of the items matters.
- Use **unordered lists** to group items with no specific hierarchy.
- Use **description lists** when you need to define terms.
- Avoid lists that are too deep or heavily nested, to keep them readable.
- Use **CSS** to customize how your lists look.

---

In the next topic, we'll learn about **elements, tags and attributes in HTML**.
