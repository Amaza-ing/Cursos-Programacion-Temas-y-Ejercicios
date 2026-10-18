# Solved exercises — Topic 7: Complete CRUD in Spring MVC

## Introduction

In these exercises you'll practice how to complete a CRUD in a Spring MVC application.

In Topic 7 we added the missing operations to complete the full data management cycle:

```text
Create  → Crear
Read    → Leer
Update  → Actualizar
Delete  → Borrar
```

Instead of courses, in these exercises we'll work with a small **book** management application. That way you'll practice the same flow, but with a different example.

You'll practice:

- Adding `update` and `deleteById` methods to the DAO.
- Implementing `UPDATE` and `DELETE` with `JdbcTemplate`.
- Updating the service layer.
- Creating edit and delete routes in the controller.
- Reusing one form to create and edit.
- Using a hidden field to keep the `id`.
- Adding edit and delete buttons to the list.
- Deleting with `POST`.
- Showing success messages with `RedirectAttributes`.
- Diagnosing typical CRUD errors.

Each solution is hidden under the **show solution** button.

---

# Exercise 1 — Recognize the CRUD operations

## Statement

Complete the table by indicating which CRUD operation corresponds to each action.

| Action | CRUD operation |
| -------------------------- | -------------- |
| Create a new book | ?              |
| View all books | ?              |
| View the details of a book | ?              |
| Edit an existing book | ?              |
| Delete a book | ?              |

---

<details>
<summary>Show solution</summary>

| Action | CRUD operation |
| -------------------------- | -------------- |
| Create a new book | Create |
| View all books | Read |
| View the details of a book | Read |
| Edit an existing book | Update |
| Delete a book | Delete |

### Explanation

CRUD sums up the four basic operations of a management application:

```text
Create  → insertar datos nuevos
Read    → consultar datos
Update  → modificar datos existentes
Delete  → eliminar datos
```

In a Spring MVC application, these operations are usually split between the controller, service, DAO, JSP views and database.

</details>

---

# Exercise 2 — Design the routes for the complete CRUD

## Statement

We already have these routes in a book application:

```text
GET  /books             → listado de libros
GET  /books/detail?id=1 → detalle de un libro
GET  /books/new         → formulario de creación
POST /books             → guardar libro nuevo
```

Add the routes needed to:

1. Show the edit form.
2. Process the edit.
3. Delete a book.

---

<details>
<summary>Show solution</summary>

```text
GET  /books/edit?id=1   → mostrar formulario de edición
POST /books/update      → procesar edición
POST /books/delete      → borrar libro
```

### Explanation

Editing requires two steps.

First we show the form with the existing data:

```text
GET /books/edit?id=1
```

Then we process the edited form:

```text
POST /books/update
```

To delete, we use `POST`:

```text
POST /books/delete
```

We don't use `GET` to delete because deleting data changes the state of the application.

</details>

---

# Exercise 3 — Create the `books` table

## Statement

Create a MySQL table named `books`.

It must have these fields:

| Column | Type | Constraint |
| ---------- | -------------- | --------------------------- |
| `id` | `BIGINT` | Auto-increment primary key |
| `title` | `VARCHAR(100)` | Required |
| `author` | `VARCHAR(80)` | Required |
| `category` | `VARCHAR(40)` | Required |
| `pages` | `INT` | Required |

---

<details>
<summary>Show solution</summary>

```sql
CREATE TABLE IF NOT EXISTS books (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(80) NOT NULL,
    category VARCHAR(40) NOT NULL,
    pages INT NOT NULL
);
```

### Explanation

`id` identifies each book.

`AUTO_INCREMENT` lets MySQL generate the identifier automatically.

The other columns use `NOT NULL`, so they must always have a value.

</details>

---

# Exercise 4 — Insert initial data

## Statement

Insert three initial books into the `books` table.

Use this data:

| title | author | category | pages |
| ------------- | ------------------------ | -------- | ----- |
| Frankenstein | Mary Shelley | Novela | 280 |
| El Hobbit | J. R. R. Tolkien | Fantasía | 310 |
| El principito | Antoine de Saint-Exupéry | Fábula | 96 |

Then write a query to check the data.

---

<details>
<summary>Show solution</summary>

