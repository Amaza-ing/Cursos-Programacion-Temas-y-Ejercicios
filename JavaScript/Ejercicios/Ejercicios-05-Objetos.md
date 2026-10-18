# **Exercises - Topic 5: Objects in JavaScript**

Below you will find 5 practical exercises on using objects in JavaScript.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create a simple object**

Create an object named `book` that has the following properties: `title`, `author`, and `year`. Display the object in the console.

<details><summary>Show solution</summary>

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

### **Exercise 2: Access to properties**

Using the `book` object from the previous exercise, display the title and author in the console using both dot notation and square bracket notation.

<details><summary>Show solution</summary>

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

### **Exercise 3: Add a method to an object**

Add a method called `getSummary` to the `book` object that returns a string in the format: "[title] was written by [author] in [year]".

<details><summary>Show solution</summary>

```js
book.getSummary = function () {
  return `${this.title} fue escrito por ${this.author} en ${this.year}`;
};

console.log(book.getSummary()); // Salida: Cien años de soledad fue escrito por Gabriel García Márquez en 1967
```

</details>

---

### **Exercise 4: Create an object constructor**

Create a constructor function called `Movie` that takes `title`, `director`, and `year` as parameters and creates an object with those properties. Next, create an instance called `myMovie`.

<details><summary>Show solution</summary>

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

### **Exercise 5: Destructuring objects**

Use destructuring to extract the `title` and `author` properties from the `book` object and display them in the console.

<details><summary>Show solution</summary>

```js
const { title, author } = book;
console.log(title); // Salida: Cien años de soledad
console.log(author); // Salida: Gabriel García Márquez
```

</details>
