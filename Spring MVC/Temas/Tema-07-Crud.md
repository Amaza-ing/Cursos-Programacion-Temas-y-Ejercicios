# Tema 7 — Completar el CRUD: editar y borrar cursos en Spring MVC

## 1. Objetivo del tema

En los temas anteriores hemos construido una aplicación Spring MVC que ya permite:

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

En este **Tema 7** vamos a completar el CRUD.

CRUD significa:

```text
Create  → Crear
Read    → Leer
Update  → Actualizar
Delete  → Borrar
```

Hasta ahora nuestra aplicación ya tenía parte del CRUD:

| Operación     | Estado                  |
| ------------- | ----------------------- |
| Crear cursos  | Ya hecho                |
| Ver cursos    | Ya hecho                |
| Editar cursos | Lo haremos en este tema |
| Borrar cursos | Lo haremos en este tema |

Al terminar este tema, nuestra aplicación permitirá:

```text
1. Ver todos los cursos.
2. Ver el detalle de un curso.
3. Crear un curso.
4. Editar un curso existente.
5. Borrar un curso existente.
```

---

# 2. Qué vamos a construir

Vamos a añadir nuevas rutas a `CourseController`.

Actualmente tenemos rutas parecidas a estas:

```text
GET  /courses             → Listado de cursos
GET  /courses/detail?id=1 → Detalle de un curso
GET  /courses/new         → Formulario de creación
POST /courses             → Guardar curso nuevo
```

En este tema añadiremos:

```text
GET  /courses/edit?id=1   → Mostrar formulario de edición
POST /courses/update      → Procesar edición
POST /courses/delete      → Borrar curso
```

El flujo completo será:

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

# 3. Punto de partida

Partimos de la aplicación anterior, donde ya tenemos una estructura parecida a esta:

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

También partimos de una tabla MySQL como esta:

```sql
CREATE TABLE IF NOT EXISTS courses (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(80) NOT NULL,
    level VARCHAR(30) NOT NULL,
    duration_in_hours INT NOT NULL
);
```

---

# 4. Recordatorio del modelo `Course`

Después de aplicar las mejoras del Tema 6, nuestra clase `Course` puede estar usando Lombok.

Archivo:

```text
src/main/java/com/example/springmvcday1/model/Course.java
```

Código:

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

## Explicación

Esta clase representa un curso.

Tiene los campos:

```text
id
title
level
durationInHours
```

El campo `id` nos permite identificar qué curso queremos editar o borrar.

Por eso en este tema será muy importante conservar el `id` cuando mostremos el formulario de edición.

---

# 5. Paso 1 — Ampliar la interfaz `CourseDao`

Hasta ahora nuestra interfaz `CourseDao` tenía métodos para:

```text
findAll()
findById()
save()
```

Ahora necesitamos añadir:

```text
update()
deleteById()
```

Archivo:

```text
src/main/java/com/example/springmvcday1/dao/CourseDao.java
```

Código actualizado:

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

## Explicación

Añadimos este método:

```java
void update(Course course);
```

Lo usaremos para modificar un curso existente en MySQL.

El objeto `Course` debe llegar con su `id`, porque necesitamos saber qué fila de la tabla hay que actualizar.

También añadimos:

```java
void deleteById(Long id);
```

Lo usaremos para borrar un curso por su identificador.

La interfaz no contiene SQL. Solo define qué operaciones debe ofrecer nuestra capa de acceso a datos.

---

# 6. Paso 2 — Implementar `update` y `deleteById` en `JdbcCourseDao`

Ahora actualizamos la implementación JDBC.

Archivo:

```text
src/main/java/com/example/springmvcday1/dao/JdbcCourseDao.java
```

Código completo actualizado:

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

# 7. Explicación del método `update`

El método nuevo es:

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

La consulta SQL es:

```sql
UPDATE courses
SET title = ?, level = ?, duration_in_hours = ?
WHERE id = ?
```

Esto significa:

```text
Actualiza la tabla courses.
Cambia el título, el nivel y la duración.
Pero solo en la fila cuyo id coincida.
```

La parte más importante es:

```sql
WHERE id = ?
```

Sin esta condición, actualizaríamos todos los cursos de la tabla.

Por ejemplo, si el curso tiene:

