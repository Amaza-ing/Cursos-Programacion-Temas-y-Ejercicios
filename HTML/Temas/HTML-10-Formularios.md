# **Topic 10: Introduction to HTML forms**

## **1. Introduction**

Forms in HTML let the user interact with the web page, collecting information that can be sent to a server for processing. They're used for sign-ups, surveys and searches, among other things.

---

## **2. Structure of a form with `<form>`**

An HTML form is defined with the `<form>` tag and contains different elements for entering information.

### **Basic example of a form:**

```html
<form>
  <label for="username">Nombre:</label>
  <input type="text" id="username" name="username" required />

  <button type="submit">Enviar</button>
</form>
```

### **Explanation:**

- `input type="text"`: A text field for entering information.
- `button type="submit"`: A button to submit the form.

---

## **3. GET vs POST methods and when to use them**

Forms can submit data using two methods:

- **GET**: Sends the data in the URL. Used for search forms or non-sensitive data.
- **POST**: Sends the data hidden in the body of the request. Used for sensitive data or large forms.

### **Example of a form with GET:**

```html
<form action="buscar.php" method="GET">
  <input type="text" name="consulta" placeholder="Buscar..." />
  <button type="submit">Buscar</button>
</form>
```

- `action`: Specifies the URL where the data will be sent.
- `method`: Defines the submission method (GET or POST).

### **Example of a form with POST:**

```html
<form action="registro.php" method="POST">
  <input type="text" name="usuario" placeholder="Nombre de usuario" required />
  <input type="password" name="clave" placeholder="Contraseña" required />
  <button type="submit">Registrarse</button>
</form>
```

---

## **4. Basic form fields**

Forms can contain various types of fields to collect information.

You can use the `<label>` element to create a label that identifies a field, by matching the `for` attribute of the `<label>` with the field's `id`. This improves the user experience, since clicking the label lets you edit the field.

You can also wrap a `<label>`-field pair in a `<fieldset>` to give your labels and fields a better structure.

### Important attributes:

- `id` uniquely identifies a field.
- `name` is the name a specific field is sent with when the form is submitted.
- `value` is the value of that field.
- `placeholder` displays some text while the field is empty.

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

### **Input types and validation in forms**

Besides text fields, there are other input types with built-in validation.

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

## **5. Using selects (`<select>`, `<option>`), checkboxes and radio buttons**

Forms let you choose predefined options using drop-down lists, checkboxes and radio buttons.

### **Example of a `select` with options:**

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

### **Example of radio buttons:**

```html
<form>
  <label><input type="radio" name="accept" value="si" />Acepto</label>
  <label><input type="radio" name="accept" value="no" />No Acepto</label>

  <button type="submit">Enviar</button>
</form>
```

---

[![Forms in HTML](https://img.youtube.com/vi/nEW11p_-gMo/0.jpg)](https://www.youtube.com/watch?v=nEW11p_-gMo&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **6. Basic form validation**

HTML provides automatic validation through attributes such as `required`, `pattern`, `minlength` and `maxlength`.

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

## **7. Good practices for HTML forms**

- Use `<label>` tags to improve accessibility.
- Apply HTML validation before relying on JavaScript validation.
- Use `placeholder` only as a complement, not as a replacement for `<label>` tags.
- Use `fieldset` to group related fields.
