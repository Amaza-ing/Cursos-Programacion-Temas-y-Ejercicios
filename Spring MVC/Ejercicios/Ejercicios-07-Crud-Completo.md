# Ejercicios resueltos — Tema 7: CRUD completo en Spring MVC

## Introducción

En estos ejercicios vas a practicar cómo completar un CRUD en una aplicación Spring MVC.

En el Tema 7 añadimos las operaciones que faltaban para completar el ciclo completo de gestión de datos:

```text
Create  → Crear
Read    → Leer
Update  → Actualizar
Delete  → Borrar
```

En lugar de usar cursos, en estos ejercicios trabajaremos con una pequeña aplicación de gestión de **libros**. Así practicarás el mismo flujo, pero con un ejemplo distinto.

Vas a practicar:

- Añadir métodos `update` y `deleteById` al DAO.
- Implementar `UPDATE` y `DELETE` con `JdbcTemplate`.
- Actualizar la capa de servicio.
- Crear rutas de edición y borrado en el controlador.
- Reutilizar un formulario para crear y editar.
- Usar un campo oculto para conservar el `id`.
- Añadir botones de editar y borrar al listado.
- Borrar mediante `POST`.
- Mostrar mensajes de éxito con `RedirectAttributes`.
- Diagnosticar errores típicos del CRUD.

Cada solución está oculta bajo el botón **mostrar solución**.

---

# Ejercicio 1 — Reconocer las operaciones CRUD

## Enunciado

Completa la tabla indicando qué operación CRUD corresponde a cada acción.

| Acción                     | Operación CRUD |
| -------------------------- | -------------- |
| Crear un libro nuevo       | ?              |
| Ver todos los libros       | ?              |
| Ver el detalle de un libro | ?              |
| Editar un libro existente  | ?              |
| Borrar un libro            | ?              |

---

<details>
<summary>mostrar solución</summary>

| Acción                     | Operación CRUD |
| -------------------------- | -------------- |
| Crear un libro nuevo       | Create         |
| Ver todos los libros       | Read           |
| Ver el detalle de un libro | Read           |
| Editar un libro existente  | Update         |
| Borrar un libro            | Delete         |

### Explicación

CRUD resume las cuatro operaciones básicas de una aplicación de gestión:

```text
Create  → insertar datos nuevos
Read    → consultar datos
Update  → modificar datos existentes
Delete  → eliminar datos
```

En una aplicación Spring MVC estas operaciones suelen repartirse entre controlador, servicio, DAO, vistas JSP y base de datos.

</details>

---

# Ejercicio 2 — Diseñar las rutas del CRUD completo

## Enunciado

Ya tenemos estas rutas en una aplicación de libros:

```text
GET  /books             → listado de libros
GET  /books/detail?id=1 → detalle de un libro
GET  /books/new         → formulario de creación
POST /books             → guardar libro nuevo
```

Añade las rutas necesarias para:

1. Mostrar el formulario de edición.
2. Procesar la edición.
3. Borrar un libro.

---

<details>
<summary>mostrar solución</summary>

```text
GET  /books/edit?id=1   → mostrar formulario de edición
POST /books/update      → procesar edición
POST /books/delete      → borrar libro
```

### Explicación

La edición necesita dos pasos.

Primero mostramos el formulario con datos existentes:

```text
GET /books/edit?id=1
```

Después procesamos el formulario editado:

```text
POST /books/update
```

Para borrar usamos `POST`:

```text
POST /books/delete
```

No usamos `GET` para borrar porque borrar datos modifica el estado de la aplicación.

</details>

---

# Ejercicio 3 — Crear la tabla `books`

## Enunciado

Crea una tabla MySQL llamada `books`.

Debe tener estos campos:

| Columna    | Tipo           | Restricción                    |
| ---------- | -------------- | ------------------------------ |
| `id`       | `BIGINT`       | Clave primaria autoincremental |
| `title`    | `VARCHAR(100)` | Obligatoria                    |
| `author`   | `VARCHAR(80)`  | Obligatoria                    |
| `category` | `VARCHAR(40)`  | Obligatoria                    |
| `pages`    | `INT`          | Obligatoria                    |

---

<details>
<summary>mostrar solución</summary>

```sql
CREATE TABLE IF NOT EXISTS books (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(80) NOT NULL,
    category VARCHAR(40) NOT NULL,
    pages INT NOT NULL
);
```

### Explicación

`id` identifica cada libro.

`AUTO_INCREMENT` permite que MySQL genere automáticamente el identificador.

Las demás columnas usan `NOT NULL`, por lo que siempre deben tener valor.

</details>

---

# Ejercicio 4 — Insertar datos iniciales

## Enunciado

Inserta tres libros iniciales en la tabla `books`.

Usa estos datos:

| title         | author                   | category | pages |
| ------------- | ------------------------ | -------- | ----- |
| Frankenstein  | Mary Shelley             | Novela   | 280   |
| El Hobbit     | J. R. R. Tolkien         | Fantasía | 310   |
| El principito | Antoine de Saint-Exupéry | Fábula   | 96    |

Después escribe una consulta para comprobar los datos.

---

<details>
<summary>mostrar solución</summary>

```sql
INSERT INTO books (title, author, category, pages)
VALUES
    ('Frankenstein', 'Mary Shelley', 'Novela', 280),
    ('El Hobbit', 'J. R. R. Tolkien', 'Fantasía', 310),
    ('El principito', 'Antoine de Saint-Exupéry', 'Fábula', 96);

SELECT * FROM books;
```

