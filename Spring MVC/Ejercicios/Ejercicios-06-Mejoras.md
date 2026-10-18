# Solved exercises — Topic 6: Spring MVC project improvements

## Introduction

In these exercises you'll practice small improvements to an existing Spring MVC project.

The goal is not to add large features, but to learn how to make the project cleaner, more maintainable and easier to extend.

We'll work on improvements similar to the ones in the topic, but with different examples so that you can practice without copying the theory code exactly.

You'll practice:

- Adding Lombok to the project.
- Using `@Data`, `@NoArgsConstructor` and `@AllArgsConstructor`.
- Reducing getters, setters and constructors in models.
- Externalizing the MySQL configuration to a `.properties` file.
- Loading external properties from `app-servlet.xml`.
- Creating reusable JSP fragments.
- Reusing a common `<head>`.
- Reusing a common menu.
- Creating global attributes with `@ControllerAdvice` and `@ModelAttribute`.
- Using global lists in forms.
- Diagnosing common errors.

The solutions are hidden under the **show solution** button.

---

# Exercise 1 — Add Lombok to the project

## Statement

We want to use Lombok in a Spring MVC project to reduce repetitive code in models.

Add to `pom.xml` the dependency you need to use Lombok.

To make it easy to update the version later, also create a property called:

```xml
<lombok.version>
```

The goal is to be able to use annotations like:

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
```

---

<details>
<summary>Show solution</summary>

## Property in the `pom.xml`

Inside `<properties>` we add:

```xml
<lombok.version>1.18.46</lombok.version>
```

The properties block could look like this:

```xml
<properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <spring.version>6.2.12</spring.version>
    <lombok.version>1.18.46</lombok.version>
</properties>
```

## Lombok dependency

Inside `<dependencies>` we add:

```xml
<!-- Lombok: reduce código repetitivo en modelos y clases Java -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>${lombok.version}</version>
    <scope>provided</scope>
</dependency>
```

### Explanation

The dependency:

```xml
<artifactId>lombok</artifactId>
```

lets you use Lombok annotations.

The `scope`:

```xml
<scope>provided</scope>
```

indicates that Lombok is used during compilation, but isn't packaged inside the `.war` file.

This makes sense because Lombok generates code at compile time. When the application runs on Tomcat, that code has already been generated.

</details>

---

# Exercise 2 — Enable Lombok in IntelliJ

## Statement

After adding Lombok to the `pom.xml`, IntelliJ still flags errors on annotations like:

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
```

Explain which settings you need to check in IntelliJ.

---

<details>
<summary>Show solution</summary>

You need to check that annotation processing is enabled in IntelliJ.

Usual path:

```text
File
→ Settings
→ Build, Execution, Deployment
→ Compiler
→ Annotation Processors
```

Then we enable:

```text
Enable annotation processing
```

It's also a good idea to:

```text
1. Recargar Maven.
2. Comprobar que la dependencia de Lombok está bien escrita.
3. Comprobar que los imports de Lombok son correctos.
```

The imports should be, for example:

```java
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
```

### Explanation

Lombok generates code at compile time.

If IntelliJ doesn't process annotations, it may look as if the getters, setters or constructors don't exist, even though the code is fine.

</details>

---

# Exercise 3 — Refactor a model using Lombok

## Statement

We have this `Book` class:

```java
package com.example.library.model;

public class Book {

    private Long id;
    private String title;
    private String author;
    private Integer pages;

    public Book() {
    }

    public Book(Long id, String title, String author, Integer pages) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.pages = pages;
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

    public Integer getPages() {
        return pages;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setPages(Integer pages) {
        this.pages = pages;
    }
}
```

Refactor the class using Lombok.

It must still have:

1. Getters.
2. Setters.
3. An empty constructor.
4. A constructor with all the attributes.

---

<details>
<summary>Show solution</summary>

