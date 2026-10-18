# Topic 8 — Readability

## 1. Objective of the topic

In **Topic 7** we completed the CRUD of our Spring MVC application.

The application already lets you:

```text
Crear cursos.
Ver el listado de cursos.
Ver el detalle de un curso.
Editar cursos.
Borrar cursos.
```

However, there is still something we can improve.

In Topic 7 we used routes like these:

```text
GET  /courses/detail?id=1
GET  /courses/edit?id=1
POST /courses/update
POST /courses/delete
```

They work correctly, but they are not the most expressive routes.

In this **Topic 8** we are going to improve the readability of the CRUD using:

```java
@PutMapping
@DeleteMapping
@PathVariable
```

The goal is for the routes to be clearer and for the code to better reflect the intention of each operation.

At the end of this topic, our routes will look like this:

```text
GET    /courses           → Listar cursos
GET    /courses/new       → Mostrar formulario de creación
POST   /courses           → Crear curso
GET    /courses/{id}      → Ver detalle de un curso
GET    /courses/{id}/edit → Mostrar formulario de edición
PUT    /courses/{id}      → Actualizar curso
DELETE /courses/{id}      → Borrar curso
```

This change does not add completely new functionality, but it greatly improves the clarity of the project.

---

# 2. What problem do we want to solve?

In Topic 7 we had these types of methods:

```java
@PostMapping("/update")
public String updateCourse(...) {
    ...
}
```

and:

```java
@PostMapping("/delete")
public String deleteCourse(...) {
    ...
}
```

These methods work, but they have a small readability problem.

They both use `POST`, although they do different things:

```text
POST /courses        → crear
POST /courses/update → actualizar
POST /courses/delete → borrar
```

The URL name tells us what is happening, but the HTTP method doesn't help much.

In a clearer web application, we can use:

```text
POST   → crear
PUT    → actualizar
DELETE → borrar
```

This way, when reading the controller, the intention becomes much clearer.

---

# 3. Before and after

## Before

```text
GET  /courses
GET  /courses/detail?id=1
GET  /courses/new
POST /courses
GET  /courses/edit?id=1
POST /courses/update
POST /courses/delete
```

## After

```text
GET    /courses
GET    /courses/1
GET    /courses/new
POST   /courses
GET    /courses/1/edit
PUT    /courses/1
DELETE /courses/1
```

### We will also improve the readability of the routes

The main difference is that the course identifier is now part of the route.

Before:

```text
/courses/detail?id=1
```

Now:

```text
/courses/1
```

Before:

```text
/courses/edit?id=1
```

Now:

```text
/courses/1/edit
```

Before:

```text
POST /courses/update
```

Now:

```text
PUT /courses/1
```

Before:

```text
POST /courses/delete
```

Now:

```text
DELETE /courses/1
```

---

# 4. HTTP methods table

Before modifying the code, it is worth remembering what each HTTP method represents.

| Method | Typical use | In our CRUD |
| -------- | ---------------------------------------- | --------------------------------- |
| `GET` | Retrieve information | View the list, details or a form |
| `POST` | Create a new resource | Create course |
| `PUT` | Update an entire existing resource | Update course |
| `DELETE` | Delete an existing resource | Delete course |

In this topic we are not going to build a complete REST API. We continue working with Spring MVC, JSP and traditional forms.

But we are going to use more expressive HTTP methods within our application.

---

# 5. An important problem: HTML forms only send GET and POST

An important limitation appears here.

A traditional HTML form only allows:

```html
<form method="get"></form>
```

or:

```html
<form method="post"></form>
```

We cannot reliably write:

```html
<form method="put"></form>
```

or:

```html
<form method="delete"></form>
```

Therefore, in order to use `@PutMapping` and `@DeleteMapping` from JSP forms, we need help from Spring:

```java
HiddenHttpMethodFilter
```

This filter lets you submit a form as `POST`, but add a hidden field called `_method` with the actual method we want to use.

For example:

```html
<form method="post">
  <input type="hidden" name="_method" value="put" />
</form>
```

Spring receives the request as `POST`, reads the `_method` field, and treats it internally as if it were a `PUT` request.

The same goes for `DELETE`.

---

# 6. What we are going to modify

In this topic we will mainly modify these files:

```text
src/main/webapp/WEB-INF/web.xml
```

to enable `HiddenHttpMethodFilter`.

