# **Tema 10: Introducción a los formularios en HTML**

## **1. Introducción**

Los formularios en HTML permiten la interacción del usuario con la página web, capturando información que puede enviarse a un servidor para su procesamiento. Se utilizan en registros, encuestas, búsquedas, entre otros.

---

## **2. Estructura de un formulario con `<form>`**

Un formulario en HTML se define con la etiqueta `<form>` y contiene diferentes elementos para ingresar información.

### **Ejemplo básico de un formulario:**

```html
<form>
  <label for="username">Nombre:</label>
  <input type="text" id="username" name="username" required />

  <button type="submit">Enviar</button>
</form>
```

### **Explicación:**

- `input type="text"`: Campo de texto para ingresar información.
- `button type="submit"`: Botón para enviar el formulario.

---

## **3. Métodos GET vs POST y cuándo usarlos**

Los formularios pueden enviar datos mediante dos métodos:

- **GET**: Envía los datos en la URL. Se usa para formularios de búsqueda o datos no sensibles.
- **POST**: Envía los datos de forma oculta en el cuerpo de la solicitud. Se usa para datos sensibles o formularios grandes.

### **Ejemplo de un formulario con GET:**

```html
<form action="buscar.php" method="GET">
  <input type="text" name="consulta" placeholder="Buscar..." />
  <button type="submit">Buscar</button>
</form>
```

- `action`: Especifica la URL donde se enviarán los datos.
- `method`: Define el método de envío (GET o POST).

### **Ejemplo de un formulario con POST:**

```html
<form action="registro.php" method="POST">
  <input type="text" name="usuario" placeholder="Nombre de usuario" required />
  <input type="password" name="clave" placeholder="Contraseña" required />
  <button type="submit">Registrarse</button>
</form>
```

---

## **4. Campos básicos en formularios**

Los formularios pueden contener diversos tipos de campos para capturar información.

Se puede utilizar el elemento `<label>` para crear una etiqueta que identifique al campo haciendo coincidir el atributo `for` del `<label>` con el `id` del campo. Esto mejora la experiencia de usuario, ya que al hacer click en la etiqueta se podrá editar el campo.

También se pueden envolver un conjunto `<label>`-campo en un `<fieldset>` para estructurar mejor las etiquetas y los campos.

### Atributos importantes:

- `id` identifica de forma única a un campo.
- `name` es el nombre de un campo concreto cuando se envíe el formulario.
- `value` es el valor de ese campo.
- `placeholder` muestra un texto mientras el campo está vacío.

### **Ejemplo de campos básicos:**

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

### **Tipos de entrada en formularios y validaciones**

Además de los campos de texto, existen otros tipos de entradas con validaciones integradas.

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

## **5. Uso de selectores (`<select>`, `<option>`), checkboxes y radio buttons**

Los formularios permiten seleccionar opciones predefinidas mediante listas desplegables, checkboxes y botones de opción.

### **Ejemplo de `select` con opciones:**

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

### **Ejemplo de checkboxes:**

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

### **Ejemplo de radio buttons:**

```html
<form>
  <label><input type="radio" name="accept" value="si" />Acepto</label>
  <label><input type="radio" name="accept" value="no" />No Acepto</label>

  <button type="submit">Enviar</button>
</form>
```

---

## **6. Validaciones básicas en formularios**

HTML ofrece validaciones automáticas mediante atributos como `required`, `pattern`, `minlength` y `maxlength`.

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

## **7. Buenas prácticas en formularios HTML**

- Usar etiquetas `<label>` para mejorar la accesibilidad.
- Aplicar validaciones HTML antes de depender de validaciones en JavaScript.
- Utilizar `placeholder` solo como complemento, no como reemplazo de etiquetas `<label>`.
- Emplear `fieldset` y `legend` para agrupar campos relacionados.
