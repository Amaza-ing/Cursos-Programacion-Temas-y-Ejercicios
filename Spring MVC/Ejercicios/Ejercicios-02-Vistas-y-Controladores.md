# Exercises Topic 2: Mappings, controllers and views in Spring MVC

## Introduction

In these exercises you'll practice the main contents of **Topic 2**:

- Configuring Spring MVC with annotations.
- Using `@Controller`.
- Using `@GetMapping`, `@RequestMapping` and `@RequestParam`.
- Sending data from the controller to the view using `Model`.
- Creating model classes.
- Creating simple services.
- Creating JSP views.
- Using JSTL to loop through lists.
- Using relative paths with `${pageContext.request.contextPath}`.

The exercises are similar to those seen in the topic, but they use other examples so that you can practice without copying the course project exactly.

Each solution is hidden under the **show solution** button.

---

# Exercise 1 — Enable controllers with annotations

## Statement

We start from a Spring MVC project that already has `web.xml` and `DispatcherServlet` configured.

Create or modify the file:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

so that Spring MVC can work with controllers annotated with `@Controller`.

The configuration must:

1. Enable Spring MVC's annotation support.
2. Scan the `com.example.library` base package.
3. Configure an `InternalResourceViewResolver`.
4. Serve static resources from `/resources/`.

<details>
<summary>Show solution</summary>

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

### Explanation

The line:

```xml
<mvc:annotation-driven />
```

enables the support Spring MVC needs to work with annotated methods.

The line:

```xml
<context:component-scan base-package="com.example.library" />
```

allows Spring to automatically find classes like:

```java
@Controller
public class HomeController {
}
```

The `ViewResolver` converts logical view names into actual JSP files. For example:

```java
return "home";
```

becomes:

```text
/WEB-INF/views/home.jsp
```

</details>

---

# Exercise 2 — Create a home controller

## Statement

Create a controller named `HomeController` in the package:

```text
com.example.library.controller
```

It must respond to these two routes:

```text
/
```

and:

```text
/home
```

The controller must send the following data to the view:

| Attribute name | Value |
| ------------------- | ------------------------------------------------ |
| `pageTitle` | `Bienvenido a la biblioteca` |
| `message` | `Aplicación de gestión de libros con Spring MVC` |

The view it must return will be called:

```text
home
```

<details>
<summary>Show solution</summary>

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

### Explanation

The annotation:

```java
@Controller
```

indicates that the class is a Spring MVC controller.

The annotation:

```java
@GetMapping({"/", "/home"})
```

indicates that the method responds to two different routes.

The `Model` object allows you to send data from the controller to the view:

```java
model.addAttribute("pageTitle", "Bienvenido a la biblioteca");
```

Then, in the JSP, it can be displayed with:

```jsp
${pageTitle}
```

The method returns:

```java
return "home";
```

Spring will search for the view:

```text
/WEB-INF/views/home.jsp
```

</details>

---

# Exercise 3 — Create the `home.jsp` view

## Statement

Create the view:

```text
src/main/webapp/WEB-INF/views/home.jsp
```

The page must:

1. Use UTF-8 encoding.
2. Show the title received from the controller.
3. Display the message received from the controller.
4. Have a link to `/books`.
5. Load the CSS file from `/resources/css/styles.css`.

<details>
<summary>Show solution</summary>

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

### Explanation

