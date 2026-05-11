# Tema 5: Gestión de excepciones, internacionalización y temas locales en Spring MVC

## 1. Objetivos del tema

En este tema vamos a completar la aplicación Spring MVC que hemos ido construyendo durante el curso.

Hasta ahora, la aplicación ya permite:

- Mostrar páginas usando controladores y vistas JSP.
- Listar cursos.
- Ver el detalle de un curso.
- Crear cursos mediante formularios.
- Validar datos del formulario.
- Opcionalmente, guardar los datos en MySQL.

En este tema añadiremos tres aspectos importantes en una aplicación web real:

1. **Gestión de excepciones**: controlar errores de forma ordenada y mostrar páginas de error personalizadas.
2. **Internacionalización**: permitir que la aplicación muestre textos en distintos idiomas.
3. **Temas locales**: permitir que el usuario cambie el aspecto visual de la aplicación, por ejemplo entre tema claro y tema oscuro.

Al terminar este tema, la aplicación podrá:

- Mostrar una página específica cuando un curso no exista.
- Mostrar una página 404 personalizada cuando el usuario acceda a una ruta inexistente.
- Mostrar textos en español o inglés.
- Cambiar el idioma usando enlaces como `?lang=es` o `?lang=en`.
- Cambiar el tema visual entre claro y oscuro.

---

## 2. Punto de partida

Partimos del proyecto usado en los temas anteriores.

La aplicación ya tiene una estructura parecida a esta:

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

En este tema añadiremos nuevas clases y nuevos archivos:

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

# Parte 1. Gestión de excepciones

## 3. ¿Por qué necesitamos gestionar excepciones?

Hasta ahora, cuando un curso no existía, podíamos hacer una comprobación directamente dentro del controlador:

```java
Course course = courseService.findById(id);

if (course == null) {
    model.addAttribute("pageTitle", "Curso no encontrado");
    model.addAttribute("courseId", id);

    return "courses/not-found";
}
```

Este código funciona, pero tiene un problema: el controlador empieza a mezclar demasiadas responsabilidades.

El controlador debería encargarse principalmente de:

- Recibir peticiones.
- Pedir datos al servicio.
- Añadir datos al modelo.
- Devolver el nombre de una vista.

Pero si en todos los métodos empezamos a añadir condiciones para errores, el código se vuelve largo y repetitivo.

Una solución más ordenada es:

```text
Si el curso no existe, el servicio lanza una excepción.
Después, una clase global se encarga de capturar esa excepción
y decidir qué página de error mostrar.
```

Así conseguimos separar mejor las responsabilidades.

---

## 4. Crear una excepción personalizada

Vamos a crear una excepción específica para cuando un curso no exista.

Creamos un nuevo paquete:

```text
src/main/java/com/example/springmvcday1/exception
```

Dentro de ese paquete creamos el archivo:

```text
CourseNotFoundException.java
```

### Código de `CourseNotFoundException.java`

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

### Explicación paso a paso

La clase empieza así:

```java
public class CourseNotFoundException extends RuntimeException {
```

Esto significa que estamos creando una excepción propia y que hereda de `RuntimeException`.

Usamos `RuntimeException` porque no queremos estar obligados a poner `throws` en todos los métodos que puedan lanzarla.

Después guardamos el identificador del curso:

```java
private final Long courseId;
```

Esto nos servirá para mostrar un mensaje más claro al usuario.

Por ejemplo:

```text
No se ha encontrado ningún curso con el identificador 999.
```

El constructor recibe el `courseId`:

```java
public CourseNotFoundException(Long courseId) {
    super("No se ha encontrado ningún curso con id " + courseId);
    this.courseId = courseId;
}
```

La línea:

```java
super("No se ha encontrado ningún curso con id " + courseId);
```

crea el mensaje interno de la excepción.

La línea:

```java
this.courseId = courseId;
```

guarda el identificador para poder recuperarlo después.

Finalmente, el método:

```java
public Long getCourseId() {
    return courseId;
}
```

