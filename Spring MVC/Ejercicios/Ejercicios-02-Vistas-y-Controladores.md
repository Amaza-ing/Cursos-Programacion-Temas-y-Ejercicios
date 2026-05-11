# Ejercicios Tema 2: Mapeos, controladores y vistas en Spring MVC

## Introducción

En estos ejercicios vas a practicar los contenidos principales del **Tema 2**:

- Configuración de Spring MVC con anotaciones.
- Uso de `@Controller`.
- Uso de `@GetMapping`, `@RequestMapping` y `@RequestParam`.
- Envío de datos desde el controlador a la vista mediante `Model`.
- Creación de clases de modelo.
- Creación de servicios sencillos.
- Creación de vistas JSP.
- Uso de JSTL para recorrer listas.
- Uso de rutas relativas con `${pageContext.request.contextPath}`.

Los ejercicios son parecidos a los vistos en el tema, pero usan otros ejemplos para que puedas practicar sin copiar exactamente el proyecto del curso.

Cada solución está oculta bajo el botón **mostrar solución**.

---

# Ejercicio 1 — Activar controladores con anotaciones

## Enunciado

Partimos de un proyecto Spring MVC que ya tiene configurado `web.xml` y `DispatcherServlet`.

Crea o modifica el archivo:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

para que Spring MVC pueda trabajar con controladores anotados con `@Controller`.

La configuración debe:

1. Activar el soporte de Spring MVC con anotaciones.
2. Escanear el paquete base `com.example.library`.
3. Configurar un `InternalResourceViewResolver`.
4. Servir recursos estáticos desde `/resources/`.

<details>
<summary>mostrar solución</summary>

```xml
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="
          http://www.springframework.org/schema/beans
          https://www.springframework.org/schema/beans/spring-beans.xsd
          http://www.springframework.org/schema/mvc
          https://www.springframework.org/schema/mvc/spring-mvc.xsd
          http://www.springframework.org/schema/context
          https://www.springframework.org/schema/context/spring-context.xsd">

    <!-- Activa el soporte de Spring MVC basado en anotaciones -->
    <mvc:annotation-driven />

    <!-- Busca automáticamente clases anotadas como @Controller o @Service -->
    <context:component-scan base-package="com.example.library" />

    <!-- Resolución de vistas JSP -->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/views/" />
        <property name="suffix" value=".jsp" />
    </bean>

    <!-- Recursos estáticos -->
    <mvc:resources mapping="/resources/**" location="/resources/" />

</beans>
```

### Explicación

La línea:

```xml
<mvc:annotation-driven />
```

activa el soporte necesario para que Spring MVC pueda trabajar con métodos anotados.

La línea:

```xml
<context:component-scan base-package="com.example.library" />
```

permite que Spring encuentre automáticamente clases como:

```java
@Controller
public class HomeController {
}
```

El `ViewResolver` convierte nombres lógicos de vista en archivos JSP reales. Por ejemplo:

```java
return "home";
```

se convierte en:

```text
/WEB-INF/views/home.jsp
```

</details>

---

# Ejercicio 2 — Crear un controlador de inicio

## Enunciado

Crea un controlador llamado `HomeController` en el paquete:

```text
com.example.library.controller
```

Debe responder a estas dos rutas:

```text
/
```

y:

```text
/home
```

El controlador debe enviar a la vista los siguientes datos:

| Nombre del atributo | Valor                                            |
| ------------------- | ------------------------------------------------ |
| `pageTitle`         | `Bienvenido a la biblioteca`                     |
| `message`           | `Aplicación de gestión de libros con Spring MVC` |

La vista que debe devolver se llamará:

```text
home
```

<details>
<summary>mostrar solución</summary>

```java
package com.example.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping({"/", "/home"})
    public String home(Model model) {
        model.addAttribute("pageTitle", "Bienvenido a la biblioteca");
        model.addAttribute("message", "Aplicación de gestión de libros con Spring MVC");

        return "home";
    }
}
```

### Explicación

La anotación:

```java
@Controller
```

indica que la clase es un controlador de Spring MVC.

La anotación:

```java
@GetMapping({"/", "/home"})
```

indica que el método responde a dos rutas distintas.

El objeto `Model` permite enviar datos desde el controlador hasta la vista:

```java
model.addAttribute("pageTitle", "Bienvenido a la biblioteca");
```

