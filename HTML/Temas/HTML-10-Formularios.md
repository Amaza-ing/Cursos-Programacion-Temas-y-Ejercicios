# **Topic 10: Introduction to HTML forms**

## **1. Introduction**

HTML forms allow user interaction with the web page, capturing information that can be sent to a server for processing. They are used in records, surveys, searches, among others.

---

## **2. Structure of a form with `<form>`**

An HTML form is defined with the `<form>` tag and contains different elements to enter information.

### **Basic example of a form:**

```html
<form>
  <label for="username">Nombre:</label>
  <input type="text" id="username" name="username" required />

  <button type="submit">Enviar</button>
</form>
```

### **Explanation:**

- `input type="text"`: Text field to enter information.
- `button type="submit"`: Button to send the form.

---

## **3. GET vs POST methods and when to use them**

Forms can submit data using two methods:

- **GET**: Send the data in the URL. Used for search forms or non-sensitive data.
- **POST**: Sends the data hidden in the body of the request. Used for sensitive data or large forms.

### **Example of a form with GET:**

```html
<form action="buscar.php" method="GET">
  <input type="text" name="consulta" placeholder="Buscar..." />
  <button type="submit">Buscar</button>
</form>
```

- `action`: Specifies the URL where the data will be sent.
- `method`: Defines the sending method (GET or POST).

### **Example of a form with POST:**

```html
<form action="registro.php" method="POST">
  <input type="text" name="usuario" placeholder="Nombre de usuario" required />
  <input type="password" name="clave" placeholder="Contraseña" required />
  <button type="submit">Registrarse</button>
</form>
```

---

## **4. Basic fields in forms**

Forms can contain various types of fields to capture information.

The `<label>` element can be used to create a label that identifies the field by matching the `for` attribute of the `<label>` with the `id` of the field. This improves the user experience, since clicking on the label allows you to edit the field.

You can also wrap an `<label>`-field set into an `<fieldset>` to better structure the tags and fields.

### Important attributes:

- `id` uniquely identifies a field.
- `name` is the name of a specific field when the form is submitted.
- `value` is the value of that field.
- `placeholder` displays a text while the field is empty.

### **Example of basic fields:**

```html
<form>
  <fieldset>
    <label for="username">Nombre:</label>
    <input
      type="text"
      id="username"
      name="username"
      placeholder="Tu nombre aquí"
      required
    />
  </fieldset>
  <fieldset>
    <label for="message">Mensaje:</label>
    <textarea id="message" name="message" rows="4" cols="50"></textarea>
  </fieldset>

  <button type="submit">Enviar</button>
</form>
```

### **Input types in forms and validations**

In addition to text fields, there are other types of entries with built-in validations.

```html
<form>
  <label for="email">Correo electrónico:</label>
  <input type="email" id="email" name="email" required />

  <label for="password">Contraseña:</label>
  <input type="password" id="password" name="password" required />

  <label for="age">Edad:</label>
  <input type="number" id="age" name="age" min="18" max="99" required />

  <label for="date">Fecha de nacimiento:</label>
  <input type="date" id="date" name="date" required />

  <button type="submit">Enviar</button>
</form>
```

---

## **5. Use of selectors (`<select>`, `<option>`), checkboxes and radio buttons**

Forms allow you to select predefined options using drop-down lists, checkboxes, and radio buttons.

### **`select` example with options:**

```html
<form>
  <label for="country">Selecciona tu país:</label>
  <select id="country" name="country">
    <option value="es">España</option>
    <option value="mx">México</option>
    <option value="ar">Argentina</option>
  </select>
  <button type="submit">Enviar</button>
</form>
```

### **Example of checkboxes:**

```html
<form>
  <label>
    <input type="checkbox" name="interests" value="deporte" /> Deportes
  </label>
  <label>
    <input type="checkbox" name="interests" value="musica" /> Música
  </label>
  <label><input type="checkbox" name="interests" value="cine" /> Cine </label>

  <button type="submit">Enviar</button>
</form>
```

### **Radio buttons example:**

```html
<form>
  <label><input type="radio" name="accept" value="si" />Acepto</label>
  <label><input type="radio" name="accept" value="no" />No Acepto</label>

  <button type="submit">Enviar</button>
</form>
```

---

[![HTML forms](https://img.youtube.com/vi/nEW11p_-gMo/0.jpg)](https://www.youtube.com/watch?v=nEW11p_-gMo&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **6. Basic validations in forms**

HTML provides automatic validations using attributes such as `required`, `pattern`, `minlength`, and `maxlength`.

```html
<form>
  <label for="user">Usuario (mín. 5 caracteres):</label>
  <input type="text" id="user" name="user" minlength="5" required />

  <label for="password">
    Contraseña (mín. 8 caracteres, solo letras y números):
  </label>
  <input
    type="password"
    id="password"
    name="password"
    pattern="[A-Za-z0-9]{8,}"
    required
  />

  <button type="submit">Enviar</button>
</form>
```

---

## **7. Good practices in HTML forms**

- Use `<label>` tags to improve accessibility.
- Apply HTML validations before relying on JavaScript validations.
- Use `placeholder` only as a complement, not as a replacement for `<label>` tags.
- Use `fieldset` to group related fields.