```java
package com.example.library.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Book {

    private Long id;
    private String title;
    private String author;
    private Integer pages;
}
```

### Explanation

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

The annotation:

```java
@NoArgsConstructor
```

generates the empty constructor.

The annotation:

```java
@AllArgsConstructor
```

generates the constructor with all the attributes.

Although we no longer see the manually written methods, the rest of the application can still use:

```java
book.getTitle()
book.setTitle("Nuevo título")
```

</details>

---

# Exercise 4 — Refactor a model with validation using Lombok

## Statement

We have a `Student` class that is used in a form.

We want to use Lombok, but without losing the validations.

Create the `Student` class in the package:

```text
com.example.academy.model
```

It must have these fields:

| Field | Type | Validation |
| ---------- | --------- | ------------------------------------- |
| `id` | `Long` | No validation |
| `fullName` | `String` | Required and between 3 and 80 characters |
| `email` | `String` | Required |
| `age` | `Integer` | Required and minimum 16 |

Use Lombok to generate getters, setters and constructors.

---

<details>
<summary>Show solution</summary>

```java
package com.example.academy.model;

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
public class Student {

    private Long id;

    @NotBlank(message = "El nombre completo es obligatorio.")
    @Size(min = 3, max = 80, message = "El nombre debe tener entre 3 y 80 caracteres.")
    private String fullName;

    @NotBlank(message = "El email es obligatorio.")
    private String email;

    @NotNull(message = "La edad es obligatoria.")
    @Min(value = 16, message = "La edad mínima es 16.")
    private Integer age;
}
```

### Explanation

Lombok does not remove validations.

We can easily combine:

```java
@Data
```

with:

```java
@NotBlank
@Size
@NotNull
@Min
```

The validation annotations still work the same.

Spring MVC will keep validating the object when we use this in the controller:

```java
@Valid @ModelAttribute("student") Student student
```

</details>

---

# Exercise 5 — Identify what each Lombok annotation generates

## Statement

Match each annotation with what it generates.

| Annotation | What it generates |
| --------------------- | ---------- |
| `@Data` | ?          |
| `@NoArgsConstructor` | ?          |
| `@AllArgsConstructor` | ?          |

Then explain why `@NoArgsConstructor` is especially important when we use forms in Spring MVC.

---

<details>
<summary>Show solution</summary>

| Annotation | What it generates |
| --------------------- | --------------------------------------------------------- |
| `@Data` | Getters, setters, `toString()`, `equals()` and `hashCode()` |
| `@NoArgsConstructor` | Empty constructor |
| `@AllArgsConstructor` | Constructor with all attributes |

`@NoArgsConstructor` is important because Spring MVC often needs to create an empty object before filling it with data submitted by a form.

For example:

```java
model.addAttribute("student", new Student());
```

Or when receiving data from a form:

```java
@ModelAttribute("student") Student student
```

Spring needs to be able to create the object and then assign values to it.

</details>

---

# Exercise 6 — Create a `database.properties` file

## Statement

In a Spring MVC project we have the MySQL configuration written directly in `app-servlet.xml`.

We want to move that data to an external file.

Create the file:

```text
src/main/resources/database.properties
```

for a database called:

```text
spring_mvc_library
```

The details are:

```text
Driver: com.mysql.cj.jdbc.Driver
URL: jdbc:mysql://localhost:3306/spring_mvc_library?useSSL=false&serverTimezone=Europe/Madrid
Usuario: root
Contraseña: TU_PASSWORD
```

---

<details>
<summary>Show solution</summary>

```properties
db.driverClassName=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/spring_mvc_library?useSSL=false&serverTimezone=Europe/Madrid
db.username=root
db.password=TU_PASSWORD
```

### Explanation

The file should be placed in:

```text
src/main/resources/database.properties
```

because later we'll load it from XML using:

```xml
classpath:database.properties
```

In this file we write:

```text
&
```

as is.

We don't write:

