# **Topic 3: The Box Model in CSS**

## **1. Introduction to the Box Model**

The **Box Model** is a fundamental concept in CSS that describes how elements are represented and organized on a web page. Every HTML element is treated as a rectangular box made up of four main areas:

1. **Content:** The area where the element's content is displayed, such as text or images.
2. **Padding:** The space between the content and the border of the element.
3. **Border:** The line that surrounds the content and the padding.
4. **Margin:** The space between the border of the element and adjacent elements.

This is how an element with content 500px wide and 20px high, 5px of padding, a 2px border, a 20px top margin and 0px for the other margins is represented:

![Box Model](https://raw.githubusercontent.com/Amaza-ing/Cursos-Programacion-Temas-y-Ejercicios/master/CSS/Assets/box-model.png "Box Model")

---

## **2. Parts of the Box Model**

Each box in CSS follows this structure:

```css
div {
  width: 200px;
  height: 100px;
  padding: 10px;
  border: 5px solid black;
  margin: 20px;
}
```


In this case:

- **width** and **height** define the size of the content.
- **padding** adds internal space around the content.
- **border** creates a solid black 5-pixel border.
- **margin** separates the element from the others.

---

## **3. How to calculate the total size of a box**

The total size of an element is calculated by adding:

```
Ancho total = width + padding izquierdo + padding derecho + border izquierdo + border derecho + margin izquierdo + margin derecho
```


```
Alto total  = height + padding superior + padding inferior + border superior + border inferior + margin superior + margin inferior
```


**Example:**

```css
div {
  width: 200px;
  height: 100px;
  padding: 10px;
  border: 5px solid black;
  margin: 20px;
}
```


The total size would be:

- **Total width:** 200 + 10 + 10 + 5 + 5 + 20 + 20 = 270px
- **Total height:** 100 + 10 + 10 + 5 + 5 + 20 + 20 = 170px

---

## **4. `box-sizing`: Controlling how the box size is calculated**

By default, CSS calculates the size of elements without including the border and padding. However, with `box-sizing: border-box;`, the width and height include the padding and border.

```css
div {
  width: 200px;
  height: 100px;
  padding: 10px;
  border: 5px solid black;
  box-sizing: border-box;
}
```


Now the width and height of the element stay at 200x100 pixels: the padding and the border don't make it any bigger.

---

## **5. Margin and padding properties**

### **Margin (`margin`)**

It defines the outer space between an element and the elements next to it.

```css
div {
  margin: 20px; /* Aplica 20px a todos los lados */
}
```


It can be set for each side individually:

```css
div {
  margin-top: 10px;
  margin-right: 20px;
  margin-bottom: 30px;
  margin-left: 40px;
}
```


You can also use the shorthand:

```css
div {
  margin: 10px 20px 30px 40px; /* top right bottom left */
}
```


### **Padding (`padding`)**

Similar to `margin`, but it defines the inner space between the content and the element's border.

```css
div {
  padding: 15px;
}
```


You can set individual values:

```css
div {
  padding-top: 5px;
  padding-right: 10px;
  padding-bottom: 15px;
  padding-left: 20px;
}
```


or

```css
div {
  padding: 5px 10px 15px 20px; /* top right bottom left */
}
```


---

## **6. Margin collapse**

When two elements have adjoining top or bottom margins, the margins are combined instead of added together.

Example:

```css
div {
  margin-bottom: 20px;
}
p {
  margin-top: 30px;
}
```


In this case, the resulting margin between the two elements will be 30px, not 50px.

---

[![Box Model](https://img.youtube.com/vi/k6p6vJLQfFE/0.jpg)](https://www.youtube.com/watch?v=k6p6vJLQfFE&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **7. Best practices with the Box Model**

- Use `box-sizing: border-box;` to avoid complicated size calculations.
- Keep a clear structure with well-defined `margin` and `padding`.
- Avoid negative margins, as they can cause unexpected problems.
- Keep an eye on margin collapse to avoid visual errors.

---

In the next topic, we will explore **units of measurement in CSS**, including pixels, percentages, em, and rem.
