# **Topic 3: The Box Model in CSS**

## **1. Introduction to the Box Model**

The **Box Model** is a fundamental concept in CSS that describes how elements are represented and organized on a web page. Each HTML element is considered a rectangular box that is made up of four main areas:

1. **Content:** The area where the element's content is displayed, such as text or images.
2. **Padding:** Space between the content and the border of the element.
3. **Border:** Line that surrounds the content and padding.
4. **Margin:** Space between the edge of the element and adjacent elements.

Representation for an element with a content of 500px wide and 20px high, 5px padding, 2px border and 20px top margin and 0px of the rest of the margins:

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
- **border** creates a 5 pixel solid black border.
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

## **4. `box-sizing`: Cash calculation control**

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


Now, the width and height of the element remain at 200x100 pixels, without increasing with padding and border.

---

## **5. Margin and padding properties**

### **Margin (`margin`)**

Defines the external space between an element and adjacent elements.

```css
div {
  margin: 20px; /* Aplica 20px a todos los lados */
}
```


It can be defined individually:

```css
div {
  margin-top: 10px;
  margin-right: 20px;
  margin-bottom: 30px;
  margin-left: 40px;
}
```


You can also use the shortcut:

```css
div {
  margin: 10px 20px 30px 40px; /* top right bottom left */
}
```


### **Padding (`padding`)**

Similar to `margin`, but defines the internal space between the content and the element's border.

```css
div {
  padding: 15px;
}
```


Individual values can be defined:

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

When two elements have consecutive top or bottom margins, they are combined rather than added.

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

## **7. Good practices with the Box Model**

- Use `box-sizing: border-box;` to avoid complicated size calculations.
- Maintain a clear structure with well-defined `margin` and `padding`.
- Avoid negative margins, as they can cause unexpected problems.
- Check margin collapse to avoid visual errors.

---

In the next topic, we will explore **units of measurement in CSS**, including pixels, percentages, em, and rem.