nos permite leer el identificador desde el manejador de errores.

---

## 5. Actualizar `CourseService`

Ahora vamos a añadir un método en el servicio que busque un curso y lance la excepción si no existe.

Archivo:

```text
src/main/java/com/example/springmvcday1/service/CourseService.java
```

Si estás usando la versión con MySQL, el servicio puede tener este aspecto:

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

Si estás usando la versión sin MySQL y sigues guardando los cursos en una lista, el método importante sería este:

```java
public Course findByIdOrThrow(Long id) {
    Course course = findById(id);

    if (course == null) {
        throw new CourseNotFoundException(id);
    }

    return course;
}
```

### Explicación del método nuevo

El método nuevo es:

```java
public Course findByIdOrThrow(Long id) {
```

Su responsabilidad es muy clara:

```text
Buscar un curso por id.
Si existe, devolverlo.
Si no existe, lanzar una excepción.
```

Primero buscamos el curso:

```java
Course course = courseDao.findById(id);
```

Después comprobamos si el resultado es `null`:

```java
if (course == null) {
    throw new CourseNotFoundException(id);
}
```

Si el curso no existe, lanzamos nuestra excepción personalizada.

Si el curso existe, lo devolvemos:

```java
return course;
```

---

## 6. Actualizar `CourseController`

Ahora podemos simplificar el método que muestra el detalle de un curso.

Archivo:

```text
src/main/java/com/example/springmvcday1/controller/CourseController.java
```

### Código actualizado del método `courseDetail`

```java
@GetMapping("/detail")
public String courseDetail(@RequestParam("id") Long id, Model model) {
    Course course = courseService.findByIdOrThrow(id);

    model.addAttribute("pageTitle", course.getTitle());
    model.addAttribute("course", course);

    return "courses/detail";
}
```

### Explicación

Antes, el controlador tenía que hacer esta comprobación:

```java
if (course == null) {
    ...
}
```

Ahora ya no hace falta.

El controlador solo escribe:

```java
Course course = courseService.findByIdOrThrow(id);
```

Si el curso existe, el código continúa normalmente.

Si no existe, se lanza una `CourseNotFoundException`.

En ese caso, el controlador no sigue ejecutándose. Spring buscará un método que sepa gestionar esa excepción.

Ese método lo crearemos ahora.

---

## 7. Crear un manejador global de excepciones

Creamos el archivo:

```text
src/main/java/com/example/springmvcday1/exception/GlobalExceptionHandler.java
```

### Código de `GlobalExceptionHandler.java`

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

### Explicación paso a paso

La clase tiene esta anotación:

```java
@ControllerAdvice
```

Esta anotación indica que la clase puede aplicar lógica común a varios controladores.

En este caso, la usaremos para manejar excepciones de forma global.

El primer método es:

```java
@ExceptionHandler(CourseNotFoundException.class)
public String handleCourseNotFound(
        CourseNotFoundException exception,
        Model model) {
```

La anotación:

```java
@ExceptionHandler(CourseNotFoundException.class)
```

significa:

```text
Cuando se lance una CourseNotFoundException,
ejecuta este método.
```

Dentro añadimos información al modelo:

```java
model.addAttribute("pageTitle", "Curso no encontrado");
model.addAttribute("courseId", exception.getCourseId());
model.addAttribute("errorMessage", exception.getMessage());
```

Después devolvemos la vista:

```java
return "error/course-not-found";
```

Esto hará que Spring busque el archivo:

```text
/WEB-INF/views/error/course-not-found.jsp
```

El segundo método es más general:

```java
@ExceptionHandler(Exception.class)
public String handleGeneralException(
        Exception exception,
        Model model) {
```

Este método capturará excepciones no previstas.

Sirve como una red de seguridad para que el usuario no vea páginas técnicas del servidor.

---

## 8. Crear la vista `course-not-found.jsp`

Creamos la carpeta:

```text
src/main/webapp/WEB-INF/views/error
```

Dentro creamos el archivo:

```text
course-not-found.jsp
```

### Código de `course-not-found.jsp`

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

### Explicación

Esta vista recibe los datos que hemos añadido en `GlobalExceptionHandler`:

```java
model.addAttribute("pageTitle", "Curso no encontrado");
model.addAttribute("courseId", exception.getCourseId());
model.addAttribute("errorMessage", exception.getMessage());
```

Por eso podemos usar en la JSP:

```jsp
${pageTitle}
${courseId}
${errorMessage}
```

Esta vista se mostrará cuando el usuario intente ver un curso que no existe.

Por ejemplo:

```text
/courses/detail?id=999
```

---

## 9. Crear una vista de error general

Creamos el archivo:

```text
src/main/webapp/WEB-INF/views/error/general-error.jsp
```

### Código de `general-error.jsp`

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

### Explicación

Esta vista se usará cuando ocurra una excepción no prevista.

El método que la devuelve es:

```java
@ExceptionHandler(Exception.class)
public String handleGeneralException(
        Exception exception,
        Model model) {
```

En una aplicación real, no siempre mostraríamos al usuario el mensaje técnico de la excepción. Podríamos mostrar un mensaje genérico y guardar el detalle del error en logs.

Para este curso, lo mostramos para entender mejor qué está ocurriendo.

---

## 10. Configurar páginas 404 y 500 en `web.xml`

La gestión con `@ControllerAdvice` funciona muy bien para excepciones que se producen dentro de los controladores.

Pero hay errores que pueden ocurrir antes, por ejemplo cuando el usuario intenta entrar en una URL que no existe:

```text
http://localhost:8080/spring-mvc-day1/pagina-inventada
```

En ese caso, podemos configurar páginas de error en `web.xml`.

Archivo:

```text
src/main/webapp/WEB-INF/web.xml
```

Añadimos al final, antes de `</web-app>`:

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

El archivo completo puede quedar así:

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

## 11. Crear `ErrorPageController`

Ahora necesitamos un controlador que atienda estas rutas:

```text
/error/404
/error/500
```

Creamos el archivo:

```text
src/main/java/com/example/springmvcday1/controller/ErrorPageController.java
```

### Código de `ErrorPageController.java`

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

### Explicación

Si ocurre un error 404, `web.xml` redirige internamente a:

```text
/error/404
```

Entonces Spring ejecuta este método:

```java
@GetMapping("/error/404")
public String notFound(Model model) {
```

El método añade un título:

```java
model.addAttribute("pageTitle", "Página no encontrada");
```

Y devuelve:

```java
return "error/not-found";
```

Por tanto, Spring buscará:

```text
/WEB-INF/views/error/not-found.jsp
```

---

## 12. Crear la vista `not-found.jsp`

Creamos el archivo:

```text
src/main/webapp/WEB-INF/views/error/not-found.jsp
```

### Código de `not-found.jsp`

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

## 13. Resumen de la gestión de excepciones

El flujo cuando un curso no existe es:

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

El flujo cuando una ruta no existe es:

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

# Parte 2. Internacionalización

## 14. ¿Qué es la internacionalización?

Internacionalizar una aplicación significa prepararla para que pueda mostrar textos en distintos idiomas.

Por ejemplo, en lugar de escribir directamente en una JSP:

```jsp
<a href="/home">Inicio</a>
```

escribimos:

```jsp
<spring:message code="nav.home" />
```

Después Spring busca el texto correspondiente en un archivo de mensajes.

En español:

```properties
nav.home=Inicio
```

En inglés:

```properties
nav.home=Home
```

Así conseguimos que la misma JSP pueda mostrar diferentes idiomas.

---

## 15. Configurar internacionalización en `app-servlet.xml`

Vamos a modificar el archivo:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

Añadiremos tres elementos:

1. `messageSource`
2. `localeResolver`
3. `LocaleChangeInterceptor`

### Código actualizado de `app-servlet.xml`

Si no estás usando MySQL, puedes usar esta versión:

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

