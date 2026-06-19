# Tema 8 — Legibilidad

## 1. Objetivo del tema

En el **Tema 7** completamos el CRUD de nuestra aplicación Spring MVC.

La aplicación ya permite:

```text
Crear cursos.
Ver el listado de cursos.
Ver el detalle de un curso.
Editar cursos.
Borrar cursos.
```

Sin embargo, todavía hay algo que podemos mejorar.

En el Tema 7 usamos rutas como estas:

```text
GET  /courses/detail?id=1
GET  /courses/edit?id=1
POST /courses/update
POST /courses/delete
```

Funcionan correctamente, pero no son las rutas más expresivas.

En este **Tema 8** vamos a mejorar la legibilidad del CRUD usando:

```java
@PutMapping
@DeleteMapping
@PathVariable
```

El objetivo es que las rutas sean más claras y que el código refleje mejor la intención de cada operación.

Al terminar este tema, nuestras rutas quedarán así:

```text
GET    /courses           → Listar cursos
GET    /courses/new       → Mostrar formulario de creación
POST   /courses           → Crear curso
GET    /courses/{id}      → Ver detalle de un curso
GET    /courses/{id}/edit → Mostrar formulario de edición
PUT    /courses/{id}      → Actualizar curso
DELETE /courses/{id}      → Borrar curso
```

Este cambio no añade una funcionalidad completamente nueva, pero mejora mucho la claridad del proyecto.

---

# 2. Qué problema queremos resolver

En el Tema 7 teníamos este tipo de métodos:

```java
@PostMapping("/update")
public String updateCourse(...) {
    ...
}
```

y:

```java
@PostMapping("/delete")
public String deleteCourse(...) {
    ...
}
```

Estos métodos funcionan, pero tienen un pequeño problema de legibilidad.

Ambos usan `POST`, aunque hacen cosas diferentes:

```text
POST /courses        → crear
POST /courses/update → actualizar
POST /courses/delete → borrar
```

El nombre de la URL nos dice lo que ocurre, pero el método HTTP no ayuda mucho.

En una aplicación web más clara, podemos usar:

```text
POST   → crear
PUT    → actualizar
DELETE → borrar
```

Así, al leer el controlador, la intención queda mucho más clara.

---

# 3. Antes y después

## Antes

```text
GET  /courses
GET  /courses/detail?id=1
GET  /courses/new
POST /courses
GET  /courses/edit?id=1
POST /courses/update
POST /courses/delete
```

## Después

```text
GET    /courses
GET    /courses/1
GET    /courses/new
POST   /courses
GET    /courses/1/edit
PUT    /courses/1
DELETE /courses/1
```

### También mejoraremos la legibilidad de las rutas

La diferencia principal es que ahora el identificador del curso forma parte de la ruta.

Antes:

```text
/courses/detail?id=1
```

Ahora:

```text
/courses/1
```

Antes:

```text
/courses/edit?id=1
```

Ahora:

```text
/courses/1/edit
```

Antes:

```text
POST /courses/update
```

Ahora:

```text
PUT /courses/1
```

Antes:

```text
POST /courses/delete
```

Ahora:

```text
DELETE /courses/1
```

---

# 4. Tabla de métodos HTTP

Antes de modificar el código, conviene recordar qué representa cada método HTTP.

| Método   | Uso habitual                             | En nuestro CRUD                   |
| -------- | ---------------------------------------- | --------------------------------- |
| `GET`    | Consultar información                    | Ver listado, detalle o formulario |
| `POST`   | Crear un nuevo recurso                   | Crear curso                       |
| `PUT`    | Actualizar un recurso existente completo | Actualizar curso                  |
| `DELETE` | Borrar un recurso existente              | Borrar curso                      |

En este tema no vamos a construir una API REST completa. Seguimos trabajando con Spring MVC, JSP y formularios tradicionales.

Pero sí vamos a usar métodos HTTP más expresivos dentro de nuestra aplicación.

---

# 5. Problema importante: los formularios HTML solo envían GET y POST

Aquí aparece una limitación importante.

Un formulario HTML tradicional solo permite:

```html
<form method="get"></form>
```

o:

```html
<form method="post"></form>
```

No podemos escribir de forma fiable:

```html
<form method="put"></form>
```

o:

```html
<form method="delete"></form>
```

Por eso, para poder usar `@PutMapping` y `@DeleteMapping` desde formularios JSP, necesitamos una ayuda de Spring:

```java
HiddenHttpMethodFilter
```

Este filtro permite enviar un formulario como `POST`, pero añadir un campo oculto llamado `_method` con el método real que queremos usar.

Por ejemplo:

```html
<form method="post">
  <input type="hidden" name="_method" value="put" />
</form>
```

Spring recibe la petición como `POST`, lee el campo `_method`, y la trata internamente como si fuera una petición `PUT`.

Lo mismo ocurre con `DELETE`.

---

# 6. Qué vamos a modificar

En este tema modificaremos principalmente estos archivos:

```text
src/main/webapp/WEB-INF/web.xml
```

para activar `HiddenHttpMethodFilter`.

```text
src/main/java/com/example/springmvcday1/controller/CourseController.java
```

para cambiar rutas y anotaciones.

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

para enviar `_method=put` cuando editemos.

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

para enviar `_method=delete` cuando borremos.

```text
src/main/webapp/WEB-INF/views/courses/detail.jsp
```

para adaptar los enlaces a las nuevas rutas.

También haremos dos pequeñas mejoras:

```text
Centralizar rutas de redirección dentro del controlador.
Crear métodos privados para preparar el formulario de creación y edición.
```

---

[![Legibilidad](https://img.youtube.com/vi/PM_QiKZc01Y/0.jpg)](https://www.youtube.com/watch?v=PM_QiKZc01Y&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

# 7. Paso 1 — Activar `HiddenHttpMethodFilter` en `web.xml`

Abrimos el archivo:

```text
src/main/webapp/WEB-INF/web.xml
```

En este archivo ya tenemos configurado el `DispatcherServlet`.

Ahora añadiremos un filtro antes de la configuración del servlet.

## Código que debemos añadir

```xml
<filter>
    <filter-name>hiddenHttpMethodFilter</filter-name>
    <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
</filter>

<filter-mapping>
    <filter-name>hiddenHttpMethodFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

## `web.xml` completo orientativo

El archivo puede quedar así:

```xml
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="
            https://jakarta.ee/xml/ns/jakartaee
            https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">

    <display-name>Spring MVC Course</display-name>

    <filter>
        <filter-name>hiddenHttpMethodFilter</filter-name>
        <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
    </filter>

    <filter-mapping>
        <filter-name>hiddenHttpMethodFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <servlet>
        <servlet-name>app</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>

        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>/WEB-INF/spring/app-servlet.xml</param-value>
        </init-param>

        <load-on-startup>1</load-on-startup>
    </servlet>

    <servlet-mapping>
        <servlet-name>app</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>

    <error-page>
        <error-code>404</error-code>
        <location>/error/404</location>
    </error-page>

    <error-page>
        <error-code>500</error-code>
        <location>/error/500</location>
    </error-page>

</web-app>
```

---

# 8. Explicación de `HiddenHttpMethodFilter`

El filtro:

```xml
<filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
```

sirve para detectar formularios `POST` que contienen un campo oculto llamado:

```text
_method
```

Por ejemplo:

```html
<input type="hidden" name="_method" value="put" />
```

o:

```html
<input type="hidden" name="_method" value="delete" />
```

Entonces Spring interpreta la petición como:

```text
PUT
```

o:

```text
DELETE
```

aunque el navegador haya enviado realmente un `POST`.

Esto nos permite tener métodos en el controlador como:

```java
@PutMapping("/{id}")
```

y:

```java
@DeleteMapping("/{id}")
```

desde formularios HTML tradicionales.

---

# 9. Paso 2 — Cambiar rutas con `@PathVariable`

Hasta ahora, para ver un detalle usábamos:

```text
/courses/detail?id=1
```

y en el controlador recibíamos:

```java
@RequestParam("id") Long id
```

Ahora usaremos:

```text
/courses/1
```

y recibiremos el valor con:

```java
@PathVariable Long id
```

## Diferencia entre `@RequestParam` y `@PathVariable`

| Anotación       | De dónde lee el dato | Ejemplo                |
| --------------- | -------------------- | ---------------------- |
| `@RequestParam` | De la query string   | `/courses/detail?id=1` |
| `@PathVariable` | De la ruta           | `/courses/1`           |

Antes:

```java
@GetMapping("/detail")
public String courseDetail(@RequestParam("id") Long id, Model model) {
    ...
}
```

Ahora:

```java
@GetMapping("/{id}")
public String courseDetail(@PathVariable Long id, Model model) {
    ...
}
```

---

# 10. Paso 3 — Actualizar `CourseController`

Vamos a modificar el controlador para usar rutas más limpias y métodos HTTP más expresivos.

Archivo:

```text
src/main/java/com/example/springmvcday1/controller/CourseController.java
```

## Código actualizado completo

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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Locale;

@Controller
@RequestMapping("/courses")
public class CourseController {

    private static final String REDIRECT_COURSES = "redirect:/courses";
    private static final String COURSE_FORM_VIEW = "courses/form";

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

    @GetMapping("/{id}")
    public String courseDetail(
            @PathVariable Long id,
            Model model) {

        Course course = courseService.findByIdOrThrow(id);

        model.addAttribute("pageTitle", course.getTitle());
        model.addAttribute("course", course);

        return "courses/detail";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        prepareCreateForm(model, new Course());

        return COURSE_FORM_VIEW;
    }

    @PostMapping
    public String createCourse(
            @Valid @ModelAttribute("course") Course course,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            prepareCreateForm(model, course);
            return COURSE_FORM_VIEW;
        }

        courseService.save(course);

        addFlashMessage(
                redirectAttributes,
                "success.course.created"
        );

        return REDIRECT_COURSES;
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(
            @PathVariable Long id,
            Model model) {

        Course course = courseService.findByIdOrThrow(id);

        prepareEditForm(model, course);

        return COURSE_FORM_VIEW;
    }

    @PutMapping("/{id}")
    public String updateCourse(
            @PathVariable Long id,
            @Valid @ModelAttribute("course") Course course,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        course.setId(id);

        if (bindingResult.hasErrors()) {
            prepareEditForm(model, course);
            return COURSE_FORM_VIEW;
        }

        courseService.update(course);

        addFlashMessage(
                redirectAttributes,
                "success.course.updated"
        );

        return REDIRECT_COURSES;
    }

    @DeleteMapping("/{id}")
    public String deleteCourse(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {

        courseService.deleteById(id);

        addFlashMessage(
                redirectAttributes,
                "success.course.deleted"
        );

        return REDIRECT_COURSES;
    }

    private void prepareCreateForm(Model model, Course course) {
        model.addAttribute("pageTitleCode", "form.title");
        model.addAttribute("formAction", "/courses");
        model.addAttribute("formMethod", "post");
        model.addAttribute("submitCode", "form.submit");
        model.addAttribute("course", course);
    }

    private void prepareEditForm(Model model, Course course) {
        model.addAttribute("pageTitleCode", "courses.edit.title");
        model.addAttribute("formAction", "/courses/" + course.getId());
        model.addAttribute("formMethod", "put");
        model.addAttribute("submitCode", "courses.update");
        model.addAttribute("course", course);
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

# 11. Explicación de los cambios en el controlador

## 11.1. Nuevos imports

Ahora necesitamos importar:

```java
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
```

`@PutMapping` se usará para actualizar.

`@DeleteMapping` se usará para borrar.

`@PathVariable` se usará para leer el `id` desde la ruta.

---

## 11.2. Constantes para vistas y redirecciones

Añadimos:

```java
private static final String REDIRECT_COURSES = "redirect:/courses";
private static final String COURSE_FORM_VIEW = "courses/form";
```

No es obligatorio, pero mejora la legibilidad.

Antes repetíamos varias veces:

```java
return "redirect:/courses";
```

y:

```java
return "courses/form";
```

Ahora podemos escribir:

```java
return REDIRECT_COURSES;
```

o:

```java
return COURSE_FORM_VIEW;
```

Si en el futuro cambia el nombre de la vista o la ruta de redirección, solo tendríamos que cambiarlo en un sitio.

---

# 12. Ruta de detalle con `@PathVariable`

Antes:

```java
@GetMapping("/detail")
public String courseDetail(@RequestParam("id") Long id, Model model) {
    ...
}
```

Ahora:

```java
@GetMapping("/{id}")
public String courseDetail(
        @PathVariable Long id,
        Model model) {
```

La URL antes era:

```text
/courses/detail?id=1
```

Ahora es:

```text
/courses/1
```

El valor `1` se guarda automáticamente en la variable `id`.

---

# 13. Ruta de edición con `@PathVariable`

Antes:

```text
/courses/edit?id=1
```

Ahora:

```text
/courses/1/edit
```

El método queda así:

```java
@GetMapping("/{id}/edit")
public String showEditForm(
        @PathVariable Long id,
        Model model) {

    Course course = courseService.findByIdOrThrow(id);

    prepareEditForm(model, course);

    return COURSE_FORM_VIEW;
}
```

Esta ruta se lee de forma muy natural:

```text
Mostrar el formulario de edición del curso 1.
```

---

# 14. Actualizar con `@PutMapping`

Antes:

```java
@PostMapping("/update")
public String updateCourse(...) {
    ...
}
```

Ahora:

```java
@PutMapping("/{id}")
public String updateCourse(
        @PathVariable Long id,
        @Valid @ModelAttribute("course") Course course,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {
```

La URL será:

```text
PUT /courses/1
```

Esto expresa mejor la intención:

```text
Actualizar el curso con id 1.
```

Dentro del método hacemos:

```java
course.setId(id);
```

## ¿Por qué hacemos `course.setId(id)`?

Porque ahora el `id` principal viene en la ruta:

```text
/courses/1
```

y lo recibimos con:

```java
@PathVariable Long id
```

Aunque el formulario también puede enviar un campo oculto con el `id`, es más claro usar el `id` de la ruta como fuente principal.

Por eso hacemos:

```java
course.setId(id);
```

Así nos aseguramos de que el objeto `Course` tiene el identificador correcto antes de actualizar.

---

# 15. Borrar con `@DeleteMapping`

Antes:

```java
@PostMapping("/delete")
public String deleteCourse(@RequestParam("id") Long id, ...) {
    ...
}
```

Ahora:

```java
@DeleteMapping("/{id}")
public String deleteCourse(
        @PathVariable Long id,
        RedirectAttributes redirectAttributes) {
```

La URL será:

```text
DELETE /courses/1
```

Esto expresa claramente:

```text
Borrar el curso con id 1.
```

El método queda más limpio porque el `id` forma parte de la ruta.

---

# 16. Métodos auxiliares para preparar formularios

En el Tema 7 repetíamos varias veces estos atributos:

```java
model.addAttribute("pageTitleCode", ...);
model.addAttribute("formAction", ...);
model.addAttribute("submitCode", ...);
model.addAttribute("course", ...);
```

Ahora hemos creado dos métodos privados:

```java
private void prepareCreateForm(Model model, Course course) {
    ...
}
```

y:

```java
private void prepareEditForm(Model model, Course course) {
    ...
}
```

## Método para creación

```java
private void prepareCreateForm(Model model, Course course) {
    model.addAttribute("pageTitleCode", "form.title");
    model.addAttribute("formAction", "/courses");
    model.addAttribute("formMethod", "post");
    model.addAttribute("submitCode", "form.submit");
    model.addAttribute("course", course);
}
```

Este método prepara el formulario para crear.

Los valores principales son:

```text
formAction → /courses
formMethod → post
submitCode → form.submit
```

## Método para edición

```java
private void prepareEditForm(Model model, Course course) {
    model.addAttribute("pageTitleCode", "courses.edit.title");
    model.addAttribute("formAction", "/courses/" + course.getId());
    model.addAttribute("formMethod", "put");
    model.addAttribute("submitCode", "courses.update");
    model.addAttribute("course", course);
}
```

Este método prepara el formulario para editar.

Los valores principales son:

```text
formAction → /courses/1
formMethod → put
submitCode → courses.update
```

Esto nos permitirá usar la misma vista `form.jsp` para crear y editar.

---

# 17. Paso 4 — Actualizar `form.jsp`

Ahora modificamos el formulario para que pueda enviar `PUT` cuando estemos editando.

Archivo:

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

## Código actualizado

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

            <c:if test="${formMethod == 'put'}">
                <input type="hidden" name="_method" value="put">
            </c:if>

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

# 18. Explicación de los cambios en `form.jsp`

## 18.1. El formulario sigue usando `POST`

El formulario tiene:

```jsp
<form:form
        method="post"
        action="${pageContext.request.contextPath}${formAction}"
        modelAttribute="course"
        cssClass="form">
```

Aunque vayamos a actualizar con `PUT`, el formulario HTML sigue enviando `POST`.

Esto es normal porque los formularios HTML tradicionales no envían `PUT` directamente.

---

## 18.2. Campo oculto `_method`

La clave está aquí:

```jsp
<c:if test="${formMethod == 'put'}">
    <input type="hidden" name="_method" value="put">
</c:if>
```

Si estamos editando, el controlador habrá enviado:

```java
model.addAttribute("formMethod", "put");
```

Entonces la JSP añade:

```html
<input type="hidden" name="_method" value="put" />
```

Cuando se envía el formulario, `HiddenHttpMethodFilter` detecta este campo y transforma la petición en `PUT`.

Así puede ejecutarse este método del controlador:

```java
@PutMapping("/{id}")
public String updateCourse(...) {
    ...
}
```

---

## 18.3. Campo oculto `id`

Seguimos manteniendo:

```jsp
<form:hidden path="id" />
```

Aunque el `id` también está en la ruta, este campo sigue siendo útil para que el objeto `course` mantenga su identificador en el formulario.

La fuente principal del `id` será la ruta:

```java
@PathVariable Long id
```

pero conservar el campo oculto ayuda a mantener el formulario completo.

---

# 19. Paso 5 — Actualizar `list.jsp`

Ahora debemos cambiar los enlaces del listado.

Archivo:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

## Código actualizado

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
                        <a href="${pageContext.request.contextPath}/courses/${course.id}">
                            <spring:message code="courses.detail" />
                        </a>

                        <a href="${pageContext.request.contextPath}/courses/${course.id}/edit">
                            <spring:message code="courses.edit" />
                        </a>

                        <form method="post"
                              action="${pageContext.request.contextPath}/courses/${course.id}"
                              class="inline-form"
                              onsubmit="return confirm('<spring:message code="courses.confirmDelete" />');">

                            <input type="hidden" name="_method" value="delete">

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

# 20. Explicación de los cambios en `list.jsp`

## 20.1. Enlace de detalle

Antes:

```jsp
<a href="${pageContext.request.contextPath}/courses/detail?id=${course.id}">
```

Ahora:

```jsp
<a href="${pageContext.request.contextPath}/courses/${course.id}">
```

Esto genera rutas como:

```text
/courses/1
/courses/2
/courses/3
```

---

## 20.2. Enlace de edición

Antes:

```jsp
<a href="${pageContext.request.contextPath}/courses/edit?id=${course.id}">
```

Ahora:

```jsp
<a href="${pageContext.request.contextPath}/courses/${course.id}/edit">
```

Esto genera rutas como:

```text
/courses/1/edit
/courses/2/edit
/courses/3/edit
```

---

## 20.3. Formulario de borrado con `_method=delete`

Antes el borrado podía ir a:

```text
POST /courses/delete
```

Ahora el formulario apunta a:

```jsp
action="${pageContext.request.contextPath}/courses/${course.id}"
```

y contiene:

```html
<input type="hidden" name="_method" value="delete" />
```

El navegador envía un `POST`.

Pero `HiddenHttpMethodFilter` convierte la petición en `DELETE`.

Entonces Spring ejecuta:

```java
@DeleteMapping("/{id}")
public String deleteCourse(...) {
    ...
}
```

---

# 21. Paso 6 — Actualizar `detail.jsp`

Ahora debemos adaptar la vista de detalle para que sus enlaces usen las rutas nuevas.

Archivo:

```text
src/main/webapp/WEB-INF/views/courses/detail.jsp
```

Código orientativo:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <%@ include file="/WEB-INF/views/fragments/head.jspf" %>
</head>
<body>

<%@ include file="/WEB-INF/views/fragments/header.jspf" %>

<main class="container">
    <section class="card">
        <h1>${course.title}</h1>

        <ul class="details">
            <li>
                <strong><spring:message code="courses.level" />:</strong>
                ${course.level}
            </li>
            <li>
                <strong><spring:message code="courses.duration" />:</strong>
                ${course.durationInHours}
                <spring:message code="courses.hours" />
            </li>
            <li>
                <strong>ID:</strong>
                ${course.id}
            </li>
        </ul>

        <div class="form-actions">
            <a class="button" href="${pageContext.request.contextPath}/courses/${course.id}/edit">
                <spring:message code="courses.edit" />
            </a>

            <a class="secondary-button" href="${pageContext.request.contextPath}/courses">
                <spring:message code="courses.backList" />
            </a>
        </div>
    </section>
</main>

</body>
</html>
```

## Explicación

El enlace de edición ahora apunta a:

```jsp
/courses/${course.id}/edit
```

Por ejemplo:

```text
/courses/3/edit
```

Así mantenemos el nuevo estilo de rutas en todo el proyecto.

---

# 22. Paso 7 — Revisar `CourseService` y `CourseDao`

La buena noticia es que, en principio, no necesitamos cambiar `CourseService` ni `CourseDao`.

El cambio principal está en:

```text
Controller
JSP
web.xml
```

Los métodos del servicio siguen siendo válidos:

```java
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
```

Y los métodos del DAO también:

```java
public void update(Course course) {
    ...
}

public void deleteById(Long id) {
    ...
}
```

Esto demuestra una ventaja de tener el proyecto separado por capas.

Podemos cambiar las rutas del controlador sin tocar la lógica de acceso a datos.

---

# 23. Paso 8 — Probar el flujo completo

## 23.1. Probar listado

Entramos en:

```text
http://localhost:8080/spring-mvc-day1/courses
```

Comprobamos que aparecen los cursos.

Los enlaces deberían ser ahora parecidos a:

```text
/courses/1
/courses/1/edit
```

---

## 23.2. Probar detalle

Pulsamos en:

```text
Ver detalle
```

La URL debe ser parecida a:

```text
/courses/1
```

Debe mostrarse el detalle del curso.

---

## 23.3. Probar creación

Entramos en:

```text
/courses/new
```

Creamos un curso.

La creación sigue usando:

```text
POST /courses
```

Debe funcionar igual que antes.

---

## 23.4. Probar edición

Pulsamos:

```text
Editar
```

La URL debe ser:

```text
/courses/1/edit
```

Modificamos el curso y enviamos el formulario.

Internamente, el formulario envía:

```text
POST /courses/1
```

con:

```text
_method=put
```

Spring lo interpreta como:

```text
PUT /courses/1
```

Debe ejecutarse el método con:

```java
@PutMapping("/{id}")
```

---

## 23.5. Probar borrado

Pulsamos:

```text
Borrar
```

El formulario envía:

```text
POST /courses/1
```

con:

```text
_method=delete
```

Spring lo interpreta como:

```text
DELETE /courses/1
```

Debe ejecutarse:

```java
@DeleteMapping("/{id}")
```

---

# 24. Cómo comprobar que `HiddenHttpMethodFilter` funciona

Una forma sencilla de comprobarlo es poner temporalmente un mensaje en el controlador.

Por ejemplo:

```java
@PutMapping("/{id}")
public String updateCourse(...) {
    System.out.println("Se ha ejecutado el método PUT");
    ...
}
```

Si al enviar el formulario de edición aparece ese mensaje en la consola, el filtro está funcionando.

También puedes probar a quitar temporalmente esta línea del formulario:

```html
<input type="hidden" name="_method" value="put" />
```

Si la quitas, el formulario llegará como `POST`, y Spring no encontrará el método `@PutMapping`.

---

# 25. Mejora adicional sencilla — Métodos privados para reducir repetición

En este tema hemos añadido dos métodos privados:

```java
prepareCreateForm(...)
prepareEditForm(...)
```

Esto es una mejora pequeña pero importante.

Antes podíamos tener repetido varias veces:

```java
model.addAttribute("pageTitleCode", "courses.edit.title");
model.addAttribute("formAction", "/courses/update");
model.addAttribute("submitCode", "courses.update");
model.addAttribute("course", course);
```

Ahora lo concentramos en:

```java
prepareEditForm(model, course);
```

Esto hace que el controlador sea más legible.

---

# 26. Mejora adicional sencilla — Constantes para vistas y redirecciones

También añadimos:

```java
private static final String REDIRECT_COURSES = "redirect:/courses";
private static final String COURSE_FORM_VIEW = "courses/form";
```

Esto evita repetir cadenas de texto.

Antes:

```java
return "redirect:/courses";
```

varias veces.

Ahora:

```java
return REDIRECT_COURSES;
```

No es obligatorio, pero en proyectos medianos ayuda a evitar errores de escritura.

---

# 27. Errores habituales del Tema 8

## Error 1 — Olvidar `HiddenHttpMethodFilter`

Si no configuramos:

```xml
<filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
```

Spring no convertirá `_method=put` en `PUT`.

Entonces el formulario llegará como `POST`.

El método:

```java
@PutMapping("/{id}")
```

no se ejecutará.

---

## Error 2 — Olvidar el campo `_method`

Si en el formulario de edición no ponemos:

```html
<input type="hidden" name="_method" value="put" />
```

el formulario seguirá siendo un `POST`.

Para el borrado ocurre lo mismo:

```html
<input type="hidden" name="_method" value="delete" />
```

---

## Error 3 — Usar `method="put"` directamente en el formulario

No debemos escribir:

```jsp
<form:form method="put">
```

En una aplicación JSP tradicional es más claro y seguro usar:

```jsp
<form:form method="post">
```

y añadir:

```html
<input type="hidden" name="_method" value="put" />
```

Así sabemos exactamente qué está ocurriendo.

---

## Error 4 — Cambiar la ruta del controlador pero no los enlaces de la JSP

Si el controlador usa:

```java
@GetMapping("/{id}")
```

pero la JSP sigue enlazando a:

```text
/courses/detail?id=1
```

la ruta antigua dejará de funcionar.

Hay que actualizar los enlaces:

```jsp
/courses/${course.id}
```

---

## Error 5 — Cambiar a `@PathVariable` pero seguir usando `@RequestParam`

Si la ruta es:

```java
@GetMapping("/{id}")
```

el método debe recibir:

```java
@PathVariable Long id
```

No:

```java
@RequestParam("id") Long id
```

`@RequestParam` espera algo como:

```text
?id=1
```

pero la nueva ruta tiene:

```text
/courses/1
```

---

## Error 6 — Confundir `/courses/new` con `/{id}`

Tenemos estas dos rutas:

```java
@GetMapping("/new")
@GetMapping("/{id}")
```

Spring suele resolver correctamente la ruta más específica, pero conviene escribir rutas claras y no usar identificadores que puedan confundirse con palabras.

En nuestro caso, `/new` significa formulario de creación, y `/{id}` significa detalle de un curso.

---

## Error 7 — No hacer `course.setId(id)` en el método `update`

En el método `@PutMapping`, el `id` viene de la ruta:

```java
@PathVariable Long id
```

Conviene hacer:

```java
course.setId(id);
```

Así nos aseguramos de que el objeto que llega al servicio tiene el identificador correcto.

---

# 28. Resumen del CRUD después del Tema 8

Después de este tema, el CRUD queda así:

| Operación        | Método HTTP | Ruta                 | Método del controlador |
| ---------------- | ----------- | -------------------- | ---------------------- |
| Listar           | `GET`       | `/courses`           | `listCourses`          |
| Ver detalle      | `GET`       | `/courses/{id}`      | `courseDetail`         |
| Mostrar creación | `GET`       | `/courses/new`       | `showCreateForm`       |
| Crear            | `POST`      | `/courses`           | `createCourse`         |
| Mostrar edición  | `GET`       | `/courses/{id}/edit` | `showEditForm`         |
| Actualizar       | `PUT`       | `/courses/{id}`      | `updateCourse`         |
| Borrar           | `DELETE`    | `/courses/{id}`      | `deleteCourse`         |

Ahora el controlador comunica mucho mejor la intención de cada operación.

---

# 39. Comparación final

## Tema 7

```java
@PostMapping("/update")
public String updateCourse(...) {
    ...
}

@PostMapping("/delete")
public String deleteCourse(...) {
    ...
}
```

## Tema 8

```java
@PutMapping("/{id}")
public String updateCourse(...) {
    ...
}

@DeleteMapping("/{id}")
public String deleteCourse(...) {
    ...
}
```

La aplicación no cambia mucho para el usuario final, pero el código queda más claro.

---

# 30. Cierre

En este tema hemos mejorado la legibilidad del CRUD usando métodos HTTP más expresivos.

Hemos aprendido que:

```text
GET sirve para consultar.
POST sirve para crear.
PUT sirve para actualizar.
DELETE sirve para borrar.
```

También hemos visto que los formularios HTML tradicionales no envían `PUT` ni `DELETE` directamente, por lo que usamos:

```text
HiddenHttpMethodFilter
```

y un campo oculto:

```html
<input type="hidden" name="_method" value="put" />
```

o:

```html
<input type="hidden" name="_method" value="delete" />
```

Además, hemos limpiado un poco el controlador usando:

```text
@PathVariable
Métodos privados para preparar formularios
Constantes para vistas y redirecciones
```

La estructura final sigue siendo la misma:

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

Pero ahora el controlador expresa mucho mejor la intención del CRUD.
