# Topic 5: Exception handling, internationalization and themes in Spring MVC

## 1. Objectives of the topic

In this topic we are going to complete the Spring MVC application that we have been building during the course.

So far, the application already lets you:

- Display pages using controllers and JSP views.
- List courses.
- View the details of a course.
- Create courses using forms.
- Validate form data.
- Optionally, save the data in MySQL.

In this topic we will add three important aspects of a real web application:

1. **Exception handling**: handle errors in an orderly way and display custom error pages.
2. **Internationalization**: allow the application to display texts in different languages.
3. **Local themes**: allow the user to change the visual appearance of the application, for example between a light theme and a dark theme.

By the end of this topic, the application will be able to:

- Show a specific page when a course does not exist.
- Show a custom 404 page when the user accesses a non-existent route.
- Show texts in Spanish or English.
- Change the language using links like `?lang=es` or `?lang=en`.
- Change the visual theme between light and dark.

---

## 2. Starting point

We start from the project used in the previous topics.

The application already has a structure similar to this:

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
        ├── resources
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

In this topic we will add new classes and new files:

```text
src/main/java/com/example/springmvcday1/exception
├── CourseNotFoundException.java
└── GlobalExceptionHandler.java

src/main/java/com/example/springmvcday1/controller
├── ErrorPageController.java
└── ThemeController.java

src/main/resources
├── messages.properties
├── messages_es.properties
└── messages_en.properties

src/main/webapp/resources/css
└── styles-dark.css

src/main/webapp/WEB-INF/views/error
├── course-not-found.jsp
├── not-found.jsp
└── general-error.jsp
```

---