```sql
INSERT INTO books (title, author, category, pages)
VALUES
    ('Frankenstein', 'Mary Shelley', 'Novela', 280),
    ('El Hobbit', 'J. R. R. Tolkien', 'Fantasía', 310),
    ('El principito', 'Antoine de Saint-Exupéry', 'Fábula', 96);

SELECT * FROM books;
```

### Explanation

We don't insert the `id` because MySQL generates it automatically.

The query:

```sql
SELECT * FROM books;
```

lets you check in DBeaver that the books have been saved.

</details>

---

# Exercise 5 — Create the `Book` model

## Statement

Create a `Book` class in the package:

```text
com.example.library.model
```

It must have:

```text
id
title
author
category
pages
```

Use Lombok to generate getters, setters and constructors.

Add these validations:

| Field | Validation |
| ---------- | ------------------------------------- |
| `title` | Required, between 3 and 100 characters |
| `author` | Required |
| `category` | Required |
| `pages` | Required, minimum 1, maximum 3000 |

---

<details>
<summary>Show solution</summary>

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

### Explanation

`@Data` generates getters and setters.

`@NoArgsConstructor` generates the empty constructor.

`@AllArgsConstructor` generates the constructor with all the fields.

The `pages` field is `Integer`, not `int`, because if the user leaves the field empty we need to be able to represent `null`.

</details>

---

# Exercise 6 — Extend the `BookDao` interface

## Statement

You have this interface:

```java
public interface BookDao {

    List<Book> findAll();

    Book findById(Long id);

    void save(Book book);
}
```

Extend it to complete the CRUD.

It must include methods to update and delete.

---

<details>
<summary>Show solution</summary>

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

### Explanation

We add:

```java
void update(Book book);
```

to modify an existing book.

We add:

```java
void deleteById(Long id);
```

to delete a book by its identifier.

The interface defines which operations exist, but it doesn't contain any SQL.

</details>

---

# Exercise 7 — Create the `RowMapper` for `Book`

## Statement

Inside `JdbcBookDao`, create a `RowMapper<Book>` that converts the columns of the `books` table into a `Book` object.

Columns:

```text
id
title
author
category
pages
```

---

<details>
<summary>Show solution</summary>

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

### Explanation

An SQL query returns rows.

Java works with objects.

The `RowMapper` transforms each row of the result into a `Book` object.

</details>

---

# Exercise 8 — Implement `findAll` and `findById`

## Statement

Implement the `findAll` and `findById` methods in `JdbcBookDao`.

`findAll` must return all the books sorted by `id`.

`findById` must look up a book by its identifier and return `null` if it doesn't exist.

---

<details>
<summary>Show solution</summary>

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

### Explanation

`findAll` returns the whole list.

`findById` uses:

```sql
WHERE id = ?
```

to look up a single record.

If there are no results, it returns `null`.

</details>

---

# Exercise 9 — Implement `save`

## Statement

Implement the `save(Book book)` method in `JdbcBookDao`.

It must insert a new book into the `books` table.

It must not insert the `id`, because MySQL generates it automatically.

---

<details>
<summary>Show solution</summary>

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

### Explanation

The query:

```sql
INSERT INTO books (title, author, category, pages)
VALUES (?, ?, ?, ?)
```

creates a new book.

We don't include `id` because the column is `AUTO_INCREMENT`.

</details>

---

# Exercise 10 — Implement `update`

## Statement

Implement the `update(Book book)` method in `JdbcBookDao`.

It must update:

```text
title
author
category
pages
```

of the book whose `id` matches.

---

<details>
<summary>Show solution</summary>

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

### Explanation

The query:

```sql
UPDATE books
SET title = ?, author = ?, category = ?, pages = ?
WHERE id = ?
```

modifies only the book whose `id` matches.

The most important part is:

```sql
WHERE id = ?
```

Without that condition, every book in the table would be updated.

</details>

---

# Exercise 11 — Implement `deleteById`

## Statement

Implement the `deleteById(Long id)` method in `JdbcBookDao`.

It must delete the book whose identifier matches from the `books` table.

---

<details>
<summary>Show solution</summary>

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

### Explanation

The query:

```sql
DELETE FROM books
WHERE id = ?
```

deletes only the given book.

Without `WHERE`, we would delete every record in the table.