```text
&amp;
```

because that's only needed in XML.

</details>

---

# Exercise 7 — Load `database.properties` from `app-servlet.xml`

## Statement

Modify `app-servlet.xml` to load the file:

```text
database.properties
```

from the classpath.

Write only the necessary line.

---

<details>
<summary>Show solution</summary>

```xml
<context:property-placeholder location="classpath:database.properties" />
```

### Explanation

This line tells Spring:

```text
Busca un archivo llamado database.properties dentro del classpath.
```

Since the file is in:

```text
src/main/resources
```

Maven will copy it to the classpath when you build the project.

Thanks to this line we can use expressions like:

```xml
${db.url}
${db.username}
${db.password}
```

</details>

---

# Exercise 8 — Replace hard-coded values with properties

## Statement

You have this `dataSource` in `app-servlet.xml`:

```xml
<bean id="dataSource"
      class="org.springframework.jdbc.datasource.DriverManagerDataSource">

    <property name="driverClassName" value="com.mysql.cj.jdbc.Driver" />

    <property name="url"
              value="jdbc:mysql://localhost:3306/spring_mvc_library?useSSL=false&amp;serverTimezone=Europe/Madrid" />

    <property name="username" value="root" />
    <property name="password" value="TU_PASSWORD" />
</bean>
```

Modify it so that it reads the values from `database.properties`.

---

<details>
<summary>Show solution</summary>

```xml
<bean id="dataSource"
      class="org.springframework.jdbc.datasource.DriverManagerDataSource">

    <property name="driverClassName" value="${db.driverClassName}" />
    <property name="url" value="${db.url}" />
    <property name="username" value="${db.username}" />
    <property name="password" value="${db.password}" />
</bean>
```

### Explanation

Before, the values were written directly in the XML.

Now they're read from:

```properties
db.driverClassName
db.url
db.username
db.password
```

For example:

```xml
<property name="url" value="${db.url}" />
```

Spring will look in `database.properties` for a line like:

```properties
db.url=jdbc:mysql://localhost:3306/spring_mvc_library?useSSL=false&serverTimezone=Europe/Madrid
```

</details>

---

# Exercise 9 — Create a complete MySQL configuration with external properties

## Statement

Write the complete XML configuration block to:

1. Load `database.properties`.
2. Configure `dataSource`.
3. Configure `jdbcTemplate`.

Use the properties:

```text
db.driverClassName
db.url
db.username
db.password
```

---

<details>
<summary>Show solution</summary>

```xml
<!-- Carga propiedades externas desde src/main/resources/database.properties -->
<context:property-placeholder location="classpath:database.properties" />

<!-- Conexión a MySQL -->
<bean id="dataSource"
      class="org.springframework.jdbc.datasource.DriverManagerDataSource">

    <property name="driverClassName" value="${db.driverClassName}" />
    <property name="url" value="${db.url}" />
    <property name="username" value="${db.username}" />
    <property name="password" value="${db.password}" />
</bean>

<!-- Objeto de Spring para ejecutar SQL -->
<bean id="jdbcTemplate"
      class="org.springframework.jdbc.core.JdbcTemplate">

    <property name="dataSource" ref="dataSource" />
</bean>
```

### Explanation

The line:

```xml
<context:property-placeholder location="classpath:database.properties" />
```

must appear before you use:

```xml
${db.url}
```

The `JdbcTemplate` uses the `dataSource`:

```xml
<property name="dataSource" ref="dataSource" />
```

The relationship looks like this:

```text
JdbcTemplate
      ↓
DataSource
      ↓
MySQL
```

</details>

---

# Exercise 10 — Diagnose an error with `database.properties`

## Statement

The app has this line in `app-servlet.xml`:

```xml
<context:property-placeholder location="classpath:database.properties" />
```

But when it starts, an error appears saying that the file can't be found.

The file is in:

```text
src/main/webapp/database.properties
```

