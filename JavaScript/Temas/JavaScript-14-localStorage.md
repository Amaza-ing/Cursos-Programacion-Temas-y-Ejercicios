# **Tema 14: Almacenamiento en el Cliente con `localStorage` y `sessionStorage`**

## **1. Introducción**

El almacenamiento web permite guardar información en el navegador del usuario de manera persistente o temporal sin necesidad de bases de datos. JavaScript ofrece dos opciones principales:

- **`localStorage`**: Guarda datos de forma persistente hasta que el usuario los elimine manualmente o el navegador los borre.
- **`sessionStorage`**: Guarda datos temporalmente, mientras dure la sesión del navegador.

Estos métodos son útiles para almacenar preferencias del usuario, tokens de autenticación, carritos de compra, etc.

---

## **2. `localStorage`: Almacenamiento Persistente**

Si queremos observar el `localStorage` en el navegador podemos hacerlo. Por ejemplo en Chrome, debemos abrir las `Chrome Devtools` (click derecho en la página ➡ inspeccionar), después ir a ➡ Application ➡ Storage ➡ Local Storage.

### **2.1. Guardar un dato en `localStorage`**

```js
localStorage.setItem("username", "Carlos");
```

### **2.2. Obtener un dato de `localStorage`**

```js
const username = localStorage.getItem("username");
console.log(username); // "Carlos"
```

### **2.3. Eliminar un dato específico**

```js
localStorage.removeItem("username");
```

### **2.4. Limpiar todo el `localStorage`**

```js
localStorage.clear();
```

---

## **3. `sessionStorage`: Almacenamiento Temporal**

`sessionStorage` funciona de manera similar a `localStorage`, pero los datos se eliminan cuando se cierra la pestaña o el navegador.

### **3.1. Guardar datos en `sessionStorage`**

```js
sessionStorage.setItem("theme", "dark");
```

### **3.2. Obtener datos de `sessionStorage`**

```js
const theme = sessionStorage.getItem("theme");
console.log(theme); // "dark"
```

### **3.3. Eliminar un dato específico**

```js
sessionStorage.removeItem("theme");
```

### **3.4. Limpiar todo el `sessionStorage`**

```js
sessionStorage.clear();
```

---

## **4. Almacenar Objetos en `localStorage` y `sessionStorage`**

`localStorage` y `sessionStorage` solo almacenan datos en formato de texto. Para guardar objetos, debemos convertirlos a JSON. Para esto podemos usar `JSON.stringify()` y para pasar de nuevo a objeto cuando queramos recoger el valor podemos usar `JSON.parse()`.

### **4.1. Guardar un objeto**

```js
const user = { name: "Ana", age: 30 };
localStorage.setItem("user", JSON.stringify(user));
```

### **4.2. Recuperar un objeto**

```js
const storedUser = JSON.parse(localStorage.getItem("user"));
console.log(storedUser.name); // "Ana"
```

---

[![localStorage & sessionStorage](https://img.youtube.com/vi/vJ4Y6EvucF4/0.jpg)](https://www.youtube.com/watch?v=vJ4Y6EvucF4&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Aplicaciones Prácticas**

### **5.1. Recordar la preferencia de un usuario**

```js
function saveTheme(theme) {
  localStorage.setItem("theme", theme);
}

function loadTheme() {
  const savedTheme = localStorage.getItem("theme") || "light";
  document.body.className = savedTheme;
}

loadTheme();
```

### **5.2. Contador de visitas con `localStorage`**

```js
let visits = localStorage.getItem("visits") || 0;
visits++;
localStorage.setItem("visits", visits);
console.log(`Número de visitas: ${visits}`);
```

---

## **6. Diferencias entre `localStorage` y `sessionStorage`**

| Característica | `localStorage`     | `sessionStorage`       |
| -------------- | ------------------ | ---------------------- |
| Persistencia   | Permanente         | Solo durante la sesión |
| Tamaño máximo  | 5MB aprox.         | 5MB aprox.             |
| Disponibilidad | Todas las pestañas | Solo la pestaña actual |

---

## **7. Conclusión**

El uso de `localStorage` y `sessionStorage` permite mejorar la experiencia del usuario almacenando datos de manera rápida y sencilla sin necesidad de bases de datos. Se debe usar con precaución, ya que los datos son accesibles desde el navegador del usuario y no deben contener información sensible como contraseñas o tokens de seguridad.

En el próximo tema veremos algunas curiosidades y comportamientos extraños en JavaScript.