### Explicación

No insertamos el `id` porque MySQL lo genera automáticamente.

La consulta:

```sql
SELECT * FROM books;
```

permite comprobar desde DBeaver que los libros se han guardado.

</details>

---

# Ejercicio 5 — Crear el modelo `Book`

## Enunciado

Crea una clase `Book` en el paquete:

```text
com.example.library.model
```

Debe tener:

```text
id
title
author
category
pages
```

Usa Lombok para generar getters, setters y constructores.

Añade validaciones:

| Campo      | Validación                            |
| ---------- | ------------------------------------- |
| `title`    | Obligatorio, entre 3 y 100 caracteres |
| `author`   | Obligatorio                           |
| `category` | Obligatorio                           |
| `pages`    | Obligatorio, mínimo 1, máximo 3000    |

---

<details>
<summary>mostrar solución</summary>

```java
package com.example.library.model;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Book {

    private Long id;

    @NotBlank(message = "El título es obligatorio.")
    @Size(min = 3, max = 100, message = "El título debe tener entre 3 y 100 caracteres.")
    private String title;

    @NotBlank(message = "El autor es obligatorio.")
    private String author;

    @NotBlank(message = "La categoría es obligatoria.")
    private String category;

    @NotNull(message = "El número de páginas es obligatorio.")
    @Min(value = 1, message = "El libro debe tener al menos 1 página.")
    @Max(value = 3000, message = "El libro no puede tener más de 3000 páginas.")
    private Integer pages;
}
```

### Explicación

`@Data` genera getters y setters.

`@NoArgsConstructor` genera el constructor vacío.

`@AllArgsConstructor` genera el constructor con todos los campos.

El campo `pages` es `Integer`, no `int`, porque si el usuario deja el campo vacío necesitamos poder representar `null`.

</details>

---

# Ejercicio 6 — Ampliar la interfaz `BookDao`

## Enunciado

Tienes esta interfaz:

```java
public interface BookDao {

    List<Book> findAll();

    Book findById(Long id);

    void save(Book book);
}
```

Amplíala para completar el CRUD.

Debe incluir métodos para actualizar y borrar.

---

<details>
<summary>mostrar solución</summary>

```java
package com.example.library.dao;

import com.example.library.model.Book;

import java.util.List;

public interface BookDao {

    List<Book> findAll();

    Book findById(Long id);

    void save(Book book);

    void update(Book book);

    void deleteById(Long id);
}
```

### Explicación

Añadimos:

```java
void update(Book book);
```

para modificar un libro existente.

Añadimos:

```java
void deleteById(Long id);
```

para borrar un libro por su identificador.

La interfaz define qué operaciones existen, pero no contiene SQL.

</details>

---

# Ejercicio 7 — Crear el `RowMapper` de `Book`

## Enunciado

Dentro de `JdbcBookDao`, crea un `RowMapper<Book>` que convierta las columnas de la tabla `books` en un objeto `Book`.

Columnas:

```text
id
title
author
category
pages
```

---

<details>
<summary>mostrar solución</summary>

```java
private final RowMapper<Book> bookRowMapper = (resultSet, rowNumber) ->
        new Book(
                resultSet.getLong("id"),
                resultSet.getString("title"),
                resultSet.getString("author"),
                resultSet.getString("category"),
                resultSet.getInt("pages")
        );
```

### Explicación

Una consulta SQL devuelve filas.

Java trabaja con objetos.

El `RowMapper` transforma cada fila del resultado en un objeto `Book`.

</details>

---

# Ejercicio 8 — Implementar `findAll` y `findById`

## Enunciado

Implementa los métodos `findAll` y `findById` dentro de `JdbcBookDao`.

`findAll` debe devolver todos los libros ordenados por `id`.

`findById` debe buscar un libro por su identificador y devolver `null` si no existe.

---

<details>
<summary>mostrar solución</summary>

```java
@Override
public List<Book> findAll() {
    String sql = """
            SELECT id, title, author, category, pages
            FROM books
            ORDER BY id
            """;

    return jdbcTemplate.query(sql, bookRowMapper);
}

@Override
public Book findById(Long id) {
    String sql = """
            SELECT id, title, author, category, pages
            FROM books
            WHERE id = ?
            """;

    List<Book> books = jdbcTemplate.query(sql, bookRowMapper, id);

    return books.stream()
            .findFirst()
            .orElse(null);
}
```

### Explicación

`findAll` devuelve una lista completa.

`findById` usa:

```sql
WHERE id = ?
```

para buscar solo un registro.

Si no hay resultados, devuelve `null`.

</details>

---

# Ejercicio 9 — Implementar `save`

## Enunciado

Implementa el método `save(Book book)` en `JdbcBookDao`.

Debe insertar un nuevo libro en la tabla `books`.

No debe insertar el `id`, porque MySQL lo genera automáticamente.

---

<details>
<summary>mostrar solución</summary>

```java
@Override
public void save(Book book) {
    String sql = """
            INSERT INTO books (title, author, category, pages)
            VALUES (?, ?, ?, ?)
            """;

    jdbcTemplate.update(
            sql,
            book.getTitle(),
            book.getAuthor(),
            book.getCategory(),
            book.getPages()
    );
}
```

### Explicación

La consulta:

```sql
INSERT INTO books (title, author, category, pages)
VALUES (?, ?, ?, ?)
```

crea un nuevo libro.