What is wrong and how would you fix it?

---

<details>
<summary>Show solution</summary>

The problem is the location of the file.

If we use:

```xml
classpath:database.properties
```

the file must be in:

```text
src/main/resources/database.properties
```

Not in:

```text
src/main/webapp/database.properties
```

The solution is to move the file to:

```text
src/main/resources/database.properties
```

### Explanation

`src/main/resources` is automatically copied to the classpath.

`src/main/webapp` belongs to the web part of the application, but it is not the right place to load properties with `classpath:`.

</details>

---

# Exercise 11 — Create a JSP fragments folder

## Statement

We want to avoid repeating the same menu and the same `<head>` in every JSP view.

Say which folder you would create and which two files you would put in it.

---

<details>
<summary>Show solution</summary>

We create this folder:

```text
src/main/webapp/WEB-INF/views/fragments
```

Inside we create:

```text
head.jspf
header.jspf
```

### Explanation

`head.jspf` will contain the common `<head>` code:
```text
meta charset
title
CSS base
CSS del tema oscuro
taglibs necesarias
```

`header.jspf` will contain the common menu:

```text
Inicio
Libros / Cursos / Productos
Cambio de idioma
Cambio de tema
```

The `.jspf` extension is typically used for JSP fragments.

</details>

---

# Exercise 12 — Create a `head.jspf` fragment

## Statement

Create a fragment called:

```text
head.jspf
```

It must:

1. Import the Spring and JSTL taglibs.
2. Work out the current theme from `sessionScope.theme`.
3. Use `light` as the default theme.
4. Always load `styles.css`.
5. Load `styles-dark.css` only if the theme is `dark`.
6. Display the title using `pageTitleCode` if it exists, or `pageTitle` if it doesn't.

---

<details>
<summary>Show solution</summary>

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

### Explanation

This fragment saves us from repeating the same `<head>` in many JSPs.

The part:

```jsp
<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />
```

means:

```text
Si no hay tema en sesión, usa light.
Si hay tema en sesión, usa ese valor.
```

The part:

```jsp
<c:choose>
```

lets some pages use an internationalized title and others a dynamic title.

For example:

```java
model.addAttribute("pageTitleCode", "books.list.title");
```

or:

```java
model.addAttribute("pageTitle", book.getTitle());
```

</details>

---

# Exercise 13 — Create a `header.jspf` fragment

## Statement

Create a fragment called:

```text
header.jspf
```

for a library application.

It must include links to:

```text
/home
/books
/authors
```

It must also include links to:

```text
/home?lang=es
/home?lang=en
/theme/change?theme=light
/theme/change?theme=dark
```

Use `<spring:message>` for the texts.

---

<details>
<summary>Show solution</summary>