Si estás usando MySQL, mantén también los beans `dataSource` y `jdbcTemplate` que configuraste en la ampliación del tema 3.

### Explicación de `messageSource`

```xml
<bean id="messageSource"
      class="org.springframework.context.support.ResourceBundleMessageSource">
    <property name="basename" value="messages" />
    <property name="defaultEncoding" value="UTF-8" />
</bean>
```

Este bean le dice a Spring que los textos traducibles estarán en archivos llamados `messages`.

Spring buscará archivos como:

```text
messages.properties
messages_es.properties
messages_en.properties
```

La propiedad:

```xml
<property name="defaultEncoding" value="UTF-8" />
```

ayuda a que se lean bien caracteres como tildes, eñes y símbolos especiales.

### Explicación de `localeResolver`

```xml
<bean id="localeResolver"
      class="org.springframework.web.servlet.i18n.SessionLocaleResolver">
    <property name="defaultLocale" value="es" />
</bean>
```

Este bean indica que el idioma activo se guardará en la sesión del usuario.

Además, el idioma por defecto será español:

```text
es
```

### Explicación de `LocaleChangeInterceptor`

```xml
<mvc:interceptors>
    <bean class="org.springframework.web.servlet.i18n.LocaleChangeInterceptor">
        <property name="paramName" value="lang" />
    </bean>
</mvc:interceptors>
```

Este interceptor permite cambiar el idioma mediante un parámetro en la URL.

Por ejemplo:

```text
/home?lang=es
```

cambia a español.

```text
/home?lang=en
```

cambia a inglés.

---

## 16. Crear archivos de mensajes

Creamos los archivos dentro de:

```text
src/main/resources
```

Los archivos serán:

```text
messages.properties
messages_es.properties
messages_en.properties
```

### Código de `messages.properties`

Este archivo se usará como archivo por defecto:

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

### Código de `messages_es.properties`

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

### Código de `messages_en.properties`

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

## 17. Usar mensajes internacionalizados en los controladores

Algunos mensajes aparecen en el controlador, no en la JSP.

Por ejemplo, cuando creamos un curso correctamente, en el tema anterior teníamos:

```java
redirectAttributes.addFlashAttribute(
        "successMessage",
        "El curso se ha creado correctamente."
);
```

Ese texto está fijo en español. Para internacionalizarlo, podemos usar `MessageSource`.

### Código actualizado de `CourseController.java`

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

### Explicación

Añadimos esta propiedad:

```java
private final MessageSource messageSource;
```

Y la recibimos en el constructor:

```java
public CourseController(
        CourseService courseService,
        MessageSource messageSource) {
```

Spring inyectará el bean que configuramos en XML:

```xml
<bean id="messageSource"
      class="org.springframework.context.support.ResourceBundleMessageSource">
```

Cuando guardamos el curso, obtenemos el idioma activo:

```java
Locale locale = LocaleContextHolder.getLocale();
```

Después buscamos el mensaje correspondiente:

```java
String successMessage = messageSource.getMessage(
        "success.course.created",
        null,
        locale
);
```

Si el idioma activo es español, se mostrará:

```text
El curso se ha creado correctamente.
```

Si el idioma activo es inglés, se mostrará:

```text
The course has been created successfully.
```

---

## 18. Internacionalizar `home.jsp`

Archivo:

```text
src/main/webapp/WEB-INF/views/home.jsp
```

### Código actualizado de `home.jsp`

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

### Explicación

Activamos las etiquetas de Spring:

```jsp
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
```

Después usamos:

```jsp
<spring:message code="home.title" />
```

Spring buscará esa clave en los archivos de mensajes.

Si el idioma es español:

```properties
home.title=Bienvenida a Spring MVC
```

Si el idioma es inglés:

```properties
home.title=Welcome to Spring MVC
```

Los enlaces para cambiar de idioma son:

```jsp
<a href="${pageContext.request.contextPath}/home?lang=es">
```

y:

```jsp
<a href="${pageContext.request.contextPath}/home?lang=en">
```