</details>

---

# Exercise 12 — Create `BookNotFoundException`

## Statement

Create a custom exception called `BookNotFoundException`.

It must:

1. Be in the `com.example.library.exception` package.
2. Extend `RuntimeException`.
3. Store the `bookId`.
4. Have a getter for `bookId`.

---

<details>
<summary>Show solution</summary>

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

### Explanation

This exception will be thrown when someone tries to view, edit or delete a book that doesn't exist.

This way we avoid handling `null` manually in every controller.

</details>

---

# Exercise 13 — Create the complete `BookService`

## Statement

Create a `BookService` service.

It must:

1. Be annotated with `@Service`.
2. Receive `BookDao` through its constructor.
3. Have these methods:
   - `findAll`
   - `findById`
   - `findByIdOrThrow`
   - `save`
   - `update`
   - `deleteById`

In `update`, it must first check that the book exists.

In `deleteById`, it must first check that the book exists.

---

<details>
<summary>Show solution</summary>

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

### Explanation

In `update` we first look up the existing book.

This lets us check that it really exists before updating it.

In `deleteById` we also check that it exists before deleting.

</details>

---

# Exercise 14 — Add internationalization messages

## Statement

Add message keys for the book CRUD actions.

Create the Spanish keys for:

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
<summary>Show solution</summary>

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

### Explanation

These keys let us avoid hard-coded text in the JSPs and in the controller.

For example:

```jsp
<spring:message code="books.edit" />
```

or:

```java
messageSource.getMessage("success.book.updated", null, locale);
```

</details>

---

# Exercise 15 — Create the method to list the books

## Statement

Create the `listBooks` method in `BookController`.

It must:

1. Respond to `GET /books`.
2. Add to the model:
   - `pageTitleCode` with `books.list.title`.
   - `books` with the list of books.
3. Return the `books/list` view.

---

<details>
<summary>Show solution</summary>

```java
@GetMapping
public String listBooks(Model model) {
    model.addAttribute("pageTitleCode", "books.list.title");
    model.addAttribute("books", bookService.findAll());

    return "books/list";
}
```

### Explanation

Since the controller will have:

```java
@RequestMapping("/books")
```

this method responds to:

```text
GET /books
```

The list of books comes from the service:

```java
bookService.findAll()
```

</details>

---

# Exercise 16 — Show the create form

## Statement

Create the `showCreateForm` method in `BookController`.

It must respond to:

```text
GET /books/new
```

It must add to the model:

| Attribute | Value |
| --------------- | -------------------- |
| `pageTitleCode` | `books.create.title` |
| `formAction` | `/books` |
| `submitCode` | `books.create` |
| `book` | `new Book()` |

It must return:

```text
books/form
```

---

<details>
<summary>Show solution</summary>

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

### Explanation

We use `formAction` and `submitCode` so we can reuse the same form for creating and editing.

When creating, the `book` object is empty.

</details>

---

# Exercise 17 — Process the creation of a book

## Statement

Create the `createBook` method in `BookController`.

It must respond to:

```text
POST /books
```

It must:

1. Receive `Book` with `@Valid` and `@ModelAttribute("book")`.
2. Receive `BindingResult`.
3. If there are errors, return to `books/form`.
4. If there are no errors, save the book.
5. Add the flash message `success.book.created`.
6. Redirect to `/books`.

---

<details>
<summary>Show solution</summary>

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

### Explanation

If there are validation errors, we return to the form.

It's important to add these again:

```java
pageTitleCode
formAction
submitCode
```

because the view needs them.

</details>

---

# Exercise 18 — Show the edit form

## Statement

Create the `showEditForm` method in `BookController`.

It must respond to:

```text
GET /books/edit?id=1
```

It must:

1. Receive the `id` parameter.
2. Look up the book with `bookService.findByIdOrThrow(id)`.
3. Add to the model:
   - `pageTitleCode` with `books.edit.title`.
   - `formAction` with `/books/update`.
   - `submitCode` with `books.update`.
   - `book` with the book found.
4. Return the `books/form` view.

---

<details>
<summary>Show solution</summary>

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

### Explanation

This method doesn't create an empty book.

It looks up an existing book and sends it to the form.

That way the form appears filled in with the current data.

</details>

---