Después, en la JSP, se podrá mostrar con:

```jsp
${pageTitle}
```

El método devuelve:

```java
return "home";
```

Spring buscará la vista:

```text
/WEB-INF/views/home.jsp
```

</details>

---

# Ejercicio 3 — Crear la vista `home.jsp`

## Enunciado

Crea la vista:

```text
src/main/webapp/WEB-INF/views/home.jsp
```

La página debe:

1. Usar codificación UTF-8.
2. Mostrar el título recibido desde el controlador.
3. Mostrar el mensaje recibido desde el controlador.
4. Tener un enlace hacia `/books`.
5. Cargar el archivo CSS desde `/resources/css/styles.css`.

<details>
<summary>mostrar solución</summary>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            ${message}
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/books">
                Ver libros disponibles
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación

La línea:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
```

ayuda a que se muestren correctamente tildes y eñes.

El título se muestra con:

```jsp
${pageTitle}
```

y el mensaje con:

```jsp
${message}
```

Ambos valores vienen del controlador.

El enlace usa:

```jsp
${pageContext.request.contextPath}
```

para que funcione aunque la aplicación se despliegue con un nombre de contexto, por ejemplo:

```text
/library-app
```

</details>

---

# Ejercicio 4 — Crear una clase de modelo `Book`

## Enunciado

Crea una clase llamada `Book` en el paquete:

```text
com.example.library.model
```

La clase debe tener estos atributos:

| Atributo | Tipo     |
| -------- | -------- |
| `id`     | `Long`   |
| `title`  | `String` |
| `author` | `String` |
| `year`   | `int`    |

Debe tener:

1. Constructor con todos los campos.
2. Getters para todos los campos.

No hace falta añadir setters en este ejercicio.

<details>
<summary>mostrar solución</summary>

```java
package com.example.library.model;

public class Book {

    private Long id;
    private String title;
    private String author;
    private int year;

    public Book(Long id, String title, String author, int year) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.year = year;
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public int getYear() {
        return year;
    }
}
```

### Explicación

Esta clase representa un libro.

Por ejemplo, podremos crear un objeto así:

```java
new Book(1L, "La isla del tesoro", "Robert Louis Stevenson", 1883);
```

Los getters son importantes porque las JSP podrán acceder a las propiedades del objeto.

Por ejemplo, si la vista recibe un objeto llamado `book`, podremos escribir:

```jsp
${book.title}
```

Internamente, JSP llamará a:

```java
getTitle()
```

</details>

---

# Ejercicio 5 — Crear un servicio de libros

## Enunciado

Crea una clase llamada `BookService` en el paquete:

```text
com.example.library.service
```

Debe estar anotada con `@Service`.

La clase debe tener una lista fija de libros y dos métodos:

```java
List<Book> findAll()
```

y:

```java
Book findById(Long id)
```

Usa al menos cuatro libros distintos.

<details>
<summary>mostrar solución</summary>

```java
package com.example.library.service;

import com.example.library.model.Book;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookService {

    private final List<Book> books = List.of(
            new Book(1L, "La isla del tesoro", "Robert Louis Stevenson", 1883),
            new Book(2L, "Frankenstein", "Mary Shelley", 1818),
            new Book(3L, "Orgullo y prejuicio", "Jane Austen", 1813),
            new Book(4L, "El hobbit", "J. R. R. Tolkien", 1937)
    );

    public List<Book> findAll() {
        return books;
    }

    public Book findById(Long id) {
        return books.stream()
                .filter(book -> book.getId().equals(id))
                .findFirst()
                .orElse(null);
    }
}
```

### Explicación

La anotación:

```java
@Service
```

indica que esta clase pertenece a la capa de servicio.

Spring la detectará automáticamente gracias a:

```xml
<context:component-scan base-package="com.example.library" />
```

El método:

```java
findAll()
```

devuelve todos los libros.

El método:

```java
findById(Long id)
```

busca un libro por su identificador.

Si lo encuentra, lo devuelve.

Si no lo encuentra, devuelve `null`.

</details>

---

# Ejercicio 6 — Crear un controlador para listar libros

## Enunciado

Crea un controlador llamado `BookController` en el paquete:

```text
com.example.library.controller
```

Debe:

1. Estar anotado con `@Controller`.
2. Tener una ruta base `/books`.
3. Recibir un `BookService` por constructor.
4. Tener un método que responda a `GET /books`.
5. Añadir al modelo:
   - `pageTitle` con el valor `Libros disponibles`.
   - `books` con la lista de libros.
6. Devolver la vista:

```text
books/list
```

<details>
<summary>mostrar solución</summary>

```java
package com.example.library.controller;

