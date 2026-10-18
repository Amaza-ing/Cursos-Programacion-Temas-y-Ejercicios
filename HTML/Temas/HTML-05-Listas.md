# **Topic 5: Lists in HTML**

## **1. Introduction**

HTML lists allow you to organize information in an ordered or unordered structure. They are widely used for navigation menus, to-do lists, categories and other organizational elements on a web page.

In HTML there are three types of lists:

- **Unordered lists (`<ul>`)**
- **Ordered lists (`<ol>`)**
- **Description Lists (`<dl>`)**

---

## **2. Unordered lists (`<ul>`)**

Unordered lists present items in no specific order, using bullets or bookmarks by default.

### **Example of unordered list:**

```HTML
<ul>
    <li>Manzana</li>
    <li>Banana</li>
    <li>Naranja</li>
</ul>
```

### **Features:**

- Defined with `<ul>` (unordered list).
- Each list item is defined with `<li>` (list item).
- Bookmark style can be changed with CSS.

---

## **3. Sorted lists (`<ol>`)**

Sorted lists display items in numerical or alphabetical order.

### **Example of ordered list:**

```HTML
<ol>
    <li>Primer paso</li>
    <li>Segundo paso</li>
    <li>Tercer paso</li>
</ol>
```

### **Features:**

- Defined with `<ol>` (ordered list).
- Each item is represented with `<li>`.
- The numbering type can be changed with the `type` attribute (`1`, `A`, `a`, `I`, `i`).

### **Example with different types of numbering:**

```HTML
<ol type="A">
    <li>Opción A</li>
    <li>Opción B</li>
    <li>Opción C</li>
</ol>
```

---

## **4. Nested lists**

Lists can contain other lists within their elements, allowing more complex structures to be created.

### **Nested list example:**

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

### **Features:**

- Lists can be nested within `<li>`.
- `<ul>` can be combined with `<ol>` as needed.

---

## **5. Description Lists (`<dl>`, `<dt>`, `<dd>`)**

Description lists are used to define terms and their respective descriptions.

### **Example description list:**

```HTML
<dl>
    <dt>HTML</dt>
    <dd>Lenguaje de marcado para la creación de páginas web.</dd>

    <dt>CSS</dt>
    <dd>Lenguaje de estilos utilizado para diseñar páginas web.</dd>
</dl>
```

### **Features:**

- Defined with `<dl>` (description list).
- `<dt>` represents the term.
- `<dd>` is the description associated with the term.

---

[![HTML lists](https://img.youtube.com/vi/_eyqw1twuP0/0.jpg)](https://www.youtube.com/watch?v=_eyqw1twuP0&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **6. Good practices when working with lists**

- Use **ordered lists** when the order of the elements is important.
- Use **unordered lists** to group elements without a specific hierarchy.
- Apply **description lists** when terms need to be defined.
- Avoid lists that are too deep or nested to improve readability.
- Use **CSS** to customize the appearance of the lists.

---

In the next topic, we will learn about **Elements, tags and attributes in HTML**.
