# **Ejercicios - Tema 5: Objetos en JavaScript**

A continuación, encontrarás 5 ejercicios prácticos sobre el uso de objetos en JavaScript.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear un objeto simple**

Crea un objeto llamado `book` que tenga las siguientes propiedades: `title`, `author` y `year`. Muestra el objeto en la consola.

<details><summary>Mostrar solución</summary>

```js
const book = {
  title: "Cien años de soledad",
  author: "Gabriel García Márquez",
  year: 1967,
};

console.log(book);
```

</details>

---

### **Ejercicio 2: Acceso a propiedades**

Usando el objeto `book` del ejercicio anterior, muestra en la consola el título y el autor utilizando tanto la notación del punto como la notación de corchetes.

<details><summary>Mostrar solución</summary>

```js
// Notación del punto
console.log(book.title); // Salida: Cien años de soledad
console.log(book.author); // Salida: Gabriel García Márquez

// Notación de corchetes
console.log(book["title"]); // Salida: Cien años de soledad
console.log(book["author"]); // Salida: Gabriel García Márquez
```

</details>

---

### **Ejercicio 3: Agregar un método a un objeto**

Agrega un método llamado `getSummary` al objeto `book` que retorne una cadena con el formato: "[title] fue escrito por [author] en [year]".

<details><summary>Mostrar solución</summary>

```js
book.getSummary = function () {
  return `${this.title} fue escrito por ${this.author} en ${this.year}`;
};

console.log(book.getSummary()); // Salida: Cien años de soledad fue escrito por Gabriel García Márquez en 1967
```

</details>

---

### **Ejercicio 4: Crear un constructor de objetos**

Crea una función constructora llamada `Movie` que reciba `title`, `director` y `year` como parámetros y cree un objeto con esas propiedades. Luego, crea una instancia llamada `myMovie`.

<details><summary>Mostrar solución</summary>

```js
function Movie(title, director, year) {
  this.title = title;
  this.director = director;
  this.year = year;
}

const myMovie = new Movie("El Padrino", "Francis Ford Coppola", 1972);
console.log(myMovie);
```

</details>

---

### **Ejercicio 5: Desestructuración de objetos**

Usa la desestructuración para extraer las propiedades `title` y `author` del objeto `book` y muéstralas en la consola.

<details><summary>Mostrar solución</summary>

```js
const { title, author } = book;
console.log(title); // Salida: Cien años de soledad
console.log(author); // Salida: Gabriel García Márquez
```

</details>