import com.example.library.service.BookService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/books")
public class BookController {

    private final BookService bookService;

    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public String listBooks(Model model) {
        model.addAttribute("pageTitle", "Libros disponibles");
        model.addAttribute("books", bookService.findAll());

        return "books/list";
    }
}
```

### Explicación

La anotación:

```java
@RequestMapping("/books")
```

define una ruta base para todo el controlador.

Como el método tiene:

```java
@GetMapping
```

sin ruta adicional, responderá a:

```text
GET /books
```

El controlador recibe `BookService` por constructor:

```java
public BookController(BookService bookService) {
    this.bookService = bookService;
}
```

Spring se encarga de inyectar el servicio automáticamente.

La vista devuelta es:

```java
return "books/list";
```

Por tanto, Spring buscará:

```text
/WEB-INF/views/books/list.jsp
```

</details>

---

# Ejercicio 7 — Crear una vista para listar libros con JSTL

## Enunciado

Crea la vista:

```text
src/main/webapp/WEB-INF/views/books/list.jsp
```

Debe mostrar una tabla con los libros recibidos desde el controlador.

La tabla debe tener estas columnas:

```text
Título | Autor | Año | Acción
```

En la columna `Acción`, añade un enlace hacia el detalle del libro:

```text
/books/detail?id=ID_DEL_LIBRO
```

Recuerda usar JSTL para recorrer la lista.

<details>
<summary>mostrar solución</summary>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/books">Libros</a>
    </nav>
</header>

<main class="container">
    <section class="card wide">
        <h1>${pageTitle}</h1>

        <table class="table">
            <thead>
            <tr>
                <th>Título</th>
                <th>Autor</th>
                <th>Año</th>
                <th>Acción</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.title}</td>
                    <td>${book.author}</td>
                    <td>${book.year}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/books/detail?id=${book.id}">
                            Ver detalle
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/home">
                Volver al inicio
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación

La línea:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

permite usar etiquetas JSTL.

El bucle:

```jsp
<c:forEach var="book" items="${books}">
```

recorre la lista de libros enviada por el controlador:

```java
model.addAttribute("books", bookService.findAll());
```

En cada vuelta, la variable `book` representa un libro concreto.

Por eso podemos acceder a sus propiedades:

```jsp
${book.title}
${book.author}
${book.year}
${book.id}
```

</details>

---

# Ejercicio 8 — Crear una ruta de detalle con `@RequestParam`

## Enunciado

Modifica `BookController` para añadir una ruta:

```text
GET /books/detail?id=1
```

El método debe:

1. Recibir el parámetro `id` usando `@RequestParam`.
2. Buscar el libro con `bookService.findById(id)`.
3. Si el libro no existe, enviar a la vista `books/not-found`.
4. Si existe, añadir al modelo:
   - `pageTitle` con el título del libro.
   - `book` con el libro encontrado.
5. Devolver la vista `books/detail`.

<details>
<summary>mostrar solución</summary>

```java
package com.example.library.controller;

import com.example.library.model.Book;
import com.example.library.service.BookService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/books")
public class BookController {

    private final BookService bookService;

    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public String listBooks(Model model) {
        model.addAttribute("pageTitle", "Libros disponibles");
        model.addAttribute("books", bookService.findAll());

        return "books/list";
    }