Gracias al `LocaleChangeInterceptor`, Spring detectará el parámetro `lang`.

---

## 19. Internacionalizar `list.jsp`

Archivo:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

### Código actualizado de `list.jsp`

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

### Explicación

Los textos fijos desaparecen de la JSP.

Por ejemplo, antes podíamos tener:

```jsp
Crear nuevo curso
```

Ahora tenemos:

```jsp
<spring:message code="courses.create" />
```

Esto hace que la misma vista pueda funcionar en varios idiomas.

---

## 20. Internacionalizar `form.jsp`

Archivo:

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

### Código actualizado de `form.jsp`

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

### Explicación

El formulario sigue vinculado al objeto `course`:

```jsp
<form:form modelAttribute="course">
```

Los campos siguen vinculados a las propiedades de `Course`:

```jsp
<form:input path="title" />
<form:select path="level">
<form:input path="durationInHours" />
```

Lo único que cambia es que los textos visibles pasan a estar internacionalizados.

---

## 21. Internacionalizar mensajes de validación

En el tema anterior teníamos mensajes de validación escritos directamente en la clase `Course`.

Por ejemplo:

```java
@NotBlank(message = "El título es obligatorio.")
```

Ahora vamos a usar claves de mensajes.

Archivo:

```text
src/main/java/com/example/springmvcday1/model/Course.java
```

### Código actualizado de `Course.java`

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

### Explicación

Ahora escribimos:

```java
@NotBlank(message = "{course.title.notBlank}")
```

en lugar de:

```java
@NotBlank(message = "El título es obligatorio.")
```

La clave:

```text
course.title.notBlank
```

se busca en los archivos de mensajes.

En español:

```properties
course.title.notBlank=El título es obligatorio.
```

En inglés:

```properties
course.title.notBlank=The title is required.
```

Así los errores del formulario también cambian de idioma.

---

# Parte 3. Temas locales

## 22. ¿Qué son los temas locales?

Un tema local permite cambiar el aspecto visual de la aplicación según una preferencia del usuario.

Por ejemplo:

```text
Tema claro
Tema oscuro
```

En versiones anteriores, Spring MVC tenía una infraestructura específica para gestionar temas. Sin embargo, en Spring Framework 6 ese soporte específico está deprecado, así que en este curso usaremos una solución sencilla y moderna:

```text
1. El usuario pulsa un enlace para elegir tema claro u oscuro.
2. Guardamos el tema elegido en la sesión.
3. La JSP lee el tema desde la sesión.
4. Si el tema es oscuro, carga un CSS adicional.
```

---

## 23. Crear `ThemeController`

Creamos el archivo:

```text
src/main/java/com/example/springmvcday1/controller/ThemeController.java
```

### Código de `ThemeController.java`

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

### Explicación

La clase está anotada con:

```java
@Controller
```

Por tanto, Spring la detecta como controlador.

La anotación:

```java
@RequestMapping("/theme")
```

indica que todas las rutas de este controlador empiezan por:

```text
/theme
```

El método:

```java
@GetMapping("/change")
```

atiende la ruta:

```text
/theme/change
```

Por ejemplo:

```text
/theme/change?theme=dark
```

El parámetro se recibe aquí:

```java
@RequestParam(defaultValue = "light") String theme
```

Si el usuario no envía ningún tema, el valor por defecto será:

```text
light
```

Después comprobamos si el valor es distinto de `dark`:

```java
if (!theme.equals("dark")) {
    theme = "light";
}
```

Esto significa:

```text
Solo aceptamos "dark" como valor especial.
Cualquier otro valor se convierte en "light".
```

Luego guardamos la preferencia en sesión:

```java
session.setAttribute("theme", theme);
```

Finalmente redirigimos al inicio:

```java
return "redirect:/home";
```

---

## 24. Crear `styles-dark.css`

Creamos el archivo:

```text
src/main/webapp/resources/css/styles-dark.css
```

### Código de `styles-dark.css`

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

### Explicación

