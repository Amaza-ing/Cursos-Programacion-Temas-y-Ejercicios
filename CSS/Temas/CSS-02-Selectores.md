# **Topic 2: Selectors and specificity in CSS**

## **1. Introduction to selectors in CSS**

**selectors** in CSS allow you to select HTML elements and apply styles to them. There are several types of selectors, each with different levels of specificity.

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

- **Tag Selector**: Select elements by their HTML tag.
  ```css
  h1 {
    color: red;
  }
  ```

- **Class Selector (`.`)**: Selects items with a specific class.
  ```css
  .highlighted {
    font-weight: bold;
  }
  ```

- **ID Selector (`#`)**: Select an item with a unique ID.
  ```css
  #some-id {
    text-align: center;
  }
  ```


### **2. Combinator selectors**

- **United selectors**: select elements that have the selectors (label, cases, id, etc.) used at the same time.

  ```css
  div.box.green {
    width: 50px;
    height: 50px;
    color: green;
  }
  ```


  It will only apply to an `<div>` with the classes `box` and `green`.

- **Offspring Selector (`espacio`)**: Selects elements within a container.
  ```css
  div p {
    color: green;
  }
  ```

- **Direct child selector (`>`)**: Selects only direct children.
  ```css
  div > p {
    font-size: 18px;
  }
  ```

- **Adjacent sibling selector (`+`)**: Select one item immediately after another.
  ```css
  h1 + p {
    font-style: italic;
  }
  ```

- **General Sibling Selector (`~`)**: Select all sibling elements.
  ```css
  h1 ~ p {
    color: gray;
  }
  ```


### **3. Attribute selectors**

They allow elements to be selected based on their attributes.

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

They allow you to stylize specific parts of an element.

```css
p::first-letter {
  font-size: 2em;
}
```


### **6. Universal selector**

It will apply to all elements. It has the lowest specificity.

```css
* {
  box-sizing: border-box;
}
```


---

## **3. CSS Specificity**

Specificity determines which CSS rule is applied when there are multiple conflicting rules.

### **Selector priority:**

1. Online Styles (`style=""`) → **Higher**.
2. ID selectors (`#id`).
3. Class selectors (`.clase`), attributes and pseudo-classes (`:hover`).
4. Tag selectors (`elemento`).
5. Legacy and Browser Styles → **Less Priority**.

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


If an `<p>` has class `highlighted` and ID `some-id`, the color **red** will be applied due to the greater specificity of the ID selector.

### **Cascade Priority:**

If there are selectors with the same specificity, the styles of the one found last in the code will be applied.

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


Here the blue color will be applied.

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


⚠ **Use sparingly** as it can make the code difficult to maintain. It is advisable not to use it at all.

---
[![nested CSS & !important](https://img.youtube.com/vi/9FNDDjs6u7I/0.jpg)](https://www.youtube.com/watch?v=9FNDDjs6u7I&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **5. Good practices with selectors in CSS**

- Use classes instead of IDs for greater reuse.
- Keep selectors short and specific.
- Avoid using `!important`.
- Organize styles in a logical order.

---

## **Links of Interest.**

- Game to practice with CSS selectors: [flukeout](https://flukeout.github.io/).

---

In the next topic, we will learn about **the box model in CSS**, an essential concept for understanding the layout and spacing of elements on a web page.
