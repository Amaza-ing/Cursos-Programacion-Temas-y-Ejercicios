# Tema 6 — Mejoras sencillas para nuestro proyecto Spring MVC

## 1. Objetivo del tema

En los temas anteriores hemos construido una aplicación Spring MVC con:

```text
Tema 1 → Arquitectura, DispatcherServlet, configuración XML y primera vista.
Tema 2 → Controladores con anotaciones, rutas, servicios y vistas.
Tema 3 → Formularios, validación y procesamiento de datos.
Tema 4 Opcional → Conexión con MySQL y DBeaver.
Tema 5 → Excepciones, internacionalización y temas visuales.
```

En este **Tema 6** vamos a mejorar el proyecto sin añadir funcionalidades demasiado complejas.

El objetivo es que el código quede más limpio, más fácil de mantener y más cómodo para seguir ampliándolo.

Trabajaremos cuatro mejoras principales:

```text
1. Usar Lombok para reducir getters, setters y constructores.
2. Mover la configuración de MySQL a un archivo database.properties.
3. Crear fragmentos JSP reutilizables para no repetir el menú y el <head>.
4. Crear atributos globales para reutilizar datos comunes en varias vistas.
```

La idea importante de este tema es esta:

```text
Una aplicación no solo debe funcionar.
También debe ser fácil de leer, modificar y mantener.
```

---

# 2. Punto de partida

Partimos del proyecto Spring MVC que ya hemos ido construyendo.

La estructura general del proyecto puede ser parecida a esta:

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

En este tema no vamos a rehacer el proyecto desde cero. Vamos a aplicar mejoras sobre lo que ya tenemos.

---

# 3. Mejora 1 — Usar Lombok para reducir código repetitivo

## 3.1. Qué problema queremos resolver

Nuestra clase `Course` tiene muchos métodos repetitivos.

Por ejemplo:

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

Este código funciona, pero ocupa mucho espacio.

Cuando una clase tiene muchos atributos, acaba llena de:

```text
getters
setters
constructores
toString
equals
hashCode
```

Este tipo de código se conoce como **código repetitivo** o **boilerplate code**.

Para reducirlo vamos a usar **Lombok**.

Lombok permite escribir anotaciones como:

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
```

y genera automáticamente parte del código que normalmente escribiríamos a mano.

---

# 4. Añadir Lombok al `pom.xml`

Abrimos el archivo:

```text
pom.xml
```

Y añadimos esta dependencia dentro del bloque `<dependencies>`:

```xml
<!-- Lombok: reduce código repetitivo en modelos y clases Java -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.46</version>
    <scope>provided</scope>
</dependency>
```

## Explicación

La dependencia es:

```xml
<artifactId>lombok</artifactId>
```

Esto añade Lombok al proyecto.

El alcance es:

```xml
<scope>provided</scope>
```

Esto significa que Lombok se usa al compilar, pero no se empaqueta dentro del `.war`.

¿Por qué?

Porque Lombok genera código durante la compilación. Una vez compilado el proyecto, Tomcat no necesita tener Lombok para ejecutar la aplicación.

---

# 5. Activar Lombok en IntelliJ

Después de añadir la dependencia, debemos comprobar que IntelliJ permite procesar anotaciones.

En IntelliJ, vamos a:

```text
File
→ Settings
→ Build, Execution, Deployment
→ Compiler
→ Annotation Processors
```

Y activamos:

```text
Enable annotation processing
```

Después recargamos Maven.

Normalmente se puede hacer desde la ventana de Maven con:

```text
Reload All Maven Projects
```

Si IntelliJ no reconoce `@Data`, `@NoArgsConstructor` o `@AllArgsConstructor`, revisa:

```text
1. Que la dependencia esté bien escrita en el pom.xml.
2. Que Maven se haya recargado.
3. Que Annotation Processing esté activado.
4. Que IntelliJ tenga soporte para Lombok.
```

---

# 6. Actualizar `Course.java` con Lombok

Antes, nuestra clase `Course` podía ser parecida a esta:

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

Ahora podemos dejarla así:

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

# 7. Explicación de las anotaciones de Lombok

## 7.1. `@Data`

La anotación:

```java
@Data
```

genera automáticamente:

```text
getters
setters
toString()
equals()
hashCode()
```

Por eso ya no necesitamos escribir manualmente:

```java
public String getTitle() {
    return title;
}