Este archivo no sustituye a `styles.css`.

Primero cargamos el CSS normal:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
```

Después, si el tema activo es oscuro, cargamos este segundo archivo:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
```

Como `styles-dark.css` se carga después, puede sobrescribir los colores definidos en `styles.css`.

---

## 25. Actualizar las JSP para cargar el tema oscuro

En las JSP donde queramos permitir tema oscuro, añadimos esta línea al principio, después de las directivas `taglib`:

```jsp
<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />
```

Esta línea significa:

```text
Si en sesión no hay ningún tema guardado, usa "light".
Si hay un tema guardado, usa ese valor.
```

Después, dentro de `<head>`, añadimos:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

<c:if test="${currentTheme == 'dark'}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
</c:if>
```

Esto significa:

```text
Carga siempre styles.css.
Si el tema actual es dark, carga también styles-dark.css.
```

---

## 26. Actualizar `styles.css` para la barra de herramientas

Añadimos estos estilos al final de:

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

### Explicación

La barra superior ahora tiene dos zonas:

```text
Izquierda: navegación principal
Derecha: idioma y tema
```

Por eso hacemos que `.header` use `display: flex`.

Con:

```css
justify-content: space-between;
```

la navegación queda a la izquierda y la barra de herramientas queda a la derecha.

---

## 27. Flujo completo del cambio de tema

Cuando el usuario pulsa el enlace de tema oscuro:

```text
/theme/change?theme=dark
```

ocurre esto:

```text
1. Spring ejecuta ThemeController.changeTheme().
2. El parámetro theme vale "dark".
3. El controlador guarda theme=dark en la sesión.
4. El controlador redirige a /home.
5. home.jsp lee sessionScope.theme.
6. Como currentTheme es "dark", carga styles-dark.css.
7. La página se muestra con tema oscuro.
```

Cuando el usuario pulsa el enlace de tema claro:

```text
/theme/change?theme=light
```

ocurre esto:

```text
1. Spring ejecuta ThemeController.changeTheme().
2. El valor no es "dark".
3. El controlador guarda theme=light en sesión.
4. La JSP ya no carga styles-dark.css.
5. La página vuelve al estilo claro.
```

---

# Parte 4. Comprobaciones finales

## 28. Comprobar gestión de excepciones

Arranca Tomcat y entra en:

```text
http://localhost:8080/spring-mvc-day1/courses/detail?id=999
```

Resultado esperado:

```text
Debe aparecer una página de error indicando que el curso no existe.
```

Después entra en:

```text
http://localhost:8080/spring-mvc-day1/pagina-inventada
```

Resultado esperado:

```text
Debe aparecer la página 404 personalizada.
```

---

## 29. Comprobar internacionalización

Entra en:

```text
http://localhost:8080/spring-mvc-day1/home?lang=es
```

Resultado esperado:

```text
La aplicación debe mostrarse en español.
```

Entra en:

```text
http://localhost:8080/spring-mvc-day1/home?lang=en
```

Resultado esperado:

```text
La aplicación debe mostrarse en inglés.
```

Después entra en:

```text
http://localhost:8080/spring-mvc-day1/courses
```

Resultado esperado:

```text
El idioma debe mantenerse, porque se ha guardado en sesión.
```

---

## 30. Comprobar temas

Entra en:

```text
http://localhost:8080/spring-mvc-day1/theme/change?theme=dark
```

Resultado esperado:

```text
La aplicación debe mostrarse con tema oscuro.
```

Después entra en:

```text
http://localhost:8080/spring-mvc-day1/theme/change?theme=light
```

Resultado esperado:

```text
La aplicación debe volver al tema claro.
```

---

# Parte 5. Errores habituales

## 31. Error: `GlobalExceptionHandler` no se ejecuta

Comprueba que la clase tiene:

```java
@ControllerAdvice
```

También comprueba que está dentro del paquete que Spring escanea:

```xml
<context:component-scan base-package="com.example.springmvcday1" />
```

Si la clase está fuera de ese paquete, Spring no la detectará.

---

## 32. Error: la excepción no se captura

Comprueba que el tipo de excepción coincide.

Si lanzas:

```java
throw new CourseNotFoundException(id);
```

el manejador debe tener:

```java
@ExceptionHandler(CourseNotFoundException.class)
```

---

## 33. Error: no cambian los textos de idioma

Comprueba que tienes configurado el `messageSource`:

```xml
<bean id="messageSource"
      class="org.springframework.context.support.ResourceBundleMessageSource">
    <property name="basename" value="messages" />
    <property name="defaultEncoding" value="UTF-8" />