[![Exceptions](https://img.youtube.com/vi/oeFiU11rBlk/0.jpg)](https://www.youtube.com/watch?v=oeFiU11rBlk&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

# Part 1. Exception handling

## 3. Why do we need to handle exceptions?

Until now, when a course did not exist, we could do a check directly within the controller:

```java
Course course = courseService.findById(id);

if (course == null) {
    model.addAttribute("pageTitle", "Curso no encontrado");
    model.addAttribute("courseId", id);

    return "courses/not-found";
}
```

This code works, but it has a problem: the controller starts mixing too many responsibilities.

The controller should mainly be responsible for:

- Receiving requests.
- Requesting data from the service.
- Adding data to the model.
- Returning the name of a view.

But if we start adding error conditions in all the methods, the code becomes long and repetitive.

A neater solution is:

```text
Si el curso no existe, el servicio lanza una excepción.
Después, una clase global se encarga de capturar esa excepción
y decidir qué página de error mostrar.
```

This way we separate responsibilities better.

---

## 4. Create a custom exception

Let's create a specific exception for when a course does not exist.

We create a new package:

```text
src/main/java/com/example/springmvcday1/exception
```

Inside that package we create the file:

```text
CourseNotFoundException.java
```

### `CourseNotFoundException.java` code

```java
package com.example.springmvcday1.exception;

public class CourseNotFoundException extends RuntimeException {

    private final Long courseId;

    public CourseNotFoundException(Long courseId) {
        super("No se ha encontrado ningún curso con id " + courseId);
        this.courseId = courseId;
    }

    public Long getCourseId() {
        return courseId;
    }
}
```

### Step-by-step explanation

The class starts like this:

```java
public class CourseNotFoundException extends RuntimeException {
```

This means that we are creating our own exception and that it inherits from `RuntimeException`.

We use `RuntimeException` because we don't want to be forced to add `throws` to every method that can throw it.

Then we save the course identifier:

```java
private final Long courseId;
```

This will help us show a clearer message to the user.

For example:

```text
No se ha encontrado ningún curso con el identificador 999.
```

The constructor receives the `courseId`:

```java
public CourseNotFoundException(Long courseId) {
    super("No se ha encontrado ningún curso con id " + courseId);
    this.courseId = courseId;
}
```

The line:

```java
super("No se ha encontrado ningún curso con id " + courseId);
```

creates the internal message of the exception.

The line:

```java
this.courseId = courseId;
```

stores the identifier so it can be retrieved later.

Finally, the method:

```java
public Long getCourseId() {
    return courseId;
}
```

allows us to read the identifier from the error handler.

---

## 5. Update `CourseService`

Now let's add a method in the service that looks for a course and throws the exception if it doesn't exist.

File:

```text
src/main/java/com/example/springmvcday1/service/CourseService.java
```

If you are using the version with MySQL, the service may look like this:

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
}
```

If you are using the version without MySQL and still saving the courses in a list, the important method would be this:

```java
public Course findByIdOrThrow(Long id) {
    Course course = findById(id);

    if (course == null) {
        throw new CourseNotFoundException(id);
    }

    return course;
}
```

### Explanation of the new method

The new method is:

```java
public Course findByIdOrThrow(Long id) {
```

Its responsibility is very clear:

```text
Buscar un curso por id.
Si existe, devolverlo.
Si no existe, lanzar una excepción.
```

First we look for the course:

```java
Course course = courseDao.findById(id);
```

Then we check if the result is `null`:

```java
if (course == null) {
    throw new CourseNotFoundException(id);
}
```

If the course does not exist, we throw our custom exception.

If the course exists, we return it:

```java
return course;
```

---

## 6. Update `CourseController`

Now we can simplify the method that displays the details of a course.

File:

```text
src/main/java/com/example/springmvcday1/controller/CourseController.java
```

### Updated code of the `courseDetail` method

```java
@GetMapping("/detail")
public String courseDetail(@RequestParam("id") Long id, Model model) {
    Course course = courseService.findByIdOrThrow(id);

    model.addAttribute("pageTitle", course.getTitle());
    model.addAttribute("course", course);

    return "courses/detail";
}
```

### Explanation

Previously, the controller had to do this check:

```java
if (course == null) {
    ...
}
```

Now it's no longer necessary.

The controller just writes:

```java
Course course = courseService.findByIdOrThrow(id);
```

If the course exists, the code continues normally.

If it does not exist, a `CourseNotFoundException` is thrown.

In that case, the controller stops running. Spring will look for a method that knows how to handle that exception.

We will create that method now.

---

## 7. Create a global exception handler

We create the file:

```text
src/main/java/com/example/springmvcday1/exception/GlobalExceptionHandler.java
```

### `GlobalExceptionHandler.java` code

```java
package com.example.springmvcday1.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(CourseNotFoundException.class)
    public String handleCourseNotFound(
            CourseNotFoundException exception,
            Model model) {

        model.addAttribute("pageTitle", "Curso no encontrado");
        model.addAttribute("courseId", exception.getCourseId());
        model.addAttribute("errorMessage", exception.getMessage());

        return "error/course-not-found";
    }

    @ExceptionHandler(Exception.class)
    public String handleGeneralException(
            Exception exception,
            Model model) {

        model.addAttribute("pageTitle", "Error inesperado");
        model.addAttribute("errorMessage", exception.getMessage());

        return "error/general-error";
    }
}
```

### Step-by-step explanation

The class has this annotation:

```java
@ControllerAdvice
```

This annotation indicates that the class can apply common logic to multiple controllers.

In this case, we will use it to handle exceptions globally.

The first method is:

```java
@ExceptionHandler(CourseNotFoundException.class)
public String handleCourseNotFound(
        CourseNotFoundException exception,
        Model model) {
```

The annotation:

```java
@ExceptionHandler(CourseNotFoundException.class)
```

means:

```text
Cuando se lance una CourseNotFoundException,
ejecuta este método.
```

Inside, we add information to the model:

```java
model.addAttribute("pageTitle", "Curso no encontrado");
model.addAttribute("courseId", exception.getCourseId());
model.addAttribute("errorMessage", exception.getMessage());
```

Then we return the view:

```java
return "error/course-not-found";
```

This will make Spring look for the file:

```text
/WEB-INF/views/error/course-not-found.jsp
```

The second method is more general:

```java
@ExceptionHandler(Exception.class)
public String handleGeneralException(
        Exception exception,
        Model model) {
```

This method will catch unexpected exceptions.

It acts as a safety net so that the user does not see the server's technical error pages.

---

## 8. Create the `course-not-found.jsp` view

We create the folder:

```text
src/main/webapp/WEB-INF/views/error
```

Inside it, we create the file:

```text
course-not-found.jsp
```

### `course-not-found.jsp` code

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

    <c:if test="${currentTheme == 'dark'}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
    </c:if>
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">
            <spring:message code="nav.home" />
        </a>
        <a href="${pageContext.request.contextPath}/courses">
            <spring:message code="nav.courses" />
        </a>
        <a href="${pageContext.request.contextPath}/about">
            <spring:message code="nav.about" />
        </a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            No se ha encontrado ningún curso con el identificador ${courseId}.
        </p>

        <p class="error">
            ${errorMessage}
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/courses">
                Volver al listado de cursos
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explanation

This view receives the data that we have added in `GlobalExceptionHandler`:

```java
model.addAttribute("pageTitle", "Curso no encontrado");
model.addAttribute("courseId", exception.getCourseId());
model.addAttribute("errorMessage", exception.getMessage());
```

That's why we can use this in the JSP:

```jsp
${pageTitle}
${courseId}
${errorMessage}
```

This view will be displayed when the user tries to view a course that does not exist.

For example:

```text
/courses/detail?id=999
```

---

## 9. Create a general error view

We create the file:

```text
src/main/webapp/WEB-INF/views/error/general-error.jsp
```

### `general-error.jsp` code

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

    <c:if test="${currentTheme == 'dark'}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
    </c:if>
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">
            <spring:message code="nav.home" />
        </a>
        <a href="${pageContext.request.contextPath}/courses">
            <spring:message code="nav.courses" />
        </a>
        <a href="${pageContext.request.contextPath}/about">
            <spring:message code="nav.about" />
        </a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            Ha ocurrido un error inesperado en la aplicación.
        </p>

        <p class="error">
            ${errorMessage}
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

This view will be used when an unexpected exception occurs.

The method that returns it is:

```java
@ExceptionHandler(Exception.class)
public String handleGeneralException(
        Exception exception,
        Model model) {
```

In a real application, we would not always show the user the technical message of the exception. We could show a generic message and save the error details in logs.

For this course, we show it to better understand what is happening.

---

[![Error 404](https://img.youtube.com/vi/phVpQszocuI/0.jpg)](https://www.youtube.com/watch?v=phVpQszocuI&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 10. Configure the 404 and 500 pages in `web.xml`

Handling errors with `@ControllerAdvice` works very well for exceptions that occur inside controllers.

But some errors can happen earlier, for example when the user tries to open a URL that does not exist:

```text
http://localhost:8080/spring-mvc-day1/pagina-inventada
```

In that case, we can configure error pages in `web.xml`.

File:

```text
src/main/webapp/WEB-INF/web.xml
```

We add this at the end, before `</web-app>`:

```xml
<error-page>
    <error-code>404</error-code>
    <location>/error/404</location>
</error-page>

<error-page>
    <error-code>500</error-code>
    <location>/error/500</location>
</error-page>
```

The complete file can look like this:

```xml
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="
            https://jakarta.ee/xml/ns/jakartaee
            https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">

    <display-name>Spring MVC Day 1</display-name>

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

## 11. Create `ErrorPageController`

Now we need a controller that handles these routes:

```text
/error/404
/error/500
```

We create the file:

```text
src/main/java/com/example/springmvcday1/controller/ErrorPageController.java
```

### `ErrorPageController.java` code

```java
package com.example.springmvcday1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ErrorPageController {

    @GetMapping("/error/404")
    public String notFound(Model model) {
        model.addAttribute("pageTitle", "Página no encontrada");
        return "error/not-found";
    }

    @GetMapping("/error/500")
    public String serverError(Model model) {
        model.addAttribute("pageTitle", "Error del servidor");
        model.addAttribute("errorMessage", "Ha ocurrido un error interno.");
        return "error/general-error";
    }
}
```

### Explanation

If a 404 error occurs, `web.xml` internally redirects to:

```text
/error/404
```

Then Spring runs this method:

```java
@GetMapping("/error/404")
public String notFound(Model model) {
```

The method adds a title:

```java
model.addAttribute("pageTitle", "Página no encontrada");
```

And returns:

```java
return "error/not-found";
```

Therefore, Spring will look for:

```text
/WEB-INF/views/error/not-found.jsp
```

---

## 12. Create the `not-found.jsp` view

We create the file:

```text
src/main/webapp/WEB-INF/views/error/not-found.jsp
```

### `not-found.jsp` code

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

    <c:if test="${currentTheme == 'dark'}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
    </c:if>
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">
            <spring:message code="nav.home" />
        </a>
        <a href="${pageContext.request.contextPath}/courses">
            <spring:message code="nav.courses" />
        </a>
        <a href="${pageContext.request.contextPath}/about">
            <spring:message code="nav.about" />
        </a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            La página que estás intentando abrir no existe.
        </p>

        <p>
            Comprueba la dirección o vuelve a una sección existente de la aplicación.
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

---

## 13. Exception handling summary

The flow when a course does not exist is:

```text
Usuario entra en /courses/detail?id=999
↓
CourseController llama a courseService.findByIdOrThrow(999)
↓
CourseService no encuentra el curso
↓
Se lanza CourseNotFoundException
↓
GlobalExceptionHandler captura la excepción
↓
Spring muestra error/course-not-found.jsp
```

The flow when a route does not exist is:

```text
Usuario entra en /pagina-inventada
↓
Tomcat detecta error 404
↓
web.xml redirige internamente a /error/404
↓
ErrorPageController atiende la ruta
↓
Spring muestra error/not-found.jsp
```

---

[![Internationalization](https://img.youtube.com/vi/ksmauF8G6XA/0.jpg)](https://www.youtube.com/watch?v=ksmauF8G6XA&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

# Part 2. Internationalization

## 14. What is internationalization?

Internationalizing an application means preparing it so that it can display texts in different languages.

For example, instead of writing this directly in a JSP:

```jsp
<a href="/home">Inicio</a>
```

we write:

```jsp
<spring:message code="nav.home" />
```

Spring then looks for the corresponding text in a messages file.

In Spanish:

```properties
nav.home=Inicio
```

In English:

```properties
nav.home=Home
```

This way the same JSP can display different languages.

---

## 15. Configure internationalization in `app-servlet.xml`

Let's modify the file:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

We will add three elements:

1. `messageSource`
2. `localeResolver`
3. `LocaleChangeInterceptor`

### Updated `app-servlet.xml` code

If you are not using MySQL, you can use this version:

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

    <mvc:annotation-driven />

    <context:component-scan base-package="com.example.springmvcday1" />

    <bean id="messageSource"
          class="org.springframework.context.support.ResourceBundleMessageSource">
        <property name="basename" value="messages" />
        <property name="defaultEncoding" value="UTF-8" />
    </bean>

    <bean id="localeResolver"
          class="org.springframework.web.servlet.i18n.SessionLocaleResolver">
        <property name="defaultLocale" value="es" />
    </bean>

    <mvc:interceptors>
        <bean class="org.springframework.web.servlet.i18n.LocaleChangeInterceptor">
            <property name="paramName" value="lang" />
        </bean>
    </mvc:interceptors>

    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/views/" />
        <property name="suffix" value=".jsp" />
    </bean>

    <mvc:resources mapping="/resources/**" location="/resources/" />

</beans>
```

If you are using MySQL, also keep the `dataSource` and `jdbcTemplate` beans that you configured in the Topic 3 extension.

### Explanation of `messageSource`

```xml
<bean id="messageSource"
      class="org.springframework.context.support.ResourceBundleMessageSource">
    <property name="basename" value="messages" />
    <property name="defaultEncoding" value="UTF-8" />
</bean>
```

This bean tells Spring that the translatable texts will be in files called `messages`.

Spring will look for files like:

```text
messages.properties
messages_es.properties
messages_en.properties
```

The property:

```xml
<property name="defaultEncoding" value="UTF-8" />
```

helps characters such as accented letters, the ñ and special symbols to be read correctly.

### Explanation of `localeResolver`

```xml
<bean id="localeResolver"
      class="org.springframework.web.servlet.i18n.SessionLocaleResolver">
    <property name="defaultLocale" value="es" />
</bean>
```

This bean indicates that the active language will be saved in the user's session.

Additionally, the default language will be Spanish:

```text
es
```

### Explanation of `LocaleChangeInterceptor`

```xml
<mvc:interceptors>
    <bean class="org.springframework.web.servlet.i18n.LocaleChangeInterceptor">
        <property name="paramName" value="lang" />
    </bean>
</mvc:interceptors>
```

This interceptor allows you to change the language using a parameter in the URL.

For example:

```text
/home?lang=es
```

switches to Spanish.

```text
/home?lang=en
```

switches to English.

---

## 16. Create the message files

We create the files inside:

```text
src/main/resources
```

The files will be:

```text
messages.properties
messages_es.properties
messages_en.properties
```

### `messages.properties` code

This file will be used as the default file:

```properties
nav.home=Inicio
nav.courses=Cursos
nav.about=Sobre el curso

language.spanish=Español
language.english=Inglés

theme.light=Tema claro
theme.dark=Tema oscuro

home.title=Bienvenida a Spring MVC
home.message=Ahora estamos usando controladores con anotaciones, formularios, errores e internacionalización.
home.courseName=Curso de Spring MVC - tema 4
home.cta=Ver listado de cursos

about.title=Sobre este curso
about.description=Este curso introduce el desarrollo de aplicaciones web con Spring MVC paso a paso.

courses.list.title=Listado de cursos
courses.list.message=Estos cursos vienen del controlador, que a su vez obtiene los datos desde un servicio.
courses.create=Crear nuevo curso
courses.detail=Ver detalle
courses.backHome=Volver al inicio
courses.backList=Volver al listado
courses.title=Título
courses.level=Nivel
courses.duration=Duración
courses.action=Acción
courses.hours=horas

form.title=Crear nuevo curso
form.message=Rellena los datos para crear un nuevo curso.
form.field.title=Título
form.field.level=Nivel
form.field.duration=Duración en horas
form.level.placeholder=Selecciona un nivel
form.level.initial=Inicial
form.level.intermediate=Intermedio
form.level.advanced=Avanzado
form.submit=Crear curso
form.cancel=Cancelar

success.course.created=El curso se ha creado correctamente.

error.courseNotFound.title=Curso no encontrado
error.courseNotFound.message=No se ha encontrado ningún curso con el identificador {0}.
error.general.title=Error inesperado
error.general.message=Ha ocurrido un error inesperado en la aplicación.
error.notFound.title=Página no encontrada
error.notFound.message=La página que estás intentando abrir no existe.
error.backHome=Volver al inicio

course.title.notBlank=El título es obligatorio.
course.title.size=El título debe tener entre 3 y 80 caracteres.
course.level.notBlank=El nivel es obligatorio.
course.duration.notNull=La duración es obligatoria.
course.duration.min=La duración mínima es de 1 hora.
course.duration.max=La duración máxima es de 200 horas.
```

### `messages_es.properties` code

```properties
nav.home=Inicio
nav.courses=Cursos
nav.about=Sobre el curso

language.spanish=Español
language.english=Inglés

theme.light=Tema claro
theme.dark=Tema oscuro

home.title=Bienvenida a Spring MVC
home.message=Ahora estamos usando controladores con anotaciones, formularios, errores e internacionalización.
home.courseName=Curso de Spring MVC - Tema 4
home.cta=Ver listado de cursos

about.title=Sobre este curso
about.description=Este curso introduce el desarrollo de aplicaciones web con Spring MVC paso a paso.

courses.list.title=Listado de cursos
courses.list.message=Estos cursos vienen del controlador, que a su vez obtiene los datos desde un servicio.
courses.create=Crear nuevo curso
courses.detail=Ver detalle
courses.backHome=Volver al inicio
courses.backList=Volver al listado
courses.title=Título
courses.level=Nivel
courses.duration=Duración
courses.action=Acción
courses.hours=horas

form.title=Crear nuevo curso
form.message=Rellena los datos para crear un nuevo curso.
form.field.title=Título
form.field.level=Nivel
form.field.duration=Duración en horas
form.level.placeholder=Selecciona un nivel
form.level.initial=Inicial
form.level.intermediate=Intermedio
form.level.advanced=Avanzado
form.submit=Crear curso
form.cancel=Cancelar

success.course.created=El curso se ha creado correctamente.

error.courseNotFound.title=Curso no encontrado
error.courseNotFound.message=No se ha encontrado ningún curso con el identificador {0}.
error.general.title=Error inesperado
error.general.message=Ha ocurrido un error inesperado en la aplicación.
error.notFound.title=Página no encontrada
error.notFound.message=La página que estás intentando abrir no existe.
error.backHome=Volver al inicio

course.title.notBlank=El título es obligatorio.
course.title.size=El título debe tener entre 3 y 80 caracteres.
course.level.notBlank=El nivel es obligatorio.
course.duration.notNull=La duración es obligatoria.
course.duration.min=La duración mínima es de 1 hora.
course.duration.max=La duración máxima es de 200 horas.
```

### `messages_en.properties` code

```properties
nav.home=Home
nav.courses=Courses
nav.about=About

language.spanish=Spanish
language.english=English

theme.light=Light theme
theme.dark=Dark theme

home.title=Welcome to Spring MVC
home.message=We are now using annotated controllers, forms, errors, and internationalization.
home.courseName=Spring MVC Course - Day 4
home.cta=View course list

about.title=About this course
about.description=This course introduces web application development with Spring MVC step by step.

courses.list.title=Course list
courses.list.message=These courses come from the controller, which gets the data from a service.
courses.create=Create new course
courses.detail=View detail
courses.backHome=Back to home
courses.backList=Back to list
courses.title=Title
courses.level=Level
courses.duration=Duration
courses.action=Action
courses.hours=hours

form.title=Create new course
form.message=Fill in the data to create a new course.
form.field.title=Title
form.field.level=Level
form.field.duration=Duration in hours
form.level.placeholder=Select a level
form.level.initial=Beginner
form.level.intermediate=Intermediate
form.level.advanced=Advanced
form.submit=Create course
form.cancel=Cancel

success.course.created=The course has been created successfully.

error.courseNotFound.title=Course not found
error.courseNotFound.message=No course was found with id {0}.
error.general.title=Unexpected error
error.general.message=An unexpected error occurred in the application.
error.notFound.title=Page not found
error.notFound.message=The page you are trying to open does not exist.
error.backHome=Back to home

course.title.notBlank=The title is required.
course.title.size=The title must be between 3 and 80 characters.
course.level.notBlank=The level is required.
course.duration.notNull=The duration is required.
course.duration.min=The minimum duration is 1 hour.
course.duration.max=The maximum duration is 200 hours.
```

---

## 17. Use internationalized messages in controllers

Some messages appear in the controller, not in the JSP.

For example, in the previous topic, when a course was created successfully we had:

```java
redirectAttributes.addFlashAttribute(
        "successMessage",
        "El curso se ha creado correctamente."
);
```

That text is fixed in Spanish. To internationalize it, we can use `MessageSource`.

### Updated `CourseController.java` code

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
            return "courses/form";
        }

        courseService.save(course);

        Locale locale = LocaleContextHolder.getLocale();

        String successMessage = messageSource.getMessage(
                "success.course.created",
                null,
                locale
        );

        redirectAttributes.addFlashAttribute("successMessage", successMessage);

        return "redirect:/courses";
    }
}
```

### Explanation

We add this property:

```java
private final MessageSource messageSource;
```

And we receive it in the constructor:

```java
public CourseController(
        CourseService courseService,
        MessageSource messageSource) {
```

Spring will inject the bean we configured in XML:

```xml
<bean id="messageSource"
      class="org.springframework.context.support.ResourceBundleMessageSource">
```

When we save the course, we get the active language:

```java
Locale locale = LocaleContextHolder.getLocale();
```

Then we look for the corresponding message:

```java
String successMessage = messageSource.getMessage(
        "success.course.created",
        null,
        locale
);
```

If the active language is Spanish, it will display:

```text
El curso se ha creado correctamente.
```

If the active language is English, it will display:

```text
The course has been created successfully.
```

---

## 18. Internationalize `home.jsp`

File:

```text
src/main/webapp/WEB-INF/views/home.jsp
```

### Updated `home.jsp` code

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="home.title" /></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

    <c:if test="${currentTheme == 'dark'}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
    </c:if>
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">
            <spring:message code="nav.home" />
        </a>
        <a href="${pageContext.request.contextPath}/courses">
            <spring:message code="nav.courses" />
        </a>
        <a href="${pageContext.request.contextPath}/about">
            <spring:message code="nav.about" />
        </a>
    </nav>

    <div class="toolbar">
        <a href="${pageContext.request.contextPath}/home?lang=es">
            <spring:message code="language.spanish" />
        </a>
        <a href="${pageContext.request.contextPath}/home?lang=en">
            <spring:message code="language.english" />
        </a>
        <a href="${pageContext.request.contextPath}/theme/change?theme=light">
            <spring:message code="theme.light" />
        </a>
        <a href="${pageContext.request.contextPath}/theme/change?theme=dark">
            <spring:message code="theme.dark" />
        </a>
    </div>
</header>

<main class="container">
    <section class="card">
        <h1>
            <spring:message code="home.title" />
        </h1>

        <p class="message">
            <spring:message code="home.message" />
        </p>

        <p>
            <strong>
                <spring:message code="home.courseName" />
            </strong>
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/courses">
                <spring:message code="home.cta" />
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explanation

We enable Spring's tags:

```jsp
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
```

Then we use:

```jsp
<spring:message code="home.title" />
```

Spring will look for that key in the message files.

If the language is Spanish:

```properties
home.title=Bienvenida a Spring MVC
```

If the language is English:

```properties
home.title=Welcome to Spring MVC
```

The links to change the language are:

```jsp
<a href="${pageContext.request.contextPath}/home?lang=es">
```

and:

```jsp
<a href="${pageContext.request.contextPath}/home?lang=en">
```

Thanks to the `LocaleChangeInterceptor`, Spring will detect the `lang` parameter.

---

## 19. Internationalize `list.jsp`

File:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

### Updated `list.jsp` code

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="courses.list.title" /></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

    <c:if test="${currentTheme == 'dark'}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
    </c:if>
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">
            <spring:message code="nav.home" />
        </a>
        <a href="${pageContext.request.contextPath}/courses">
            <spring:message code="nav.courses" />
        </a>
        <a href="${pageContext.request.contextPath}/about">
            <spring:message code="nav.about" />
        </a>
    </nav>

    <div class="toolbar">
        <a href="${pageContext.request.contextPath}/courses?lang=es">
            <spring:message code="language.spanish" />
        </a>
        <a href="${pageContext.request.contextPath}/courses?lang=en">
            <spring:message code="language.english" />
        </a>
        <a href="${pageContext.request.contextPath}/theme/change?theme=light">
            <spring:message code="theme.light" />
        </a>
        <a href="${pageContext.request.contextPath}/theme/change?theme=dark">
            <spring:message code="theme.dark" />
        </a>
    </div>
</header>

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
                    <td>
                        <a href="${pageContext.request.contextPath}/courses/detail?id=${course.id}">
                            <spring:message code="courses.detail" />
                        </a>
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

### Explanation

Hard-coded texts disappear from the JSP.

For example, before we could have:

```jsp
Crear nuevo curso
```

Now we have:

```jsp
<spring:message code="courses.create" />
```

This means that the same view can work in multiple languages.

---

## 20. Internationalize `form.jsp`

File:

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

### Updated `form.jsp` code

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="form.title" /></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

    <c:if test="${currentTheme == 'dark'}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
    </c:if>
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">
            <spring:message code="nav.home" />
        </a>
        <a href="${pageContext.request.contextPath}/courses">
            <spring:message code="nav.courses" />
        </a>
        <a href="${pageContext.request.contextPath}/about">
            <spring:message code="nav.about" />
        </a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>
            <spring:message code="form.title" />
        </h1>

        <p class="message">
            <spring:message code="form.message" />
        </p>

        <form:form
                method="post"
                action="${pageContext.request.contextPath}/courses"
                modelAttribute="course"
                cssClass="form">

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
                    <form:option value="Inicial">
                        <spring:message code="form.level.initial" />
                    </form:option>
                    <form:option value="Intermedio">
                        <spring:message code="form.level.intermediate" />
                    </form:option>
                    <form:option value="Avanzado">
                        <spring:message code="form.level.advanced" />
                    </form:option>
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
                    <spring:message code="form.submit" />
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

### Explanation

The form is still bound to the `course` object:

```jsp
<form:form modelAttribute="course">
```

The fields are still bound to the properties of `Course`:

```jsp
<form:input path="title" />
<form:select path="level">
<form:input path="durationInHours" />
```

The only thing that changes is that the visible texts become internationalized.

---

## 21. Internationalize validation messages

In the previous topic we had validation messages written directly in the `Course` class.

For example:

```java
@NotBlank(message = "El título es obligatorio.")
```

Now we are going to use message keys.

File:

```text
src/main/java/com/example/springmvcday1/model/Course.java
```

### Updated `Course.java` code

```java
package com.example.springmvcday1.model;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

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

### Explanation

Now we write:

```java
@NotBlank(message = "{course.title.notBlank}")
```

instead of:

```java
@NotBlank(message = "El título es obligatorio.")
```

The key:

```text
course.title.notBlank
```

is looked up in the message files.

In Spanish:

```properties
course.title.notBlank=El título es obligatorio.
```

In English:

```properties
course.title.notBlank=The title is required.
```

This way form errors also change language.

---

[![Themes](https://img.youtube.com/vi/MBKMcnjJKME/0.jpg)](https://www.youtube.com/watch?v=MBKMcnjJKME&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

# Part 3. Local themes

## 22. What are local themes?

A local theme allows you to change the visual appearance of the application according to a user preference.

For example:

```text
Tema claro
Tema oscuro
```

In previous versions, Spring MVC had a specific infrastructure for managing themes. However, in Spring Framework 6 that specific support is deprecated, so in this course we will use a simple and modern solution:

```text
1. El usuario pulsa un enlace para elegir tema claro u oscuro.
2. Guardamos el tema elegido en la sesión.
3. La JSP lee el tema desde la sesión.
4. Si el tema es oscuro, carga un CSS adicional.
```

---

## 23. Create `ThemeController`

We create the file:

```text
src/main/java/com/example/springmvcday1/controller/ThemeController.java
```

### `ThemeController.java` code

```java
package com.example.springmvcday1.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/theme")
public class ThemeController {

    @GetMapping("/change")
    public String changeTheme(
            @RequestParam(defaultValue = "light") String theme,
            HttpSession session) {

        if (!theme.equals("dark")) {
            theme = "light";
        }

        session.setAttribute("theme", theme);

        return "redirect:/home";
    }
}
```

### Explanation

The class is annotated with:

```java
@Controller
```

Therefore, Spring detects it as a controller.

The annotation:

```java
@RequestMapping("/theme")
```

indicates that all routes in this controller begin with:

```text
/theme
```

The method:

```java
@GetMapping("/change")
```

handles the route:

```text
/theme/change
```

For example:

```text
/theme/change?theme=dark
```

The parameter is received here:

```java
@RequestParam(defaultValue = "light") String theme
```

If the user does not send any theme, the default value will be:

```text
light
```

Then we check if the value is different from `dark`:

```java
if (!theme.equals("dark")) {
    theme = "light";
}
```

This means:

```text
Solo aceptamos "dark" como valor especial.
Cualquier otro valor se convierte en "light".
```

Then we save the preference in the session:

```java
session.setAttribute("theme", theme);
```

Finally we redirect to the home page:

```java
return "redirect:/home";
```

---

## 24. Create `styles-dark.css`

We create the file:

```text
src/main/webapp/resources/css/styles-dark.css
```

### `styles-dark.css` code

```css
body {
  background-color: #111827;
  color: #e5e7eb;
}

.header {
  background-color: #020617;
}

.card {
  background-color: #1f2937;
  color: #e5e7eb;
}

h1 {
  color: #f9fafb;
}

.message {
  color: #d1d5db;
}

.table th {
  background-color: #111827;
  color: #f9fafb;
}

.table th,
.table td {
  border-bottom: 1px solid #374151;
}

.input {
  background-color: #111827;
  color: #f9fafb;
  border-color: #4b5563;
}

.input:focus {
  border-color: #60a5fa;
}

.secondary-button {
  background-color: #374151;
  color: #f9fafb;
}

.secondary-button:hover {
  background-color: #4b5563;
}

code {
  background-color: #111827;
  color: #f9fafb;
}

.success {
  background-color: #064e3b;
  border-color: #10b981;
  color: #d1fae5;
}

.error {
  color: #fca5a5;
}
```

### Explanation

This file does not replace `styles.css`.

First we load the normal CSS:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
```

Then, if the active theme is dark, we load this second file:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
```

Since `styles-dark.css` is loaded later, it can override the colors defined in `styles.css`.

---

## 25. Update the JSPs to load the dark theme

In the JSPs where we want to allow a dark theme, we add this line at the beginning, after the `taglib` directives:

```jsp
<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />
```

This line means:

```text
Si en sesión no hay ningún tema guardado, usa "light".
Si hay un tema guardado, usa ese valor.
```

Then, inside `<head>`, we add:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

<c:if test="${currentTheme == 'dark'}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
</c:if>
```

This means:

```text
Carga siempre styles.css.
Si el tema actual es dark, carga también styles-dark.css.
```

---

## 26. Update `styles.css` for the toolbar

We add these styles to the end of:

```text
src/main/webapp/resources/css/styles.css
```

```css
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.toolbar {
  display: flex;
  gap: 12px;
  font-size: 14px;
}

.toolbar a {
  color: white;
  text-decoration: none;
}

.toolbar a:hover {
  text-decoration: underline;
}
```

### Explanation

The top bar now has two zones:

```text
Izquierda: navegación principal
Derecha: idioma y tema
```

That's why we make `.header` use `display: flex`.

With:

```css
justify-content: space-between;
```

the navigation stays on the left and the toolbar on the right.

---

## 27. Complete theme change flow

When the user clicks the dark theme link:

```text
/theme/change?theme=dark
```

this happens:

```text
1. Spring ejecuta ThemeController.changeTheme().
2. El parámetro theme vale "dark".
3. El controlador guarda theme=dark en la sesión.
4. El controlador redirige a /home.
5. home.jsp lee sessionScope.theme.
6. Como currentTheme es "dark", carga styles-dark.css.
7. La página se muestra con tema oscuro.
```

When the user clicks the light theme link:

```text
/theme/change?theme=light
```

this happens:

```text
1. Spring ejecuta ThemeController.changeTheme().
2. El valor no es "dark".
3. El controlador guarda theme=light en sesión.
4. La JSP ya no carga styles-dark.css.
5. La página vuelve al estilo claro.
```

---

# Part 4. Final checks

## 28. Check exception handling

Start Tomcat and go to:

```text
http://localhost:8080/spring-mvc-day1/courses/detail?id=999
```

Expected result:

```text
Debe aparecer una página de error indicando que el curso no existe.
```

Then go to:

```text
http://localhost:8080/spring-mvc-day1/pagina-inventada
```

Expected result:

```text
Debe aparecer la página 404 personalizada.
```

---

## 29. Check internationalization

Go to:

```text
http://localhost:8080/spring-mvc-day1/home?lang=es
```

Expected result:

```text
La aplicación debe mostrarse en español.
```

Go to:

```text
http://localhost:8080/spring-mvc-day1/home?lang=en
```

Expected result:

```text
La aplicación debe mostrarse en inglés.
```

Then go to:

```text
http://localhost:8080/spring-mvc-day1/courses
```

Expected result:

```text
El idioma debe mantenerse, porque se ha guardado en sesión.
```

---

## 30. Check themes

Go to:

```text
http://localhost:8080/spring-mvc-day1/theme/change?theme=dark
```

Expected result:

```text
La aplicación debe mostrarse con tema oscuro.
```

Then go to:

```text
http://localhost:8080/spring-mvc-day1/theme/change?theme=light
```

Expected result:

```text
La aplicación debe volver al tema claro.
```

---

# Part 5. Common mistakes

## 31. Error: `GlobalExceptionHandler` does not run

Check that the class has:

```java
@ControllerAdvice
```

Also check that it is inside the package that Spring scans:

```xml
<context:component-scan base-package="com.example.springmvcday1" />
```

If the class is outside that package, Spring will not detect it.

---

## 32. Error: The exception is not caught

Check that the exception type matches.

If you throw:

```java
throw new CourseNotFoundException(id);
```

the handler must have:

```java
@ExceptionHandler(CourseNotFoundException.class)
```

---

## 33. Error: Language texts do not change

Check that you have `messageSource` configured:

```xml
<bean id="messageSource"
      class="org.springframework.context.support.ResourceBundleMessageSource">
    <property name="basename" value="messages" />
    <property name="defaultEncoding" value="UTF-8" />
</bean>
```

Also check that the files are in:

```text
src/main/resources
```

and that they are named exactly:

```text
messages.properties
messages_es.properties
messages_en.properties
```

---

## 34. Error: `?lang=en` does not change the language

Check that the interceptor exists:

```xml
<mvc:interceptors>
    <bean class="org.springframework.web.servlet.i18n.LocaleChangeInterceptor">
        <property name="paramName" value="lang" />
    </bean>
</mvc:interceptors>
```

And check that the `localeResolver` also exists:

```xml
<bean id="localeResolver"
      class="org.springframework.web.servlet.i18n.SessionLocaleResolver">
    <property name="defaultLocale" value="es" />
</bean>
```

---

## 35. Error: The key appears instead of the text

If something like this appears on the screen:

```text
???nav.home???
```

or just the key itself:

```text
nav.home
```

it means that Spring cannot find that key in the `.properties` files.

Check that the key written in the JSP exactly matches the key in the file.

JSP:

```jsp
<spring:message code="nav.courses" />
```

`.properties` file:

```properties
nav.courses=Cursos
```

---

## 36. Error: The dark theme is not applied

Check that the file exists:

```text
src/main/webapp/resources/css/styles-dark.css
```

Also check that the JSP loads the file when the theme is `dark`:

```jsp
<c:if test="${currentTheme == 'dark'}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
</c:if>
```

And check that the controller saves the theme in the session:

```java
session.setAttribute("theme", theme);
```

---

## 37. Error: The language and theme bar looks wrong

Check that you have added the `.toolbar` styles to `styles.css`:

```css
.toolbar {
  display: flex;
  gap: 12px;
  font-size: 14px;
}
```

And that the `header` uses flex:

```css
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
```

---

# Part 6. Final summary

In this topic we have added three cross-cutting features to the application.

## Exception handling

We have created:

```text
CourseNotFoundException
GlobalExceptionHandler
error/course-not-found.jsp
error/general-error.jsp
error/not-found.jsp
```

The main idea is:

```text
El servicio puede lanzar excepciones.
El manejador global decide qué vista de error mostrar.
```

---

## Internationalization

We have created:

```text
messages.properties
messages_es.properties
messages_en.properties
```

And we have configured:

```text
messageSource
localeResolver
LocaleChangeInterceptor
```

The main idea is:

```text
Las JSP no escriben textos fijos.
Las JSP usan claves.
Spring busca el texto en el idioma activo.
```

---

## Local themes

We have created:

```text
ThemeController
styles-dark.css
```

And we have used the session to save the visual preference.

The main idea is:

```text
El usuario elige un tema.
La aplicación guarda el tema en sesión.
La JSP carga el CSS adecuado.
```

---

## Final idea of the topic

Spring MVC is not only used to create routes and views.

It also allows you to better organize a web application by adding:

```text
Control de errores
Mensajes traducibles
Preferencias del usuario
Vistas más cuidadas
Código más mantenible
```

By the end of this topic, the application already has a structure much closer to a real web application.