public void setTitle(String title) {
    this.title = title;
}
```

Aunque no los veamos en el archivo, esos métodos existirán cuando el proyecto se compile.

---

## 7.2. `@NoArgsConstructor`

La anotación:

```java
@NoArgsConstructor
```

genera un constructor vacío.

Es equivalente a escribir:

```java
public Course() {
}
```

Este constructor es importante en Spring MVC porque cuando mostramos un formulario solemos hacer:

```java
model.addAttribute("course", new Course());
```

Spring necesita poder crear un objeto vacío para ir rellenándolo con los datos del formulario.

---

## 7.3. `@AllArgsConstructor`

La anotación:

```java
@AllArgsConstructor
```

genera un constructor con todos los atributos.

Es equivalente a escribir:

```java
public Course(Long id, String title, String level, Integer durationInHours) {
    this.id = id;
    this.title = title;
    this.level = level;
    this.durationInHours = durationInHours;
}
```

Esto nos permite seguir creando cursos así:

```java
new Course(1L, "Spring MVC desde cero", "Inicial", 20);
```

---

# 8. Comprobación de que Lombok funciona

Después de modificar `Course.java`, revisamos si el resto del proyecto sigue funcionando.

Por ejemplo, en `CourseService` puede que tengamos:

```java
new Course(1L, "Spring MVC desde cero", "Inicial", 20);
```

Esto seguirá funcionando gracias a:

```java
@AllArgsConstructor
```

En una JSP podemos seguir escribiendo:

```jsp
${course.title}
```

Esto seguirá funcionando porque Lombok genera:

```java
getTitle()
```

También seguirá funcionando:

```java
course.setId(generatedId.longValue());
```

porque Lombok genera:

```java
setId(Long id)
```

Por tanto, desde fuera la clase `Course` se comporta igual que antes.

Lo único que cambia es que nosotros escribimos menos código.

---

# 9. Cuándo conviene usar Lombok y cuándo tener cuidado

Lombok es muy útil para modelos sencillos.

Por ejemplo:

```text
Course
Product
Customer
Event
```

Pero conviene tener cuidado con `@Data` en clases muy complejas.

`@Data` genera `equals`, `hashCode` y `toString`. En muchos modelos sencillos esto está bien, pero en aplicaciones grandes o con relaciones complejas puede no ser lo más adecuado.

Para este curso, `@Data` es una buena opción porque nuestras clases son simples.

---

# 10. Mejora 2 — Externalizar la configuración de MySQL

## 10.1. Qué problema queremos resolver

En la ampliación de MySQL configuramos la conexión directamente en `app-servlet.xml`.

Por ejemplo:

```xml
<property name="url"
          value="jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&amp;serverTimezone=Europe/Madrid" />