</bean>
```

Comprueba también que los archivos están en:

```text
src/main/resources
```

y se llaman exactamente:

```text
messages.properties
messages_es.properties
messages_en.properties
```

---

## 34. Error: `?lang=en` no cambia el idioma

Comprueba que existe el interceptor:

```xml
<mvc:interceptors>
    <bean class="org.springframework.web.servlet.i18n.LocaleChangeInterceptor">
        <property name="paramName" value="lang" />
    </bean>
</mvc:interceptors>
```

Y comprueba que también existe el `localeResolver`:

```xml
<bean id="localeResolver"
      class="org.springframework.web.servlet.i18n.SessionLocaleResolver">
    <property name="defaultLocale" value="es" />
</bean>
```

---

## 35. Error: aparece la clave en lugar del texto

Si en pantalla aparece algo como:

```text
???nav.home???
```

o directamente la clave:

```text
nav.home
```

significa que Spring no encuentra esa clave en los archivos `.properties`.

Comprueba que la clave escrita en la JSP coincide exactamente con la clave del archivo.

JSP:

```jsp
<spring:message code="nav.courses" />
```

Archivo `.properties`:

```properties
nav.courses=Cursos
```

---

## 36. Error: el tema oscuro no se aplica

Comprueba que el archivo existe:

```text
src/main/webapp/resources/css/styles-dark.css
```

Comprueba también que la JSP carga el archivo cuando el tema es `dark`:

```jsp
<c:if test="${currentTheme == 'dark'}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
</c:if>
```

Y comprueba que el controlador guarda el tema en sesión:

```java
session.setAttribute("theme", theme);
```

---

## 37. Error: la barra de idioma y tema se ve mal

Comprueba que has añadido los estilos de `.toolbar` en `styles.css`:

```css
.toolbar {
  display: flex;
  gap: 12px;
  font-size: 14px;
}
```

Y que el `header` usa flex:

```css
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
```

---

# Parte 6. Resumen final

En este tema hemos añadido tres funcionalidades transversales a la aplicación.

## Gestión de excepciones

Hemos creado:

```text
CourseNotFoundException
GlobalExceptionHandler
error/course-not-found.jsp
error/general-error.jsp
error/not-found.jsp
```

La idea principal es:

```text
El servicio puede lanzar excepciones.
El manejador global decide qué vista de error mostrar.
```

---

## Internacionalización

Hemos creado:

```text
messages.properties
messages_es.properties
messages_en.properties
```

Y hemos configurado:

```text
messageSource
localeResolver
LocaleChangeInterceptor
```

La idea principal es:

```text
Las JSP no escriben textos fijos.
Las JSP usan claves.
Spring busca el texto en el idioma activo.
```

---

## Temas locales

Hemos creado:

```text
ThemeController
styles-dark.css
```

Y hemos usado la sesión para guardar la preferencia visual.

La idea principal es:

```text
El usuario elige un tema.
La aplicación guarda el tema en sesión.
La JSP carga el CSS adecuado.
```

---

## Idea final del tema

Spring MVC no solo sirve para crear rutas y vistas.

También permite organizar mejor una aplicación web añadiendo:

```text
Control de errores
Mensajes traducibles
Preferencias del usuario
Vistas más cuidadas
Código más mantenible
```

Al terminar este tema, la aplicación ya tiene una estructura mucho más cercana a una aplicación web real.