```jsp
<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">
            <spring:message code="nav.home" />
        </a>

        <a href="${pageContext.request.contextPath}/books">
            <spring:message code="nav.books" />
        </a>

        <a href="${pageContext.request.contextPath}/authors">
            <spring:message code="nav.authors" />
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

### Explanation

This fragment centralizes the menu.

If we want to add a new section to the menu, we no longer have to modify all the JSPs.

We only modify:

```text
header.jspf
```

The texts come from the message files thanks to:

```jsp
<spring:message code="nav.books" />
```

</details>

---

# Exercise 14 — Use fragments in a JSP

## Statement

You have a view called:

```text
books/list.jsp
```

Modify its structure so that it uses:

```text
head.jspf
header.jspf
```

You should end up with a JSP with this structure:

```text
directivas iniciales
html
head con include
body
header con include
main
```

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

        <table class="table">
            <thead>
            <tr>
                <th><spring:message code="books.title" /></th>
                <th><spring:message code="books.author" /></th>
                <th><spring:message code="books.pages" /></th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.title}</td>
                    <td>${book.author}</td>
                    <td>${book.pages}</td>
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

The line:

```jsp
<%@ include file="/WEB-INF/views/fragments/head.jspf" %>
```

inserts the common `<head>`.

The line:

```jsp
<%@ include file="/WEB-INF/views/fragments/header.jspf" %>
```

inserts the common menu.

The view is cleaner because it no longer repeats the same code on every page.

</details>

---

# Exercise 15 — Create global attributes for a form

## Statement

In a library application, we want several forms to have a list of literary genres available.

Create a class called:

```text
GlobalModelAttributes
```

in the package:

```text
com.example.library.config
```

It must add an attribute to the model called:

```text
bookGenres
```

with this list:

```text
Novela
Ensayo
Poesía
Teatro
Ciencia ficción
```

The class must use `@ControllerAdvice` and `@ModelAttribute`.

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

    @ModelAttribute("bookGenres")
    public List<String> bookGenres() {
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

lets you apply common logic to several controllers.

The method:

```java
@ModelAttribute("bookGenres")
```

automatically adds an attribute to the model called:

```text
bookGenres
```

JSPs can use it like this:

```jsp
${bookGenres}
```

without each controller having to add it manually.

</details>

---

# Exercise 16 — Use a global attribute in a dropdown

## Statement

You have this book form:

```jsp
<form:select path="genre" cssClass="input">
    <form:option value="" label="Selecciona un género" />
    <form:option value="Novela" label="Novela" />
    <form:option value="Ensayo" label="Ensayo" />
    <form:option value="Poesía" label="Poesía" />
</form:select>
```

Modify it so that the options come from:

```jsp
${bookGenres}
```

---

<details>
<summary>Show solution</summary>

```jsp
<form:select path="genre" cssClass="input">
    <form:option value="">
        Selecciona un género
    </form:option>

    <c:forEach var="genre" items="${bookGenres}">
        <form:option value="${genre}">
            ${genre}
        </form:option>
    </c:forEach>
</form:select>

<form:errors path="genre" cssClass="error" />
```

### Explanation

The loop:

```jsp
<c:forEach var="genre" items="${bookGenres}">
```

loops through the global list created in Java:

```java
@ModelAttribute("bookGenres")
public List<String> bookGenres() {
    return List.of("Novela", "Ensayo", "Poesía", "Teatro", "Ciencia ficción");
}
```

For each genre, a dropdown option is created.

If tomorrow we want to add a new genre, we change it in Java, not in the JSP.

</details>

---

# Exercise 17 — Add the application name as a global attribute

## Statement

Modify `GlobalModelAttributes` to add a global attribute called:

```text
appName
```

with the value:

```text
Library Manager
```

Then display that value in `header.jspf`.

---

<details>
<summary>Show solution</summary>

## `GlobalModelAttributes` class

```java
package com.example.library.config;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@ControllerAdvice
public class GlobalModelAttributes {

    @ModelAttribute("bookGenres")
    public List<String> bookGenres() {
        return List.of(
                "Novela",
                "Ensayo",
                "Poesía",
                "Teatro",
                "Ciencia ficción"
        );
    }

    @ModelAttribute("appName")
    public String appName() {
        return "Library Manager";
    }
}
```

## Using it in `header.jspf`

```jsp
<header class="header">
    <div class="brand">
        ${appName}
    </div>

    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">
            <spring:message code="nav.home" />
        </a>

        <a href="${pageContext.request.contextPath}/books">
            <spring:message code="nav.books" />
        </a>

        <a href="${pageContext.request.contextPath}/authors">
            <spring:message code="nav.authors" />
        </a>
    </nav>
</header>
```

### Explanation

`appName` is available in all views because it is added from a class with:

```java
@ControllerAdvice
```

This avoids repeating the application name directly in each JSP.

</details>

---

# Exercise 18 — Add a style for the app's branding

## Statement

Add a CSS style for the class:

```css
.brand
```

It must be shown in white, in bold and with some space between it and the menu.

---

<details>
<summary>Show solution</summary>

We add this to:

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

If the `header` uses flexbox, it may look better with:

```css
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
```

### Explanation

The class:

```css
.brand
```

is applied to the application name:

```jsp
<div class="brand">
    ${appName}