No incluimos `id` porque la columna es `AUTO_INCREMENT`.

</details>

---

# Ejercicio 10 — Implementar `update`

## Enunciado

Implementa el método `update(Book book)` en `JdbcBookDao`.

Debe actualizar:

```text
title
author
category
pages
```

del libro cuyo `id` coincida.

---

<details>
<summary>mostrar solución</summary>

```java
@Override
public void update(Book book) {
    String sql = """
            UPDATE books
            SET title = ?, author = ?, category = ?, pages = ?
            WHERE id = ?
            """;

    jdbcTemplate.update(
            sql,
            book.getTitle(),
            book.getAuthor(),
            book.getCategory(),
            book.getPages(),
            book.getId()
    );
}
```

### Explicación

La consulta:

```sql
UPDATE books
SET title = ?, author = ?, category = ?, pages = ?
WHERE id = ?
```

modifica solo el libro cuyo `id` coincida.

La parte más importante es:

```sql
WHERE id = ?
```

Sin esa condición se actualizarían todos los libros de la tabla.

</details>

---

# Ejercicio 11 — Implementar `deleteById`

## Enunciado

Implementa el método `deleteById(Long id)` en `JdbcBookDao`.

Debe borrar de la tabla `books` el libro cuyo identificador coincida.

---

<details>
<summary>mostrar solución</summary>

```java
@Override
public void deleteById(Long id) {
    String sql = """
            DELETE FROM books
            WHERE id = ?
            """;

    jdbcTemplate.update(sql, id);
}
```

### Explicación

La consulta:

```sql
DELETE FROM books
WHERE id = ?
```

borra solo el libro indicado.

Sin `WHERE`, borraríamos todos los registros de la tabla.

</details>

---

# Ejercicio 12 — Crear `BookNotFoundException`

## Enunciado

Crea una excepción personalizada llamada `BookNotFoundException`.

Debe:

1. Estar en el paquete `com.example.library.exception`.
2. Extender de `RuntimeException`.
3. Guardar el `bookId`.
4. Tener getter para `bookId`.

---

<details>
<summary>mostrar solución</summary>

```java
package com.example.library.exception;

public class BookNotFoundException extends RuntimeException {

    private final Long bookId;

    public BookNotFoundException(Long bookId) {
        super("No se ha encontrado ningún libro con id " + bookId);
        this.bookId = bookId;
    }

    public Long getBookId() {
        return bookId;
    }
}
```

### Explicación

Esta excepción se lanzará cuando alguien intente ver, editar o borrar un libro que no existe.

Así evitamos manejar `null` manualmente en cada controlador.

</details>

---

# Ejercicio 13 — Crear `BookService` completo

## Enunciado

Crea un servicio `BookService`.

Debe:

1. Estar anotado con `@Service`.
2. Recibir `BookDao` por constructor.
3. Tener métodos:
   - `findAll`
   - `findById`
   - `findByIdOrThrow`
   - `save`
   - `update`
   - `deleteById`

En `update`, primero debe comprobar que el libro existe.

En `deleteById`, primero debe comprobar que el libro existe.

---

<details>
<summary>mostrar solución</summary>

```java
package com.example.library.service;

import com.example.library.dao.BookDao;
import com.example.library.exception.BookNotFoundException;
import com.example.library.model.Book;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookService {

    private final BookDao bookDao;

    public BookService(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    public List<Book> findAll() {
        return bookDao.findAll();
    }

    public Book findById(Long id) {
        return bookDao.findById(id);
    }

    public Book findByIdOrThrow(Long id) {
        Book book = bookDao.findById(id);

        if (book == null) {
            throw new BookNotFoundException(id);
        }

        return book;
    }

    public void save(Book book) {
        bookDao.save(book);
    }

    public void update(Book book) {
        Book existingBook = findByIdOrThrow(book.getId());

        existingBook.setTitle(book.getTitle());
        existingBook.setAuthor(book.getAuthor());
        existingBook.setCategory(book.getCategory());
        existingBook.setPages(book.getPages());

        bookDao.update(existingBook);
    }

    public void deleteById(Long id) {
        findByIdOrThrow(id);
        bookDao.deleteById(id);
    }
}
```

### Explicación

En `update` buscamos primero el libro existente.

Esto permite comprobar que realmente existe antes de actualizarlo.

En `deleteById` también comprobamos que existe antes de borrar.

</details>

---

# Ejercicio 14 — Añadir mensajes de internacionalización

## Enunciado

Añade claves de mensajes para las acciones del CRUD de libros.

Crea las claves en español para:

```text
books.list.title
books.create
books.create.title
books.edit
books.edit.title
books.delete
books.update
books.detail
books.confirmDelete
success.book.created
success.book.updated
success.book.deleted
```

---

<details>
<summary>mostrar solución</summary>

```properties
books.list.title=Listado de libros
books.create=Crear nuevo libro
books.create.title=Crear libro
books.edit=Editar
books.edit.title=Editar libro
books.delete=Borrar
books.update=Actualizar libro
books.detail=Ver detalle
books.confirmDelete=¿Seguro que quieres borrar este libro?
success.book.created=El libro se ha creado correctamente.
success.book.updated=El libro se ha actualizado correctamente.
success.book.deleted=El libro se ha borrado correctamente.
```

### Explicación

Estas claves nos permiten evitar textos fijos en las JSP y en el controlador.

Por ejemplo:

```jsp
<spring:message code="books.edit" />
```

