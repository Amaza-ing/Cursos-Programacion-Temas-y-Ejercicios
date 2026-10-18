# **Exercises - Topic 10: Introduction to HTML forms**

## **Instructions:**

Below you will find 8 practical exercises on HTML forms.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create a basic form**

Create a form that contains a text field for the username and a submit button.

<details><summary>Show solution</summary>

```html
<form>
  <label for="username">Nombre:</label>
  <input type="text" id="username" name="username" required />
  <button type="submit">Enviar</button>
</form>
```

</details>

---

### **Exercise 2: Fields with different input types**

Create a form with fields such as email, number and date of birth.

<details><summary>Show solution</summary>

```html
<form>
  <label for="email">Correo electrónico:</label>
  <input type="email" id="email" name="email" required />

  <label for="age">Edad:</label>
  <input type="number" id="age" name="age" min="18" max="99" required />

  <label for="date">Fecha de nacimiento:</label>
  <input type="date" id="date" name="date" required />

  <button type="submit">Enviar</button>
</form>
```

</details>

---

### **Exercise 3: Using `select` and `option`**

Create a form with a drop-down menu to select the city of residence.

<details><summary>Show solution</summary>

```html
<form>
  <label for="city">Ciudad:</label>
  <select id="city" name="city">
    <option value="barcelona">Barcelona</option>
    <option value="madrid">Madrid</option>
    <option value="malaga">Málaga</option>
  </select>
  <button type="submit">Enviar</button>
</form>
```

</details>

---

### **Exercise 4: Using checkboxes**

Create a form with checkboxes to select interests.

<details><summary>Show solution</summary>

```html
<form>
  <label>
    <input type="checkbox" name="interests" value="deporte" /> Deporte
  </label>
  <label>
    <input type="checkbox" name="interests" value="musica" /> Música
  </label>
  <label> <input type="checkbox" name="interests" value="cine" /> Cine </label>

  <button type="submit">Enviar</button>
</form>
```

</details>

---

### **Exercise 5: Using radio buttons**

Create a form with radio buttons to choose marital status.

<details><summary>Show solution</summary>

```html
<form>
  <label><input type="radio" name="status" value="soltero" /> Soltero/a</label>
  <label><input type="radio" name="status" value="casado" /> Casado/a</label>
  <label><input type="radio" name="status" value="otro" /> Otro</label>
  <button type="submit">Enviar</button>
</form>
```

</details>

---

### **Exercise 6: Validations in forms**

Create a form with a user field that requires at least 5 characters.

<details><summary>Show solution</summary>

```html
<form>
  <label for="username">Usuario:</label>
  <input type="text" id="username" name="username" minlength="5" required />
  <button type="submit">Enviar</button>
</form>
```

</details>

---

### **Exercise 7: Group fields with `fieldset`**

Create a form where personal data is grouped with `fieldset`.

<details><summary>Show solution</summary>

```html
<form>
  <fieldset>
    <label for="name">Nombre:</label>
    <input type="text" id="name" name="name" required />
  </fieldset>

  <fieldset>
    <label for="email">Correo electrónico:</label>
    <input type="email" id="email" name="email" required />
  </fieldset>

  <button type="submit">Enviar</button>
</form>
```

</details>

---

### **Exercise 8: Create a complete contact form**

Design a contact form with name, email, message and a send button.

<details><summary>Show solution</summary>

```html
<form>
  <label for="name">Nombre:</label>
  <input type="text" id="name" name="name" required />

  <label for="email">Correo electrónico:</label>
  <input type="email" id="email" name="email" required />

  <label for="message">Mensaje:</label>
  <textarea id="message" name="message" rows="4" cols="50" required></textarea>

  <button type="submit">Enviar</button>
</form>
```

</details>
