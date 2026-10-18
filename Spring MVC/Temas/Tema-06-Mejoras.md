#Topic 6 — Simple improvements for our Spring MVC project

## 1. Objective of the topic

In the previous topics we have built a Spring MVC application with:

```text
Tema 1 → Arquitectura, DispatcherServlet, configuración XML y primera vista.
Tema 2 → Controladores con anotaciones, rutas, servicios y vistas.
Tema 3 → Formularios, validación y procesamiento de datos.
Tema 4 Opcional → Conexión con MySQL y DBeaver.
Tema 5 → Excepciones, internacionalización y temas visuales.
```

In this **Topic 6** we are going to improve the project without adding too complex functionalities.

The goal is to make the code cleaner, easier to maintain, and more comfortable to continue expanding.

We will work on four main improvements:

```text
1. Usar Lombok para reducir getters, setters y constructores.
2. Mover la configuración de MySQL a un archivo database.properties.
3. Crear fragmentos JSP reutilizables para no repetir el menú y el <head>.
4. Crear atributos globales para reutilizar datos comunes en varias vistas.
```

The important idea of this topic is this:

```text
Una aplicación no solo debe funcionar.
También debe ser fácil de leer, modificar y mantener.
```

---

#2. Starting point

We start from the Spring MVC project that we have already been building.

The general structure of the project may look like this:

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
                    ├── home.jsp
                    ├── about.jsp
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

In this topic we are not going to remake the project from scratch. We are going to apply improvements to what we already have.

---