<property name="username" value="root" />
<property name="password" value="TU_PASSWORD" />
```

Esto funciona, pero tiene algunos inconvenientes:

```text
1. La contraseña queda dentro del XML principal.
2. Si cambia la base de datos, hay que tocar app-servlet.xml.
3. La configuración de Spring MVC y la configuración de MySQL quedan mezcladas.
```

Una mejora sencilla es mover esos valores a un archivo `.properties`.

---

# 11. Crear `database.properties`

Creamos este archivo:

```text
src/main/resources/database.properties
```

Contenido:

```properties
db.driverClassName=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&serverTimezone=Europe/Madrid
db.username=root
db.password=TU_PASSWORD
```

## Explicación

Aquí guardamos los datos de conexión con MySQL.

La propiedad:

```properties
db.driverClassName=com.mysql.cj.jdbc.Driver
```

indica el driver de MySQL.

La propiedad:

```properties
db.url=jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&serverTimezone=Europe/Madrid
```

indica la URL de conexión.

La propiedad:

```properties
db.username=root
```

indica el usuario.

La propiedad:

```properties
db.password=TU_PASSWORD
```

indica la contraseña.

Cada alumno debe cambiar:

```text
TU_PASSWORD
```

por la contraseña real de su MySQL.

---

# 12. Diferencia entre `&` en XML y en `.properties`

En `app-servlet.xml` teníamos que escribir:

```xml
&amp;
```

Por ejemplo:

```xml
value="jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&amp;serverTimezone=Europe/Madrid"
```

Pero en `database.properties` escribimos:

```properties
db.url=jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&serverTimezone=Europe/Madrid
```

Aquí usamos:

```text
&
```

normal.

La razón es que XML interpreta `&` como un carácter especial, pero un archivo `.properties` no funciona igual.

---

# 13. Modificar `app-servlet.xml` para leer `database.properties`

Abrimos:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

Dentro del archivo ya debemos tener el namespace `context`, porque lo hemos usado para:

```xml
<context:component-scan base-package="com.example.springmvcday1" />
```

Ahora añadimos esta línea:

```xml
<context:property-placeholder location="classpath:database.properties" />
```

Puede quedar así:

```xml
<!-- Busca automáticamente controladores, servicios, DAOs y otros componentes -->
<context:component-scan base-package="com.example.springmvcday1" />

<!-- Carga propiedades externas desde src/main/resources/database.properties -->
<context:property-placeholder location="classpath:database.properties" />
```

Después modificamos el `dataSource`.

Antes:

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

Ahora:

```xml
<bean id="dataSource"
      class="org.springframework.jdbc.datasource.DriverManagerDataSource">

    <property name="driverClassName" value="${db.driverClassName}" />
    <property name="url" value="${db.url}" />
    <property name="username" value="${db.username}" />
    <property name="password" value="${db.password}" />
</bean>
```

El `JdbcTemplate` se queda igual:

```xml
<bean id="jdbcTemplate"
      class="org.springframework.jdbc.core.JdbcTemplate">

    <property name="dataSource" ref="dataSource" />
</bean>
```

---

# 14. `app-servlet.xml` con la mejora aplicada

La parte importante del archivo quedaría así:

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

# 15. Comprobación de la configuración externa

Para comprobar que funciona:

1. Arrancamos MySQL.
2. Abrimos DBeaver y comprobamos que la base de datos existe.
3. Revisamos `database.properties`.
4. Ejecutamos Tomcat.
5. Entramos en:

```text
http://localhost:8080/spring-mvc-day1/courses
```

Si se muestran los cursos desde MySQL, la configuración funciona.

Si hay error, revisamos:

```text
1. Que database.properties esté en src/main/resources.
2. Que la contraseña sea correcta.
3. Que app-servlet.xml tenga context:property-placeholder.
4. Que MySQL esté iniciado.
5. Que la base de datos exista.
```

---

# 16. Mejora 3 — Crear fragmentos JSP reutilizables

## 16.1. Qué problema queremos resolver

En varias vistas repetimos mucho código.

Por ejemplo, muchas JSP tienen:

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

También repetimos la carga de CSS:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

<c:if test="${currentTheme == 'dark'}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
</c:if>
```

El problema es que si queremos modificar el menú, tenemos que modificar muchas vistas.

Una mejora sencilla es crear **fragmentos JSP reutilizables**.

---

# 17. Crear la carpeta `fragments`

Creamos esta carpeta:

```text
src/main/webapp/WEB-INF/views/fragments
```

Dentro crearemos estos archivos:

```text
head.jspf
header.jspf
```

La extensión `.jspf` se suele usar para fragmentos JSP.

No es obligatorio, pero ayuda a diferenciar una página completa de un fragmento reutilizable.

---

# 18. Crear el fragmento `head.jspf`

Creamos el archivo:

```text
src/main/webapp/WEB-INF/views/fragments/head.jspf
```

Contenido:

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

# 19. Explicación de `head.jspf`

Primero declaramos las librerías de etiquetas:

```jsp
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

Necesitamos `spring` para poder usar:

```jsp
<spring:message>
```

Necesitamos `c` para poder usar etiquetas JSTL como:

```jsp
<c:if>
<c:choose>
<c:when>
<c:otherwise>
```

Después calculamos el tema actual:

```jsp
<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />
```

Esto significa:

```text
Si no hay tema guardado en sesión, usa light.
Si hay tema guardado en sesión, usa ese valor.
```

Después generamos el `<title>` de la página.

Usamos:

```jsp
<c:choose>
```

porque algunas páginas tienen título internacionalizado y otras tienen título dinámico.

Por ejemplo, el listado de cursos puede usar:

```java
model.addAttribute("pageTitleCode", "courses.list.title");
```

Pero el detalle de un curso puede usar:

```java
model.addAttribute("pageTitle", course.getTitle());
```

Por eso contemplamos las dos posibilidades.

Finalmente cargamos siempre:

```jsp
styles.css
```

y solo si el tema es oscuro cargamos:

```jsp
styles-dark.css
```

---

# 20. Crear el fragmento `header.jspf`

Creamos el archivo:

```text
src/main/webapp/WEB-INF/views/fragments/header.jspf
```

Contenido:

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

# 21. Explicación de `header.jspf`

Este fragmento contiene el menú común.

Incluye:

```text
1. Enlace a inicio.
2. Enlace a cursos.
3. Enlace a sobre el curso.
4. Cambio de idioma a español.
5. Cambio de idioma a inglés.
6. Cambio a tema claro.
7. Cambio a tema oscuro.
```

La ventaja es que, si más adelante queremos añadir un enlace nuevo, solo modificamos este archivo.

Por ejemplo, si queremos añadir contacto:

```jsp
<a href="${pageContext.request.contextPath}/contact">
    Contacto
</a>
```

lo hacemos una sola vez.

---

# 22. Usar los fragmentos en una JSP

Ahora vamos a aplicar los fragmentos a una vista.

Tomemos como ejemplo:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

Antes podía tener mucho código repetido.

Ahora puede empezar así:

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

La línea:

```jsp
<%@ include file="/WEB-INF/views/fragments/head.jspf" %>
```

inserta el contenido de `head.jspf`.

La línea:

```jsp
<%@ include file="/WEB-INF/views/fragments/header.jspf" %>
```

inserta el menú común.

---

# 23. Ejemplo completo de `courses/list.jsp` simplificado

Archivo:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

Código:

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

# 24. Qué hemos ganado con los fragmentos

Antes cada JSP repetía:

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

Ahora todo eso está centralizado en:

```text
head.jspf
header.jspf
```

Esto hace que las vistas sean más cortas y más fáciles de mantener.

---

# 25. Mejora 4 — Crear atributos globales para datos comunes

## 25.1. Qué problema queremos resolver

En el formulario de cursos tenemos un desplegable de niveles.

Por ejemplo:

```jsp
<form:select path="level" cssClass="input">
    <form:option value="" label="Selecciona un nivel" />
    <form:option value="Inicial" label="Inicial" />
    <form:option value="Intermedio" label="Intermedio" />
    <form:option value="Avanzado" label="Avanzado" />
</form:select>
```

Esto funciona, pero tiene un inconveniente:

```text
Los niveles están escritos directamente en la vista.
```

Si mañana queremos añadir un nuevo nivel, tenemos que modificar la JSP.

Una mejora sencilla es preparar esos datos desde Java y enviarlos automáticamente al modelo.

---

# 26. Crear `GlobalModelAttributes`

Creamos un nuevo paquete:

```text
src/main/java/com/example/springmvcday1/config
```

Dentro creamos el archivo:

```text
GlobalModelAttributes.java
```

Código:

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

# 27. Explicación de `GlobalModelAttributes`

La clase tiene:

```java
@ControllerAdvice
```

Ya usamos `@ControllerAdvice` para gestionar excepciones.

También puede usarse para añadir datos comunes al modelo.

Este método:

```java
@ModelAttribute("courseLevels")
public List<String> courseLevels() {
    return List.of("Inicial", "Intermedio", "Avanzado");
}
```

añade automáticamente un atributo llamado:

```text
courseLevels
```

a las vistas.

Por tanto, una JSP podrá usar:

```jsp
${courseLevels}
```

sin que cada controlador tenga que añadirlo manualmente.

También añadimos:

```java
@ModelAttribute("appName")
public String appName() {
    return "Spring MVC Courses";
}
```

Esto permite tener disponible el nombre de la aplicación en las vistas.

---

# 28. Usar `courseLevels` en `form.jsp`

Ahora modificamos el desplegable de niveles.

Archivo:

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

Antes:

```jsp
<form:select path="level" cssClass="input">
    <form:option value="" label="Selecciona un nivel" />
    <form:option value="Inicial" label="Inicial" />
    <form:option value="Intermedio" label="Intermedio" />
    <form:option value="Avanzado" label="Avanzado" />