```java
id = 2
title = "Spring MVC avanzado"
level = "Avanzado"
durationInHours = 30
```

La consulta actualizará solo la fila con `id = 2`.

El orden de los valores es importante:

```java
course.getTitle(),           // primer ?
course.getLevel(),           // segundo ?
course.getDurationInHours(), // tercer ?
course.getId()               // cuarto ?
```

---

# 8. Explicación del método `deleteById`

El método de borrado es:

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

La consulta SQL es:

```sql
DELETE FROM courses
WHERE id = ?
```

Esto significa:

```text
Borra de la tabla courses
la fila cuyo id coincida con el parámetro.
```

De nuevo, la parte más importante es:

```sql
WHERE id = ?
```

Sin `WHERE`, borraríamos todos los cursos.

Por eso, cuando hacemos operaciones de borrado o actualización, debemos revisar muy bien la condición.

---

# 9. Paso 3 — Actualizar `CourseService`

Ahora el servicio también debe exponer métodos para editar y borrar.

Archivo:

```text
src/main/java/com/example/springmvcday1/service/CourseService.java
```

Código actualizado:

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

# 10. Explicación del método `update` en el servicio

El método es:

```java
public void update(Course course) {
    Course existingCourse = findByIdOrThrow(course.getId());

    existingCourse.setTitle(course.getTitle());
    existingCourse.setLevel(course.getLevel());
    existingCourse.setDurationInHours(course.getDurationInHours());

    courseDao.update(existingCourse);
}
```

Primero buscamos el curso existente:

```java
Course existingCourse = findByIdOrThrow(course.getId());
```

Esto tiene una ventaja: si alguien intenta editar un curso que no existe, lanzamos nuestra excepción personalizada.

Después copiamos los nuevos datos:

```java
existingCourse.setTitle(course.getTitle());
existingCourse.setLevel(course.getLevel());
existingCourse.setDurationInHours(course.getDurationInHours());
```

Finalmente actualizamos en la base de datos:

```java
courseDao.update(existingCourse);
```

Podríamos haber llamado directamente a:

```java
courseDao.update(course);
```

Pero buscar antes el curso existente nos permite comprobar que realmente existe antes de actualizarlo.

---

# 11. Explicación del método `deleteById` en el servicio

El método es:

```java
public void deleteById(Long id) {
    findByIdOrThrow(id);
    courseDao.deleteById(id);
}
```

Primero comprobamos que el curso existe:

```java
findByIdOrThrow(id);
```

Si no existe, se lanza `CourseNotFoundException`.

Si existe, borramos:

```java
courseDao.deleteById(id);
```

Esto evita que la aplicación intente borrar silenciosamente un curso inexistente.

---

# 12. Paso 4 — Añadir mensajes al archivo de internacionalización

Antes de modificar el controlador y las vistas, añadiremos nuevas claves de mensajes.

Archivos:

```text
src/main/resources/messages.properties
src/main/resources/messages_es.properties
src/main/resources/messages_en.properties
```

Añadimos estas claves a `messages.properties` y `messages_es.properties`:

```properties
courses.edit=Editar
courses.delete=Borrar
courses.confirmDelete=¿Seguro que quieres borrar este curso?
courses.edit.title=Editar curso
courses.update=Actualizar curso
success.course.updated=El curso se ha actualizado correctamente.
success.course.deleted=El curso se ha borrado correctamente.
```

Y estas claves a `messages_en.properties`:

```properties
courses.edit=Edit
courses.delete=Delete
courses.confirmDelete=Are you sure you want to delete this course?
courses.edit.title=Edit course
courses.update=Update course
success.course.updated=The course has been updated successfully.
success.course.deleted=The course has been deleted successfully.
```

## Explicación

Estas claves nos permitirán mostrar textos como:

```text
Editar
Borrar
Actualizar curso
El curso se ha actualizado correctamente.
```

sin escribirlos directamente en la JSP.

Así mantenemos la internacionalización que ya habíamos creado en el tema anterior.

---

# 13. Paso 5 — Actualizar `CourseController`

Ahora vamos a añadir los métodos de editar y borrar.

Archivo:

```text
src/main/java/com/example/springmvcday1/controller/CourseController.java
```

Código completo actualizado:

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