# Exercise 19 — Process the editing of a book

## Statement

Create the `updateBook` method in `BookController`.

It must respond to:

```text
POST /books/update
```

It must:

1. Receive `Book` with `@Valid` and `@ModelAttribute("book")`.
2. Receive `BindingResult`.
3. If there are errors, return to the edit form.
4. If there are no errors, update the book.
5. Add the flash message `success.book.updated`.
6. Redirect to `/books`.

---

<details>
<summary>Show solution</summary>

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

### Explanation

This method is similar to the create method, but it calls:

```java
bookService.update(book);
```

instead of:

```java
bookService.save(book);
```

</details>

---

# Exercise 20 — Delete a book

## Statement

Create the `deleteBook` method in `BookController`.

It must respond to:

```text
POST /books/delete
```

It must:

1. Receive the `id` parameter.
2. Delete the book with `bookService.deleteById(id)`.
3. Add the flash message `success.book.deleted`.
4. Redirect to `/books`.

---

<details>
<summary>Show solution</summary>

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

### Explanation

We delete using `POST`, not `GET`.

This is important because deleting changes data.

After deleting, we redirect to the list.

</details>

---

# Exercise 21 — Create a private method for flash messages

## Statement

In `BookController`, create a private method called `addFlashMessage`.

It must:

1. Receive `RedirectAttributes`.
2. Receive a message code.
3. Get the current language with `LocaleContextHolder`.
4. Get the message using `MessageSource`.
5. Add it as `successMessage`.

---

<details>
<summary>Show solution</summary>

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

### Required imports

```java
import org.springframework.context.i18n.LocaleContextHolder;

import java.util.Locale;
```

### Explanation

This method saves us from repeating code every time we want to show a success message.

For example:

```java
addFlashMessage(redirectAttributes, "success.book.updated");
```

</details>

---

# Exercise 22 — Create a reusable `books/form.jsp`

## Statement

Create a `books/form.jsp` view that works for both creating and editing books.

It must:

1. Use `<form:form>`.
2. Use `modelAttribute="book"`.
3. Submit the form to `${formAction}`.
4. Include a hidden field for `id`.
5. Have these fields:
   - `title`
   - `author`
   - `category`
   - `pages`
6. Show validation errors.
7. Use `${submitCode}` for the button text.

---

<details>
<summary>Show solution</summary>

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

### Explanation

The most important part for editing is:

```jsp
<form:hidden path="id" />
```

This field keeps the book's identifier.

Without that field, the object could reach the controller with `id = null`.

</details>

---

# Exercise 23 — Create global categories for the form

## Statement

The `books/form.jsp` view uses:

```jsp
${bookCategories}
```

Create a `GlobalModelAttributes` class that adds that list to the model.

The categories will be:

```text
Novela
Ensayo
Poesía
Teatro
Ciencia ficción
```

---

<details>
<summary>Show solution</summary>

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

### Explanation

The annotation:

```java
@ControllerAdvice
```

makes this attribute available in several views.

The method:

```java
@ModelAttribute("bookCategories")
```

adds a list to the model that can be used in the JSPs.

</details>

---

# Exercise 24 — Update the list with actions

## Statement

Create the actions part of `books/list.jsp`.

For each book, it must show:

1. A link to view the details.
2. A link to edit.
3. A `POST` form to delete.

The delete button must ask for confirmation before submitting the form.

---

<details>
<summary>Show solution</summary>

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

### Explanation

The edit link uses `GET` because it only shows a form.

Deleting uses `POST` because it changes data.

The `id` is sent in a hidden field.

</details>

---

# Exercise 25 — Create the complete `books/list.jsp`

## Statement

Create a `books/list.jsp` view with:

1. A table of books.
2. A success message if `successMessage` exists.
3. A button to create a book.
4. Details, edit and delete actions.

---

<details>
<summary>Show solution</summary>

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

### Explanation

Each row has three actions:

```text
Ver detalle
Editar
Borrar
```

Deleting is done with a `POST` form.

</details>

---

# Exercise 26 — Add styles for the actions

## Statement

Add CSS styles so the table actions appear inline.

Create styles for:

```text
.actions-cell
.inline-form
.link-button
.link-button:hover
```

---

<details>
<summary>Show solution</summary>

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