</form:select>
```

Ahora:

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

# 29. Vista `form.jsp` con fragmentos y niveles globales

El archivo completo puede quedar así:

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

# 30. Explicación del nuevo desplegable

El bloque importante es este:

```jsp
<c:forEach var="level" items="${courseLevels}">
    <form:option value="${level}">
        ${level}
    </form:option>
</c:forEach>
```

Aquí recorremos la lista:

```jsp
${courseLevels}
```

Esa lista viene de:

```java
@ModelAttribute("courseLevels")
public List<String> courseLevels() {
    return List.of("Inicial", "Intermedio", "Avanzado");
}
```

Por cada nivel, se genera una opción del desplegable.

Si la lista contiene:

```text
Inicial
Intermedio
Avanzado
```

la JSP genera opciones equivalentes a:

```html
<option value="Inicial">Inicial</option>
<option value="Intermedio">Intermedio</option>
<option value="Avanzado">Avanzado</option>
```

---

# 31. Añadir un nuevo nivel

Si ahora queremos añadir un nuevo nivel llamado:

```text
Experto
```

ya no modificamos la JSP.

Solo cambiamos Java:

```java
@ModelAttribute("courseLevels")
public List<String> courseLevels() {
    return List.of("Inicial", "Intermedio", "Avanzado", "Experto");
}
```

La vista se actualizará automáticamente.

---

# 32. Usar `appName` en el menú

Como hemos creado este atributo global:

```java
@ModelAttribute("appName")
public String appName() {
    return "Spring MVC Courses";
}
```

podemos usarlo en `header.jspf`.

Por ejemplo:

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

Ahora el nombre de la aplicación se puede cambiar desde Java, no desde cada JSP.

---

# 33. Añadir estilo para `.brand`

Si usamos `.brand`, añadimos este CSS en:

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

Si el `header` usa `display: flex`, el nombre de la aplicación aparecerá junto al menú.

---

# 34. Resumen de archivos creados o modificados

En este tema hemos tocado estos archivos:

```text
pom.xml
```

Añadimos Lombok.

```text
src/main/java/com/example/springmvcday1/model/Course.java
```

Simplificamos el modelo con Lombok.

```text
src/main/resources/database.properties
```

Creamos un archivo externo para los datos de conexión con MySQL.

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

Cargamos `database.properties` y usamos `${db...}`.

```text
src/main/webapp/WEB-INF/views/fragments/head.jspf
```

Creamos un fragmento común para el `<head>`.

```text
src/main/webapp/WEB-INF/views/fragments/header.jspf
```

Creamos un fragmento común para el menú.

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

Usamos fragmentos para simplificar la vista.

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

Usamos fragmentos y la lista global de niveles.

```text
src/main/java/com/example/springmvcday1/config/GlobalModelAttributes.java
```

Creamos atributos globales disponibles en varias vistas.

```text
src/main/webapp/resources/css/styles.css
```

Añadimos estilos para `.brand`, si usamos el nombre de la aplicación en el menú.

---

# 35. Errores habituales del Tema 6

## Error 1 — Lombok no genera getters y setters

Si IntelliJ marca errores en una clase con `@Data`, revisa:

```text
1. La dependencia de Lombok está en pom.xml.
2. Maven se ha recargado.
3. Annotation Processing está activado.
4. Los imports de Lombok son correctos.
```

Los imports deben ser:

```java
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
```

---

## Error 2 — Falta el constructor vacío

Si usamos formularios, necesitamos constructor vacío.

Con Lombok lo conseguimos con:

```java
@NoArgsConstructor
```

Si lo quitamos, Spring puede tener problemas para crear el objeto del formulario.

---

## Error 3 — `database.properties` está en una carpeta incorrecta

El archivo debe estar en:

```text
src/main/resources/database.properties
```

No debe estar en:

```text
src/main/java
```

ni en:

```text
src/main/webapp
```

porque lo estamos cargando con:

```xml
classpath:database.properties
```

---

## Error 4 — Usar `&amp;` dentro de `database.properties`

En `database.properties` debe escribirse:

```properties
db.url=jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&serverTimezone=Europe/Madrid
```

No:

```properties
db.url=jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&amp;serverTimezone=Europe/Madrid
```

`&amp;` solo era necesario dentro del XML.

---

## Error 5 — Olvidar `context:property-placeholder`

Si usamos:

```xml
<property name="url" value="${db.url}" />
```

pero no añadimos:

```xml
<context:property-placeholder location="classpath:database.properties" />
```

Spring no sabrá sustituir `${db.url}`.

---

## Error 6 — Incluir mal un fragmento JSP

La ruta debe coincidir con la ubicación real del archivo.

Correcto:

```jsp
<%@ include file="/WEB-INF/views/fragments/head.jspf" %>
```

Incorrecto si la carpeta no existe o está mal escrita:

```jsp
<%@ include file="/WEB-INF/fragments/head.jspf" %>
```

---

## Error 7 — Usar `<spring:message>` sin importar la taglib

Si una JSP usa:

```jsp
<spring:message code="nav.home" />
```

debe existir esta línea en la JSP o en un fragmento incluido:

```jsp
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
```

En nuestro caso, `head.jspf` ya la incluye, pero hay que asegurarse de que se está incluyendo correctamente.

---

## Error 8 — Usar `<c:forEach>` sin JSTL

Si usamos:

```jsp
<c:forEach var="level" items="${courseLevels}">
```

debe existir:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

Además, el proyecto debe tener las dependencias de JSTL en el `pom.xml`.

---

## Error 9 — El atributo global no aparece en la vista

Si `${courseLevels}` no aparece, revisa:

```text
1. Que GlobalModelAttributes tenga @ControllerAdvice.
2. Que el paquete esté dentro del component-scan.
3. Que el método tenga @ModelAttribute("courseLevels").
4. Que el nombre usado en la JSP coincida exactamente.
```

Por ejemplo:

```java
@ModelAttribute("courseLevels")
```

debe coincidir con:

```jsp
${courseLevels}
```

---

# 36. Resultado final del Tema 6

Después de aplicar estas mejoras, el proyecto sigue funcionando igual desde el punto de vista del usuario.

El usuario puede seguir:

```text
Ver cursos
Crear cursos
Cambiar idioma
Cambiar tema
Ver errores personalizados
```

Pero por dentro el proyecto está más limpio.

## Antes

```text
Course.java tenía muchos getters y setters.
Los datos de MySQL estaban dentro del XML.
Cada JSP repetía el menú y el head.
Los niveles del formulario estaban escritos directamente en la vista.
```

## Después

```text
Course.java usa Lombok.
La conexión con MySQL está en database.properties.
Las JSP reutilizan head.jspf y header.jspf.
Los niveles del formulario vienen de un atributo global.
```

---

# 37. Cierre del tema

Este tema introduce una idea importante para cualquier proyecto:

```text
La calidad de una aplicación no depende solo de que funcione.
También depende de que el código sea claro, ordenado y fácil de cambiar.
```

Las mejoras aplicadas son pequeñas, pero tienen mucho valor:

```text
Lombok reduce código repetitivo.
database.properties separa configuración de lógica.
Los fragmentos JSP evitan duplicación.
Los atributos globales centralizan datos compartidos.
```

Con esto, el proyecto Spring MVC queda más preparado para crecer sin volverse desordenado.