o:

```java
messageSource.getMessage("success.book.updated", null, locale);
```

</details>

---

# Ejercicio 15 — Crear el método para listar libros

## Enunciado

Crea el método `listBooks` en `BookController`.

Debe:

1. Responder a `GET /books`.
2. Añadir al modelo:
   - `pageTitleCode` con `books.list.title`.
   - `books` con la lista de libros.
3. Devolver la vista `books/list`.

---

<details>
<summary>mostrar solución</summary>

```java
@GetMapping
public String listBooks(Model model) {
    model.addAttribute("pageTitleCode", "books.list.title");
    model.addAttribute("books", bookService.findAll());

    return "books/list";
}
```

### Explicación

Como el controlador tendrá:

```java
@RequestMapping("/books")
```

este método responde a:

```text
GET /books
```

El listado de libros viene del servicio:

```java
bookService.findAll()
```

</details>

---

# Ejercicio 16 — Mostrar el formulario de creación

## Enunciado

Crea el método `showCreateForm` en `BookController`.

Debe responder a:

```text
GET /books/new
```

Debe añadir al modelo:

| Atributo        | Valor                |
| --------------- | -------------------- |
| `pageTitleCode` | `books.create.title` |
| `formAction`    | `/books`             |
| `submitCode`    | `books.create`       |
| `book`          | `new Book()`         |

Debe devolver:

```text
books/form
```

---