[![Lombok](https://img.youtube.com/vi/koH27nSBigc/0.jpg)](https://www.youtube.com/watch?v=koH27nSBigc&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

#3. Improvement 1 — Use Lombok to reduce boilerplate code

## 3.1. What problem do we want to solve?

Our `Course` class has many boilerplate methods.

For example:

```java
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
```

This code works, but it takes up a lot of space.

When a class has many attributes, it ends up full of:

```text
getters
setters
constructores
toString
equals
hashCode
```

This type of code is known as **boilerplate code** or **boilerplate code**.

To reduce it we are going to use **Lombok**.

Lombok allows you to write annotations such as:

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
```

and automatically generates some of the code that we would normally write by hand.

---

#4. Add Lombok to `pom.xml`

We open the file:

```text
pom.xml
```

And we add this dependency within the `<dependencies>` block:

```xml
<!-- Lombok: reduce código repetitivo en modelos y clases Java -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.46</version>
    <scope>provided</scope>
</dependency>
```

## Explanation

The dependency is:

```xml
<artifactId>lombok</artifactId>
```

This adds Lombok to the project.

The scope is:

```xml
<scope>provided</scope>
```

This means that Lombok is used when compiling, but is not packaged inside the `.war`.

Why?

Because Lombok generates code during compilation. Once the project is compiled, Tomcat does not need to have Lombok to run the application.

---

#5. Activate Lombok in IntelliJ

After adding the dependency, we must verify that IntelliJ allows processing annotations.

In IntelliJ, we will:

```text
File
→ Settings
→ Build, Execution, Deployment
→ Compiler
→ Annotation Processors
```

And we activate:

```text
Enable annotation processing
```

Then we reload Maven.

Normally it can be done from the Maven window with:

```text
Reload All Maven Projects
```

If IntelliJ does not recognize `@Data`, `@NoArgsConstructor` or `@AllArgsConstructor`, check:

```text
1. Que la dependencia esté bien escrita en el pom.xml.
2. Que Maven se haya recargado.
3. Que Annotation Processing esté activado.
4. Que IntelliJ tenga soporte para Lombok.
```

---

#6. Update `Course.java` with Lombok

Previously, our `Course` class could look like this:

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

Now we can leave it like this:

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

---

#7. Lombok Annotations Explained

## 7.1. `@Data`

The annotation:

```java
@Data
```

automatically generates:

```text
getters
setters
toString()
equals()
hashCode()
```

That's why we no longer need to manually write:

```java
public String getTitle() {
    return title;
}

public void setTitle(String title) {
    this.title = title;
}
```

Even if we don't see them in the file, those methods will exist when the project is compiled.

---

## 7.2. `@NoArgsConstructor`

The annotation:

```java
@NoArgsConstructor
```

generates an empty constructor.

It is equivalent to writing:

```java
public Course() {
}
```

This constructor is important in Spring MVC because when we display a form we usually do:

```java
model.addAttribute("course", new Course());
```

Spring needs to be able to create an empty object to fill it with the form data.

---

## 7.3. `@AllArgsConstructor`

The annotation:
```java
@AllArgsConstructor
```

generates a constructor with all the attributes.

It is equivalent to writing:

```java
public Course(Long id, String title, String level, Integer durationInHours) {
    this.id = id;
    this.title = title;
    this.level = level;
    this.durationInHours = durationInHours;
}
```

This allows us to continue creating courses like this:

```java
new Course(1L, "Spring MVC desde cero", "Inicial", 20);
```

---

#8. Checking that Lombok works

After modifying `Course.java`, we check if the rest of the project still works.

For example, in `CourseService` we may have:

```java
new Course(1L, "Spring MVC desde cero", "Inicial", 20);
```

This will continue to work thanks to:

```java
@AllArgsConstructor
```

In a JSP we can continue writing:

```jsp
${course.title}
```

This will still work because Lombok generates:

```java
getTitle()
```

It will also continue to work:

```java
course.setId(generatedId.longValue());
```

because Lombok generates:

```java
setId(Long id)
```

Therefore, from the outside the `Course` class behaves the same as before.

The only thing that changes is that we write less code.

---

# 9. When to use Lombok and when to be careful

Lombok is very useful for simple models.

For example:

```text
Course
Product
Customer
Event
```

But you should be careful with `@Data` in very complex classes.

`@Data` generates `equals`, `hashCode` and `toString`. In many simple models this is fine, but in large applications or with complex relationships it may not be appropriate.

For this course, `@Data` is a good choice because our classes are simple.

---

#10. Improvement 2 — Externalize MySQL configuration

## 10.1. What problem do we want to solve?

In the MySQL extension we configure the connection directly in `app-servlet.xml`.

For example:

```xml
<property name="url"
          value="jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&amp;serverTimezone=Europe/Madrid" />

<property name="username" value="root" />
<property name="password" value="TU_PASSWORD" />
```

This works, but has some drawbacks:

```text
1. La contraseña queda dentro del XML principal.
2. Si cambia la base de datos, hay que tocar app-servlet.xml.
3. La configuración de Spring MVC y la configuración de MySQL quedan mezcladas.
```

A simple improvement is to move those values to an `.properties` file.

---

[![database.properties](https://img.youtube.com/vi/VbtIhjTanAE/0.jpg)](https://www.youtube.com/watch?v=VbtIhjTanAE&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

#11. Create `database.properties`

We create this file:

```text
src/main/resources/database.properties
```

Content:

```properties
db.driverClassName=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&serverTimezone=Europe/Madrid
db.username=root
db.password=TU_PASSWORD
```

## Explanation

Here we save the connection data with MySQL.

The property:

```properties
db.driverClassName=com.mysql.cj.jdbc.Driver
```

indicates the MySQL driver.

The property:

```properties
db.url=jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&serverTimezone=Europe/Madrid
```

indicates the connection URL.

The property:

```properties
db.username=root
```

indicates the user.

The property:

```properties
db.password=TU_PASSWORD
```

indicates the password.

Each student must change:

```text
TU_PASSWORD
```

by the actual password of your MySQL.

---

#12. Difference between `&` in XML and in `.properties`

In `app-servlet.xml` we had to write:

```xml
&amp;
```

For example:

```xml
value="jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&amp;serverTimezone=Europe/Madrid"
```

But in `database.properties` we write:

```properties
db.url=jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&serverTimezone=Europe/Madrid
```

Here we use:

```text
&
```

normal.

The reason is that XML interprets `&` as a special character, but an `.properties` file does not work the same.

---

#13. Modify `app-servlet.xml` to read `database.properties`

We open:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

Inside the file we must already have the namespace `context`, because we have used it to:

```xml
<context:component-scan base-package="com.example.springmvcday1" />
```

Now we add this line:

```xml
<context:property-placeholder location="classpath:database.properties" />
```

It can look like this:

```xml
<!-- Busca automáticamente controladores, servicios, DAOs y otros componentes -->
<context:component-scan base-package="com.example.springmvcday1" />

<!-- Carga propiedades externas desde src/main/resources/database.properties -->
<context:property-placeholder location="classpath:database.properties" />
```

Then we modify the `dataSource`.

Before:

```xml
<bean id="dataSource"
      class="org.springframework.jdbc.datasource.DriverManagerDataSource">

    <property name="driverClassName" value="com.mysql.cj.jdbc.Driver" />

    <property name="url"
              value="jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&amp;serverTimezone=Europe/Madrid" />

    <property name="username" value="root" />
    <property name="password" value="TU_PASSWORD" />
</bean>
```

Now:

```xml
<bean id="dataSource"
      class="org.springframework.jdbc.datasource.DriverManagerDataSource">

    <property name="driverClassName" value="${db.driverClassName}" />
    <property name="url" value="${db.url}" />
    <property name="username" value="${db.username}" />
    <property name="password" value="${db.password}" />
</bean>
```

The `JdbcTemplate` remains the same:

```xml
<bean id="jdbcTemplate"
      class="org.springframework.jdbc.core.JdbcTemplate">

    <property name="dataSource" ref="dataSource" />
</bean>
```

---

#14. `app-servlet.xml` with upgrade applied

The important part of the file would look like this:

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

    <context:property-placeholder location="classpath:database.properties" />

    <bean id="dataSource"
          class="org.springframework.jdbc.datasource.DriverManagerDataSource">

        <property name="driverClassName" value="${db.driverClassName}" />
        <property name="url" value="${db.url}" />
        <property name="username" value="${db.username}" />
        <property name="password" value="${db.password}" />
    </bean>

    <bean id="jdbcTemplate"
          class="org.springframework.jdbc.core.JdbcTemplate">

        <property name="dataSource" ref="dataSource" />
    </bean>

    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/views/" />
        <property name="suffix" value=".jsp" />
    </bean>

    <mvc:resources mapping="/resources/**" location="/resources/" />

</beans>
```

---

#15. Checking External Settings

To check that it works:

1. We start MySQL.
2. We open DBeaver and check that the database exists.
3. We check `database.properties`.
4. We run Tomcat.
5. We enter:

```text
http://localhost:8080/spring-mvc-day1/courses
```

If the courses are displayed from MySQL, the configuration works.

If there is an error, we check:

```text
1. Que database.properties esté en src/main/resources.
2. Que la contraseña sea correcta.
3. Que app-servlet.xml tenga context:property-placeholder.
4. Que MySQL esté iniciado.
5. Que la base de datos exista.
```

---

[![Fragments](https://img.youtube.com/vi/HXiqJSppQnI/0.jpg)](https://www.youtube.com/watch?v=HXiqJSppQnI&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

#16. Improvement 3 — Create reusable JSP fragments

## 16.1. What problem do we want to solve?

In several views we repeat a lot of code.

For example, many JSPs have:

```jsp
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
```

We also repeat the CSS loading:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

<c:if test="${currentTheme == 'dark'}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
</c:if>
```

The problem is that if we want to modify the menu, we have to modify many views.

A simple improvement is to create **reusable JSP fragments**.

---

#17. Create `fragments` folder

We create this folder:

```text
src/main/webapp/WEB-INF/views/fragments
```

Inside we will create these files:

```text
head.jspf
header.jspf
```

The `.jspf` extension is typically used for JSP fragments.

It's not required, but it helps differentiate an entire page from a reusable fragment.

---

#18. Create `head.jspf` fragment

We create the file:

```text
src/main/webapp/WEB-INF/views/fragments/head.jspf
```

Content:

```jsp
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />

<meta charset="UTF-8">

<c:choose>
    <c:when test="${not empty pageTitleCode}">
        <title><spring:message code="${pageTitleCode}" /></title>
    </c:when>
    <c:otherwise>
        <title>${pageTitle}</title>
    </c:otherwise>
</c:choose>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

<c:if test="${currentTheme == 'dark'}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
</c:if>
```

---

#19. `head.jspf` Explanation

First we declare the tag libraries:

```jsp
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

We need `spring` to be able to use:

```jsp
<spring:message>
```

We need `c` to be able to use JSTL tags like:

```jsp
<c:if>
<c:choose>
<c:when>
<c:otherwise>
```

Then we calculate the current theme:

```jsp
<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />
```

This means:

```text
Si no hay tema guardado en sesión, usa light.
Si hay tema guardado en sesión, usa ese valor.
```

Then we generate the `<title>` of the page.

We use:

```jsp
<c:choose>
```

because some pages have an internationalized title and others have a dynamic title.

For example, the course listing can use:

```java
model.addAttribute("pageTitleCode", "courses.list.title");
```

But the detail of a course can use:

```java
model.addAttribute("pageTitle", course.getTitle());
```

That is why we consider both possibilities.

Finally we always load:

```jsp
styles.css
```

and only if the theme is dark do we load:

```jsp
styles-dark.css
```

---

#20. Create `header.jspf` fragment

We create the file:

```text
src/main/webapp/WEB-INF/views/fragments/header.jspf
```

Content:

```jsp
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
```

---

#21. `header.jspf` Explanation

This snippet contains the common menu.

Includes:

```text
1. Enlace a inicio.
2. Enlace a cursos.
3. Enlace a sobre el curso.
4. Cambio de idioma a español.
5. Cambio de idioma a inglés.
6. Cambio a tema claro.
7. Cambio a tema oscuro.
```

The advantage is that, if we later want to add a new link, we only modify this file.

For example, if we want to add contact:

```jsp
<a href="${pageContext.request.contextPath}/contact">
    Contacto
</a>
```

We do it only once.

---

#22. Use fragments in a JSP

Now let's apply the fragments to a view.

Take as an example:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

Before you could have a lot of repeated code.

Now you can start like this:

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
    ...
</main>

</body>
</html>
```

The line:

```jsp
<%@ include file="/WEB-INF/views/fragments/head.jspf" %>
```

inserts the content of `head.jspf`.

The line:

```jsp
<%@ include file="/WEB-INF/views/fragments/header.jspf" %>
```

insert the common menu.

---

#23. Complete `courses/list.jsp` Example Simplified

File:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

Code:

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

---

# 24. What we have gained with the fragments

Before each JSP repeated:

```text
taglibs
meta charset
title
CSS base
CSS oscuro
menú
opciones de idioma
opciones de tema
```

Now all that is centralized in:

```text
head.jspf
header.jspf
```

This makes views shorter and easier to maintain.

---

[![Global Attributes](https://img.youtube.com/vi/FRhcFwESdEw/0.jpg)](https://www.youtube.com/watch?v=FRhcFwESdEw&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

#25. Improvement 4 — Create global attributes for common data

## 25.1. What problem do we want to solve?

In the course form we have a drop-down list of levels.

For example:
```jsp
<form:select path="level" cssClass="input">
    <form:option value="" label="Selecciona un nivel" />
    <form:option value="Inicial" label="Inicial" />
    <form:option value="Intermedio" label="Intermedio" />
    <form:option value="Avanzado" label="Avanzado" />
</form:select>
```

This works, but has a drawback:

```text
Los niveles están escritos directamente en la vista.
```

If tomorrow we want to add a new level, we have to modify the JSP.

A simple improvement is to prepare that data from Java and automatically send it to the model.

---

#26. Create `GlobalModelAttributes`

We create a new package:

```text
src/main/java/com/example/springmvcday1/config
```

Inside we create the file:

```text
GlobalModelAttributes.java
```

Code:

```java
package com.example.springmvcday1.config;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@ControllerAdvice
public class GlobalModelAttributes {

    @ModelAttribute("courseLevels")
    public List<String> courseLevels() {
        return List.of("Inicial", "Intermedio", "Avanzado");
    }

    @ModelAttribute("appName")
    public String appName() {
        return "Spring MVC Courses";
    }
}
```

---

#27. `GlobalModelAttributes` Explanation

The class has:

```java
@ControllerAdvice
```

We already use `@ControllerAdvice` to handle exceptions.

It can also be used to add common data to the model.

This method:

```java
@ModelAttribute("courseLevels")
public List<String> courseLevels() {
    return List.of("Inicial", "Intermedio", "Avanzado");
}
```

automatically adds an attribute called:

```text
courseLevels
```

to the views.

Therefore, a JSP can use:

```jsp
${courseLevels}
```

without each driver having to add it manually.

We also add:

```java
@ModelAttribute("appName")
public String appName() {
    return "Spring MVC Courses";
}
```

This allows the application name to be available in the views.

---

#28. Use `courseLevels` in `form.jsp`

Now we modify the levels dropdown.

File:

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

Before:

```jsp
<form:select path="level" cssClass="input">
    <form:option value="" label="Selecciona un nivel" />
    <form:option value="Inicial" label="Inicial" />
    <form:option value="Intermedio" label="Intermedio" />
    <form:option value="Avanzado" label="Avanzado" />
</form:select>
```

Now:

```jsp
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
```

---

#29. `form.jsp` View with Shards and Global Levels

The complete file can look like this:

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

---

#30. Explanation of the new dropdown

The important block is this:

```jsp
<c:forEach var="level" items="${courseLevels}">
    <form:option value="${level}">
        ${level}
    </form:option>
</c:forEach>
```

Here we go through the list:

```jsp
${courseLevels}
```

That list comes from:

```java
@ModelAttribute("courseLevels")
public List<String> courseLevels() {
    return List.of("Inicial", "Intermedio", "Avanzado");
}
```

For each level, a drop-down option is generated.

If the list contains:

```text
Inicial
Intermedio
Avanzado
```

The JSP generates options equivalent to:

```html
<option value="Inicial">Inicial</option>
<option value="Intermedio">Intermedio</option>
<option value="Avanzado">Avanzado</option>
```

---

#31. Add a new level

If now we want to add a new level called:

```text
Experto
```

We no longer modify the JSP.

We only change Java:

```java
@ModelAttribute("courseLevels")
public List<String> courseLevels() {
    return List.of("Inicial", "Intermedio", "Avanzado", "Experto");
}
```

The view will update automatically.

---

#32. Use `appName` in the menu

How we created this global attribute:

```java
@ModelAttribute("appName")
public String appName() {
    return "Spring MVC Courses";
}
```

we can use it in `header.jspf`.

For example:

```jsp
<header class="header">
    <div class="brand">
        ${appName}
    </div>

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
```

Now the application name can be changed from Java, not from each JSP.

---

#33. Add style for `.brand`

If we use `.brand`, we add this CSS in:

```text
src/main/webapp/resources/css/styles.css
```

```css
.brand {
  color: white;
  font-weight: bold;
  margin-right: 24px;
}
```

If `header` uses `display: flex`, the application name will appear next to the menu.

---

#34. Summary of created or modified files

In this topic we have touched on these files:

```text
pom.xml
```

We add Lombok.

```text
src/main/java/com/example/springmvcday1/model/Course.java
```

We simplify the model with Lombok.

```text
src/main/resources/database.properties
```

We create an external file for the connection data with MySQL.

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

We load `database.properties` and use `${db...}`.

```text
src/main/webapp/WEB-INF/views/fragments/head.jspf
```

We create a common shard for the `<head>`.

```text
src/main/webapp/WEB-INF/views/fragments/header.jspf
```

We create a common fragment for the menu.

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

We use fragments to simplify the view.

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

We use fragments and the global tier list.

```text
src/main/java/com/example/springmvcday1/config/GlobalModelAttributes.java
```

We create global attributes available in multiple views.

```text
src/main/webapp/resources/css/styles.css
```

We added styles for `.brand`, if we use the application name in the menu.

---

#35. Common mistakes from Topic 6

## Error 1 — Lombok does not generate getters and setters

If IntelliJ flags errors in a class with `@Data`, check:

```text
1. La dependencia de Lombok está en pom.xml.
2. Maven se ha recargado.
3. Annotation Processing está activado.
4. Los imports de Lombok son correctos.
```

The imports must be:

```java
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
```

---
## Error 2 — Empty constructor missing

If we use forms, we need empty constructor.

With Lombok we achieve it with:

```java
@NoArgsConstructor
```

If we remove it, Spring may have problems creating the form object.

---

## Error 3 — `database.properties` is in the wrong folder

The file must be in:

```text
src/main/resources/database.properties
```

It should not be in:

```text
src/main/java
```

nor in:

```text
src/main/webapp
```

because we are loading it with:

```xml
classpath:database.properties
```

---

## Error 4 — Using `&amp;` inside `database.properties`

In `database.properties` you must write:

```properties
db.url=jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&serverTimezone=Europe/Madrid
```

Not:

```properties
db.url=jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&amp;serverTimezone=Europe/Madrid
```

`&amp;` was only needed within the XML.

---

## Error 5 — Forget `context:property-placeholder`

If we use:

```xml
<property name="url" value="${db.url}" />
```

but we do not add:

```xml
<context:property-placeholder location="classpath:database.properties" />
```

Spring will not know how to replace `${db.url}`.

---

## Error 6 — Include a JSP fragment incorrectly

The path must match the actual location of the file.

Correct:

```jsp
<%@ include file="/WEB-INF/views/fragments/head.jspf" %>
```

Incorrect if the folder does not exist or is misspelled:

```jsp
<%@ include file="/WEB-INF/fragments/head.jspf" %>
```

---

## Error 7 — Using `<spring:message>` without importing the taglib

If a JSP uses:

```jsp
<spring:message code="nav.home" />
```

This line must exist in the JSP or in an included fragment:

```jsp
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
```

In our case, `head.jspf` already includes it, but you have to make sure it is being included correctly.

---

## Error 8 — Using `<c:forEach>` without JSTL

If we use:

```jsp
<c:forEach var="level" items="${courseLevels}">
```

must exist:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

Additionally, the project must have the JSTL dependencies on the `pom.xml`.

---

## Error 9 — Global attribute does not appear in the view

If `${courseLevels}` does not appear, check:

```text
1. Que GlobalModelAttributes tenga @ControllerAdvice.
2. Que el paquete esté dentro del component-scan.
3. Que el método tenga @ModelAttribute("courseLevels").
4. Que el nombre usado en la JSP coincida exactamente.
```

For example:

```java
@ModelAttribute("courseLevels")
```

must match:

```jsp
${courseLevels}
```

---

# 36. Final result of Topic 6

After applying these improvements, the project continues to function the same from the user's point of view.

The user can follow:

```text
Ver cursos
Crear cursos
Cambiar idioma
Cambiar tema
Ver errores personalizados
```

But inside the project is cleaner.

## Before

```text
Course.java tenía muchos getters y setters.
Los datos de MySQL estaban dentro del XML.
Cada JSP repetía el menú y el head.
Los niveles del formulario estaban escritos directamente en la vista.
```

## After

```text
Course.java usa Lombok.
La conexión con MySQL está en database.properties.
Las JSP reutilizan head.jspf y header.jspf.
Los niveles del formulario vienen de un atributo global.
```

---

#37. Closing the topic

This topic introduces an important idea for any project:

```text
La calidad de una aplicación no depende solo de que funcione.
También depende de que el código sea claro, ordenado y fácil de cambiar.
```

The improvements applied are small, but have a lot of value:

```text
Lombok reduce código repetitivo.
database.properties separa configuración de lógica.
Los fragmentos JSP evitan duplicación.
Los atributos globales centralizan datos compartidos.
```

With this, the Spring MVC project is better prepared to grow without becoming messy.