# 14. Explicación general del controlador actualizado

El controlador ahora tiene métodos para todas las operaciones CRUD:

| Método           | Ruta                       | Función                        |
| ---------------- | -------------------------- | ------------------------------ |
| `listCourses`    | `GET /courses`             | Listar cursos                  |
| `courseDetail`   | `GET /courses/detail?id=1` | Ver detalle                    |
| `showCreateForm` | `GET /courses/new`         | Mostrar formulario de creación |
| `createCourse`   | `POST /courses`            | Crear curso                    |
| `showEditForm`   | `GET /courses/edit?id=1`   | Mostrar formulario de edición  |
| `updateCourse`   | `POST /courses/update`     | Actualizar curso               |
| `deleteCourse`   | `POST /courses/delete`     | Borrar curso                   |

Además, hemos creado un método privado:

```java
private void addFlashMessage(...)
```

para no repetir el código de obtener mensajes internacionalizados.

---

# 15. Explicación de `showEditForm`

El método es:

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

Este método responde a una URL como:

```text
/courses/edit?id=2
```

Primero lee el parámetro `id`:

```java
@RequestParam("id") Long id
```

Después busca el curso:

```java
Course course = courseService.findByIdOrThrow(id);
```

Si el curso existe, se añade al modelo:

```java
model.addAttribute("course", course);
```

La vista recibirá un curso con datos reales, no un curso vacío.

También añadimos:

```java
model.addAttribute("formAction", "/courses/update");
model.addAttribute("submitCode", "courses.update");
```

Esto nos permitirá reutilizar la misma vista `form.jsp` para crear y editar.

---

# 16. Reutilizar `form.jsp` para crear y editar

En lugar de crear dos vistas separadas:

```text
create-form.jsp
edit-form.jsp
```

vamos a reutilizar:

```text
courses/form.jsp
```

La diferencia será:

| Modo   | Acción del formulario | Texto del botón  |
| ------ | --------------------- | ---------------- |
| Crear  | `/courses`            | Crear curso      |
| Editar | `/courses/update`     | Actualizar curso |

Por eso en el controlador enviamos estos atributos:

```java
model.addAttribute("formAction", "/courses");
model.addAttribute("submitCode", "form.submit");
```

para crear, y:

```java
model.addAttribute("formAction", "/courses/update");
model.addAttribute("submitCode", "courses.update");
```

para editar.

---

# 17. Explicación de `updateCourse`

El método es:

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

Este método procesa el formulario de edición.

Recibe el objeto:

```java
@ModelAttribute("course") Course course
```

Spring rellena ese objeto con los datos enviados por el formulario.

También usamos:

```java
@Valid
```

para validar los datos.

Si hay errores:

```java
if (bindingResult.hasErrors()) {
```

volvemos al formulario.

Si no hay errores:

```java
courseService.update(course);
```

actualizamos el curso.

Después añadimos un mensaje flash y redirigimos:

```java
return "redirect:/courses";
```

---

# 18. Explicación de `deleteCourse`

El método es:

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

Este método recibe el `id` del curso que queremos borrar.

Usamos `POST` para borrar porque borrar datos modifica el estado de la aplicación.

No es recomendable borrar usando un enlace `GET` como:

```text
/courses/delete?id=1
```

Es mejor usar un formulario con método `POST`.

Después de borrar, redirigimos al listado.

---

# 19. Explicación de `addFlashMessage`

Hemos creado este método privado:

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

Lo usamos para no repetir este bloque varias veces:

```java
Locale locale = LocaleContextHolder.getLocale();

String message = messageSource.getMessage(
        "success.course.created",
        null,
        locale
);

redirectAttributes.addFlashAttribute("successMessage", message);
```

Ahora, cuando queremos añadir un mensaje flash, solo hacemos:

```java
addFlashMessage(redirectAttributes, "success.course.updated");
```

Esto mejora la limpieza del controlador.

---

# 20. Paso 6 — Actualizar `form.jsp`

Ahora debemos modificar el formulario para que sirva tanto para crear como para editar.

Archivo:

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

Código actualizado:

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

# 21. Explicación de los cambios en `form.jsp`

## 21.1. Acción dinámica del formulario

Antes teníamos algo como:

