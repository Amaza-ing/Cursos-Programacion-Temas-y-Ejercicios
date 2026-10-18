# Topic 3 — Form processing in Spring MVC

## 1. Objective of the topic

In this topic we will learn how to work with forms in a Spring MVC application.

Until now, the application allows you to navigate between pages, show a list of courses and see the details of a specific course. In this topic we will add a new functionality: **create courses from a web form**.

The goal is to understand this complete flow:

```text
1. El usuario entra en una página con un formulario.
2. Spring MVC prepara un objeto vacío para ese formulario.
3. La vista JSP muestra los campos.
4. El usuario rellena el formulario.
5. El navegador envía los datos mediante POST.
6. Spring MVC convierte esos datos en un objeto Java.
7. Spring valida el objeto.
8. Si hay errores, vuelve al formulario y los muestra.
9. Si todo es correcto, guarda los datos.
10. Redirige al listado de cursos.
```

During this topic we will work with these concepts:

- `@ModelAttribute`
- `@Valid`
- `BindingResult`
- Spring form tags
- field validation
- error messages
- redirects
- Post-Redirect-Get pattern
- temporary messages with `RedirectAttributes`

In this topic **we will not use MySQL yet**. We will temporarily save courses in memory to focus on forms processing. Later we could replace this list with a database.

---

## 2. Starting point

We start from the project created in the previous topics.

The application already has these routes:

```text
/                     → Página de inicio
/home                 → Página de inicio
/about                → Página sobre el curso
/courses              → Listado de cursos
/courses/detail?id=1  → Detalle de un curso
```

In this topic we will add these new routes:

```text
/courses/new          → Muestra el formulario para crear un curso
/courses              → Procesa el formulario mediante POST
```

It is important to note that `/courses` will be used in two different ways:

```text
GET  /courses    → muestra el listado de cursos
POST /courses    → procesa el formulario de creación
```

This is very common in web applications.

The `GET` method is typically used to **display pages**.

The `POST` method is typically used to **send data to the server**.

---

## 3. Final project structure

At the end of this topic, the project will have this structure:

```text
spring-mvc-day1
│
├── pom.xml
│
└── src
    └── main
        ├── java
        │   └── com
        │       └── example
        │           └── springmvcday1
        │               ├── controller
        │               │   ├── HomeController.java
        │               │   └── CourseController.java
        │               │
        │               ├── model
        │               │   └── Course.java
        │               │
        │               └── service
        │                   └── CourseService.java
        │
        └── webapp
            ├── resources
            │   └── css
            │       └── styles.css
            │
            └── WEB-INF
                ├── web.xml
                ├── spring
                │   └── app-servlet.xml
                │
                └── views
                    ├── home.jsp
                    ├── about.jsp
                    │
                    └── courses
                        ├── list.jsp
                        ├── detail.jsp
                        ├── form.jsp
                        └── not-found.jsp
```

The most important new file will be:

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

That file will contain the form to create a course.

---

