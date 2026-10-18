# **Topic 6: Typography and Fonts in CSS**

## **1. Introduction to typography in CSS**

Typography is a fundamental aspect of web design, as it affects the readability and aesthetics of a page. CSS lets you define fonts, sizes, spacing and styles to customize the appearance of text.

---

## **2. `font-family` property**

It defines the font of the text. It's a good idea to use a list of fallback fonts.

```css
p {
  font-family: Arial, Helvetica, sans-serif;
}
```


Font types:

- **Serif**: With serifs (Times New Roman, Georgia)
- **Sans-serif**: Without serifs (Arial, Helvetica)
- **Monospace**: Each character has the same width (Courier New, Consolas)
- **Cursive**: Handwritten style (Comic Sans, Pacifico)
- **Fantasy**: Decorative designs (Papyrus, Impact)

---

## **3. Font size with `font-size`**

It sets the size of the text, using different units.

```css
h1 {
  font-size: 24px;
}
```


Recommended units:

- `px`: Pixels (fixed size)
- `em`: Relative to the size of the parent element
- `rem`: Relative to the size of the root (`html`)

Example:

```css
p {
  font-size: 1.5em; /* 1.5 veces el tamaño base */
}
```


---

## **4. Font styles with `font-style` and `font-weight`**

### **`font-style`**

It defines whether the text is normal, italic or oblique.

```css
p {
  font-style: italic;
}
```


### **`font-weight`**

It defines the thickness of the text.

```css
h1 {
  font-weight: bold;
}
```


Common values:

- `normal`
- `bold`
- `lighter`
- `bolder`
- Numbers (`100` to `900`)

Example:

```css
h2 {
  font-weight: 300;
}
```


---

## **5. Text spacing with `letter-spacing` and `line-height`**

### **`letter-spacing`**

Controls the spacing between characters.

```css
p {
  letter-spacing: 2px;
}
```


### **`line-height`**

Controls the space between lines.

```css
p {
  line-height: 1.5;
}
```


---

## **6. Importing external fonts with Google Fonts**

To use an external font, such as those from [Google Fonts](https://fonts.google.com/), you need to import it into the CSS file.

Example with **Roboto**:

```css
@import url("https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap");

body {
  font-family: "Roboto", sans-serif;
}
```


---

[![Typography & Google Fonts](https://img.youtube.com/vi/3L7GkNa0jtc/0.jpg)](https://www.youtube.com/watch?v=3L7GkNa0jtc&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **7. Best practices for typography in CSS**

- Use `rem` or `em` instead of `px` for better accessibility.
- Define fallback fonts in `font-family`.
- Avoid excessive use of decorative fonts.
- Apply a suitable `line-height` to improve readability.
- Use **Google Fonts** or **@font-face** for custom fonts.

---

In the next topic, we will explore **positioning with CSS**, including the differences between relative and absolute positioning, as well as other useful options.
