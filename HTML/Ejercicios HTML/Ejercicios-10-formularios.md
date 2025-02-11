# **Ejercicios - Tema 10: Introducción a los formularios en HTML**

## **Instrucciones:**

A continuación, encontrarás 10 ejercicios prácticos sobre formularios en HTML. Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear un formulario básico**

Crea un formulario que contenga un campo de texto para el nombre de usuario y un botón de envío.

<details><summary>Mostrar solución</summary>

```html
<form>
  <label for="username">Nombre:</label>
  <input type="text" id="username" name="username" required />
  <button type="submit">Enviar</button>
</form>
```

</details>

---


### **Ejercicio 2: Campos con diferentes tipos de entrada**

Crea un formulario con campos de tipo email, número y fecha de nacimiento.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 3: Uso de `select` y `option`**

Crea un formulario con un menú desplegable para seleccionar la ciudad de residencia.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 4: Uso de checkboxes**

Crea un formulario con casillas de verificación para seleccionar intereses.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 5: Uso de radio buttons**

Crea un formulario con botones de opción para elegir el estado civil.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 6: Validaciones en formularios**

Crea un formulario con un campo de usuario que requiera al menos 5 caracteres.

<details><summary>Mostrar solución</summary>

```html
<form>
  <label for="username">Usuario:</label>
  <input type="text" id="username" name="username" minlength="5" required />
  <button type="submit">Enviar</button>
</form>
```

</details>

---

### **Ejercicio 7: Agrupar campos con `fieldset`**

Crea un formulario donde los datos personales estén agrupados con `fieldset`.

<details><summary>Mostrar solución</summary>

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

### **Ejercicio 8: Crear un formulario de contacto completo**

Diseña un formulario de contacto con nombre, correo, mensaje y un botón de envío.

<details><summary>Mostrar solución</summary>

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