</div>
```

This way, the application gets a small visual identity in the menu.

</details>

---

# Exercise 19 — Diagnose errors with Lombok

## Statement

Read the following cases and explain what happens.

## Case A

The class has:

```java
@Data
@AllArgsConstructor
public class Book {
    private Long id;
    private String title;
}
```

But when the form is shown, Spring fails to create an empty object.

What's missing?

---

## Case B

The project compiles in Maven, but IntelliJ flags an error on `getTitle()` saying that it does not exist.

What could be happening?

---

## Case C

Lombok has been added to `pom.xml`, but Maven has not been reloaded.

What problem may appear?

---

<details>
<summary>Show solution</summary>

## Case A

What's missing is:

```java
@NoArgsConstructor
```

The class has a constructor with all the fields, but it does not have an empty constructor.

For forms in Spring MVC we normally need:

```java
@NoArgsConstructor
```

The class should look like this:

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Book {
    private Long id;
    private String title;
}
```

---

## Case B

IntelliJ may not be processing Lombok annotations.

You have to check:

```text
File
→ Settings
→ Build, Execution, Deployment
→ Compiler
→ Annotation Processors
→ Enable annotation processing
```

It is also worth checking that the Lombok imports are correct.

---

## Case C

If Maven is not reloaded, IntelliJ may not download Lombok.

In that case, the annotations:

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
```

will appear in red or won't work correctly.

The solution is to reload the Maven project.

</details>

---

# Exercise 20 — Diagnose errors with JSP fragments

## Statement

Read the following cases and explain what happens.

## Case A

The view contains:

```jsp
<%@ include file="/WEB-INF/views/fragments/head.jspf" %>
```

but the file is actually in:

```text
/WEB-INF/views/common/head.jspf
```

What will happen?

---

## Case B

The `header.jspf` file uses:

```jsp
<spring:message code="nav.home" />
```

but no JSP includes the Spring taglib, and `head.jspf` isn't included either.

What will happen?

---

## Case C

The JSP uses:

```jsp
<c:forEach var="genre" items="${bookGenres}">
```

but JSTL hasn't been declared.

What's missing?

---

<details>
<summary>Show solution</summary>

## Case A

The fragment path is wrong.

The JSP attempts to include:

```text
/WEB-INF/views/fragments/head.jspf
```

but the file is in:

```text
/WEB-INF/views/common/head.jspf
```

The solution is to fix the path:

```jsp
<%@ include file="/WEB-INF/views/common/head.jspf" %>
```

or move the file to the expected folder.

---

## Case B

The tag:

```jsp
<spring:message>
```

will not work if the Spring taglib is not declared.

There must be:

```jsp
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
```

It can be in the JSP directly or in a fragment included before it.

---

## Case C

The JSTL declaration is missing:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

Additionally, the project must have the JSTL dependencies in the `pom.xml`.

</details>

---

# Exercise 21 — Diagnose errors with global attributes

## Statement

Read the following cases and explain what happens.

## Case A

The `GlobalModelAttributes` class does not have `@ControllerAdvice`.

What problem may appear?

---

## Case B

The method has:

```java
@ModelAttribute("genres")
public List<String> bookGenres() {
    return List.of("Novela", "Ensayo");
}
```

but the JSP uses:

```jsp
${bookGenres}
```

Why doesn't the list appear?

---

## Case C

The `GlobalModelAttributes` class is in:

```text
com.other.config
```

but the `component-scan` only scans:

```text
com.example.library
```

What's happening?

---

<details>
<summary>Show solution</summary>

## Case A

If this is missing:

```java
@ControllerAdvice
```

Spring will not treat that class as a global class for controllers.

The methods with:

```java
@ModelAttribute
```

won't be applied globally.

---

## Case B

The attribute name does not match.

Java creates an attribute called:

```text
genres
```

but the JSP looks for:

```text
bookGenres
```

The solution is to use the same name.

Either we change the Java code:

```java
@ModelAttribute("bookGenres")
```

or we change the JSP:

```jsp
${genres}
```

---

## Case C

Spring will not find the class because it is outside the scanned package.

The `component-scan` must include the package where the class is.

For example:

```xml
<context:component-scan base-package="com.example.library" />
```

it only scans classes within:

```text
com.example.library
```

If the class is in:

```text
com.other.config
```

it won't be detected.

</details>

---

# Exercise 22 — Final challenge: improve a movie section

## Statement

You have a Spring MVC movie application.

You want to apply several improvements from Topic 6.

Create or modify what is necessary to achieve the following:

1. Add Lombok to `Movie`.
2. Create `database.properties` for a `spring_mvc_movies` database.
3. Configure `dataSource` and `jdbcTemplate` using external properties.
4. Create the `head.jspf` and `header.jspf` fragments.
5. Create a `GlobalModelAttributes` class.
6. Add a global `movieGenres` list.
7. Use `movieGenres` in a movie form.

---

<details>
<summary>Show solution</summary>

## 1. Lombok dependency in `pom.xml`

```xml
<properties>
    <lombok.version>1.18.46</lombok.version>