[![Forms](https://img.youtube.com/vi/fjZBNBwiu8c/0.jpg)](https://www.youtube.com/watch?v=fjZBNBwiu8c&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 4. Add validation dependency

To validate forms in Java we will use **Jakarta Bean Validation**.

This technology allows you to declare rules directly in the Java class.

For example:

```java
@NotBlank(message = "El título es obligatorio.")
private String title;
```

With this annotation we indicate that the `title` field cannot be empty.

For these annotations to work, we need to add Hibernate Validator to the `pom.xml`.

### Code that we must add in `pom.xml`

Inside the `<dependencies>` tag, we add this dependency:

```xml
<!-- Implementación de Jakarta Bean Validation -->
<dependency>
    <groupId>org.hibernate.validator</groupId>
    <artifactId>hibernate-validator</artifactId>
    <version>8.0.3.Final</version>
</dependency>
```

### Complete block of dependencies

The complete block of project dependencies would look like this:

```xml
<dependencies>

    <!-- Spring MVC -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-webmvc</artifactId>
        <version>${spring.version}</version>
    </dependency>

    <!-- Servlet API: la proporciona Tomcat en tiempo de ejecución -->
    <dependency>
        <groupId>jakarta.servlet</groupId>
        <artifactId>jakarta.servlet-api</artifactId>
        <version>6.0.0</version>
        <scope>provided</scope>
    </dependency>

    <!-- JSTL API para usar etiquetas como c:forEach en JSP -->
    <dependency>
        <groupId>jakarta.servlet.jsp.jstl</groupId>
        <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
        <version>3.0.2</version>
    </dependency>

    <!-- Implementación de JSTL -->
    <dependency>
        <groupId>org.glassfish.web</groupId>
        <artifactId>jakarta.servlet.jsp.jstl</artifactId>
        <version>3.0.1</version>
    </dependency>

    <!-- Implementación de Jakarta Bean Validation -->
    <dependency>
        <groupId>org.hibernate.validator</groupId>
        <artifactId>hibernate-validator</artifactId>
        <version>8.0.3.Final</version>
    </dependency>

</dependencies>
```

### Explanation

The new dependency is this:

```xml
<dependency>
    <groupId>org.hibernate.validator</groupId>
    <artifactId>hibernate-validator</artifactId>
    <version>8.0.3.Final</version>
</dependency>
```

Thanks to it we can use annotations such as:

```java
@NotBlank
@Size
@NotNull
@Min
@Max
```

These annotations are placed in the model class, not in the controller or view.

The idea is that the validation rules are part of the object itself that we want to validate.

---

## 5. Update `Course` class

In the previous topic our `Course` class was very simple. It had attributes, constructor and getters.

Now we need Spring MVC to be able to create an `Course` object from data submitted by a form.

For that, the class must have:

1. An empty constructor.
2. Getters.
3.Setters.
4. Validation notes.

The file we are going to modify is:

```text
src/main/java/com/example/springmvcday1/model/Course.java
```

### Full code of `Course.java`

```java
package com.example.springmvcday1.model;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class Course {

    private Long id;

    @NotBlank(message = "El título es obligatorio.")
    @Size(min = 3, max = 80, message = "El título debe tener entre 3 y 80 caracteres.")
    private String title;

    @NotBlank(message = "El nivel es obligatorio.")
    private String level;

    @NotNull(message = "La duración es obligatoria.")
    @Min(value = 1, message = "La duración mínima es de 1 hora.")
    @Max(value = 200, message = "La duración máxima es de 200 horas.")
    private Integer durationInHours;

    public Course() {
    }

    public Course(Long id, String title, String level, Integer durationInHours) {
        this.id = id;
        this.title = title;
        this.level = level;
        this.durationInHours = durationInHours;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public Integer getDurationInHours() {
        return durationInHours;
    }

    public void setDurationInHours(Integer durationInHours) {
        this.durationInHours = durationInHours;
    }
}
```

---
[![Validation](https://img.youtube.com/vi/JEYTTwuVz38/0.jpg)](https://www.youtube.com/watch?v=JEYTTwuVz38&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 6. Explanation of `Course` class

### 6.1. Validation imports

At first we import these classes:

```java
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
```

Each one serves a different validation rule.

| Annotation | Function |
| ----------- | ----------------------------------------------------------------- |
| `@NotBlank` | Check that a text is not empty or made up of only spaces |
| `@Size` | Check the length of a text |
| `@NotNull` | Check that the value is not `null` |
| `@Min` | Checks that a number has a minimum value |
| `@Max` | Checks that a number does not exceed a maximum value |

---

### 6.2. Title validation

The `title` attribute looks like this:

```java
@NotBlank(message = "El título es obligatorio.")
@Size(min = 3, max = 80, message = "El título debe tener entre 3 y 80 caracteres.")
private String title;
```

This means that the title must meet two conditions:

```text
1. No puede estar vacío.
2. Debe tener entre 3 y 80 caracteres.
```

If the user leaves the field empty, this message will appear:

```text
El título es obligatorio.
```

If you type a title that is too short or too long, this message appears:

```text
El título debe tener entre 3 y 80 caracteres.
```

---

### 6.3. Level validation

The `level` attribute looks like this:

```java
@NotBlank(message = "El nivel es obligatorio.")
private String level;
```

This means that the user must choose a level.

Later, in the JSP view, we will create a dropdown with these options:

```text
Inicial
Intermedio
Avanzado
```

---

### 6.4. Duration validation

The `durationInHours` attribute looks like this:

```java
@NotNull(message = "La duración es obligatoria.")
@Min(value = 1, message = "La duración mínima es de 1 hora.")
@Max(value = 200, message = "La duración máxima es de 200 horas.")
private Integer durationInHours;
```

This means that the duration must meet three conditions:

```text
1. No puede estar vacía.
2. Debe ser como mínimo 1.
3. Debe ser como máximo 200.
```

For example:

| Entered value | Result |
| ----------------- | ----------------------------------------- |
| empty | Error: duration is required |
| `0` | Error: minimum duration is 1 hour |
| `201` | Error: maximum duration is 200 hours |
| `20` | Correct |

---

### 6.5. Why do we use `Integer` and not `int`

In the previous topic we used:

```java
private int durationInHours;
```

Now we use:

```java
private Integer durationInHours;
```

The reason is important.

`int` is a primitive type and cannot take `null`.

`Integer` is an object and it can be used as `null`.

When the user leaves the field empty, we need Spring to be able to represent that field as `null`. This is how you can activate this validation:

```java
@NotNull(message = "La duración es obligatoria.")
```

Therefore, in forms, it is often preferable to use `Integer` instead of `int`.

---

### 6.6. empty constructor

We add this constructor:

```java
public Course() {
}
```

This constructor is necessary so that Spring can create an empty object before filling it with form data.

When the user submits the form, Spring internally does something like this:

```java
Course course = new Course();
course.setTitle(valorDelFormulario);
course.setLevel(valorDelFormulario);
course.setDurationInHours(valorDelFormulario);
```

In order to do `new Course()`, the class needs an empty constructor.

---

### 6.7. setters

We also add `set` methods:

```java
public void setTitle(String title) {
    this.title = title;
}
```

Spring uses these setters to enter the values ​​sent by the form into the object.

For example, if the form sends this:

```text
title=Spring MVC práctico
```

Spring will do something equivalent to:

```java
course.setTitle("Spring MVC práctico");
```

---

## 7. Update `CourseService` service

In the previous topic, the course list had been created with `List.of(...)`.

This form is used to create a fixed list, but does not allow adding new courses.

Now we need a modifiable list, because the form will create new courses.

The file we are going to modify is:

```text
src/main/java/com/example/springmvcday1/service/CourseService.java
```

### Complete code of `CourseService.java`

```java
package com.example.springmvcday1.service;

import com.example.springmvcday1.model.Course;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CourseService {

    private final List<Course> courses = new ArrayList<>();

    private Long nextId = 4L;

    public CourseService() {
        courses.add(new Course(1L, "Spring MVC desde cero", "Inicial", 20));
        courses.add(new Course(2L, "Spring MVC con formularios", "Intermedio", 15));
        courses.add(new Course(3L, "Spring MVC avanzado", "Avanzado", 25));
    }

    public List<Course> findAll() {
        return courses;
    }

    public Course findById(Long id) {
        return courses.stream()
                .filter(course -> course.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public void save(Course course) {
        course.setId(nextId);
        courses.add(course);
        nextId++;
    }
}
```

---

## 8. `CourseService` Explanation

### 8.1. Modifiable list

Now we use:

```java
private final List<Course> courses = new ArrayList<>();
```

`ArrayList` allows adding new elements.

This is necessary because the `save()` method will add courses to the list.

---

### 8.2. Next course identifier

We also add:

```java
private Long nextId = 4L;
```

The initial courses already have these identifiers:

```text
1
2
3
```

Therefore, the next course created from the form will have identifier `4`.

Then the next one will have `5`, and so on.

---

### 8.3. Initial course load

In the constructor we add three initial courses:

```java
public CourseService() {
    courses.add(new Course(1L, "Spring MVC desde cero", "Inicial", 20));
    courses.add(new Course(2L, "Spring MVC con formularios", "Intermedio", 15));
    courses.add(new Course(3L, "Spring MVC avanzado", "Avanzado", 25));
}
```

This allows the application to have data from the first moment.

---

### 8.4. `findAll()` method

The method:

```java
public List<Course> findAll() {
    return courses;
}
```

returns all courses.

It is used by the controller to display the list.

---

### 8.5. `findById()` method

The method:

```java
public Course findById(Long id) {
    return courses.stream()
            .filter(course -> course.getId().equals(id))
            .findFirst()
            .orElse(null);
}
```

Search for a course by its identifier.

If it finds the course, it returns it.

If it is not found, it returns `null`.

---

### 8.6. `save()` method

The new method is:

```java
public void save(Course course) {
    course.setId(nextId);
    courses.add(course);
    nextId++;
}
```

This method does three things:

```text
1. Asigna un identificador al curso nuevo.
2. Añade el curso a la lista.
3. Incrementa el contador para el siguiente curso.
```

For example, if a course arrives with this data:

```text
Título: Java Web
Nivel: Inicial
Duración: 12
```

the `save()` method will assign it the identifier `4` and add it to the list.

Afterwards `nextId` will become `5`.

---

## 9. Update `CourseController` driver

Now we will add two new methods to the controller:

```text
GET  /courses/new
POST /courses
```

The file we are going to modify is:

```text
src/main/java/com/example/springmvcday1/controller/CourseController.java
```

### Updated full code of `CourseController.java`

```java
package com.example.springmvcday1.controller;

import com.example.springmvcday1.model.Course;
import com.example.springmvcday1.service.CourseService;
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
@RequestMapping("/courses")
public class CourseController {

    private final CourseService courseService;

    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping
    public String listCourses(Model model) {
        model.addAttribute("pageTitle", "Listado de cursos");
        model.addAttribute("courses", courseService.findAll());

        return "courses/list";
    }

    @GetMapping("/detail")
    public String courseDetail(@RequestParam("id") Long id, Model model) {
        Course course = courseService.findById(id);

        if (course == null) {
            model.addAttribute("pageTitle", "Curso no encontrado");
            model.addAttribute("courseId", id);

            return "courses/not-found";
        }

        model.addAttribute("pageTitle", course.getTitle());
        model.addAttribute("course", course);

        return "courses/detail";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("pageTitle", "Crear nuevo curso");
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
            model.addAttribute("pageTitle", "Crear nuevo curso");
            return "courses/form";
        }

        courseService.save(course);

        redirectAttributes.addFlashAttribute(
                "successMessage",
                "El curso se ha creado correctamente."
        );

        return "redirect:/courses";
    }
}
```

---

## 10. Explanation of the method that displays the form

The first new method is:

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    model.addAttribute("pageTitle", "Crear nuevo curso");
    model.addAttribute("course", new Course());

    return "courses/form";
}
```

This method responds to the route:

```text
GET /courses/new
```

Your responsibility is to display the empty form.

---

### 10.1. Add page title

First we add:

```java
model.addAttribute("pageTitle", "Crear nuevo curso");
```

This attribute will be used in the JSP view to display the title.

In the JSP we can write:

```jsp
${pageTitle}
```

And it will show:

```text
Crear nuevo curso
```

---

### 10.2. Add the form object

Then we add:

```java
model.addAttribute("course", new Course());
```

This line is fundamental.

We are creating an empty object:

```java
new Course()
```

And we are sending it to view with the name:

```text
course
```

That object will be used by the form.

The relationship will be this:

```text
Controlador crea un Course vacío
↓
La vista recibe ese objeto como "course"
↓
El formulario se vincula a ese objeto
↓
Cada campo del formulario se vincula a una propiedad
```

---

### 10.3. Return form view

Finally we return:

```java
return "courses/form";
```

This is not the exact file name.

It is the logical name of the view.
Since we have `ViewResolver` configured in `app-servlet.xml`, Spring will do this transformation:

```text
courses/form
```

becomes:

```text
/WEB-INF/views/courses/form.jsp
```

---

## 11. Explanation of the method that processes the form

The second new method is:

```java
@PostMapping
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {

    if (bindingResult.hasErrors()) {
        model.addAttribute("pageTitle", "Crear nuevo curso");
        return "courses/form";
    }

    courseService.save(course);

    redirectAttributes.addFlashAttribute(
            "successMessage",
            "El curso se ha creado correctamente."
    );

    return "redirect:/courses";
}
```

This method responds to:

```text
POST /courses
```

As the controller has this general path:

```java
@RequestMapping("/courses")
```

And the method has:

```java
@PostMapping
```

the result is:

```text
POST /courses
```

---

## 12. `@ModelAttribute`

The most important part of the method is this:

```java
@ModelAttribute("course") Course course
```

This tells Spring:

```text
Toma los datos enviados por el formulario y colócalos dentro de un objeto Course.
```

For example, if the form submits this data:

```text
title=Spring MVC práctico
level=Intermedio
durationInHours=12
```

Spring will create or populate an object similar to this:

```java
Course course = new Course();
course.setTitle("Spring MVC práctico");
course.setLevel("Intermedio");
course.setDurationInHours(12);
```

This way we avoid manually reading each field.

Without `@ModelAttribute`, we would have to do something much more repetitive:

```java
@PostMapping
public String createCourse(
        @RequestParam("title") String title,
        @RequestParam("level") String level,
        @RequestParam("durationInHours") Integer durationInHours) {

    Course course = new Course();
    course.setTitle(title);
    course.setLevel(level);
    course.setDurationInHours(durationInHours);

    courseService.save(course);

    return "redirect:/courses";
}
```

With `@ModelAttribute`, Spring does that conversion automatically.

---

## 13. `@Valid`

Before `@ModelAttribute` we have written:

```java
@Valid
```

The complete parameter looks like this:

```java
@Valid @ModelAttribute("course") Course course
```

This means:

```text
Después de rellenar el objeto Course, valida sus anotaciones.
```

Spring will review rules like these:

```java
@NotBlank(message = "El título es obligatorio.")
@Size(min = 3, max = 80, message = "El título debe tener entre 3 y 80 caracteres.")
private String title;
```

If the title is empty, an error will be raised.

If the title is less than 3 characters, an error will also be raised.

If everything is correct, there will be no validation errors.

---

## 14. `BindingResult`

After the validated object appears:

```java
BindingResult bindingResult
```

This object contains the validation result.

If there are errors, they will be inside `bindingResult`.

That's why we use:

```java
if (bindingResult.hasErrors()) {
    model.addAttribute("pageTitle", "Crear nuevo curso");
    return "courses/form";
}
```

This means:

```text
Si el formulario tiene errores:
    - no guardes el curso
    - vuelve a mostrar el formulario
    - muestra los mensajes de error
```

### Important

`BindingResult` should come right after the object being validated.

Correct:

```java
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        BindingResult bindingResult,
        Model model) {
```

Incorrect:

```java
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        Model model,
        BindingResult bindingResult) {
```

If misplaced, Spring will not correctly associate validation errors with the `course` object.

---

## 15. Save the course

If there are no errors, we execute:

```java
courseService.save(course);
```

The controller does not save the course directly.

Delegate that task to the service.

This keeps responsibilities separate:

| Class | Responsibility |
| ------------------ | -------------------------------------------------- |
| `CourseController` | Receive web requests and decide which view to show |
| `CourseService` | Manage course data |
| `Course` | Represent course data |

---

## 16. Success message with `RedirectAttributes`

After saving the course, we add a temporary message:

```java
redirectAttributes.addFlashAttribute(
        "successMessage",
        "El curso se ha creado correctamente."
);
```

This message will be displayed in the listing after the redirect.

The keyword here is **flash attribute**.

A flash attribute is temporary data that lives only during the next request.

The flow will be:

```text
POST /courses
↓
Se guarda el curso
↓
Se crea successMessage como flash attribute
↓
Se redirige a /courses
↓
El listado muestra successMessage
↓
El mensaje desaparece
```

This is useful for displaying messages like:

```text
El curso se ha creado correctamente.
```

---

## 17. Redirect after saving

Finally we return:

```java
return "redirect:/courses";
```

This does not look for a JSP called `redirect:/courses`.

When Spring sees that the string starts with `redirect:`, it understands that it must send a redirect to the browser.

The browser will make a new request to:

```text
/courses
```

This is very important after processing forms.

---

## 18. Post-Redirect-Get Pattern
After successfully processing a form, it is advisable not to directly return a view.

It is better to redirect.

This pattern is called **Post-Redirect-Get**.

The sequence is:

```text
POST → redirect → GET
```

In our case:

```text
POST /courses
↓
redirect:/courses
↓
GET /courses
```

This avoids a common problem: the form being submitted twice if the user refreshes the page.

If after saving we directly returned a view, when pressing F5 the browser could try to repeat the POST.

With a redirect, the last request is a normal GET, so refreshing the page does not recreate the course.

---

## 19. Create the `form.jsp` view

Now let's create the form view.

File path:

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

To create forms in JSP with Spring MVC we use Spring's form tag library.

This library is activated with this line at the beginning of the file:

```jsp
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
```

### Full code of `form.jsp`

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

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/courses">Cursos</a>
        <a href="${pageContext.request.contextPath}/about">Sobre el curso</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            Rellena los datos para crear un nuevo curso.
        </p>

        <form:form
                method="post"
                action="${pageContext.request.contextPath}/courses"
                modelAttribute="course"
                cssClass="form">

            <div class="form-group">
                <form:label path="title">Título</form:label>
                <form:input path="title" cssClass="input" />
                <form:errors path="title" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="level">Nivel</form:label>
                <form:select path="level" cssClass="input">
                    <form:option value="" label="Selecciona un nivel" />
                    <form:option value="Inicial" label="Inicial" />
                    <form:option value="Intermedio" label="Intermedio" />
                    <form:option value="Avanzado" label="Avanzado" />
                </form:select>
                <form:errors path="level" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="durationInHours">Duración en horas</form:label>
                <form:input path="durationInHours" type="number" cssClass="input" />
                <form:errors path="durationInHours" cssClass="error" />
            </div>

            <div class="form-actions">
                <button type="submit" class="button">
                    Crear curso
                </button>

                <a class="secondary-button" href="${pageContext.request.contextPath}/courses">
                    Cancelar
                </a>
            </div>

        </form:form>
    </section>
</main>

</body>
</html>
```

---

## 20. `form.jsp` Explanation

### 20.1. Page Directive

The first line is:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
```

This indicates that the page uses UTF-8 encoding.

It is important so that the accents and ñ are seen correctly.

---

### 20.2. Spring Forms Library

The second line is:

```jsp
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
```

Thanks to this line we can use tags like:

```jsp
<form:form>
<form:input>
<form:select>
<form:option>
<form:errors>
```

These tags are useful because they connect directly to the model object.

---

### 20.3. The `form:form` tag

The form starts like this:

```jsp
<form:form
        method="post"
        action="${pageContext.request.contextPath}/courses"
        modelAttribute="course"
        cssClass="form">
```

This tag generates an HTML form.

Let's look at each part.

#### `method="post"`

Indicates that the data will be sent via POST.

```jsp
method="post"
```

That means the form will be processed by this controller method:

```java
@PostMapping
public String createCourse(...) {
    ...
}
```

#### `action="${pageContext.request.contextPath}/courses"`

Indicates which URL the data will be sent to.

```jsp
action="${pageContext.request.contextPath}/courses"
```

We use:

```jsp
${pageContext.request.contextPath}
```

so as not to manually type the name of the application.

If the application is deployed as:

```text
/spring-mvc-day1
```

the final action will be:

```text
/spring-mvc-day1/courses
```

#### `modelAttribute="course"`

This is the most important part:

```jsp
modelAttribute="course"
```

Indicates that the form is linked to the model object named `course`.

That object was added in the controller:

```java
model.addAttribute("course", new Course());
```

Therefore, each field in the form will connect to a property of that object.

---

### 20.4. `title` field

The title field is:

```jsp
<div class="form-group">
    <form:label path="title">Título</form:label>
    <form:input path="title" cssClass="input" />
    <form:errors path="title" cssClass="error" />
</div>
```

The key part is:

```jsp
path="title"
```

This means that this field connects to the `title` property of the `Course` class.

In Java, that property is:

```java
private String title;
```

When the user submits the form, Spring will do something similar to:

```java
course.setTitle(valorIntroducido);
```

The label:

```jsp
<form:errors path="title" cssClass="error" />
```

will show errors related to the title.

For example, if the user leaves the title empty, it will display:

```text
El título es obligatorio.
```

---

### 20.5. `level` field

The level field is:

```jsp
<div class="form-group">
    <form:label path="level">Nivel</form:label>
    <form:select path="level" cssClass="input">
        <form:option value="" label="Selecciona un nivel" />
        <form:option value="Inicial" label="Inicial" />
        <form:option value="Intermedio" label="Intermedio" />
        <form:option value="Avanzado" label="Avanzado" />
    </form:select>
    <form:errors path="level" cssClass="error" />
</div>
```

This field connects to:

```java
private String level;
```

The user will be able to choose one of these options:

```text
Inicial
Intermedio
Avanzado
```

The first option has empty value:

```jsp
<form:option value="" label="Selecciona un nivel" />
```

This allows us to detect that the user has not selected any level.

If you submit the form without choosing a level, this validation will be activated:

```java
@NotBlank(message = "El nivel es obligatorio.")
private String level;
```

And the error will be shown here:

```jsp
<form:errors path="level" cssClass="error" />
```

---

### 20.6. `durationInHours` field

The duration field is:

```jsp
<div class="form-group">
    <form:label path="durationInHours">Duración en horas</form:label>
    <form:input path="durationInHours" type="number" cssClass="input" />
    <form:errors path="durationInHours" cssClass="error" />
</div>
```

This field connects to:

```java
private Integer durationInHours;
```

If the user enters `20`, Spring will try to convert that value to `Integer`.

These validations will then be applied:

```java
@NotNull(message = "La duración es obligatoria.")
@Min(value = 1, message = "La duración mínima es de 1 hora.")
@Max(value = 200, message = "La duración máxima es de 200 horas.")
private Integer durationInHours;
```

If there are errors, they will be displayed here:

```jsp
<form:errors path="durationInHours" cssClass="error" />
```

---

### 20.7. Form buttons

In the end we have:

```jsp
<div class="form-actions">
    <button type="submit" class="button">
        Crear curso
    </button>

    <a class="secondary-button" href="${pageContext.request.contextPath}/courses">
        Cancelar
    </a>
</div>
```

The button:

```html
<button type="submit" class="button">Crear curso</button>
```

submit the form.

The link:

```jsp
<a class="secondary-button" href="${pageContext.request.contextPath}/courses">
    Cancelar
</a>
```

takes the user back to the list without sending data.

---

## 21. Update `list.jsp` view

Now we must modify the list to add two things:

1. A button to go to the form.
2. A success message after creating a course.

The file we modified is:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

### Updated full code of `list.jsp`

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
        <a href="${pageContext.request.contextPath}/courses">Cursos</a>
        <a href="${pageContext.request.contextPath}/about">Sobre el curso</a>
    </nav>
</header>

<main class="container">
    <section class="card wide">
        <h1>${pageTitle}</h1>

        <p class="message">
            Estos cursos vienen del controlador, que a su vez obtiene los datos desde un servicio.
        </p>

        <c:if test="${not empty successMessage}">
            <div class="success">
                ${successMessage}
            </div>
        </c:if>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/courses/new">
                Crear nuevo curso
            </a>
        </p>

        <table class="table">
            <thead>
            <tr>
                <th>Título</th>
                <th>Nivel</th>
                <th>Duración</th>
                <th>Acción</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="course" items="${courses}">
                <tr>
                    <td>${course.title}</td>
                    <td>${course.level}</td>
                    <td>${course.durationInHours} horas</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/courses/detail?id=${course.id}">
                            Ver detalle
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <p>
            <a class="secondary-button" href="${pageContext.request.contextPath}/home">
                Volver al inicio
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

---

## 22. Explanation of changes in `list.jsp`

### 22.1. Show success message

We add this block:

```jsp
<c:if test="${not empty successMessage}">
    <div class="success">
        ${successMessage}
    </div>
</c:if>
```

This block uses JSTL.

The label:

```jsp
<c:if>
```

allows displaying content only if a condition is met.

In this case, the condition is:

```jsp
${not empty successMessage}
```

That is to say:

```text
Si successMessage no está vacío, muestra el mensaje.
```

That message is created in the controller:

```java
redirectAttributes.addFlashAttribute(
        "successMessage",
        "El curso se ha creado correctamente."
);
```

---

### 22.2. Button to create a course

We also added this link:

```jsp
<a class="button" href="${pageContext.request.contextPath}/courses/new">
    Crear nuevo curso
</a>
```

This link takes the user to:

```text
/courses/new
```

That route will be served by this method:

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    ...
}
```

---

## 23. Update CSS file

Now we will add styles for:

- form
- fields
- errors
- success message
- secondary buttons

The file is:

```text
src/main/webapp/resources/css/styles.css
```

We add this code to the end of the file:

```css
.form {
  margin-top: 24px;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  font-weight: bold;
}

.input {
  width: 100%;
  box-sizing: border-box;
  padding: 10px 12px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 16px;
}

.input:focus {
  outline: none;
  border-color: #2563eb;
}

.error {
  display: block;
  margin-top: 6px;
  color: #b91c1c;
  font-size: 14px;
}

.success {
  margin: 20px 0;
  padding: 12px 16px;
  background-color: #dcfce7;
  border: 1px solid #86efac;
  color: #166534;
  border-radius: 8px;
}

.form-actions {
  display: flex;
  gap: 12px;
  align-items: center;
  margin-top: 24px;
}

.secondary-button {
  display: inline-block;
  margin-top: 16px;
  padding: 10px 16px;
  background-color: #e5e7eb;
  color: #111827;
  border-radius: 8px;
  text-decoration: none;
}

.secondary-button:hover {
  background-color: #d1d5db;
  text-decoration: none;
}
```

---

## 24. CSS explanation

### 24.1. Form styles

```css
.form {
  margin-top: 24px;
}
```

Add separation between the introductory text and the form.

---

### 24.2. Field Groups

```css
.form-group {
  margin-bottom: 20px;
}
```

Visually separate each field of the form.

---

### 24.3. Tags

```css
.form-group label {
  display: block;
  margin-bottom: 8px;
  font-weight: bold;
}
```

Makes the label of each field appear above the input and in bold.

---

### 24.4. Form fields

```css
.input {
  width: 100%;
  box-sizing: border-box;
  padding: 10px 12px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 16px;
}
```

This class applies to form fields.

For example:

```jsp
<form:input path="title" cssClass="input" />
```

---

### 24.5. Errors

```css
.error {
  display: block;
  margin-top: 6px;
  color: #b91c1c;
  font-size: 14px;
}
```

This class applies to error messages.

For example:

```jsp
<form:errors path="title" cssClass="error" />
```

If there is an error in the `title` field, the message will appear in this style.

---

### 24.6. success message

```css
.success {
  margin: 20px 0;
  padding: 12px 16px;
  background-color: #dcfce7;
  border: 1px solid #86efac;
  color: #166534;
  border-radius: 8px;
}
```

This class applies to the message that appears after successfully creating a course.

---

## 25. Complete flow when the form is correct

Let's see the whole process step by step.

### Step 1

The user enters:

```text
http://localhost:8080/spring-mvc-day1/courses/new
```

### Step 2

Spring executes this method:

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    model.addAttribute("pageTitle", "Crear nuevo curso");
    model.addAttribute("course", new Course());

    return "courses/form";
}
```

### Step 3

The controller sends to the view:

```text
pageTitle → Crear nuevo curso
course    → objeto Course vacío
```

### Step 4

Spring shows the view:

```text
/WEB-INF/views/courses/form.jsp
```

### Step 5

The user fills out the form:

```text
Título: Spring MVC práctico
Nivel: Intermedio
Duración: 12
```

### Step 6

The user presses the button:

```text
Crear curso
```

### Step 7

The browser sends a request:

```text
POST /courses
```

### Step 8

Spring executes:

```java
@PostMapping
public String createCourse(...) {
    ...
}
```

### Step 9

Spring creates an `Course` object with the submitted data:

```java
course.setTitle("Spring MVC práctico");
course.setLevel("Intermedio");
course.setDurationInHours(12);
```

### Step 10
Spring validates the object.

Since the data is correct, there are no errors.

### Step 11

The controller saves the course:

```java
courseService.save(course);
```

### Step 12

The driver creates a success message:

```java
redirectAttributes.addFlashAttribute(
        "successMessage",
        "El curso se ha creado correctamente."
);
```

### Step 13

The controller redirects to the listing:

```java
return "redirect:/courses";
```

### Step 14

The browser makes a new request:

```text
GET /courses
```

### Step 15

The updated list with the new course is displayed.

---

## 26. Complete flow when form has errors

Now suppose the user submits the empty form.

### Step 1

The user enters:

```text
/courses/new
```

### Step 2

Spring displays the form.

### Step 3

The user does not fill out anything and clicks:

```text
Crear curso
```

### Step 4

The browser sends:

```text
POST /courses
```

### Step 5

Spring tries to create an `Course` object.

But the fields don't follow the rules:

```java
@NotBlank(message = "El título es obligatorio.")
private String title;

@NotBlank(message = "El nivel es obligatorio.")
private String level;

@NotNull(message = "La duración es obligatoria.")
private Integer durationInHours;
```

### Step 6

`BindingResult` contains errors.

### Step 7

The controller executes:

```java
if (bindingResult.hasErrors()) {
    model.addAttribute("pageTitle", "Crear nuevo curso");
    return "courses/form";
}
```

### Step 8

The course is not saved.

### Step 9

Spring shows again:

```text
/WEB-INF/views/courses/form.jsp
```

### Step 10

The view displays the errors using:

```jsp
<form:errors path="title" cssClass="error" />
<form:errors path="level" cssClass="error" />
<form:errors path="durationInHours" cssClass="error" />
```

---

## 27. Difference between `@RequestParam` and `@ModelAttribute`

In the previous topic we used:

```java
@RequestParam("id") Long id
```

This was used to read a single parameter from the URL:

```text
/courses/detail?id=1
```

`@RequestParam` is useful for reading single values.

For example:

```java
@RequestParam("id") Long id
@RequestParam("search") String search
```

But when we have a form with several fields, it would be uncomfortable to read each field separately:

```java
@PostMapping
public String createCourse(
        @RequestParam("title") String title,
        @RequestParam("level") String level,
        @RequestParam("durationInHours") Integer durationInHours) {
    ...
}
```

In those cases we use:

```java
@ModelAttribute("course") Course course
```

So Spring creates a complete object with all the form data.

| Annotation | Main use |
| ----------------- | ------------------------------------------ |
| `@RequestParam` | Read individual parameters |
| `@ModelAttribute` | Construct an object from several fields |

---

## 28. Difference between returning a view and returning a redirect

In Spring MVC it is not the same to return this:

```java
return "courses/form";
```

than return this:

```java
return "redirect:/courses";
```

---

### 28.1. Return a view

When we return:

```java
return "courses/form";
```

Spring uses the `ViewResolver`.

With our setup, it will search for:

```text
/WEB-INF/views/courses/form.jsp
```

This is used when we want to display a page directly.

For example, when there are validation errors:

```java
if (bindingResult.hasErrors()) {
    model.addAttribute("pageTitle", "Crear nuevo curso");
    return "courses/form";
}
```

---

### 28.2. Return a redirect

When we return:

```java
return "redirect:/courses";
```

Spring does not look for a JSP.

Instead, it sends a response to the browser saying:

```text
Haz una nueva petición a /courses
```

This is used after successfully processing a form.

---

## 29. Possible extension with MySQL

In this topic we have saved the courses in memory:

```java
private final List<Course> courses = new ArrayList<>();
```

This means that data is lost when the application is restarted.

It is enough to learn forms.

Later we could replace this storage with a MySQL database.

The flow would be:

```text
Formulario
↓
CourseController
↓
CourseService
↓
CourseRepository
↓
MySQL
```

In that case, we would use DBeaver to manage the database and check the saved logs.

But for this topic it is convenient to separate the concepts:

```text
Primero: entender formularios y validación.
Después: añadir persistencia en base de datos.
```

---

## 30. Common mistakes

### Error 1: forgetting the form object
If we do not add this in the controller:

```java
model.addAttribute("course", new Course());
```

but in the JSP we use:

```jsp
<form:form modelAttribute="course">
```

Spring will not find the object associated with the form.

The form needs a model attribute named exactly:

```text
course
```

---

### Error 2: Using field names that do not exist

If in the JSP we write:

```jsp
<form:input path="name" />
```

but the `Course` class does not have a property called `name`, the link will fail.

The class has:

```java
private String title;
```

Therefore, the form must use:

```jsp
<form:input path="title" />
```

The `path` values must match the properties of the object.

---

### Error 3: Forget `BindingResult`

If we write:

```java
@PostMapping
public String createCourse(@Valid @ModelAttribute("course") Course course) {
    courseService.save(course);
    return "redirect:/courses";
}
```

we will not be able to check for errors.

The correct thing is:

```java
@PostMapping
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        BindingResult bindingResult) {
    ...
}
```

---

### Error 4: misplace `BindingResult`

Incorrect:

```java
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        Model model,
        BindingResult bindingResult) {
```

Correct:

```java
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        BindingResult bindingResult,
        Model model) {
```

`BindingResult` should come right after the validated object.

---

### Error 5: Using `int` instead of `Integer`

If we use:

```java
private int durationInHours;
```

an empty value is not represented well as `null`.

For forms it is clearer to use:

```java
private Integer durationInHours;
```

So this validation can work correctly:

```java
@NotNull(message = "La duración es obligatoria.")
```

---

### Error 6: Return `courses/list` after saving

After saving successfully, we might think about doing this:

```java
return "courses/list";
```

But it is better to do:

```java
return "redirect:/courses";
```

This way we prevent the form from being resubmitted if the user refreshes the page.

---

### Error 7: Forget validation dependency

If we use annotations like:

```java
@NotBlank
@Size
@Min
```

but we don't have Hibernate Validator in the `pom.xml`, the validation will not work correctly.

That's why we add:

```xml
<dependency>
    <groupId>org.hibernate.validator</groupId>
    <artifactId>hibernate-validator</artifactId>
    <version>8.0.3.Final</version>
</dependency>
```

---

### Error 8: forgetting the forms library in JSP

If we use tags like:

```jsp
<form:form>
<form:input>
<form:errors>
```

but we don't add this line at the beginning of the JSP:

```jsp
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
```

the view will not be able to interpret those labels.

---

## 31. Final summary of the topic

In this topic we have learned how to process forms in Spring MVC.

The main idea is:

```text
Spring MVC puede convertir automáticamente los datos de un formulario en un objeto Java.
```

The complete flow is:

```text
GET /courses/new
↓
El controlador crea un Course vacío
↓
La vista form.jsp muestra el formulario
↓
El usuario rellena los campos
↓
POST /courses
↓
Spring rellena un objeto Course con @ModelAttribute
↓
Spring valida el objeto con @Valid
↓
BindingResult guarda los errores
↓
Si hay errores, se vuelve a mostrar el formulario
↓
Si no hay errores, se guarda el curso
↓
redirect:/courses
↓
Se muestra el listado actualizado
```

The main pieces are:

| Element | Function |
| -------------------- | ------------------------------------------------------- |
| `@ModelAttribute` | Binds form data to a Java object |
| `@Valid` | Activate object validation |
| `BindingResult` | Save validation errors |
| `form:form` | Create a form linked to the model |
| `form:input` | Create a field associated with a property |
| `form:select` | Create a dropdown associated with a property |
| `form:errors` | Shows validation errors |
| `RedirectAttributes` | Allows you to send temporary messages after a redirect |
| `redirect:/...` | Redirect the browser to another route |
| Post-Redirect-Get | Avoid accidental form resubmissions |

The key phrase that we must remember is:

```text
El controlador no necesita leer manualmente cada campo del formulario.
Spring MVC recibe los datos, crea el objeto, lo valida y permite decidir qué vista mostrar.
```