```text
src/main/java/com/example/springmvcday1/controller/CourseController.java
```

to change routes and annotations.

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

to send `_method=put` when we edit.

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

to send `_method=delete` when we delete.

```text
src/main/webapp/WEB-INF/views/courses/detail.jsp
```

to adapt the links to the new routes.

We will also make two small improvements:

```text
Centralizar rutas de redirección dentro del controlador.
Crear métodos privados para preparar el formulario de creación y edición.
```

---

[![Readability](https://img.youtube.com/vi/PM_QiKZc01Y/0.jpg)](https://www.youtube.com/watch?v=PM_QiKZc01Y&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

# 7. Step 1 — Enable `HiddenHttpMethodFilter` in `web.xml`

We open the file:

```text
src/main/webapp/WEB-INF/web.xml
```

In this file we already have the `DispatcherServlet` configured.

Now we will add a filter before the servlet configuration.

## Code to add

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

## Complete `web.xml` (for reference)

The file can look like this:

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

# 8. Explanation of `HiddenHttpMethodFilter`

The filter:

```xml
<filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
```

is used to detect `POST` forms that contain a hidden field called:

```text
_method
```

For example:

```html
<input type="hidden" name="_method" value="put" />
```

or:

```html
<input type="hidden" name="_method" value="delete" />
```

Spring then interprets the request as:

```text
PUT
```

or:

```text
DELETE
```

even though the browser actually sent a `POST`.

This allows us to have methods in the controller like:

```java
@PutMapping("/{id}")
```

and:

```java
@DeleteMapping("/{id}")
```

from traditional HTML forms.

---

# 9. Step 2 — Change routes with `@PathVariable`

Until now, to view a course's details we used:

```text
/courses/detail?id=1
```

and in the controller we received:

```java
@RequestParam("id") Long id
```

Now we will use:

```text
/courses/1
```

and we will receive the value with:

```java
@PathVariable Long id
```

## Difference between `@RequestParam` and `@PathVariable`

| Annotation | Where it reads the data from | Example |
| --------------- | -------------------- | ---------------------- |
| `@RequestParam` | From the query string | `/courses/detail?id=1` |
| `@PathVariable` | From the route | `/courses/1` |

Before:

```java
@GetMapping("/detail")
public String courseDetail(@RequestParam("id") Long id, Model model) {
    ...
}
```

Now:

```java
@GetMapping("/{id}")
public String courseDetail(@PathVariable Long id, Model model) {
    ...
}
```

---

# 10. Step 3 — Update `CourseController`

We are going to modify the controller to use cleaner routes and more expressive HTTP methods.

File:

```text
src/main/java/com/example/springmvcday1/controller/CourseController.java
```

## Updated full code

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

# 11. Explanation of the changes in the controller

## 11.1. New imports

Now we need to import:

```java
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
```

`@PutMapping` will be used to update.

`@DeleteMapping` will be used to delete.

`@PathVariable` will be used to read the `id` from the route.

---

## 11.2. Constants for views and redirects

We add:

```java
private static final String REDIRECT_COURSES = "redirect:/courses";
private static final String COURSE_FORM_VIEW = "courses/form";
```

It is not required, but it improves readability.

Before, we repeated this several times:

```java
return "redirect:/courses";
```

and:

```java
return "courses/form";
```

Now we can write:

```java
return REDIRECT_COURSES;
```

or:

```java
return COURSE_FORM_VIEW;
```

If the view name or the redirect route changes in the future, we would only have to change it in one place.

---

# 12. Detail route with `@PathVariable`

Before:

```java
@GetMapping("/detail")
public String courseDetail(@RequestParam("id") Long id, Model model) {
    ...
}
```

Now:

```java
@GetMapping("/{id}")
public String courseDetail(
        @PathVariable Long id,
        Model model) {
```

The URL before was:

```text
/courses/detail?id=1
```

Now it is:

```text
/courses/1
```

The value `1` is automatically stored in the `id` variable.

---

# 13. Edit route with `@PathVariable`

Before:

```text
/courses/edit?id=1
```

Now:

```text
/courses/1/edit
```

The method looks like this:

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

This route reads very naturally:

```text
Mostrar el formulario de edición del curso 1.
```

---

# 14. Update with `@PutMapping`

Before:

```java
@PostMapping("/update")
public String updateCourse(...) {
    ...
}
```

Now:

```java
@PutMapping("/{id}")
public String updateCourse(
        @PathVariable Long id,
        @Valid @ModelAttribute("course") Course course,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {
```

The URL will be:

```text
PUT /courses/1
```

This expresses the intention better:

```text
Actualizar el curso con id 1.
```

Inside the method we do:

```java
course.setId(id);
```

## Why do we call `course.setId(id)`?

Because now the main `id` comes in the route:

```text
/courses/1
```

and we receive it with:

```java
@PathVariable Long id
```

Although the form can also submit a hidden field with the `id`, it is clearer to use the `id` from the route as the main source.

That's why we do:

```java
course.setId(id);
```

This ensures that the `Course` object has the correct identifier before updating.

---

# 15. Delete with `@DeleteMapping`

Before:

```java
@PostMapping("/delete")
public String deleteCourse(@RequestParam("id") Long id, ...) {
    ...
}
```

Now:

```java
@DeleteMapping("/{id}")
public String deleteCourse(
        @PathVariable Long id,
        RedirectAttributes redirectAttributes) {
```

The URL will be:

```text
DELETE /courses/1
```

This clearly expresses:

```text
Borrar el curso con id 1.
```

The method is cleaner because the `id` is part of the route.

---

# 16. Helper methods for preparing forms

In Topic 7 we repeated these attributes several times:

```java
model.addAttribute("pageTitleCode", ...);
model.addAttribute("formAction", ...);
model.addAttribute("submitCode", ...);
model.addAttribute("course", ...);
```

Now we have created two private methods:

```java
private void prepareCreateForm(Model model, Course course) {
    ...
}
```

and:

```java
private void prepareEditForm(Model model, Course course) {
    ...
}
```

## Method for creating

```java
private void prepareCreateForm(Model model, Course course) {
    model.addAttribute("pageTitleCode", "form.title");
    model.addAttribute("formAction", "/courses");
    model.addAttribute("formMethod", "post");
    model.addAttribute("submitCode", "form.submit");
    model.addAttribute("course", course);
}
```

This method prepares the form for creating.

The main values are:

```text
formAction → /courses
formMethod → post
submitCode → form.submit
```

## Method for editing

```java
private void prepareEditForm(Model model, Course course) {
    model.addAttribute("pageTitleCode", "courses.edit.title");
    model.addAttribute("formAction", "/courses/" + course.getId());
    model.addAttribute("formMethod", "put");
    model.addAttribute("submitCode", "courses.update");
    model.addAttribute("course", course);
}
```

This method prepares the form for editing.

The main values are:

```text
formAction → /courses/1
formMethod → put
submitCode → courses.update
```

This will allow us to use the same `form.jsp` view for creating and editing.

---

# 17. Step 4 — Update `form.jsp`

We now modify the form so that it can submit `PUT` when we are editing.

File:

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

## Updated code

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

# 18. Explanation of the changes in `form.jsp`

## 18.1. The form still uses `POST`

The form has:

```jsp
<form:form
        method="post"
        action="${pageContext.request.contextPath}${formAction}"
        modelAttribute="course"
        cssClass="form">
```

Even though we are updating with `PUT`, the HTML form still sends `POST`.

This is normal because traditional HTML forms do not send `PUT` directly.

---

## 18.2. The hidden `_method` field

The key is here:

```jsp
<c:if test="${formMethod == 'put'}">
    <input type="hidden" name="_method" value="put">
</c:if>
```

If we are editing, the controller will have sent:

```java
model.addAttribute("formMethod", "put");
```

Then the JSP adds:

```html
<input type="hidden" name="_method" value="put" />
```

When the form is submitted, `HiddenHttpMethodFilter` detects this field and turns the request into a `PUT`.

That's how this controller method can run:

```java
@PutMapping("/{id}")
public String updateCourse(...) {
    ...
}
```

---

## 18.3. The hidden `id` field

We still keep:

```jsp
<form:hidden path="id" />
```

Although the `id` is also in the route, this field is still useful so that the `course` object keeps its identifier in the form.

The main source of the `id` will be the route:

```java
@PathVariable Long id
```

but keeping the hidden field helps keep the form complete.

---

# 19. Step 5 — Update `list.jsp`

Now we must change the links in the list.

File:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

## Updated code

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

# 20. Explanation of the changes in `list.jsp`

## 20.1. Detail link

Before:

```jsp
<a href="${pageContext.request.contextPath}/courses/detail?id=${course.id}">
```

Now:

```jsp
<a href="${pageContext.request.contextPath}/courses/${course.id}">
```

This generates routes like:

```text
/courses/1
/courses/2
/courses/3
```

---

## 20.2. Edit link

Before:

```jsp
<a href="${pageContext.request.contextPath}/courses/edit?id=${course.id}">
```

Now:

```jsp
<a href="${pageContext.request.contextPath}/courses/${course.id}/edit">
```

This generates routes like:

```text
/courses/1/edit
/courses/2/edit
/courses/3/edit
```

---

## 20.3. Delete form with `_method=delete`

Before, deletion could go to:

```text
POST /courses/delete
```

Now the form points to:

```jsp
action="${pageContext.request.contextPath}/courses/${course.id}"
```

and contains:

```html
<input type="hidden" name="_method" value="delete" />
```

The browser sends a `POST`.

But `HiddenHttpMethodFilter` converts the request into a `DELETE`.

Then Spring runs:

```java
@DeleteMapping("/{id}")
public String deleteCourse(...) {
    ...
}
```

---

# 21. Step 6 — Update `detail.jsp`

Now we must adapt the detail view so that its links use the new routes.

File:

```text
src/main/webapp/WEB-INF/views/courses/detail.jsp
```

Reference code:

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

## Explanation

The edit link now points to:

```jsp
/courses/${course.id}/edit
```

For example:

```text
/courses/3/edit
```

This way we keep the new route style throughout the project.

---

# 22. Step 7 — Check `CourseService` and `CourseDao`

The good news is that, in principle, we do not need to change `CourseService` or `CourseDao`.

The main change is in:

```text
Controller
JSP
web.xml
```

The service methods are still valid:

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

And the DAO methods too:

```java
public void update(Course course) {
    ...
}

public void deleteById(Long id) {
    ...
}
```

This shows one advantage of separating the project into layers.

We can change the controller routes without touching the data access logic.

---

# 23. Step 8 — Test the complete flow

## 23.1. Test the list

We go to:

```text
http://localhost:8080/spring-mvc-day1/courses
```

We check that the courses appear.

The links should now look like:

```text
/courses/1
/courses/1/edit
```

---

## 23.2. Test the details

We click on:

```text
Ver detalle
```

The URL should look like:

```text
/courses/1
```

The course details should be shown.

---

## 23.3. Test creating

We go to:

```text
/courses/new
```

We create a course.

Creating still uses:

```text
POST /courses
```

It should work the same as before.

---

## 23.4. Test editing

We click:

```text
Editar
```

The URL should be:

```text
/courses/1/edit
```

We modify the course and submit the form.

Internally, the form sends:

```text
POST /courses/1
```

with:

```text
_method=put
```

Spring interprets it as:

```text
PUT /courses/1
```

The method that should run is the one with:

```java
@PutMapping("/{id}")
```

---

## 23.5. Test deleting

We click:

```text
Borrar
```

The form sends:

```text
POST /courses/1
```

with:

```text
_method=delete
```

Spring interprets it as:

```text
DELETE /courses/1
```

This method should run:

```java
@DeleteMapping("/{id}")
```

---

# 24. How to check that `HiddenHttpMethodFilter` works

An easy way to check this is to temporarily add a message to the controller.

For example:

```java
@PutMapping("/{id}")
public String updateCourse(...) {
    System.out.println("Se ha ejecutado el método PUT");
    ...
}
```

If this message appears in the console when you submit the edit form, the filter is working.

You can also try temporarily removing this line from the form:

```html
<input type="hidden" name="_method" value="put" />
```

If you remove it, the form will arrive as `POST`, and Spring will not find the `@PutMapping` method.

---

# 25. Simple additional improvement — Private methods to reduce repetition

In this topic we have added two private methods:

```java
prepareCreateForm(...)
prepareEditForm(...)
```

This is a small but important improvement.

Before, we could have this repeated several times:

```java
model.addAttribute("pageTitleCode", "courses.edit.title");
model.addAttribute("formAction", "/courses/update");
model.addAttribute("submitCode", "courses.update");
model.addAttribute("course", course);
```

Now we centralize it in:
```java
prepareEditForm(model, course);
```

This makes the controller more readable.

---

# 26. Simple additional improvement — Constants for views and redirects

We also add:

```java
private static final String REDIRECT_COURSES = "redirect:/courses";
private static final String COURSE_FORM_VIEW = "courses/form";
```

This avoids repeating text strings.

Before:

```java
return "redirect:/courses";
```

several times.

Now:

```java
return REDIRECT_COURSES;
```

It is not mandatory, but in medium-sized projects it helps avoid typos.

---

# 27. Common mistakes in Topic 8

## Error 1 — Forgetting `HiddenHttpMethodFilter`

If we do not configure:

```xml
<filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
```

Spring will not convert `_method=put` to `PUT`.

Then the form will arrive as `POST`.

The method:

```java
@PutMapping("/{id}")
```

will not run.

---

## Error 2 — Forgetting the `_method` field

If we don't add this to the edit form:

```html
<input type="hidden" name="_method" value="put" />
```

the form will still be a `POST`.

The same thing happens for deletion:

```html
<input type="hidden" name="_method" value="delete" />
```

---

## Error 3 — Using `method="put"` directly in the form

We should not write:

```jsp
<form:form method="put">
```

In a traditional JSP application it is clearer and safer to use:

```jsp
<form:form method="post">
```

and add:

```html
<input type="hidden" name="_method" value="put" />
```

This way we know exactly what is happening.

---

## Error 4 — Changing the controller route but not the JSP links

If the controller uses:

```java
@GetMapping("/{id}")
```

but the JSP keeps linking to:

```text
/courses/detail?id=1
```

the old route will no longer work.

The links need to be updated:

```jsp
/courses/${course.id}
```

---

## Error 5 — Switching to `@PathVariable` but still using `@RequestParam`

If the route is:

```java
@GetMapping("/{id}")
```

the method should receive:

```java
@PathVariable Long id
```

Not:

```java
@RequestParam("id") Long id
```

`@RequestParam` expects something like:

```text
?id=1
```

but the new route has:

```text
/courses/1
```

---

## Error 6 — Confusing `/courses/new` with `/{id}`

We have these two routes:

```java
@GetMapping("/new")
@GetMapping("/{id}")
```

Spring usually resolves the most specific route correctly, but it is a good idea to write clear routes and not use identifiers that could be confused with words.

In our case, `/new` means the creation form, and `/{id}` means a course's details.

---

## Error 7 — Not calling `course.setId(id)` in the `update` method

In the `@PutMapping` method, the `id` comes from the route:

```java
@PathVariable Long id
```

It is advisable to do:

```java
course.setId(id);
```

This way we ensure that the object that arrives at the service has the correct identifier.

---

# 28. CRUD summary after Topic 8

After this topic, the CRUD looks like this:

| Operation | HTTP method | Route | Controller method |
| ---------------- | ----------- | -------------------- | ---------------------- |
| List | `GET` | `/courses` | `listCourses` |
| View details | `GET` | `/courses/{id}` | `courseDetail` |
| Show creation form | `GET` | `/courses/new` | `showCreateForm` |
| Create | `POST` | `/courses` | `createCourse` |
| Show edit form | `GET` | `/courses/{id}/edit` | `showEditForm` |
| Update | `PUT` | `/courses/{id}` | `updateCourse` |
| Delete | `DELETE` | `/courses/{id}` | `deleteCourse` |

Now the controller communicates the intention of each operation much better.

---

# 29. Final comparison

## Topic 7

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

## Topic 8

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

The application doesn't change much for the end user, but the code becomes clearer.

---

# 30. Closing the topic

In this topic we have improved the readability of the CRUD by using more expressive HTTP methods.

We have learned that:

```text
GET sirve para consultar.
POST sirve para crear.
PUT sirve para actualizar.
DELETE sirve para borrar.
```

We have also seen that traditional HTML forms do not send `PUT` or `DELETE` directly, so we use:

```text
HiddenHttpMethodFilter
```

and a hidden field:

```html
<input type="hidden" name="_method" value="put" />
```

or:

```html
<input type="hidden" name="_method" value="delete" />
```

Additionally, we've cleaned up the controller a bit using:

```text
@PathVariable
Métodos privados para preparar formularios
Constantes para vistas y redirecciones
```

The final structure remains the same:

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

But now the controller expresses the intention of the CRUD much better.
