# **Topic 7: Positioning in CSS**

## **1. Introduction to positioning in CSS**

Positioning in CSS lets you control where elements are placed on a web page. It is set with the `position` property, which offers different modes for arranging elements depending on what the design needs.

---

## **2. `position` property and its values**

The `position` property has several values that affect the location of an element in the document flow.

| Value | Description |
| ---------- | ---------------------------------------------------------------------------------------------------------- |
| `static` | Default value. The elements follow the normal flow of the document.                                     |
| `relative` | The element is positioned **relative** to its original location.                                             |
| `absolute` | The element is positioned **relative** to its first ancestor with `position: relative`, `absolute`, or `fixed`. |
| `fixed` | The element remains fixed on the screen regardless of scrolling.                                        |
| `sticky` | The element behaves as relative until a certain scroll point is reached, where it becomes fixed.            |

---

## **3. `position: static` (Default position)**

All elements in HTML have `position: static` by default.

```css
.box {
  position: static;
}
```


Elements with `static` follow the normal document flow and do not respond to `top`, `right`, `bottom`, or `left`.

---

## **4. `position: relative` (Relative position)**

It lets you move an element **from its original position** without affecting nearby elements.

```css
.box {
  position: relative;
  top: 20px;
  left: 30px;
}
```


The element will be shifted 20px down and 30px to the right from its initial position.

---

## **5. `position: absolute` (Absolute position)**

It positions an element **absolutely, relative to its first positioned ancestor** (`relative`, `absolute`, `fixed`).

```css
.container {
  position: relative;
}

.box {
  position: absolute;
  top: 10px;
  left: 20px;
}
```


If `.container` did not have `position: relative`, `.box` would be positioned relative to `body`.

---

## **6. `position: fixed` (Fixed position)**

It keeps an element fixed on the screen regardless of scrolling.

```css
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  background-color: black;
  color: white;
}
```


Useful for fixed navigation menus at the top of the page.

---

## **7. `position: sticky` (Sticky position)**

The element behaves like `relative` until it reaches a certain scroll point, where it becomes `fixed`.

```css
.header {
  position: sticky;
  top: 0;
  background-color: yellow;
}
```


Useful for section titles or table headings.

---

## **8. Key differences between `relative`, `absolute`, `fixed` and `sticky`**

| Property | Moves when scrolling | Relative to |
| ---------- | ---------------------- | --------------------------------------- |
| `relative` | Yes | Its original position |
| `absolute` | Yes | Its first positioned ancestor |
| `fixed` | No | The browser window |
| `sticky` | Partially | Its position until it reaches a threshold |

---

[![CSS Positioning](https://img.youtube.com/vi/-BfSfqOHrug/0.jpg)](https://www.youtube.com/watch?v=-BfSfqOHrug&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **9. Best practices for positioning**

- Use `relative` when you need to move elements without affecting others.
- Apply `absolute` only when there is a positioned container.
- Avoid `fixed` on large elements, as it can hurt usability.
- Use `sticky` to improve the browsing experience.

---

In the next topic, we'll explore **layout with flexbox in CSS**, a powerful technique for arranging elements on a page.