</properties>
```

```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>${lombok.version}</version>
    <scope>provided</scope>
</dependency>
```

## 2. Model `Movie.java`

```java
package com.example.movies.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Movie {

    private Long id;

    @NotBlank(message = "El título es obligatorio.")
    @Size(min = 2, max = 100, message = "El título debe tener entre 2 y 100 caracteres.")
    private String title;

    @NotBlank(message = "El género es obligatorio.")
    private String genre;

    @NotNull(message = "El año es obligatorio.")
    private Integer releaseYear;
}
```

## 3. `database.properties`

File:

```text
src/main/resources/database.properties
```

```properties
db.driverClassName=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/spring_mvc_movies?useSSL=false&serverTimezone=Europe/Madrid
db.username=root
db.password=TU_PASSWORD
```

## 4. Configuration in `app-servlet.xml`

```xml
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
```

## 5. `head.jspf` fragment

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

## 6. `header.jspf` fragment

```jsp
<header class="header">
    <div class="brand">
        ${appName}
    </div>

    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">
            <spring:message code="nav.home" />
        </a>

        <a href="${pageContext.request.contextPath}/movies">
            Películas
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

## 7. `GlobalModelAttributes.java`

```java
package com.example.movies.config;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@ControllerAdvice
public class GlobalModelAttributes {

    @ModelAttribute("movieGenres")
    public List<String> movieGenres() {
        return List.of(
                "Drama",
                "Comedia",
                "Ciencia ficción",
                "Terror",
                "Animación"
        );
    }

    @ModelAttribute("appName")
    public String appName() {
        return "Movie Manager";
    }
}
```

## 8. Using `movieGenres` in `movies/form.jsp`

```jsp
<form:select path="genre" cssClass="input">
    <form:option value="">
        Selecciona un género
    </form:option>

    <c:forEach var="genre" items="${movieGenres}">
        <form:option value="${genre}">
            ${genre}
        </form:option>
    </c:forEach>
</form:select>

<form:errors path="genre" cssClass="error" />
```

### Explanation of the challenge

This challenge brings together the main improvements of Topic 6:

```text
Lombok reduce código repetitivo.
database.properties separa configuración de MySQL.
Los fragmentos JSP evitan repetir código en vistas.
GlobalModelAttributes permite reutilizar datos comunes.
```

The project will continue to work the same for the user, but it will be better organized internally.

</details>