```jsp
action="${pageContext.request.contextPath}/courses"
```

Ahora tenemos:

```jsp
action="${pageContext.request.contextPath}${formAction}"
```

Esto permite que el controlador decida a dónde se enviará el formulario.

Si estamos creando:

```java
model.addAttribute("formAction", "/courses");
```

la acción final será:

```text
/courses
```

Si estamos editando:

```java
model.addAttribute("formAction", "/courses/update");
```

la acción final será:

```text
/courses/update
```

---

## 21.2. Campo oculto para el `id`

Añadimos:

```jsp
<form:hidden path="id" />
```

Esto es muy importante.

Cuando editamos un curso, necesitamos conservar su identificador.

El usuario no necesita ver el `id`, pero la aplicación sí lo necesita para saber qué curso actualizar.

El campo oculto genera algo parecido a:

```html
<input type="hidden" name="id" value="2" />
```

Cuando el formulario se envía, Spring rellena:

```java
course.setId(2L);
```

Sin este campo oculto, el objeto `Course` llegaría al método `updateCourse` sin `id`.

Y si no tenemos `id`, no podemos hacer:

```sql
WHERE id = ?
```

---

## 21.3. Texto dinámico del botón

Antes el botón siempre decía:

```text
Crear curso
```

Ahora usamos:

```jsp
<spring:message code="${submitCode}" />
```

Si estamos creando, el controlador envía:

```java
model.addAttribute("submitCode", "form.submit");
```

Si estamos editando, envía:

```java
model.addAttribute("submitCode", "courses.update");
```

Así reutilizamos el mismo formulario.

---

# 22. Paso 7 — Actualizar `list.jsp`

Ahora vamos a añadir botones para editar y borrar en el listado.

Archivo:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

Código actualizado:

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

# 23. Explicación de los nuevos botones del listado

## 23.1. Enlace de detalle

Ya teníamos:

```jsp
<a href="${pageContext.request.contextPath}/courses/detail?id=${course.id}">
    <spring:message code="courses.detail" />
</a>
```

Este enlace sirve para ver el detalle.

---

## 23.2. Enlace de edición

Añadimos:

```jsp
<a href="${pageContext.request.contextPath}/courses/edit?id=${course.id}">
    <spring:message code="courses.edit" />
</a>
```

Este enlace lleva a:

```text
/courses/edit?id=1
```

Ese endpoint ejecuta:

```java
@GetMapping("/edit")
public String showEditForm(...)
```

El controlador carga el curso y muestra el formulario con sus datos.

---

## 23.3. Formulario de borrado

Para borrar usamos un formulario:

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

No usamos un enlace normal para borrar.

No hacemos esto:

```jsp
<a href="/courses/delete?id=1">Borrar</a>
```

porque un enlace usa `GET`, y `GET` debería usarse para consultar información, no para borrar datos.

Por eso usamos:

```html
method="post"
```

El `id` viaja en un campo oculto:

```html
<input type="hidden" name="id" value="${course.id}" />
```

Y el controlador lo recibe con:

```java
@RequestParam("id") Long id
```

---

## 23.4. Confirmación antes de borrar

Añadimos:

```jsp
onsubmit="return confirm('<spring:message code="courses.confirmDelete" />');"
```

Esto muestra una ventana de confirmación del navegador.

Si el usuario acepta, el formulario se envía.

Si cancela, no se borra nada.

El mensaje viene de:

```properties
courses.confirmDelete=¿Seguro que quieres borrar este curso?
```

---

# 24. Paso 8 — Añadir estilos para acciones

Vamos a mejorar un poco el aspecto de los botones de acción.

Archivo:

```text
src/main/webapp/resources/css/styles.css
```

Añadimos al final:

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

## Explicación

La clase:

```css
.actions-cell
```

hace que las acciones se muestren en línea con separación.

La clase:

```css
.inline-form
```

evita que el formulario de borrado ocupe una línea completa.

La clase:

```css
.link-button
```

hace que el botón de borrar parezca un enlace.

Esto permite usar un formulario `POST` sin romper visualmente la tabla.

---

# 25. Paso 9 — Ajustar el tema oscuro

Si estamos usando `styles-dark.css`, añadimos también estilos para el botón de borrar.

Archivo:

```text
src/main/webapp/resources/css/styles-dark.css
```

Añadimos:

```css
.link-button {
  color: #93c5fd;
}

.link-button:hover {
  color: #bfdbfe;
}
```

## Explicación

En tema oscuro, el color azul normal puede verse peor.

Por eso usamos un azul más claro.

---

# 26. Paso 10 — Probar la edición

Ahora probamos la edición paso a paso.

## 26.1. Entrar al listado

Abrimos:

```text
http://localhost:8080/spring-mvc-day1/courses
```

Deberíamos ver la tabla de cursos.

En cada fila debería aparecer:

```text
Ver detalle | Editar | Borrar
```

## 26.2. Pulsar editar

Pulsamos en:

```text
Editar
```

La URL será parecida a:

```text
/courses/edit?id=1
```

Debería aparecer el formulario con los datos actuales del curso.

## 26.3. Modificar datos

Cambiamos, por ejemplo:

```text
Duración: 20 → 30
```

Pulsamos:

```text
Actualizar curso
```

## 26.4. Comprobar resultado

La aplicación debe redirigir al listado.

Debe aparecer el mensaje:

```text
El curso se ha actualizado correctamente.
```

Y el curso debe mostrar la nueva duración.

## 26.5. Comprobar en DBeaver

También podemos ejecutar:

```sql
SELECT * FROM courses;
```

para comprobar que el cambio se ha guardado en MySQL.

---

# 27. Paso 11 — Probar el borrado

## 27.1. Entrar al listado

Abrimos:

```text
/courses
```

## 27.2. Pulsar borrar

Pulsamos el botón:

```text
Borrar
```

El navegador debe mostrar una confirmación.

## 27.3. Cancelar

Primero probamos a cancelar.

El curso no debe borrarse.

## 27.4. Aceptar

Volvemos a pulsar borrar y aceptamos.

La aplicación debe enviar:

```text
POST /courses/delete
```

Después debe redirigir al listado.

Debe aparecer el mensaje:

```text
El curso se ha borrado correctamente.
```

El curso ya no debe aparecer.

## 27.5. Comprobar en DBeaver

Ejecutamos:

```sql
SELECT * FROM courses;
```

El curso borrado ya no debería aparecer.

---

# 28. Por qué usamos `POST` para borrar

Es importante entender esto.

Un enlace normal hace una petición `GET`.

Por ejemplo:

```html
<a href="/courses/delete?id=1">Borrar</a>
```

Eso enviaría:

```text
GET /courses/delete?id=1
```

Pero `GET` debería usarse para consultar información, no para modificar o borrar datos.

Borrar es una acción que cambia el estado de la aplicación.

Por eso usamos:

```html
<form method="post"></form>
```

Así el borrado se hace mediante:

```text
POST /courses/delete
```

Es una opción más adecuada para este nivel del curso.

Más adelante, en aplicaciones REST, también se puede usar el método HTTP `DELETE`, pero en aplicaciones JSP tradicionales es habitual usar formularios `POST`.

---

# 29. Diferencia entre crear y editar

Crear y editar se parecen, pero no son exactamente iguales.

## Crear

Cuando creamos un curso:

```text
No hay id todavía.
El usuario rellena un formulario vacío.
La aplicación hace un INSERT.
MySQL genera el id.
```

Ruta:

```text
GET  /courses/new
POST /courses
```

SQL:

```sql
INSERT INTO courses (...)
VALUES (...)
```

## Editar

Cuando editamos un curso:

```text
El curso ya existe.
Necesitamos conservar su id.
El formulario se carga con datos actuales.
La aplicación hace un UPDATE.
```

Ruta:

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

El `id` es la clave para saber qué fila modificar.

---

# 30. Diferencia entre borrar y ocultar

En este tema usamos borrado real:

```sql
DELETE FROM courses
WHERE id = ?
```

Esto elimina la fila de la tabla.

En aplicaciones reales, a veces se usa otra estrategia llamada **borrado lógico**.

En lugar de borrar la fila, se añade una columna como:

```sql
active BOOLEAN
```

o:

```sql
deleted BOOLEAN
```

Y al borrar se hace:

```sql
UPDATE courses
SET deleted = true
WHERE id = ?
```