    @GetMapping("/detail")
    public String bookDetail(@RequestParam("id") Long id, Model model) {
        Book book = bookService.findById(id);

        if (book == null) {
            model.addAttribute("pageTitle", "Libro no encontrado");
            model.addAttribute("bookId", id);

            return "books/not-found";
        }

        model.addAttribute("pageTitle", book.getTitle());
        model.addAttribute("book", book);

        return "books/detail";
    }
}
```

### Explicación

La ruta base del controlador es:

```java
@RequestMapping("/books")
```

El método tiene:

```java
@GetMapping("/detail")
```

Por tanto, responde a:

```text
/books/detail
```

El parámetro de la URL se lee con:

```java
@RequestParam("id") Long id
```

Si la URL es:

```text
/books/detail?id=3
```

entonces `id` valdrá:

```java
3L
```

</details>

---

# Ejercicio 9 — Crear la vista de detalle de un libro

## Enunciado

Crea la vista:

```text
src/main/webapp/WEB-INF/views/books/detail.jsp
```

Debe mostrar:

1. El título del libro.
2. El autor.
3. El año de publicación.
4. Un enlace para volver al listado de libros.

<details>
<summary>mostrar solución</summary>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/books">Libros</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${book.title}</h1>

        <ul class="details">
            <li>
                <strong>Autor:</strong> ${book.author}
            </li>
            <li>
                <strong>Año de publicación:</strong> ${book.year}
            </li>
            <li>
                <strong>Identificador:</strong> ${book.id}
            </li>
        </ul>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/books">
                Volver al listado
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación

Esta vista recibe un objeto llamado:

```jsp
${book}
```

Ese objeto viene del controlador:

```java
model.addAttribute("book", book);
```

Por eso podemos escribir:

```jsp
${book.title}
${book.author}
${book.year}
```

La vista se muestra cuando el controlador devuelve:

```java
return "books/detail";
```

Spring la convierte en:

```text
/WEB-INF/views/books/detail.jsp
```

</details>

---

# Ejercicio 10 — Crear la vista de libro no encontrado

## Enunciado

Crea la vista:

```text
src/main/webapp/WEB-INF/views/books/not-found.jsp
```

Debe mostrar:

1. El título de página recibido como `${pageTitle}`.
2. Un mensaje indicando que no existe ningún libro con el identificador recibido.
3. Un enlace para volver al listado de libros.

<details>
<summary>mostrar solución</summary>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/books">Libros</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            No se ha encontrado ningún libro con el identificador ${bookId}.
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/books">
                Volver al listado de libros
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación

Esta vista se usa cuando el controlador ejecuta este bloque:

```java
if (book == null) {
    model.addAttribute("pageTitle", "Libro no encontrado");
    model.addAttribute("bookId", id);

    return "books/not-found";
}
```

El atributo:

```java
bookId
```

se muestra en la JSP con:

```jsp
${bookId}
```

</details>

---

# Ejercicio 11 — Añadir una página “Sobre la biblioteca”

## Enunciado

Añade una nueva ruta:

```text
/about-library
```

Esta ruta debe mostrar una página con información sobre la biblioteca.

Crea un método en `HomeController` que añada al modelo:

| Atributo      | Valor                                                                                  |
| ------------- | -------------------------------------------------------------------------------------- |
| `pageTitle`   | `Sobre la biblioteca`                                                                  |
| `description` | `Esta aplicación permite consultar libros disponibles y ver su información detallada.` |

Debe devolver la vista:

```text
about-library
```

Después crea la JSP correspondiente.

<details>
<summary>mostrar solución</summary>

## Controlador

```java
package com.example.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping({"/", "/home"})
    public String home(Model model) {
        model.addAttribute("pageTitle", "Bienvenido a la biblioteca");
        model.addAttribute("message", "Aplicación de gestión de libros con Spring MVC");

        return "home";
    }

    @GetMapping("/about-library")
    public String aboutLibrary(Model model) {
        model.addAttribute("pageTitle", "Sobre la biblioteca");
        model.addAttribute("description",
                "Esta aplicación permite consultar libros disponibles y ver su información detallada.");

        return "about-library";
    }
}
```

## Vista `about-library.jsp`

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/books">Libros</a>
        <a href="${pageContext.request.contextPath}/about-library">Sobre la biblioteca</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            ${description}
        </p>

        <p>
            Este ejemplo nos permite practicar rutas, controladores, modelos y vistas.
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/home">
                Volver al inicio
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación

La ruta:

```java
@GetMapping("/about-library")
```

responde a:

```text
/about-library
```

El controlador devuelve:

```java
return "about-library";
```

Por tanto, Spring buscará:

```text
/WEB-INF/views/about-library.jsp
```

</details>

---

# Ejercicio 12 — Diagnosticar errores frecuentes

## Enunciado

Lee cada caso y explica cuál es el problema.

## Caso A

En `app-servlet.xml` aparece esto:

```xml
<context:component-scan base-package="com.example.store" />
```

Pero los controladores están en:

```text
com.example.library.controller
```

La aplicación arranca, pero `/books` devuelve error 404.

¿Qué está ocurriendo?

## Caso B

El controlador devuelve:

```java
return "book/list";
```

Pero la vista está en:

```text
/WEB-INF/views/books/list.jsp
```

¿Qué error hay?

## Caso C

En la JSP se escribe:

```jsp
<c:forEach var="book" items="${books}">
```

pero falta esta línea:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

¿Qué puede ocurrir?

<details>
<summary>mostrar solución</summary>

## Caso A

El problema está en el paquete escaneado.

Spring está buscando controladores en:

```text
com.example.store
```

pero realmente están en:

```text
com.example.library.controller
```

Por eso no encuentra `BookController`.

La solución es cambiar el `component-scan`:

```xml
<context:component-scan base-package="com.example.library" />
```

## Caso B

El problema está en el nombre lógico de la vista.

El controlador devuelve:

```java
return "book/list";
```

Por tanto, Spring buscará:

```text
/WEB-INF/views/book/list.jsp
```

Pero la vista real está en:

```text
/WEB-INF/views/books/list.jsp
```

La solución es devolver:

```java
return "books/list";
```

## Caso C

El problema es que se está usando JSTL sin declarar la librería de etiquetas.

La JSP no sabrá interpretar:

```jsp
<c:forEach>
```

La solución es añadir al principio de la JSP:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

Además, el proyecto debe tener las dependencias de JSTL en el `pom.xml`.

</details>

---

# Ejercicio 13 — Reto final: añadir una segunda sección de la aplicación

## Enunciado

Añade una nueva sección para autores.

Debes crear:

1. Una clase `Author`.
2. Un servicio `AuthorService`.
3. Un controlador `AuthorController`.
4. Una vista `authors/list.jsp`.

La ruta será:

```text
/authors
```

La página debe mostrar una tabla con:

```text
Nombre | País | Número de libros
```

Usa al menos tres autores.

<details>
<summary>mostrar solución</summary>

## Modelo `Author.java`

```java
package com.example.library.model;

