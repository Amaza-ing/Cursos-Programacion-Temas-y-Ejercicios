# **Topic 2: Selectors and specificity in CSS**

## **1. Introduction to selectors in CSS**

**Selectors** in CSS let you select HTML elements and apply styles to them. There are several types of selectors, each with a different level of specificity.

### **Example of a basic selector:**

```css
p {
  color: blue;
}
```


This selector applies the color blue to all paragraphs (`<p>`) on the page.

---

## **2. Types of selectors in CSS**

### **1. Basic selectors**

- **Tag selector**: selects elements by their HTML tag.
  ```css
  h1 {
    color: red;
  }
  ```

- **Class selector (`.`)**: selects elements with a specific class.
  ```css
  .highlighted {
    font-weight: bold;
  }
  ```

- **ID selector (`#`)**: selects an element with a unique ID.
  ```css
  #some-id {
    text-align: center;
  }
  ```


### **2. Combinator selectors**

- **Compound selectors**: select elements that match all the selectors used (tag, classes, ID, etc.) at the same time.

  ```css
  div.box.green {
    width: 50px;
    height: 50px;
    color: green;
  }
  ```


  It will only apply to a `<div>` with the classes `box` and `green`.

- **Descendant selector (`espacio`)**: selects elements inside a container.
  ```css
  div p {
    color: green;
  }
  ```

- **Direct child selector (`>`)**: selects only direct children.
  ```css
  div > p {
    font-size: 18px;
  }
  ```

- **Adjacent sibling selector (`+`)**: selects an element that comes immediately after another.
  ```css
  h1 + p {
    font-style: italic;
  }
  ```

- **General sibling selector (`~`)**: selects all sibling elements.
  ```css
  h1 ~ p {
    color: gray;
  }
  ```


### **3. Attribute selectors**

They let you select elements based on their attributes.

```css
input[type="text"] {
  border: 1px solid black;
}
```


### **4. Pseudo-class selectors**

They apply styles when an element is in a specific state.

```css
a:hover {
  color: red;
}
```


### **5. Pseudo-element selectors**

They let you style specific parts of an element.

```css
p::first-letter {
  font-size: 2em;
}
```


### **6. Universal selector**

It applies to all elements. It has the lowest specificity.

```css
* {
  box-sizing: border-box;
}
```


---

## **3. Specificity in CSS**

Specificity determines which CSS rule is applied when there are multiple conflicting rules.

### **Selector priority:**

1. Inline styles (`style=""`) → **Highest**.
2. ID selectors (`#id`).
3. Class selectors (`.clase`), attributes and pseudo-classes (`:hover`).
4. Tag selectors (`elemento`).
5. Inherited and browser styles → **Lowest priority**.

### **Example of specificity:**

```css
p {
  color: blue; /* Baja especificidad (0, 0, 1) */
}

.highlighted {
  color: green; /* Más específica que una etiqueta (0, 1, 0) */
}

#some-id {
  color: red; /* ID tiene mayor especificidad (1, 0, 0) */
}
```


If a `<p>` has the class `highlighted` and the ID `some-id`, the color **red** will be applied, because the ID selector is more specific.

### **Cascade priority:**

If several selectors have the same specificity, the styles of the one that comes last in the code are applied.

```css
.some-class {
  color: red;
}

.some-class {
  color: green;
}

.some-class {
  color: blue;
}
```


Here, the color blue will be applied.

---

[![CSS Selectors](https://img.youtube.com/vi/vwAhrcfUmbE/0.jpg)](https://www.youtube.com/watch?v=vwAhrcfUmbE&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **4. Using `!important`**

The `!important` rule overrides all previous rules, even if they have greater specificity.

```css
p {
  color: blue !important;
}
```


⚠ **Use it sparingly**, as it can make the code hard to maintain. It's best not to use it at all.

---
[![Nested CSS & !important](https://img.youtube.com/vi/9FNDDjs6u7I/0.jpg)](https://www.youtube.com/watch?v=9FNDDjs6u7I&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **5. Best practices for selectors in CSS**

- Use classes instead of IDs for better reusability.
- Keep selectors short and specific.
- Avoid using `!important`.
- Organize styles in a logical order.

---

## **Useful links**

- A game to practice CSS selectors: [flukeout](https://flukeout.github.io/).

---

In the next topic, we will learn about **the box model in CSS**, an essential concept for understanding the layout and spacing of elements on a web page.
