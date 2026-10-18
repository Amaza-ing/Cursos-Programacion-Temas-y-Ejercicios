# **Topic 7: Positioning in CSS**

## **1. Introduction to Positioning in CSS**

Positioning in CSS allows you to control the location of elements within a web page. It is defined with the `position` property, which offers different ways to organize elements according to the need of the design.

---

## **2. `position` property and its values**

The `position` property has several values that affect the location of an item in the document flow.

| Value | Description |
| ---------- | ---------------------------------------------------------------------------------------------------------- |
| `static` | Default value. The elements follow the normal flow of the document.                                     |
| `relative` | The element is positioned **relative** to its original location.                                             |
| `absolute` | The element is positioned **relative** to its first ancestor with `position: relative`, `absolute`, or `fixed`. |
| `fixed` | The element remains fixed on the screen regardless of scrolling.                                        |
| `sticky` | The element acts as a relative until a point on the scroll is reached, where it becomes fixed.            |

---

## **3. `position: static` (Default position)**

All elements in HTML have `position: static` by default.

```css
.box {
  position: static;
}
```


Items with `static` follow the normal document flow and do not respond to `top`, `right`, `bottom`, or `left`.

---

## **4. `position: relative` (Relative position)**

Allows you to move an element **from its original position** without affecting nearby elements.

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

Positions an element **absolutely with respect to its first positioned ancestor** (`relative`, `absolute`, `fixed`).

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

Keeps an element fixed on the screen regardless of scrolling.

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


Useful for sticky navigation menus at the top of the page.

---

## **7. `position: sticky` (Sticky Position)**

The element behaves like `relative` until it reaches a point on the scroll, where it becomes `fixed`.

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

| Property | It moves with the scroll | Relating to |
| ---------- | ---------------------- | --------------------------------------- |
| `relative` | Yes | Your original position |
| `absolute` | Yes | Your first ancestor positioned |
| `fixed` | No | The browser window |
| `sticky` | Partially | Its position until it reaches a threshold |

---

[![CSS Positioning](https://img.youtube.com/vi/-BfSfqOHrug/0.jpg)](https://www.youtube.com/watch?v=-BfSfqOHrug&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **9. Good practices in the use of positioning**

- Use `relative` when you need to move elements without affecting others.
- Apply `absolute` only when you have a container positioned.
- Avoid `fixed` on large elements, as they may affect usability.
- Use `sticky` to improve the browsing experience.

---

In the next topic, we'll explore **flexbox layout in CSS**, a powerful technique for arranging elements on a page.