public class Author {

    private Long id;
    private String name;
    private String country;
    private int bookCount;

    public Author(Long id, String name, String country, int bookCount) {
        this.id = id;
        this.name = name;
        this.country = country;
        this.bookCount = bookCount;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getCountry() {
        return country;
    }

    public int getBookCount() {
        return bookCount;
    }
}
```

## Servicio `AuthorService.java`

```java
package com.example.library.service;

import com.example.library.model.Author;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AuthorService {

    private final List<Author> authors = List.of(
            new Author(1L, "Mary Shelley", "Reino Unido", 3),
            new Author(2L, "Jane Austen", "Reino Unido", 6),
            new Author(3L, "J. R. R. Tolkien", "Reino Unido", 12)
    );

    public List<Author> findAll() {
        return authors;
    }
}
```

## Controlador `AuthorController.java`

```java
package com.example.library.controller;

import com.example.library.service.AuthorService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/authors")
public class AuthorController {

    private final AuthorService authorService;

    public AuthorController(AuthorService authorService) {
        this.authorService = authorService;
    }

    @GetMapping
    public String listAuthors(Model model) {
        model.addAttribute("pageTitle", "Listado de autores");
        model.addAttribute("authors", authorService.findAll());

        return "authors/list";
    }
}
```

## Vista `authors/list.jsp`

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/books">Libros</a>
        <a href="${pageContext.request.contextPath}/authors">Autores</a>
    </nav>
</header>

<main class="container">
    <section class="card wide">
        <h1>${pageTitle}</h1>

        <table class="table">
            <thead>
            <tr>
                <th>Nombre</th>
                <th>País</th>
                <th>Número de libros</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="author" items="${authors}">
                <tr>
                    <td>${author.name}</td>
                    <td>${author.country}</td>
                    <td>${author.bookCount}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/home">
                Volver al inicio
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación

Este reto reúne varias ideas del Tema 2:

- Crear un modelo.
- Crear un servicio.
- Inyectar el servicio en un controlador.
- Crear una ruta con `@RequestMapping` y `@GetMapping`.
- Enviar una lista a la vista con `Model`.
- Recorrer la lista con JSTL.
- Usar un nombre lógico de vista.

El controlador devuelve:

```java
return "authors/list";
```

Por tanto, Spring busca:

```text
/WEB-INF/views/authors/list.jsp
```

</details>
