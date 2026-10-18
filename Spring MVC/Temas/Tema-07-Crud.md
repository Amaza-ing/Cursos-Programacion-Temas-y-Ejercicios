# Topic 7 — Completing the CRUD: editing and deleting courses in Spring MVC

## 1. Objective of the topic

In the previous topics we have built a Spring MVC application that already lets you:

```text
Ver el listado de cursos.
Ver el detalle de un curso.
Crear un curso nuevo mediante formulario.
Validar los datos del formulario.
Guardar cursos en MySQL.
Gestionar errores.
Usar internacionalización.
Aplicar pequeñas mejoras al proyecto.
```

In this **Topic 7** we are going to complete the CRUD.

CRUD means:

```text
Create  → Crear
Read    → Leer
Update  → Actualizar
Delete  → Borrar
```

Until now our application already had part of the CRUD:

| Operation | Status |
| ------------- | ----------------------- |
| Create courses | Already done |
| View courses | Already done |
| Edit courses | We will do it in this topic |
| Delete courses | We will do it in this topic |

By the end of this topic, our application will let you:

```text
1. Ver todos los cursos.
2. Ver el detalle de un curso.
3. Crear un curso.
4. Editar un curso existente.
5. Borrar un curso existente.
```

---

# 2. What we are going to build

We are going to add new routes to `CourseController`.

We currently have routes similar to these:

```text
GET  /courses             → Listado de cursos
GET  /courses/detail?id=1 → Detalle de un curso
GET  /courses/new         → Formulario de creación
POST /courses             → Guardar curso nuevo
```

In this topic we will add:

```text
GET  /courses/edit?id=1   → Mostrar formulario de edición
POST /courses/update      → Procesar edición
POST /courses/delete      → Borrar curso
```

The complete flow will be:

```text
Editar curso
------------
Listado de cursos
↓
Botón Editar
↓
GET /courses/edit?id=1
↓
Formulario con datos actuales del curso
↓
POST /courses/update
↓
Validación
↓
UPDATE en MySQL
↓
Redirección al listado


Borrar curso
------------
Listado de cursos
↓
Botón Borrar
↓
POST /courses/delete
↓
DELETE en MySQL
↓
Redirección al listado
```

---

# 3. Starting point

We start from the previous application, where we already have a structure similar to this:

```text
spring-mvc-project
│
├── pom.xml
│
└── src
    └── main
        ├── java
        │   └── com
        │       └── example
        │           └── springmvcday1
        │               ├── config
        │               │   └── GlobalModelAttributes.java
        │               │
        │               ├── controller
        │               │   ├── HomeController.java
        │               │   ├── CourseController.java
        │               │   └── ThemeController.java
        │               │
        │               ├── dao
        │               │   ├── CourseDao.java
        │               │   └── JdbcCourseDao.java
        │               │
        │               ├── exception
        │               │   ├── CourseNotFoundException.java
        │               │   └── GlobalExceptionHandler.java
        │               │
        │               ├── model
        │               │   └── Course.java
        │               │
        │               └── service
        │                   └── CourseService.java
        │
        ├── resources
        │   ├── database.properties
        │   ├── messages.properties
        │   ├── messages_es.properties
        │   └── messages_en.properties
        │
        └── webapp
            ├── resources
            │   └── css
            │       ├── styles.css
            │       └── styles-dark.css
            │
            └── WEB-INF
                ├── web.xml
                ├── spring
                │   └── app-servlet.xml
                │
                └── views
                    ├── fragments
                    │   ├── head.jspf
                    │   └── header.jspf
                    │
                    ├── courses
                    │   ├── list.jsp
                    │   ├── detail.jsp
                    │   └── form.jsp
                    │
                    └── error
                        ├── course-not-found.jsp
                        ├── general-error.jsp
                        └── not-found.jsp
```

We also start from a MySQL table like this:

```sql
CREATE TABLE IF NOT EXISTS courses (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(80) NOT NULL,
    level VARCHAR(30) NOT NULL,
    duration_in_hours INT NOT NULL
);
```

---

# 4. A reminder of the `Course` model

After applying the improvements from Topic 6, our `Course` class may be using Lombok.

File:

```text
src/main/java/com/example/springmvcday1/model/Course.java
```

Code:

```java
package com.example.springmvcday1.model;

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
public class Course {

    private Long id;

    @NotBlank(message = "{course.title.notBlank}")
    @Size(min = 3, max = 80, message = "{course.title.size}")
    private String title;

    @NotBlank(message = "{course.level.notBlank}")
    private String level;

    @NotNull(message = "{course.duration.notNull}")
    @Min(value = 1, message = "{course.duration.min}")
    @Max(value = 200, message = "{course.duration.max}")
    private Integer durationInHours;
}
```