<details>
<summary>mostrar solución</summary>

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    model.addAttribute("pageTitleCode", "books.create.title");
    model.addAttribute("formAction", "/books");
    model.addAttribute("submitCode", "books.create");
    model.addAttribute("book", new Book());

    return "books/form";
}
```

### Explicación

Usamos `formAction` y `submitCode` para poder reutilizar el mismo formulario al crear y editar.

Para crear, el objeto `book` está vacío.

</details>

---

# Ejercicio 17 — Procesar la creación de un libro

## Enunciado

Crea el método `createBook` en `BookController`.

Debe responder a:

```text
POST /books
```

Debe:

1. Recibir `Book` con `@Valid` y `@ModelAttribute("book")`.
2. Recibir `BindingResult`.
3. Si hay errores, volver a `books/form`.
4. Si no hay errores, guardar el libro.
5. Añadir mensaje flash `success.book.created`.
6. Redirigir a `/books`.

---

<details>
<summary>mostrar solución</summary>

```java
@PostMapping
public String createBook(
        @Valid @ModelAttribute("book") Book book,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {

    if (bindingResult.hasErrors()) {
        model.addAttribute("pageTitleCode", "books.create.title");
        model.addAttribute("formAction", "/books");
        model.addAttribute("submitCode", "books.create");

        return "books/form";
    }

    bookService.save(book);

    addFlashMessage(
            redirectAttributes,
            "success.book.created"
    );

    return "redirect:/books";
}
```

### Explicación

Si hay errores de validación, volvemos al formulario.

Es importante volver a añadir:

```java
pageTitleCode
formAction
submitCode
```

porque la vista los necesita.

</details>

---

# Ejercicio 18 — Mostrar el formulario de edición

## Enunciado

Crea el método `showEditForm` en `BookController`.

Debe responder a:

```text
GET /books/edit?id=1
```

Debe:

1. Recibir el parámetro `id`.
2. Buscar el libro con `bookService.findByIdOrThrow(id)`.
3. Añadir al modelo:
   - `pageTitleCode` con `books.edit.title`.
   - `formAction` con `/books/update`.
   - `submitCode` con `books.update`.
   - `book` con el libro encontrado.
4. Devolver la vista `books/form`.

---

<details>
<summary>mostrar solución</summary>

```java
@GetMapping("/edit")
public String showEditForm(
        @RequestParam("id") Long id,
        Model model) {

    Book book = bookService.findByIdOrThrow(id);

    model.addAttribute("pageTitleCode", "books.edit.title");
    model.addAttribute("formAction", "/books/update");
    model.addAttribute("submitCode", "books.update");
    model.addAttribute("book", book);

    return "books/form";
}
```

### Explicación

Este método no crea un libro vacío.

Busca un libro existente y lo envía al formulario.

Así el formulario aparece relleno con los datos actuales.

</details>

---

# Ejercicio 19 — Procesar la edición de un libro

## Enunciado

Crea el método `updateBook` en `BookController`.

Debe responder a:

```text
POST /books/update
```

Debe:

1. Recibir `Book` con `@Valid` y `@ModelAttribute("book")`.
2. Recibir `BindingResult`.
3. Si hay errores, volver al formulario de edición.
4. Si no hay errores, actualizar el libro.
5. Añadir mensaje flash `success.book.updated`.
6. Redirigir a `/books`.

---

<details>
<summary>mostrar solución</summary>

```java
@PostMapping("/update")
public String updateBook(
        @Valid @ModelAttribute("book") Book book,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {

    if (bindingResult.hasErrors()) {
        model.addAttribute("pageTitleCode", "books.edit.title");
        model.addAttribute("formAction", "/books/update");
        model.addAttribute("submitCode", "books.update");

        return "books/form";
    }

    bookService.update(book);

    addFlashMessage(
            redirectAttributes,
            "success.book.updated"
    );

    return "redirect:/books";
}
```

### Explicación

Este método se parece al de creación, pero llama a:

```java
bookService.update(book);
```

en lugar de:

```java
bookService.save(book);
```

</details>

---

# Ejercicio 20 — Borrar un libro

## Enunciado

Crea el método `deleteBook` en `BookController`.

Debe responder a:

```text
POST /books/delete
```

Debe:

1. Recibir el parámetro `id`.
2. Borrar el libro con `bookService.deleteById(id)`.
3. Añadir mensaje flash `success.book.deleted`.
4. Redirigir a `/books`.

---

<details>
<summary>mostrar solución</summary>

```java
@PostMapping("/delete")
public String deleteBook(
        @RequestParam("id") Long id,
        RedirectAttributes redirectAttributes) {

    bookService.deleteById(id);

    addFlashMessage(
            redirectAttributes,
            "success.book.deleted"
    );

    return "redirect:/books";
}
```

### Explicación

Borramos usando `POST`, no `GET`.

Esto es importante porque borrar modifica datos.

Después de borrar, redirigimos al listado.

</details>

---

# Ejercicio 21 — Crear método privado para mensajes flash

## Enunciado

En `BookController`, crea un método privado llamado `addFlashMessage`.

Debe:

1. Recibir `RedirectAttributes`.
2. Recibir un código de mensaje.
3. Obtener el idioma actual con `LocaleContextHolder`.
4. Obtener el mensaje usando `MessageSource`.
5. Añadirlo como `successMessage`.

---

<details>
<summary>mostrar solución</summary>

```java
private void addFlashMessage(
        RedirectAttributes redirectAttributes,
        String messageCode) {

    Locale locale = LocaleContextHolder.getLocale();

    String message = messageSource.getMessage(
            messageCode,
            null,
            locale
    );

    redirectAttributes.addFlashAttribute("successMessage", message);
}
```

### Imports necesarios

```java
import org.springframework.context.i18n.LocaleContextHolder;

import java.util.Locale;
```

### Explicación

Este método evita repetir código cada vez que queremos mostrar un mensaje de éxito.

Por ejemplo:

```java
addFlashMessage(redirectAttributes, "success.book.updated");
```

</details>

---

# Ejercicio 22 — Crear `books/form.jsp` reutilizable

## Enunciado

Crea una vista `books/form.jsp` que sirva tanto para crear como para editar libros.

Debe:

1. Usar `<form:form>`.
2. Usar `modelAttribute="book"`.
3. Enviar el formulario a `${formAction}`.
4. Incluir un campo oculto para `id`.
5. Tener campos:
   - `title`
   - `author`
   - `category`
   - `pages`
6. Mostrar errores de validación.
7. Usar `${submitCode}` para el texto del botón.

---

<details>
<summary>mostrar solución</summary>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <%@ include file="/WEB-INF/views/fragments/head.jspf" %>
</head>
<body>

<%@ include file="/WEB-INF/views/fragments/header.jspf" %>

<main class="container">
    <section class="card">
        <h1>
            <spring:message code="${pageTitleCode}" />
        </h1>

        <form:form
                method="post"
                action="${pageContext.request.contextPath}${formAction}"
                modelAttribute="book"
                cssClass="form">

            <form:hidden path="id" />

            <div class="form-group">
                <form:label path="title">Título</form:label>
                <form:input path="title" cssClass="input" />
                <form:errors path="title" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="author">Autor</form:label>
                <form:input path="author" cssClass="input" />
                <form:errors path="author" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="category">Categoría</form:label>
                <form:select path="category" cssClass="input">
                    <form:option value="">
                        Selecciona una categoría
                    </form:option>

                    <c:forEach var="category" items="${bookCategories}">
                        <form:option value="${category}">
                            ${category}
                        </form:option>
                    </c:forEach>
                </form:select>
                <form:errors path="category" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="pages">Páginas</form:label>
                <form:input path="pages" type="number" cssClass="input" />
                <form:errors path="pages" cssClass="error" />
            </div>

            <div class="form-actions">
                <button type="submit" class="button">
                    <spring:message code="${submitCode}" />
                </button>

                <a class="secondary-button" href="${pageContext.request.contextPath}/books">
                    Cancelar
                </a>
            </div>

        </form:form>
    </section>
</main>

</body>
</html>
```

### Explicación

La parte más importante para editar es:

```jsp
<form:hidden path="id" />
```

Este campo conserva el identificador del libro.

Sin ese campo, el objeto podría llegar al controlador con `id = null`.

</details>

---

# Ejercicio 23 — Crear categorías globales para el formulario

## Enunciado

La vista `books/form.jsp` usa:

```jsp
${bookCategories}
```

Crea una clase `GlobalModelAttributes` que añada esa lista al modelo.

Las categorías serán:

```text
Novela
Ensayo
Poesía
Teatro
Ciencia ficción
```

---

<details>
<summary>mostrar solución</summary>

```java
package com.example.library.config;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@ControllerAdvice
public class GlobalModelAttributes {

    @ModelAttribute("bookCategories")
    public List<String> bookCategories() {
        return List.of(
                "Novela",
                "Ensayo",
                "Poesía",
                "Teatro",
                "Ciencia ficción"
        );
    }
}
```

### Explicación

La anotación:

```java
@ControllerAdvice
```

permite que este atributo esté disponible en varias vistas.

El método:

```java
@ModelAttribute("bookCategories")
```

añade al modelo una lista que puede usarse en JSP.

</details>

---

# Ejercicio 24 — Actualizar el listado con acciones

## Enunciado

Crea la parte de acciones de `books/list.jsp`.

Por cada libro debe aparecer:

1. Enlace para ver detalle.
2. Enlace para editar.
3. Formulario `POST` para borrar.

El botón de borrar debe pedir confirmación antes de enviar el formulario.

---

<details>
<summary>mostrar solución</summary>

```jsp
<td class="actions-cell">
    <a href="${pageContext.request.contextPath}/books/detail?id=${book.id}">
        <spring:message code="books.detail" />
    </a>

    <a href="${pageContext.request.contextPath}/books/edit?id=${book.id}">
        <spring:message code="books.edit" />
    </a>

    <form method="post"
          action="${pageContext.request.contextPath}/books/delete"
          class="inline-form"
          onsubmit="return confirm('<spring:message code="books.confirmDelete" />');">

        <input type="hidden" name="id" value="${book.id}">

        <button type="submit" class="link-button">
            <spring:message code="books.delete" />
        </button>
    </form>
</td>
```

### Explicación

El enlace de edición usa `GET` porque solo muestra un formulario.

El borrado usa `POST` porque modifica datos.

El `id` se envía en un campo oculto.

</details>

---

# Ejercicio 25 — Crear `books/list.jsp` completo

## Enunciado

Crea una vista `books/list.jsp` con:

1. Tabla de libros.
2. Mensaje de éxito si existe `successMessage`.
3. Botón para crear libro.
4. Acciones de detalle, edición y borrado.

---

<details>
<summary>mostrar solución</summary>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <%@ include file="/WEB-INF/views/fragments/head.jspf" %>
</head>
<body>

<%@ include file="/WEB-INF/views/fragments/header.jspf" %>

<main class="container">
    <section class="card wide">
        <h1>
            <spring:message code="books.list.title" />
        </h1>

        <c:if test="${not empty successMessage}">
            <div class="success">
                ${successMessage}
            </div>
        </c:if>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/books/new">
                <spring:message code="books.create" />
            </a>
        </p>

        <table class="table">
            <thead>
            <tr>
                <th>Título</th>
                <th>Autor</th>
                <th>Categoría</th>
                <th>Páginas</th>
                <th>Acción</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.title}</td>
                    <td>${book.author}</td>
                    <td>${book.category}</td>
                    <td>${book.pages}</td>
                    <td class="actions-cell">
                        <a href="${pageContext.request.contextPath}/books/detail?id=${book.id}">
                            <spring:message code="books.detail" />
                        </a>

                        <a href="${pageContext.request.contextPath}/books/edit?id=${book.id}">
                            <spring:message code="books.edit" />
                        </a>

                        <form method="post"
                              action="${pageContext.request.contextPath}/books/delete"
                              class="inline-form"
                              onsubmit="return confirm('<spring:message code="books.confirmDelete" />');">

                            <input type="hidden" name="id" value="${book.id}">

                            <button type="submit" class="link-button">
                                <spring:message code="books.delete" />
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </section>
</main>

</body>
</html>
```

### Explicación

Cada fila tiene tres acciones:

```text
Ver detalle
Editar
Borrar
```

El borrado se hace con formulario `POST`.

</details>

---

# Ejercicio 26 — Añadir estilos para las acciones

## Enunciado

Añade estilos CSS para que las acciones de la tabla se vean en línea.

Crea estilos para:

```text
.actions-cell
.inline-form
.link-button
.link-button:hover
```

---

<details>
<summary>mostrar solución</summary>

```css
.actions-cell {
  display: flex;
  gap: 12px;
  align-items: center;
}

.inline-form {
  display: inline;
  margin: 0;
}

.link-button {
  border: none;
  background: none;
  color: #2563eb;
  cursor: pointer;
  padding: 0;
  font: inherit;
  text-decoration: underline;
}

.link-button:hover {
  color: #1d4ed8;
}
```

### Explicación

`.actions-cell` coloca las acciones en línea.

`.inline-form` evita que el formulario de borrado ocupe una línea completa.

`.link-button` hace que el botón de borrar parezca un enlace.

</details>

---

# Ejercicio 27 — Explicar por qué hace falta el campo oculto `id`

## Enunciado

En el formulario de edición aparece esta línea:

```jsp
<form:hidden path="id" />
```

Explica para qué sirve y qué problema tendríamos si la quitamos.

---

<details>
<summary>mostrar solución</summary>

El campo oculto conserva el identificador del libro que estamos editando.

Cuando el usuario envía el formulario, Spring rellena el objeto `Book`.

Gracias a:

```jsp
<form:hidden path="id" />
```

el objeto llega con su `id`.

Ese valor es necesario para ejecutar:

```sql
UPDATE books
SET ...
WHERE id = ?
```

Si quitamos el campo oculto, el objeto podría llegar con `id = null`.

Entonces el servicio no sabría qué libro actualizar.

</details>

---

# Ejercicio 28 — Explicar por qué borrar con POST

## Enunciado

Explica por qué es mejor borrar con:

```html
<form method="post"></form>
```

en lugar de usar un enlace como:

```html
<a href="/books/delete?id=1">Borrar</a>
```

---

<details>
<summary>mostrar solución</summary>

Un enlace normal usa una petición `GET`.

`GET` debería usarse para consultar información, no para modificar datos.

Borrar un libro modifica el estado de la aplicación.

Por eso es mejor usar:

```html
<form method="post"></form>
```

Así el borrado se realiza mediante:

```text
POST /books/delete
```

Esto evita que una simple visita a una URL pueda borrar datos accidentalmente.

</details>

---

# Ejercicio 29 — Diagnosticar errores frecuentes

## Enunciado

Lee cada caso y explica el problema.

## Caso A

En `books/form.jsp` se ha olvidado:

```jsp
<form:hidden path="id" />
```

Al editar, aparece error o no se actualiza el libro correcto.

¿Qué ocurre?

---

## Caso B

El formulario de edición envía a:

```text
/books
```

en lugar de:

```text
/books/update
```

¿Qué puede pasar?

---

## Caso C

En el DAO se escribe:

```sql
UPDATE books
SET title = ?
```

sin `WHERE`.

¿Qué ocurre?

---

## Caso D

El botón de borrar es este:

```jsp
<a href="${pageContext.request.contextPath}/books/delete?id=${book.id}">
    Borrar
</a>
```

¿Qué problema tiene?

---

<details>
<summary>mostrar solución</summary>

## Caso A

El objeto `Book` llega al controlador sin `id`.

Sin `id`, el servicio no sabe qué libro debe actualizar.

La solución es añadir:

```jsp
<form:hidden path="id" />
```

---

## Caso B

Si el formulario de edición envía a:

```text
/books
```

probablemente ejecutará el método de creación.

En lugar de actualizar el libro existente, puede crear un libro nuevo.

La acción de edición debe ser:

```text
/books/update
```

---

## Caso C

Sin `WHERE`, la consulta actualiza todos los registros de la tabla.

Incorrecto:

```sql
UPDATE books
SET title = ?
```

Correcto:

```sql
UPDATE books
SET title = ?
WHERE id = ?
```

---

## Caso D

Ese enlace usa `GET`.

No es recomendable borrar datos con `GET`.

Es mejor usar un formulario con:

```html
method="post"
```

y enviar el `id` en un campo oculto.

</details>

---

# Ejercicio 30 — Reto final: CRUD completo de editoriales

## Enunciado

Crea una sección para gestionar editoriales llamada `Publisher`.

Debe tener estos campos:

| Campo         | Tipo      |
| ------------- | --------- |
| `id`          | `Long`    |
| `name`        | `String`  |
| `country`     | `String`  |
| `foundedYear` | `Integer` |

Debes crear:

1. Modelo `Publisher`.
2. Interfaz `PublisherDao`.
3. Implementación `JdbcPublisherDao`.
4. Servicio `PublisherService`.
5. Controlador `PublisherController`.
6. Vista `publishers/list.jsp`.
7. Vista `publishers/form.jsp`.

Debe permitir:

```text
Listar editoriales.
Crear editorial.
Editar editorial.
Borrar editorial.
```

---

<details>
<summary>mostrar solución</summary>

## Modelo `Publisher.java`

```java
package com.example.library.model;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Publisher {

    private Long id;

    @NotBlank(message = "El nombre es obligatorio.")
    private String name;

    @NotBlank(message = "El país es obligatorio.")
    private String country;

    @NotNull(message = "El año de fundación es obligatorio.")
    @Min(value = 1400, message = "El año debe ser mayor o igual a 1400.")
    private Integer foundedYear;
}
```

## Interfaz `PublisherDao.java`

```java
package com.example.library.dao;

import com.example.library.model.Publisher;

import java.util.List;

public interface PublisherDao {

    List<Publisher> findAll();

    Publisher findById(Long id);

    void save(Publisher publisher);

    void update(Publisher publisher);

    void deleteById(Long id);
}
```

## Implementación `JdbcPublisherDao.java`

```java
package com.example.library.dao;

import com.example.library.model.Publisher;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class JdbcPublisherDao implements PublisherDao {

    private final JdbcTemplate jdbcTemplate;

    public JdbcPublisherDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Publisher> publisherRowMapper = (resultSet, rowNumber) ->
            new Publisher(
                    resultSet.getLong("id"),
                    resultSet.getString("name"),
                    resultSet.getString("country"),
                    resultSet.getInt("founded_year")
            );

    @Override
    public List<Publisher> findAll() {
        String sql = """
                SELECT id, name, country, founded_year
                FROM publishers
                ORDER BY id
                """;

        return jdbcTemplate.query(sql, publisherRowMapper);
    }

    @Override
    public Publisher findById(Long id) {
        String sql = """
                SELECT id, name, country, founded_year
                FROM publishers
                WHERE id = ?
                """;

        List<Publisher> publishers = jdbcTemplate.query(sql, publisherRowMapper, id);

        return publishers.stream()
                .findFirst()
                .orElse(null);
    }

    @Override
    public void save(Publisher publisher) {
        String sql = """
                INSERT INTO publishers (name, country, founded_year)
                VALUES (?, ?, ?)
                """;

        jdbcTemplate.update(
                sql,
                publisher.getName(),
                publisher.getCountry(),
                publisher.getFoundedYear()
        );
    }

    @Override
    public void update(Publisher publisher) {
        String sql = """
                UPDATE publishers
                SET name = ?, country = ?, founded_year = ?
                WHERE id = ?
                """;

        jdbcTemplate.update(
                sql,
                publisher.getName(),
                publisher.getCountry(),
                publisher.getFoundedYear(),
                publisher.getId()
        );
    }

    @Override
    public void deleteById(Long id) {
        String sql = """
                DELETE FROM publishers
                WHERE id = ?
                """;

        jdbcTemplate.update(sql, id);
    }
}
```

## Servicio `PublisherService.java`

```java
package com.example.library.service;

import com.example.library.dao.PublisherDao;
import com.example.library.model.Publisher;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PublisherService {

    private final PublisherDao publisherDao;

    public PublisherService(PublisherDao publisherDao) {
        this.publisherDao = publisherDao;
    }

    public List<Publisher> findAll() {
        return publisherDao.findAll();
    }

    public Publisher findById(Long id) {
        return publisherDao.findById(id);
    }

    public void save(Publisher publisher) {
        publisherDao.save(publisher);
    }

    public void update(Publisher publisher) {
        publisherDao.update(publisher);
    }

    public void deleteById(Long id) {
        publisherDao.deleteById(id);
    }
}
```

## Controlador `PublisherController.java`

```java
package com.example.library.controller;

import com.example.library.model.Publisher;
import com.example.library.service.PublisherService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/publishers")
public class PublisherController {

    private final PublisherService publisherService;

    public PublisherController(PublisherService publisherService) {
        this.publisherService = publisherService;
    }

    @GetMapping
    public String listPublishers(Model model) {
        model.addAttribute("pageTitle", "Listado de editoriales");
        model.addAttribute("publishers", publisherService.findAll());

        return "publishers/list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("pageTitle", "Crear editorial");
        model.addAttribute("formAction", "/publishers");
        model.addAttribute("buttonText", "Crear editorial");
        model.addAttribute("publisher", new Publisher());

        return "publishers/form";
    }

    @PostMapping
    public String createPublisher(
            @Valid @ModelAttribute("publisher") Publisher publisher,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("pageTitle", "Crear editorial");
            model.addAttribute("formAction", "/publishers");
            model.addAttribute("buttonText", "Crear editorial");

            return "publishers/form";
        }

        publisherService.save(publisher);
        redirectAttributes.addFlashAttribute("successMessage", "Editorial creada correctamente.");

        return "redirect:/publishers";
    }

    @GetMapping("/edit")
    public String showEditForm(
            @RequestParam("id") Long id,
            Model model) {

        Publisher publisher = publisherService.findById(id);

        model.addAttribute("pageTitle", "Editar editorial");
        model.addAttribute("formAction", "/publishers/update");
        model.addAttribute("buttonText", "Actualizar editorial");
        model.addAttribute("publisher", publisher);

        return "publishers/form";
    }

    @PostMapping("/update")
    public String updatePublisher(
            @Valid @ModelAttribute("publisher") Publisher publisher,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("pageTitle", "Editar editorial");
            model.addAttribute("formAction", "/publishers/update");
            model.addAttribute("buttonText", "Actualizar editorial");

            return "publishers/form";
        }

        publisherService.update(publisher);
        redirectAttributes.addFlashAttribute("successMessage", "Editorial actualizada correctamente.");

        return "redirect:/publishers";
    }

    @PostMapping("/delete")
    public String deletePublisher(
            @RequestParam("id") Long id,
            RedirectAttributes redirectAttributes) {

        publisherService.deleteById(id);
        redirectAttributes.addFlashAttribute("successMessage", "Editorial borrada correctamente.");

        return "redirect:/publishers";
    }
}
```

## Vista `publishers/list.jsp`

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

<main class="container">
    <section class="card wide">
        <h1>${pageTitle}</h1>

        <c:if test="${not empty successMessage}">
            <div class="success">
                ${successMessage}
            </div>
        </c:if>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/publishers/new">
                Crear editorial
            </a>
        </p>

        <table class="table">
            <thead>
            <tr>
                <th>Nombre</th>
                <th>País</th>
                <th>Año de fundación</th>
                <th>Acción</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="publisher" items="${publishers}">
                <tr>
                    <td>${publisher.name}</td>
                    <td>${publisher.country}</td>
                    <td>${publisher.foundedYear}</td>
                    <td class="actions-cell">
                        <a href="${pageContext.request.contextPath}/publishers/edit?id=${publisher.id}">
                            Editar
                        </a>

                        <form method="post"
                              action="${pageContext.request.contextPath}/publishers/delete"
                              class="inline-form"
                              onsubmit="return confirm('¿Seguro que quieres borrar esta editorial?');">

                            <input type="hidden" name="id" value="${publisher.id}">

                            <button type="submit" class="link-button">
                                Borrar
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </section>
</main>

</body>
</html>
```

## Vista `publishers/form.jsp`

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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

        <form:form
                method="post"
                action="${pageContext.request.contextPath}${formAction}"
                modelAttribute="publisher"
                cssClass="form">

            <form:hidden path="id" />

            <div class="form-group">
                <form:label path="name">Nombre</form:label>
                <form:input path="name" cssClass="input" />
                <form:errors path="name" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="country">País</form:label>
                <form:input path="country" cssClass="input" />
                <form:errors path="country" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="foundedYear">Año de fundación</form:label>
                <form:input path="foundedYear" type="number" cssClass="input" />
                <form:errors path="foundedYear" cssClass="error" />
            </div>

            <div class="form-actions">
                <button type="submit" class="button">
                    ${buttonText}
                </button>

                <a class="secondary-button" href="${pageContext.request.contextPath}/publishers">
                    Cancelar
                </a>
            </div>

        </form:form>
    </section>
</main>

</body>
</html>
```

### Explicación

Este reto reúne todo el CRUD:

```text
Crear
Listar
Editar
Borrar
```

También reutiliza un único formulario para crear y editar.

El campo:

```jsp
<form:hidden path="id" />
```

permite conservar el identificador durante la edición.

</details>

---