### Explanation

`.actions-cell` places the actions inline.

`.inline-form` prevents the delete form from taking up an entire line.

`.link-button` makes the delete button look like a link.

</details>

---

# Exercise 27 — Explain why the hidden `id` field is needed

## Statement

This line appears in the edit form:

```jsp
<form:hidden path="id" />
```

Explain what it is for and what problem we would have if we removed it.

---

<details>
<summary>Show solution</summary>

The hidden field keeps the identifier of the book we are editing.

When the user submits the form, Spring populates the `Book` object.

Thanks to:

```jsp
<form:hidden path="id" />
```

the object arrives with its `id`.

That value is needed to run:

```sql
UPDATE books
SET ...
WHERE id = ?
```

If we remove the hidden field, the object could arrive with `id = null`.

Then the service wouldn't know which book to update.

</details>

---

# Exercise 28 — Explain why we delete with POST

## Statement

Explain why it's better to delete with:

```html
<form method="post"></form>
```

instead of using a link like:

```html
<a href="/books/delete?id=1">Borrar</a>
```

---

<details>
<summary>Show solution</summary>

A normal link uses a `GET` request.

`GET` should be used to query information, not to modify data.

Deleting a book changes the state of the application.

That's why it's better to use:

```html
<form method="post"></form>
```

That way, the deletion is done through:

```text
POST /books/delete
```

This prevents a simple visit to a URL from deleting data by accident.

</details>

---

# Exercise 29 — Diagnose common errors

## Statement

Read each case and explain the problem.

## Case A

In `books/form.jsp`, someone forgot:

```jsp
<form:hidden path="id" />
```

When editing, an error appears or the right book isn't updated.

What happens?

---

## Case B

The edit form submits to:

```text
/books
```

instead of:

```text
/books/update
```

What can happen?

---

## Case C

In the DAO, someone wrote:

```sql
UPDATE books
SET title = ?
```

without `WHERE`.

What happens?

---

## Case D

The delete button is this:

```jsp
<a href="${pageContext.request.contextPath}/books/delete?id=${book.id}">
    Borrar
</a>
```

What's wrong with it?

---

<details>
<summary>Show solution</summary>

## Case A

The `Book` object reaches the controller without an `id`.

Without an `id`, the service doesn't know which book to update.

The solution is to add:

```jsp
<form:hidden path="id" />
```

---

## Case B

If the edit form submits to:

```text
/books
```

it will probably run the create method.

Instead of updating the existing book, it may create a new book.

The edit action must be:

```text
/books/update
```

---

## Case C

Without `WHERE`, the query updates every record in the table.

Incorrect:

```sql
UPDATE books
SET title = ?
```

Correct:

```sql
UPDATE books
SET title = ?
WHERE id = ?
```

---

## Case D

That link uses `GET`.

Deleting data with `GET` isn't recommended.

It's better to use a form with:

```html
method="post"
```

and send the `id` in a hidden field.

</details>

---

# Exercise 30 — Final challenge: complete CRUD for publishers

## Statement

Create a section to manage publishers called `Publisher`.

It must have these fields:

| Field | Type |
| ------------- | --------- |
| `id` | `Long` |
| `name` | `String` |
| `country` | `String` |
| `foundedYear` | `Integer` |

You must create:

1. The `Publisher` model.
2. The `PublisherDao` interface.
3. The `JdbcPublisherDao` implementation.
4. The `PublisherService` service.
5. The `PublisherController` controller.
6. The `publishers/list.jsp` view.
7. The `publishers/form.jsp` view.

It must allow:

```text
Listar editoriales.
Crear editorial.
Editar editorial.
Borrar editorial.
```

---

<details>
<summary>Show solution</summary>

## `Publisher.java` model

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

## `PublisherDao.java` interface

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

## `JdbcPublisherDao.java` implementation

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

## `PublisherService.java` service

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

## `PublisherController.java` controller

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

## `publishers/list.jsp` view

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

## `publishers/form.jsp` view

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

### Explanation

This challenge brings the whole CRUD together:

```text
Crear
Listar
Editar
Borrar
```

It also reuses a single form for creating and editing.

The field:

```jsp
<form:hidden path="id" />
```

lets us keep the identifier during editing.

</details>

---