## Explanation

This class represents a course.

It has the fields:

```text
id
title
level
durationInHours
```

The `id` field allows us to identify which course we want to edit or delete.

That is why in this topic it will be very important to preserve the `id` when we show the edit form.

---

[![Full CRUD](https://img.youtube.com/vi/YEoaT7bY1Ws/0.jpg)](https://www.youtube.com/watch?v=YEoaT7bY1Ws&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

# 5. Step 1 — Extend the `CourseDao` interface

Until now our `CourseDao` interface had methods for:

```text
findAll()
findById()
save()
```

Now we need to add:

```text
update()
deleteById()
```

File:

```text
src/main/java/com/example/springmvcday1/dao/CourseDao.java
```

Updated code:

```java
package com.example.springmvcday1.dao;

import com.example.springmvcday1.model.Course;

import java.util.List;

public interface CourseDao {

    List<Course> findAll();

    Course findById(Long id);

    void save(Course course);

    void update(Course course);

    void deleteById(Long id);
}
```

## Explanation

We add this method:

```java
void update(Course course);
```

We will use it to modify an existing course in MySQL.

The `Course` object must arrive with its `id`, because we need to know which row of the table to update.

We also add:

```java
void deleteById(Long id);
```

We will use it to delete a course by its identifier.

The interface does not contain SQL. It only defines what operations our data access layer should offer.

---

# 6. Step 2 — Implement `update` and `deleteById` in `JdbcCourseDao`

Now we update the JDBC implementation.

File:

```text
src/main/java/com/example/springmvcday1/dao/JdbcCourseDao.java
```

Updated full code:

```java
package com.example.springmvcday1.dao;

import com.example.springmvcday1.model.Course;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;

@Repository
public class JdbcCourseDao implements CourseDao {

    private final JdbcTemplate jdbcTemplate;

    public JdbcCourseDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Course> courseRowMapper = (resultSet, rowNumber) ->
            new Course(
                    resultSet.getLong("id"),
                    resultSet.getString("title"),
                    resultSet.getString("level"),
                    resultSet.getInt("duration_in_hours")
            );

    @Override
    public List<Course> findAll() {
        String sql = """
                SELECT id, title, level, duration_in_hours
                FROM courses
                ORDER BY id
                """;

        return jdbcTemplate.query(sql, courseRowMapper);
    }

    @Override
    public Course findById(Long id) {
        String sql = """
                SELECT id, title, level, duration_in_hours
                FROM courses
                WHERE id = ?
                """;

        List<Course> courses = jdbcTemplate.query(sql, courseRowMapper, id);

        return courses.stream()
                .findFirst()
                .orElse(null);
    }

    @Override
    public void save(Course course) {
        String sql = """
                INSERT INTO courses (title, level, duration_in_hours)
                VALUES (?, ?, ?)
                """;

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    Statement.RETURN_GENERATED_KEYS
            );

            preparedStatement.setString(1, course.getTitle());
            preparedStatement.setString(2, course.getLevel());
            preparedStatement.setInt(3, course.getDurationInHours());

            return preparedStatement;
        }, keyHolder);

        Number generatedId = keyHolder.getKey();

        if (generatedId != null) {
            course.setId(generatedId.longValue());
        }
    }

    @Override
    public void update(Course course) {
        String sql = """
                UPDATE courses
                SET title = ?, level = ?, duration_in_hours = ?
                WHERE id = ?
                """;

        jdbcTemplate.update(
                sql,
                course.getTitle(),
                course.getLevel(),
                course.getDurationInHours(),
                course.getId()
        );
    }

    @Override
    public void deleteById(Long id) {
        String sql = """
                DELETE FROM courses
                WHERE id = ?
                """;

        jdbcTemplate.update(sql, id);
    }
}
```

---

# 7. Explanation of the `update` method

The new method is:

```java
@Override
public void update(Course course) {
    String sql = """
            UPDATE courses
            SET title = ?, level = ?, duration_in_hours = ?
            WHERE id = ?
            """;

    jdbcTemplate.update(
            sql,
            course.getTitle(),
            course.getLevel(),
            course.getDurationInHours(),
            course.getId()
    );
}
```

The SQL query is:

```sql
UPDATE courses
SET title = ?, level = ?, duration_in_hours = ?
WHERE id = ?
```

This means:

```text
Actualiza la tabla courses.
Cambia el título, el nivel y la duración.
Pero solo en la fila cuyo id coincida.
```

The most important part is:

```sql
WHERE id = ?
```

Without this condition, we would update all the courses in the table.

For example, if the course has:

```java
id = 2
title = "Spring MVC avanzado"
level = "Avanzado"
durationInHours = 30
```

The query will update only the row with `id = 2`.

The order of the values is important:

```java
course.getTitle(),           // primer ?
course.getLevel(),           // segundo ?
course.getDurationInHours(), // tercer ?
course.getId()               // cuarto ?
```

---

# 8. Explanation of the `deleteById` method

The deletion method is:

```java
@Override
public void deleteById(Long id) {
    String sql = """
            DELETE FROM courses
            WHERE id = ?
            """;

    jdbcTemplate.update(sql, id);
}
```

The SQL query is:

```sql
DELETE FROM courses
WHERE id = ?
```

This means:

```text
Borra de la tabla courses
la fila cuyo id coincida con el parámetro.
```

Again, the most important part is:

```sql
WHERE id = ?
```

Without `WHERE`, we would delete all courses.

That's why, when we delete or update data, we must check the condition very carefully.

---

# 9. Step 3 — Update `CourseService`

Now the service must also expose methods for editing and deleting.

File:

```text
src/main/java/com/example/springmvcday1/service/CourseService.java
```

Updated code:

```java
package com.example.springmvcday1.service;

import com.example.springmvcday1.dao.CourseDao;
import com.example.springmvcday1.exception.CourseNotFoundException;
import com.example.springmvcday1.model.Course;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseService {

    private final CourseDao courseDao;

    public CourseService(CourseDao courseDao) {
        this.courseDao = courseDao;
    }

    public List<Course> findAll() {
        return courseDao.findAll();
    }

    public Course findById(Long id) {
        return courseDao.findById(id);
    }

    public Course findByIdOrThrow(Long id) {
        Course course = courseDao.findById(id);

        if (course == null) {
            throw new CourseNotFoundException(id);
        }

        return course;
    }

    public void save(Course course) {
        courseDao.save(course);
    }

    public void update(Course course) {
        Course existingCourse = findByIdOrThrow(course.getId());

        existingCourse.setTitle(course.getTitle());
        existingCourse.setLevel(course.getLevel());
        existingCourse.setDurationInHours(course.getDurationInHours());

        courseDao.update(existingCourse);
    }

    public void deleteById(Long id) {
        findByIdOrThrow(id);
        courseDao.deleteById(id);
    }
}
```

---

# 10. Explanation of the `update` method in the service

The method is:

```java
public void update(Course course) {
    Course existingCourse = findByIdOrThrow(course.getId());

    existingCourse.setTitle(course.getTitle());
    existingCourse.setLevel(course.getLevel());
    existingCourse.setDurationInHours(course.getDurationInHours());

    courseDao.update(existingCourse);
}
```

First we look for the existing course:

```java
Course existingCourse = findByIdOrThrow(course.getId());
```

This has an advantage: if someone tries to edit a course that doesn't exist, we throw our custom exception.

Then we copy the new data:

```java
existingCourse.setTitle(course.getTitle());
existingCourse.setLevel(course.getLevel());
existingCourse.setDurationInHours(course.getDurationInHours());
```

Finally we update the database:

```java
courseDao.update(existingCourse);
```

We could have called this directly:

```java
courseDao.update(course);
```

But searching for the existing course first allows us to verify that it really exists before updating it.

---

# 11. Explanation of the `deleteById` method in the service

The method is:

```java
public void deleteById(Long id) {
    findByIdOrThrow(id);
    courseDao.deleteById(id);
}
```

First we check that the course exists:

```java
findByIdOrThrow(id);
```

If it does not exist, `CourseNotFoundException` is thrown.

If it exists, we delete it:

```java
courseDao.deleteById(id);
```

This prevents the application from trying to silently delete a non-existent course.

---

# 12. Step 4 — Add messages to the internationalization file

Before modifying the controller and views, we will add new message keys.

Files:

```text
src/main/resources/messages.properties
src/main/resources/messages_es.properties
src/main/resources/messages_en.properties
```

We add these keys to `messages.properties` and `messages_es.properties`:

```properties
courses.edit=Editar
courses.delete=Borrar
courses.confirmDelete=¿Seguro que quieres borrar este curso?
courses.edit.title=Editar curso
courses.update=Actualizar curso
success.course.updated=El curso se ha actualizado correctamente.
success.course.deleted=El curso se ha borrado correctamente.
```

And these keys to `messages_en.properties`:

```properties
courses.edit=Edit
courses.delete=Delete
courses.confirmDelete=Are you sure you want to delete this course?
courses.edit.title=Edit course
courses.update=Update course
success.course.updated=The course has been updated successfully.
success.course.deleted=The course has been deleted successfully.
```

## Explanation

These keys will allow us to display texts such as:

```text
Editar
Borrar
Actualizar curso
El curso se ha actualizado correctamente.
```

without writing them directly in the JSP.

This way we keep the internationalization that we had already set up in the previous topic.

---

# 13. Step 5 — Update `CourseController`

Now let's add the edit and delete methods.

File:

```text
src/main/java/com/example/springmvcday1/controller/CourseController.java
```

Updated full code:

```java
package com.example.springmvcday1.controller;

import com.example.springmvcday1.model.Course;
import com.example.springmvcday1.service.CourseService;
import jakarta.validation.Valid;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Locale;

@Controller
@RequestMapping("/courses")
public class CourseController {

    private final CourseService courseService;
    private final MessageSource messageSource;

    public CourseController(
            CourseService courseService,
            MessageSource messageSource) {

        this.courseService = courseService;
        this.messageSource = messageSource;
    }

    @GetMapping
    public String listCourses(Model model) {
        model.addAttribute("pageTitleCode", "courses.list.title");
        model.addAttribute("courses", courseService.findAll());

        return "courses/list";
    }

    @GetMapping("/detail")
    public String courseDetail(@RequestParam("id") Long id, Model model) {
        Course course = courseService.findByIdOrThrow(id);

        model.addAttribute("pageTitle", course.getTitle());
        model.addAttribute("course", course);

        return "courses/detail";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("pageTitleCode", "form.title");
        model.addAttribute("formAction", "/courses");
        model.addAttribute("submitCode", "form.submit");
        model.addAttribute("course", new Course());

        return "courses/form";
    }

    @PostMapping
    public String createCourse(
            @Valid @ModelAttribute("course") Course course,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("pageTitleCode", "form.title");
            model.addAttribute("formAction", "/courses");
            model.addAttribute("submitCode", "form.submit");

            return "courses/form";
        }

        courseService.save(course);

        addFlashMessage(
                redirectAttributes,
                "success.course.created"
        );

        return "redirect:/courses";
    }

    @GetMapping("/edit")
    public String showEditForm(
            @RequestParam("id") Long id,
            Model model) {

        Course course = courseService.findByIdOrThrow(id);

        model.addAttribute("pageTitleCode", "courses.edit.title");
        model.addAttribute("formAction", "/courses/update");
        model.addAttribute("submitCode", "courses.update");
        model.addAttribute("course", course);

        return "courses/form";
    }

    @PostMapping("/update")
    public String updateCourse(
            @Valid @ModelAttribute("course") Course course,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("pageTitleCode", "courses.edit.title");
            model.addAttribute("formAction", "/courses/update");
            model.addAttribute("submitCode", "courses.update");

            return "courses/form";
        }

        courseService.update(course);

        addFlashMessage(
                redirectAttributes,
                "success.course.updated"
        );

        return "redirect:/courses";
    }

    @PostMapping("/delete")
    public String deleteCourse(
            @RequestParam("id") Long id,
            RedirectAttributes redirectAttributes) {

        courseService.deleteById(id);

        addFlashMessage(
                redirectAttributes,
                "success.course.deleted"
        );

        return "redirect:/courses";
    }

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
}
```

---

# 14. General explanation of the updated controller

The controller now has methods for all CRUD operations:

| Method | Route | Function |
| ---------------- | -------------------------- | --------------------------- |
| `listCourses` | `GET /courses` | List courses |
| `courseDetail` | `GET /courses/detail?id=1` | View details |
| `showCreateForm` | `GET /courses/new` | Show creation form |
| `createCourse` | `POST /courses` | Create course |
| `showEditForm` | `GET /courses/edit?id=1` | Show edit form |
| `updateCourse` | `POST /courses/update` | Update course |
| `deleteCourse` | `POST /courses/delete` | Delete course |

Additionally, we have created a private method:

```java
private void addFlashMessage(...)
```

to avoid repeating the code that gets internationalized messages.

---

# 15. Explanation of `showEditForm`

The method is:

```java
@GetMapping("/edit")
public String showEditForm(
        @RequestParam("id") Long id,
        Model model) {

    Course course = courseService.findByIdOrThrow(id);

    model.addAttribute("pageTitleCode", "courses.edit.title");
    model.addAttribute("formAction", "/courses/update");
    model.addAttribute("submitCode", "courses.update");
    model.addAttribute("course", course);

    return "courses/form";
}
```

This method responds to a URL like:

```text
/courses/edit?id=2
```

First it reads the `id` parameter:

```java
@RequestParam("id") Long id
```

Then it looks for the course:

```java
Course course = courseService.findByIdOrThrow(id);
```

If the course exists, it is added to the model:

```java
model.addAttribute("course", course);
```

The view will receive a course with real data, not an empty course.

We also add:

```java
model.addAttribute("formAction", "/courses/update");
model.addAttribute("submitCode", "courses.update");
```

This will allow us to reuse the same `form.jsp` view for creating and editing.

---

# 16. Reuse `form.jsp` for creating and editing

Instead of creating two separate views:

```text
create-form.jsp
edit-form.jsp
```

we are going to reuse:

```text
courses/form.jsp
```

The difference will be:

| Mode | Form action | Button text |
| ------ | --------------------- | ---------------- |
| Create | `/courses` | Create course |
| Edit | `/courses/update` | Update course |

That's why in the controller we send these attributes:

```java
model.addAttribute("formAction", "/courses");
model.addAttribute("submitCode", "form.submit");
```

for creating, and:

```java
model.addAttribute("formAction", "/courses/update");
model.addAttribute("submitCode", "courses.update");
```

for editing.

---

# 17. Explanation of `updateCourse`

The method is:

```java
@PostMapping("/update")
public String updateCourse(
        @Valid @ModelAttribute("course") Course course,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {

    if (bindingResult.hasErrors()) {
        model.addAttribute("pageTitleCode", "courses.edit.title");
        model.addAttribute("formAction", "/courses/update");
        model.addAttribute("submitCode", "courses.update");

        return "courses/form";
    }

    courseService.update(course);

    addFlashMessage(
            redirectAttributes,
            "success.course.updated"
    );

    return "redirect:/courses";
}
```

This method processes the edit form.

It receives the object:

```java
@ModelAttribute("course") Course course
```

Spring fills that object with the data sent by the form.

We also use:

```java
@Valid
```

to validate the data.

If there are errors:

```java
if (bindingResult.hasErrors()) {
```

we go back to the form.

If there are no errors:

```java
courseService.update(course);
```

we update the course.

Then we add a flash message and redirect:

```java
return "redirect:/courses";
```

---

# 18. Explanation of `deleteCourse`

The method is:

```java
@PostMapping("/delete")
public String deleteCourse(
        @RequestParam("id") Long id,
        RedirectAttributes redirectAttributes) {

    courseService.deleteById(id);

    addFlashMessage(
            redirectAttributes,
            "success.course.deleted"
    );

    return "redirect:/courses";
}
```

This method receives the `id` of the course we want to delete.

We use `POST` to delete because deleting data changes the state of the application.

It is not recommended to delete using a `GET` link such as:

```text
/courses/delete?id=1
```

It is better to use a form with the `POST` method.

After deleting, we redirect to the list.

---

# 19. Explanation of `addFlashMessage`

We have created this private method:

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

We use it to avoid repeating this block several times:

```java
Locale locale = LocaleContextHolder.getLocale();

String message = messageSource.getMessage(
        "success.course.created",
        null,
        locale
);

redirectAttributes.addFlashAttribute("successMessage", message);
```

Now, when we want to add a flash message, we just do:

```java
addFlashMessage(redirectAttributes, "success.course.updated");
```

This makes the controller cleaner.

---

# 20. Step 6 — Update `form.jsp`

Now we must modify the form so that it can be used for both creating and editing.

File:

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

Updated code:

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

        <p class="message">
            <spring:message code="form.message" />
        </p>

        <form:form
                method="post"
                action="${pageContext.request.contextPath}${formAction}"
                modelAttribute="course"
                cssClass="form">

            <form:hidden path="id" />

            <div class="form-group">
                <form:label path="title">
                    <spring:message code="form.field.title" />
                </form:label>

                <form:input path="title" cssClass="input" />
                <form:errors path="title" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="level">
                    <spring:message code="form.field.level" />
                </form:label>

                <form:select path="level" cssClass="input">
                    <form:option value="">
                        <spring:message code="form.level.placeholder" />
                    </form:option>

                    <c:forEach var="level" items="${courseLevels}">
                        <form:option value="${level}">
                            ${level}
                        </form:option>
                    </c:forEach>
                </form:select>

                <form:errors path="level" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="durationInHours">
                    <spring:message code="form.field.duration" />
                </form:label>

                <form:input path="durationInHours" type="number" cssClass="input" />
                <form:errors path="durationInHours" cssClass="error" />
            </div>

            <div class="form-actions">
                <button type="submit" class="button">
                    <spring:message code="${submitCode}" />
                </button>

                <a class="secondary-button" href="${pageContext.request.contextPath}/courses">
                    <spring:message code="form.cancel" />
                </a>
            </div>

        </form:form>
    </section>
</main>

</body>
</html>
```

---

# 21. Explanation of the changes in `form.jsp`

## 21.1. Dynamic form action

Before, we had something like:

```jsp
action="${pageContext.request.contextPath}/courses"
```

Now we have:

```jsp
action="${pageContext.request.contextPath}${formAction}"
```

This allows the controller to decide where the form will be sent.

If we are creating:

```java
model.addAttribute("formAction", "/courses");
```

the final action will be:

```text
/courses
```

If we are editing:

```java
model.addAttribute("formAction", "/courses/update");
```

the final action will be:

```text
/courses/update
```

---

## 21.2. Hidden field for `id`

We add:

```jsp
<form:hidden path="id" />
```

This is very important.

When we edit a course, we need to preserve its identifier.

The user does not need to see the `id`, but the application does need it to know which course to update.

The hidden field generates something like:

```html
<input type="hidden" name="id" value="2" />
```

When the form is submitted, Spring fills in:

```java
course.setId(2L);
```

Without this hidden field, the `Course` object would arrive in the `updateCourse` method without `id`.

And if we don't have `id`, we can't do:

```sql
WHERE id = ?
```

---

## 21.3. Dynamic button text

Before, the button always said:

```text
Crear curso
```

Now we use:

```jsp
<spring:message code="${submitCode}" />
```

If we are creating, the controller sends:

```java
model.addAttribute("submitCode", "form.submit");
```

If we are editing, it sends:

```java
model.addAttribute("submitCode", "courses.update");
```

This way we reuse the same form.

---

# 22. Step 7 — Update `list.jsp`

Now we are going to add edit and delete buttons to the list.

File:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

Updated code:

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
            <spring:message code="courses.list.title" />
        </h1>

        <p class="message">
            <spring:message code="courses.list.message" />
        </p>

        <c:if test="${not empty successMessage}">
            <div class="success">
                ${successMessage}
            </div>
        </c:if>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/courses/new">
                <spring:message code="courses.create" />
            </a>
        </p>

        <table class="table">
            <thead>
            <tr>
                <th><spring:message code="courses.title" /></th>
                <th><spring:message code="courses.level" /></th>
                <th><spring:message code="courses.duration" /></th>
                <th><spring:message code="courses.action" /></th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="course" items="${courses}">
                <tr>
                    <td>${course.title}</td>
                    <td>${course.level}</td>
                    <td>
                        ${course.durationInHours}
                        <spring:message code="courses.hours" />
                    </td>
                    <td class="actions-cell">
                        <a href="${pageContext.request.contextPath}/courses/detail?id=${course.id}">
                            <spring:message code="courses.detail" />
                        </a>

                        <a href="${pageContext.request.contextPath}/courses/edit?id=${course.id}">
                            <spring:message code="courses.edit" />
                        </a>

                        <form method="post"
                              action="${pageContext.request.contextPath}/courses/delete"
                              class="inline-form"
                              onsubmit="return confirm('<spring:message code="courses.confirmDelete" />');">

                            <input type="hidden" name="id" value="${course.id}">

                            <button type="submit" class="link-button">
                                <spring:message code="courses.delete" />
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <p>
            <a class="secondary-button" href="${pageContext.request.contextPath}/home">
                <spring:message code="courses.backHome" />
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

---

# 23. Explanation of the new buttons in the list

## 23.1. Detail link

We already had:

```jsp
<a href="${pageContext.request.contextPath}/courses/detail?id=${course.id}">
    <spring:message code="courses.detail" />
</a>
```

This link is used to view the details.

---

## 23.2. Edit link

We add:

```jsp
<a href="${pageContext.request.contextPath}/courses/edit?id=${course.id}">
    <spring:message code="courses.edit" />
</a>
```

This link leads to:

```text
/courses/edit?id=1
```

That endpoint runs:

```java
@GetMapping("/edit")
public String showEditForm(...)
```

The controller loads the course and displays the form with its data.

---

## 23.3. Delete form

To delete we use a form:

```jsp
<form method="post"
      action="${pageContext.request.contextPath}/courses/delete"
      class="inline-form"
      onsubmit="return confirm('<spring:message code="courses.confirmDelete" />');">

    <input type="hidden" name="id" value="${course.id}">

    <button type="submit" class="link-button">
        <spring:message code="courses.delete" />
    </button>
</form>
```

We don't use a normal link to delete.

We don't do this:

```jsp
<a href="/courses/delete?id=1">Borrar</a>
```

because a link uses `GET`, and `GET` should be used to retrieve information, not to delete data.

That's why we use:

```html
method="post"
```

The `id` travels in a hidden field:

```html
<input type="hidden" name="id" value="${course.id}" />
```

And the controller receives it with:

```java
@RequestParam("id") Long id
```

---

## 23.4. Confirmation before deletion

We add:

```jsp
onsubmit="return confirm('<spring:message code="courses.confirmDelete" />');"
```

This displays a browser confirmation window.

If the user accepts, the form is submitted.

If they cancel, nothing is deleted.

The message comes from:

```properties
courses.confirmDelete=¿Seguro que quieres borrar este curso?
```

---

# 24. Step 8 — Add styles for the actions

We are going to improve the look of the action buttons a little.

File:

```text
src/main/webapp/resources/css/styles.css
```

We add this at the end:

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

## Explanation

The class:

```css
.actions-cell
```

displays the actions inline, with some spacing between them.

The class:

```css
.inline-form
```

prevents the delete form from taking up an entire line.

The class:

```css
.link-button
```

makes the delete button look like a link.

This allows a `POST` form to be used without visually breaking the table.

---

# 25. Step 9 — Adjust the dark theme

If we are using `styles-dark.css`, we also add styles for the delete button.

File:

```text
src/main/webapp/resources/css/styles-dark.css
```

We add:

```css
.link-button {
  color: #93c5fd;
}

.link-button:hover {
  color: #bfdbfe;
}
```

## Explanation

In the dark theme, the normal blue may look worse.

That's why we use a lighter blue.

---

# 26. Step 10 — Test editing

Now we test editing step by step.

## 26.1. Open the list

We open:

```text
http://localhost:8080/spring-mvc-day1/courses
```

We should see the course table.

Each row should show:

```text
Ver detalle | Editar | Borrar
```

## 26.2. Click edit

We click on:

```text
Editar
```

The URL will be similar to:

```text
/courses/edit?id=1
```

The form should appear with the current course data.

## 26.3. Modify the data

We change, for example:

```text
Duración: 20 → 30
```

We click:

```text
Actualizar curso
```

## 26.4. Check the result

The application should redirect to the list.

The message should appear:

```text
El curso se ha actualizado correctamente.
```

And the course should show the new duration.

## 26.5. Check in DBeaver

We can also run:

```sql
SELECT * FROM courses;
```

to verify that the change has been saved in MySQL.

---

# 27. Step 11 — Test deleting

## 27.1. Open the list

We open:

```text
/courses
```

## 27.2. Click delete

We click the button:

```text
Borrar
```

The browser should display a confirmation.

## 27.3. Cancel

First we try canceling.

The course should not be deleted.

## 27.4. Accept

We click delete again and accept.

The application must send:

```text
POST /courses/delete
```

Then it should redirect to the list.

The message should appear:

```text
El curso se ha borrado correctamente.
```

The course should no longer appear.

## 27.5. Check in DBeaver

We run:

```sql
SELECT * FROM courses;
```

The deleted course should no longer appear.

---

# 28. Why we use `POST` to delete

It is important to understand this.

A normal link makes a `GET` request.

For example:

```html
<a href="/courses/delete?id=1">Borrar</a>
```

That would send:

```text
GET /courses/delete?id=1
```

But `GET` should be used to retrieve information, not to modify or delete data.

Deleting is an action that changes the state of the application.

That's why we use:

```html
<form method="post"></form>
```

This way, deletion is done with:

```text
POST /courses/delete
```

It is a more suitable option for this level of the course.

Later, in REST applications, the `DELETE` HTTP method can also be used, but in traditional JSP applications it is common to use `POST` forms.

---

# 29. Difference between creating and editing

Creating and editing look similar, but they are not exactly the same.

## Create

When we create a course:

```text
No hay id todavía.
El usuario rellena un formulario vacío.
La aplicación hace un INSERT.
MySQL genera el id.
```

Route:

```text
GET  /courses/new
POST /courses
```

SQL:

```sql
INSERT INTO courses (...)
VALUES (...)
```

## Edit

When we edit a course:

```text
El curso ya existe.
Necesitamos conservar su id.
El formulario se carga con datos actuales.
La aplicación hace un UPDATE.
```

Route:

```text
GET  /courses/edit?id=1
POST /courses/update
```

SQL:

```sql
UPDATE courses
SET ...
WHERE id = ?
```

The `id` is the key to knowing which row to modify.

---

# 30. Difference between deleting and hiding

In this topic we use real deletion:

```sql
DELETE FROM courses
WHERE id = ?
```

This removes the row from the table.

In real applications, another strategy called **logical deletion** is sometimes used.

Instead of deleting the row, a column like this one is added:

```sql
active BOOLEAN
```

or:

```sql
deleted BOOLEAN
```

And deleting is done like this:

```sql
UPDATE courses
SET deleted = true
WHERE id = ?
```

This way the data is still in the database, but the application no longer displays it.

In this course we will use real deletion because it makes CRUD easier to learn.

---

# 31. Common mistakes in Topic 7

## Error 1 — Forgetting the hidden `id` field

If we don't add this to `form.jsp`:

```jsp
<form:hidden path="id" />
```

when editing, the `Course` object will arrive without an identifier.

Then the `update` method will not know which course to update.

---

## Error 2 — Using the same action to create and edit without telling them apart

If the edit form sends to:

```text
POST /courses
```

a new course will be created instead of updating the existing one.

To edit, the action must be:

```text
POST /courses/update
```

That's why we use:

```jsp
action="${pageContext.request.contextPath}${formAction}"
```

---

## Error 3 — Not adding data back to the model when there are errors

If there are validation errors while editing, we must add this again:

```java
model.addAttribute("pageTitleCode", "courses.edit.title");
model.addAttribute("formAction", "/courses/update");
model.addAttribute("submitCode", "courses.update");
```

If we don't do this, the `form.jsp` view may fail or display incorrect data.

---

## Error 4 — Deleting with a `GET` link

It is not recommended to do this:

```jsp
<a href="/courses/delete?id=1">Borrar</a>
```

It is better to use:

```jsp
<form method="post" action="/courses/delete">
```

This way we avoid deleting data with a simple visit to a URL.

---

## Error 5 — Forgetting `WHERE` in SQL

This error is very dangerous.

Incorrect:

```sql
DELETE FROM courses;
```

This deletes all courses.

Correct:

```sql
DELETE FROM courses
WHERE id = ?;
```

The same goes for `UPDATE`.

Incorrect:

```sql
UPDATE courses
SET title = ?;
```

This updates all courses.

Correct:

```sql
UPDATE courses
SET title = ?, level = ?, duration_in_hours = ?
WHERE id = ?;
```

---

## Error 6 — Not checking if the course exists before updating or deleting

If we update or delete a non-existent course, nothing may happen and the application may seem to work.

But it is better to check first:

```java
findByIdOrThrow(id);
```

This way, if the course does not exist, we display a controlled error page.

---

## Error 7 — Missing messages in `messages.properties`

If we use:

```jsp
<spring:message code="courses.edit" />
```

but the key does not exist:

```properties
courses.edit=Editar
```

Spring will not be able to resolve the message correctly.

---

# 32. Summary of the complete editing flow

The editing flow is:

```text
Usuario pulsa Editar
↓
GET /courses/edit?id=1
↓
CourseController busca el curso
↓
Se añade el curso al modelo
↓
form.jsp muestra los datos actuales
↓
Usuario modifica el formulario
↓
POST /courses/update
↓
Spring rellena un objeto Course
↓
Spring valida los datos
↓
Si hay errores, vuelve al formulario
↓
Si no hay errores, CourseService actualiza
↓
CourseDao ejecuta UPDATE
↓
Redirección a /courses
↓
Mensaje de éxito
```

---

# 33. Summary of the complete deletion flow

The delete flow is:

```text
Usuario pulsa Borrar
↓
El navegador muestra confirmación
↓
Usuario acepta
↓
POST /courses/delete
↓
CourseController recibe el id
↓
CourseService comprueba que existe
↓
CourseDao ejecuta DELETE
↓
Redirección a /courses
↓
Mensaje de éxito
```

---

# 34. Final CRUD result

By the end of this topic, our application will have the complete CRUD:

| Operation | Route | SQL |
| ------------ | -------------------------- | --------------------- |
| Create | `POST /courses` | `INSERT` |
| Read list | `GET /courses` | `SELECT` |
| Read detail | `GET /courses/detail?id=1` | `SELECT WHERE id = ?` |
| Edit | `POST /courses/update` | `UPDATE WHERE id = ?` |
| Delete | `POST /courses/delete` | `DELETE WHERE id = ?` |

The application can now manage courses completely.

---

# 35. Closing the topic

In this topic we have completed one of the most important parts of any web application: the CRUD.

Until now our application could create and view courses. Now it can also:

```text
Editar cursos existentes.
Borrar cursos existentes.
```

In addition, we have reinforced several important ideas:

```text
El controlador recibe peticiones y decide el flujo.
El servicio coordina la lógica.
El DAO ejecuta SQL.
Las vistas muestran formularios y botones.
El id es fundamental para editar y borrar.
POST es más adecuado que GET para acciones que modifican datos.
```

The final structure remains clear:

```text
JSP
↓
Controller
↓
Service
↓
DAO
↓
JdbcTemplate
↓
MySQL
```

With this, the Spring MVC application is much more complete and closer to a real project.