The line:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
```

helps accented letters and the letter ñ display correctly.

The title is displayed with:

```jsp
${pageTitle}
```

and the message with:

```jsp
${message}
```

Both values come from the controller.

The link uses:

```jsp
${pageContext.request.contextPath}
```

so that it works even if the application is deployed with a context name, for example:

```text
/library-app
```

</details>

---

# Exercise 4 — Create a `Book` model class

## Statement

Create a class called `Book` in the package:

```text
com.example.library.model
```

The class must have these attributes:

| Attribute | Type |
| -------- | -------- |
| `id` | `Long` |
| `title` | `String` |
| `author` | `String` |
| `year` | `int` |

It must have:

1. A constructor with all the fields.
2. Getters for all the fields.

There is no need to add setters in this exercise.

<details>
<summary>Show solution</summary>

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

### Explanation

This class represents a book.

For example, we can create an object like this:

```java
new Book(1L, "La isla del tesoro", "Robert Louis Stevenson", 1883);
```

Getters are important because they let JSPs access the object's properties.

For example, if the view receives an object called `book`, we can write:

```jsp
${book.title}
```

Internally, JSP will call:

```java
getTitle()
```

</details>

---

# Exercise 5 — Create a book service

## Statement

Create a class called `BookService` in the package:

```text
com.example.library.service
```

It must be annotated with `@Service`.

The class must have a fixed list of books and two methods:

```java
List<Book> findAll()
```

and:

```java
Book findById(Long id)
```

Use at least four different books.

<details>
<summary>Show solution</summary>

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

### Explanation

The annotation:

```java
@Service
```

indicates that this class belongs to the service layer.

Spring will detect it automatically thanks to:

```xml
<context:component-scan base-package="com.example.library" />
```

The method:

```java
findAll()
```

returns all the books.

The method:

```java
findById(Long id)
```

looks for a book by its identifier.

If it finds it, it returns it.

If it doesn't find it, it returns `null`.

</details>

---

# Exercise 6 — Create a controller to list books

## Statement

Create a controller named `BookController` in the package:

```text
com.example.library.controller
```

It must:

1. Be annotated with `@Controller`.
2. Have the base path `/books`.
3. Receive a `BookService` through its constructor.
4. Have a method that responds to `GET /books`.
5. Add to the model:
   - `pageTitle` with the value `Libros disponibles`.
   - `books` with the list of books.
6. Return the view:

```text
books/list
```

<details>
<summary>Show solution</summary>

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

### Explanation

The annotation:

```java
@RequestMapping("/books")
```

defines a base route for the entire controller.

Since the method has:

```java
@GetMapping
```

with no additional path, it will respond to:

```text
GET /books
```

The controller receives `BookService` through its constructor:

```java
public BookController(BookService bookService) {
    this.bookService = bookService;
}
```

Spring takes care of injecting the service automatically.

The view returned is:

```java
return "books/list";
```

Therefore, Spring will look for:

```text
/WEB-INF/views/books/list.jsp
```

</details>

---
# Exercise 7 — Create a view to list books with JSTL

## Statement

Create the view:

```text
src/main/webapp/WEB-INF/views/books/list.jsp
```

It must display a table with the books received from the controller.

The table must have these columns:

```text
Título | Autor | Año | Acción
```

In the `Acción` column, add a link to the book's detail page:

```text
/books/detail?id=ID_DEL_LIBRO
```

Remember to use JSTL to loop through the list.

<details>
<summary>Show solution</summary>

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

### Explanation

The line:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

lets you use JSTL tags.

The loop:

```jsp
<c:forEach var="book" items="${books}">
```

loops through the list of books sent by the controller:

```java
model.addAttribute("books", bookService.findAll());
```

On each iteration, the variable `book` represents a specific book.

That is why we can access its properties:

```jsp
${book.title}
${book.author}
${book.year}
${book.id}
```

</details>

---

# Exercise 8 — Create a detail route with `@RequestParam`

## Statement

Modify `BookController` to add a route:

```text
GET /books/detail?id=1
```

The method must:

1. Receive the parameter `id` using `@RequestParam`.
2. Look up the book with `bookService.findById(id)`.
3. If the book does not exist, return the `books/not-found` view.
4. If it exists, add to the model:
   - `pageTitle` with the title of the book.
   - `book` with the book found.
5. Return the `books/detail` view.

<details>
<summary>Show solution</summary>

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

### Explanation

The base path of the controller is:

```java
@RequestMapping("/books")
```

The method has:

```java
@GetMapping("/detail")
```

Therefore, it responds to:

```text
/books/detail
```

The URL parameter is read with:

```java
@RequestParam("id") Long id
```

If the URL is:

```text
/books/detail?id=3
```

then `id` will be:

```java
3L
```

</details>

---

# Exercise 9 — Create the detail view of a book

## Statement

Create the view:

```text
src/main/webapp/WEB-INF/views/books/detail.jsp
```

It must show:

1. The title of the book.
2. The author.
3. The year of publication.
4. A link to go back to the book list.

<details>
<summary>Show solution</summary>

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

### Explanation

This view receives an object called:

```jsp
${book}
```

That object comes from the controller:

```java
model.addAttribute("book", book);
```

That's why we can write:

```jsp
${book.title}
${book.author}
${book.year}
```

The view is displayed when the controller returns:

```java
return "books/detail";
```

Spring converts it into:

```text
/WEB-INF/views/books/detail.jsp
```

</details>

---

# Exercise 10 — Create the “book not found” view

## Statement

Create the view:

```text
src/main/webapp/WEB-INF/views/books/not-found.jsp
```

It must show:

1. The page title received as `${pageTitle}`.
2. A message saying that there is no book with the received identifier.
3. A link to go back to the book list.

<details>
<summary>Show solution</summary>

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

### Explanation

This view is used when the controller runs this block:

```java
if (book == null) {
    model.addAttribute("pageTitle", "Libro no encontrado");
    model.addAttribute("bookId", id);

    return "books/not-found";
}
```

The attribute:

```java
bookId
```

is shown in the JSP with:

```jsp
${bookId}
```

</details>

---

# Exercise 11 — Add an “About the Library” page

## Statement

Add a new route:

```text
/about-library
```

This route must display a page with information about the library.

Create a method in `HomeController` that adds to the model:

| Attribute | Value |
| ------------- | -------------------------------------------------------------------------------------- |
| `pageTitle` | `Sobre la biblioteca` |
| `description` | `Esta aplicación permite consultar libros disponibles y ver su información detallada.` |

It must return the view:

```text
about-library
```

Then create the corresponding JSP.

<details>
<summary>Show solution</summary>

## Controller

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

## View `about-library.jsp`

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

### Explanation

The route:

```java
@GetMapping("/about-library")
```

responds to:

```text
/about-library
```

The controller returns:

```java
return "about-library";
```

Therefore, Spring will look for:

```text
/WEB-INF/views/about-library.jsp
```

</details>

---

# Exercise 12 — Diagnose common errors

## Statement

Read each case and explain what the problem is.

## Case A

`app-servlet.xml` contains this:

```xml
<context:component-scan base-package="com.example.store" />
```

But the controllers are in:

```text
com.example.library.controller
```

The application starts, but `/books` returns a 404 error.

What is happening?

## Case B

The controller returns:

```java
return "book/list";
```

But the view is in:

```text
/WEB-INF/views/books/list.jsp
```

What's the error?

## Case C

The JSP contains:

```jsp
<c:forEach var="book" items="${books}">
```

but this line is missing:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

What might happen?

<details>
<summary>Show solution</summary>

## Case A

The problem is with the scanned package.

Spring is looking for controllers in:

```text
com.example.store
```

but they are really in:

```text
com.example.library.controller
```

That's why it doesn't find `BookController`.

The solution is to change the `component-scan`:

```xml
<context:component-scan base-package="com.example.library" />
```

## Case B

The problem is in the logical name of the view.

The controller returns:

```java
return "book/list";
```

Therefore, Spring will look for:

```text
/WEB-INF/views/book/list.jsp
```

But the real view is in:

```text
/WEB-INF/views/books/list.jsp
```

The solution is to return:

```java
return "books/list";
```

## Case C

The problem is that JSTL is being used without declaring the tag library.

The JSP will not know how to interpret:

```jsp
<c:forEach>
```

The solution is to add this at the beginning of the JSP:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

Additionally, the project must have the JSTL dependencies in the `pom.xml`.

</details>

---

# Exercise 13 — Final challenge: add a second section to the application

## Statement

Add a new section for authors.

You must create:

1. A class `Author`.
2. An `AuthorService` service.
3. An `AuthorController` controller.
4. An `authors/list.jsp` view.

The route will be:

```text
/authors
```

The page should display a table with:

```text
Nombre | País | Número de libros
```

Use at least three authors.

<details>
<summary>Show solution</summary>

## Model `Author.java`

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

## `AuthorService.java` service

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

## `AuthorController.java` controller

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

## View `authors/list.jsp`

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

### Explanation

This challenge brings together several ideas from Topic 2:

- Create a model.
- Create a service.
- Inject the service into a controller.
- Create a route with `@RequestMapping` and `@GetMapping`.
- Send a list to the view with `Model`.
- Loop through the list with JSTL.
- Use a logical view name.

The controller returns:

```java
return "authors/list";
```

Therefore, Spring looks for:

```text
/WEB-INF/views/authors/list.jsp
```

</details>