Así el dato sigue en la base de datos, pero la aplicación deja de mostrarlo.

En este curso usaremos borrado real porque es más sencillo para aprender CRUD.

---

# 31. Errores habituales del Tema 7

## Error 1 — Olvidar el campo oculto `id`

Si en `form.jsp` no ponemos:

```jsp
<form:hidden path="id" />
```

al editar, el objeto `Course` llegará sin identificador.

Entonces el método `update` no sabrá qué curso actualizar.

---

## Error 2 — Usar la misma acción para crear y editar sin distinguir

Si el formulario de edición envía a:

```text
POST /courses
```

se creará un curso nuevo en lugar de actualizar el existente.

Para editar, la acción debe ser:

```text
POST /courses/update
```

Por eso usamos:

```jsp
action="${pageContext.request.contextPath}${formAction}"
```

---

## Error 3 — No volver a añadir datos al modelo si hay errores

Si hay errores de validación en edición, debemos volver a añadir:

```java
model.addAttribute("pageTitleCode", "courses.edit.title");
model.addAttribute("formAction", "/courses/update");
model.addAttribute("submitCode", "courses.update");
```

Si no lo hacemos, la vista `form.jsp` puede fallar o mostrar datos incorrectos.

---

## Error 4 — Borrar con un enlace `GET`

No es recomendable hacer:

```jsp
<a href="/courses/delete?id=1">Borrar</a>
```

Es mejor usar:

```jsp
<form method="post" action="/courses/delete">
```

Así evitamos borrar datos con una simple visita a una URL.

---

## Error 5 — Olvidar el `WHERE` en SQL

Este error es muy peligroso.

Incorrecto:

```sql
DELETE FROM courses;
```

Esto borra todos los cursos.

Correcto:

```sql
DELETE FROM courses
WHERE id = ?;
```

Lo mismo ocurre con `UPDATE`.

Incorrecto:

```sql
UPDATE courses
SET title = ?;
```

Esto actualiza todos los cursos.

Correcto:

```sql
UPDATE courses
SET title = ?, level = ?, duration_in_hours = ?
WHERE id = ?;
```

---

## Error 6 — No comprobar si el curso existe antes de actualizar o borrar

Si actualizamos o borramos un curso inexistente, puede que no ocurra nada y la aplicación parezca funcionar.

Pero es mejor comprobar antes:

```java
findByIdOrThrow(id);
```

Así, si el curso no existe, mostramos una página de error controlada.

---

## Error 7 — No tener mensajes en `messages.properties`

Si usamos:

```jsp
<spring:message code="courses.edit" />
```

pero no existe la clave:

```properties
courses.edit=Editar
```

Spring no podrá resolver el mensaje correctamente.

---

# 32. Resumen del flujo completo de edición

El flujo de edición es:

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

# 33. Resumen del flujo completo de borrado

El flujo de borrado es:

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

# 34. Resultado final del CRUD

Al terminar este tema, nuestra aplicación tendrá el CRUD completo:

| Operación    | Ruta                       | SQL                   |
| ------------ | -------------------------- | --------------------- |
| Crear        | `POST /courses`            | `INSERT`              |
| Leer listado | `GET /courses`             | `SELECT`              |
| Leer detalle | `GET /courses/detail?id=1` | `SELECT WHERE id = ?` |
| Editar       | `POST /courses/update`     | `UPDATE WHERE id = ?` |
| Borrar       | `POST /courses/delete`     | `DELETE WHERE id = ?` |

La aplicación ya puede gestionar cursos de forma completa.

---

# 35. Cierre del tema

En este tema hemos completado una de las partes más importantes de cualquier aplicación web: el CRUD.

Hasta ahora nuestra aplicación podía crear y consultar cursos. Ahora también puede:

```text
Editar cursos existentes.
Borrar cursos existentes.
```

Además, hemos reforzado varias ideas importantes:

```text
El controlador recibe peticiones y decide el flujo.
El servicio coordina la lógica.
El DAO ejecuta SQL.
Las vistas muestran formularios y botones.
El id es fundamental para editar y borrar.
POST es más adecuado que GET para acciones que modifican datos.
```

La estructura final sigue siendo clara:

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

Con esto, la aplicación Spring MVC queda mucho más completa y cercana a un proyecto real.
