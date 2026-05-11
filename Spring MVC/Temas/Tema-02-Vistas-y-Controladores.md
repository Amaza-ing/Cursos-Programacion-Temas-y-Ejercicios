# Tema 2: Mapeos, controladores con anotaciones y vistas en Spring MVC

## 1. Objetivos del tema

En el Tema 1 creamos una primera aplicación Spring MVC usando una configuración clásica basada en XML. Registramos manualmente un controlador y asociamos URLs a ese controlador desde el archivo `app-servlet.xml`.

En este Tema 2 vamos a avanzar hacia una forma de trabajo más habitual en Spring MVC: el uso de **controladores con anotaciones**.

Al finalizar este tema deberías ser capaz de:

- Entender la diferencia entre los mapeos definidos en XML y los mapeos definidos con anotaciones.
- Crear controladores usando `@Controller`.
- Asociar rutas a métodos usando `@GetMapping` y `@RequestMapping`.
- Enviar datos desde el controlador a la vista usando `Model`.
- Crear varias vistas JSP conectadas con diferentes rutas.
- Mostrar listas de datos en una JSP usando JSTL.
- Leer parámetros de la URL usando `@RequestParam`.
- Comprender el flujo completo entre navegador, controlador, modelo y vista.

La idea principal del tema es esta:

```text
El usuario escribe una URL.
Spring MVC busca un método de un controlador que atienda esa URL.
El controlador prepara los datos.
Spring MVC busca la vista correspondiente.
La vista genera el HTML que verá el usuario.
```

---

## 2. Punto de partida

Partimos del proyecto creado en el Tema 1:

```text
spring-mvc-day1
```

En el Tema 1 teníamos una aplicación muy sencilla con:

- Un archivo `web.xml`.
- Un archivo `app-servlet.xml`.
- Un controlador clásico implementando la interfaz `Controller`.
- Una vista JSP llamada `home.jsp`.
- Un archivo CSS.

En este tema vamos a modificar y ampliar ese proyecto para tener varias páginas.

La aplicación final tendrá estas rutas:

| Ruta                   | Descripción                       |
| ---------------------- | --------------------------------- |
| `/`                    | Página de inicio                  |
| `/home`                | Página de inicio                  |
| `/about`               | Página informativa sobre el curso |
| `/courses`             | Listado de cursos                 |
| `/courses/detail?id=1` | Detalle de un curso concreto      |

---

## 3. Estructura final del proyecto

Al terminar este tema, la estructura del proyecto será aproximadamente esta:

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
                        └── not-found.jsp
```

No todos los archivos son completamente nuevos. Algunos, como `pom.xml`, `app-servlet.xml`, `home.jsp` y `styles.css`, ya existían en el Tema 1, pero ahora los modificaremos.

---

## 4. De la configuración XML a las anotaciones

En el Tema 1 relacionábamos una URL con un controlador usando XML.

Por ejemplo:

```xml
<bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
    <property name="mappings">
        <props>
            <prop key="/">homeController</prop>
            <prop key="/home">homeController</prop>
        </props>
    </property>
</bean>
```

Ese código decía que las rutas `/` y `/home` debían ser atendidas por el bean llamado `homeController`.

A partir de ahora haremos esa asociación directamente en Java:

```java
@GetMapping({"/", "/home"})
public String home(Model model) {
    return "home";
}
```

La diferencia principal es que ahora la URL aparece junto al método que se ejecuta. Esto hace que el código sea más fácil de leer y mantener.

Antes teníamos que mirar dos sitios:

```text
XML → para saber qué URL llama al controlador.
Java → para saber qué hace el controlador.
```

Ahora casi todo queda en la clase Java:

```text
Java → URL, método, modelo y vista.
```

---

## 5. Actualización del archivo `pom.xml`

Como en este tema vamos a mostrar una lista de cursos en una JSP, nos conviene usar JSTL.

JSTL nos permite escribir etiquetas útiles dentro de JSP. Por ejemplo, para recorrer una lista usaremos:

```jsp
<c:forEach var="course" items="${courses}">
    ...
</c:forEach>
```

Para poder usar esas etiquetas necesitamos añadir las dependencias de JSTL al archivo `pom.xml`.

### Código completo de `pom.xml`

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="
            http://maven.apache.org/POM/4.0.0
            https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>spring-mvc-day1</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>war</packaging>

    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <spring.version>6.2.12</spring.version>
    </properties>

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

    </dependencies>

    <build>
        <finalName>spring-mvc-day1</finalName>

        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-war-plugin</artifactId>
                <version>3.4.0</version>
            </plugin>
        </plugins>
    </build>

</project>
```

### Explicación del código

Esta dependencia ya la teníamos en el Tema 1:

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-webmvc</artifactId>
    <version>${spring.version}</version>
</dependency>
```

Es la dependencia principal para trabajar con Spring MVC.

También mantenemos la dependencia de la Servlet API:

```xml
<dependency>
    <groupId>jakarta.servlet</groupId>
    <artifactId>jakarta.servlet-api</artifactId>
    <version>6.0.0</version>
    <scope>provided</scope>
</dependency>
```

Usamos `scope` con valor `provided` porque Tomcat ya proporciona esta librería cuando ejecuta la aplicación.

Las dependencias nuevas son estas:

```xml
<dependency>
    <groupId>jakarta.servlet.jsp.jstl</groupId>
    <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
    <version>3.0.2</version>
</dependency>

<dependency>
    <groupId>org.glassfish.web</groupId>
    <artifactId>jakarta.servlet.jsp.jstl</artifactId>
    <version>3.0.1</version>
</dependency>
```

La primera contiene la API de JSTL. La segunda contiene la implementación real.

Si no añadimos estas dependencias y luego usamos una etiqueta como `c:forEach`, la aplicación puede fallar al renderizar la JSP.

---

## 6. Actualización de `app-servlet.xml`

En el Tema 1 registrábamos el controlador manualmente en XML. Ahora queremos que Spring encuentre automáticamente las clases anotadas con `@Controller` o `@Service`.

Para ello debemos activar dos cosas:

1. El soporte MVC basado en anotaciones.
2. El escaneo automático de componentes.

El archivo está en:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

### Código completo de `app-servlet.xml`

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

    <!-- Activa el soporte de Spring MVC basado en anotaciones -->
    <mvc:annotation-driven />

    <!-- Busca automáticamente controladores, servicios y otros componentes -->
    <context:component-scan base-package="com.example.springmvcday1" />

    <!-- Resolución de vistas JSP -->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/views/" />
        <property name="suffix" value=".jsp" />
    </bean>

    <!-- Recursos estáticos: CSS, JS, imágenes, etc. -->
    <mvc:resources mapping="/resources/**" location="/resources/" />

</beans>
```

### Explicación del código

Esta línea es fundamental:

```xml
<mvc:annotation-driven />
```

Permite que Spring MVC trabaje correctamente con controladores basados en anotaciones, por ejemplo con métodos marcados con `@GetMapping`.

También añadimos:

```xml
<context:component-scan base-package="com.example.springmvcday1" />
```

Esto le indica a Spring que debe buscar clases anotadas dentro del paquete:

```text
com.example.springmvcday1
```

Por ejemplo, si tenemos esta clase:

```java
@Controller
public class HomeController {
    ...
}
```

Spring la detectará automáticamente.

Y si tenemos esta otra:

```java
@Service
public class CourseService {
    ...
}
```

Spring también la detectará automáticamente.

Ya no necesitamos escribir esto:

```xml
<bean id="homeController"
      class="com.example.springmvcday1.controller.HomeController" />
```

Tampoco necesitamos escribir manualmente los mapeos de cada URL en XML. Ahora los mapeos estarán en los propios métodos del controlador.

La configuración del `ViewResolver` se mantiene:

```xml
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
    <property name="prefix" value="/WEB-INF/views/" />
    <property name="suffix" value=".jsp" />
</bean>
```

Esto significa que cuando un controlador devuelva:

```java
return "home";
```

Spring buscará esta JSP:

```text
/WEB-INF/views/home.jsp
```

Y cuando devuelva:

```java
return "courses/list";
```

Spring buscará esta JSP:

```text
/WEB-INF/views/courses/list.jsp
```

---

## 7. Creación del modelo `Course`

Antes de crear la página de cursos, necesitamos una clase que represente un curso.

La crearemos en esta ruta:

```text
src/main/java/com/example/springmvcday1/model/Course.java
```

### Código completo de `Course.java`

```java
package com.example.springmvcday1.model;

public class Course {

    private Long id;
    private String title;
    private String level;
    private int durationInHours;

    public Course(Long id, String title, String level, int durationInHours) {
        this.id = id;
        this.title = title;
        this.level = level;
        this.durationInHours = durationInHours;
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getLevel() {
        return level;
    }

    public int getDurationInHours() {
        return durationInHours;
    }
}
```

### Explicación del código

Esta clase representa un curso dentro de nuestra aplicación.

Tiene cuatro atributos:

```java
private Long id;
private String title;
private String level;
private int durationInHours;
```

Cada atributo guarda una parte de la información del curso:

| Atributo          | Significado                   |
| ----------------- | ----------------------------- |
| `id`              | Identificador único del curso |
| `title`           | Título del curso              |
| `level`           | Nivel del curso               |
| `durationInHours` | Duración en horas             |

El constructor permite crear cursos fácilmente:

```java
public Course(Long id, String title, String level, int durationInHours) {
    this.id = id;
    this.title = title;
    this.level = level;
    this.durationInHours = durationInHours;
}
```

Por ejemplo:

```java
new Course(1L, "Spring MVC desde cero", "Inicial", 20);
```

crea un curso con estos datos:

```text
id: 1
title: Spring MVC desde cero
level: Inicial
durationInHours: 20
```

Los métodos `get` permiten leer los datos desde otras clases y desde la JSP.

Por ejemplo, si en una JSP tenemos un objeto llamado `course`, podemos escribir:

```jsp
${course.title}
```

Internamente, JSP llamará al método:

```java
getTitle()
```

Por eso es importante que la clase tenga métodos `get` públicos.

---

## 8. Creación del servicio `CourseService`

Ahora vamos a crear una clase de servicio.

Un servicio es una clase que contiene lógica relacionada con los datos o con las operaciones de la aplicación.

En una aplicación real, este servicio podría consultar una base de datos MySQL. En este tema todavía no vamos a usar base de datos. Usaremos una lista fija de cursos para centrarnos en Spring MVC.

La ruta será:

```text
src/main/java/com/example/springmvcday1/service/CourseService.java
```

### Código completo de `CourseService.java`

```java
package com.example.springmvcday1.service;

import com.example.springmvcday1.model.Course;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseService {

    private final List<Course> courses = List.of(
            new Course(1L, "Spring MVC desde cero", "Inicial", 20),
            new Course(2L, "Spring MVC con formularios", "Intermedio", 15),
            new Course(3L, "Spring MVC avanzado", "Avanzado", 25)
    );

    public List<Course> findAll() {
        return courses;
    }

    public Course findById(Long id) {
        return courses.stream()
                .filter(course -> course.getId().equals(id))
                .findFirst()
                .orElse(null);
    }
}
```

### Explicación del código

La clase empieza con esta anotación:

```java
@Service
```

Esta anotación le dice a Spring:

```text
Esta clase es un componente de servicio.
Spring debe crear un objeto de esta clase y gestionarlo.
```

Como en `app-servlet.xml` hemos escrito:

```xml
<context:component-scan base-package="com.example.springmvcday1" />
```

Spring encontrará automáticamente esta clase.

Después creamos una lista fija de cursos:

```java
private final List<Course> courses = List.of(
        new Course(1L, "Spring MVC desde cero", "Inicial", 20),
        new Course(2L, "Spring MVC con formularios", "Intermedio", 15),
        new Course(3L, "Spring MVC avanzado", "Avanzado", 25)
);
```

Esta lista simula los datos de la aplicación.

El método `findAll()` devuelve todos los cursos:

```java
public List<Course> findAll() {
    return courses;
}
```

Lo usaremos para mostrar el listado de cursos.

El método `findById()` busca un curso por su identificador:

```java
public Course findById(Long id) {
    return courses.stream()
            .filter(course -> course.getId().equals(id))
            .findFirst()
            .orElse(null);
}
```

La idea es:

```text
Recorrer la lista de cursos.
Quedarse con el curso cuyo id coincida.
Devolver el primero que encuentre.
Si no encuentra ninguno, devolver null.
```

Más adelante veremos formas más completas de gestionar los casos en los que algo no se encuentra, especialmente cuando estudiemos gestión de excepciones.

---

## 9. Creación del controlador `HomeController`

Ahora vamos a modificar el controlador principal para que use anotaciones.

La ruta será:

```text
src/main/java/com/example/springmvcday1/controller/HomeController.java
```

### Código completo de `HomeController.java`

```java
package com.example.springmvcday1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping({"/", "/home"})
    public String home(Model model) {
        model.addAttribute("pageTitle", "Bienvenida a Spring MVC");
        model.addAttribute("message", "Ahora estamos usando controladores con anotaciones.");
        model.addAttribute("courseName", "Curso de Spring MVC - Día 2");

        return "home";
    }

    @GetMapping("/about")
    public String about(Model model) {
        model.addAttribute("pageTitle", "Sobre este curso");
        model.addAttribute("description",
                "Este curso introduce el desarrollo de aplicaciones web con Spring MVC paso a paso.");

        return "about";
    }
}
```

### Explicación del código

La clase está marcada con:

```java
@Controller
```

Esto indica que la clase es un controlador de Spring MVC.

Spring detectará esta clase automáticamente porque hemos activado el escaneo de componentes en `app-servlet.xml`.

El primer método es:

```java
@GetMapping({"/", "/home"})
public String home(Model model) {
    ...
}
```

`@GetMapping` indica que este método atenderá peticiones HTTP de tipo GET.

En este caso, el método atiende dos rutas:

```text
/
/home
```

Por tanto, estas dos direcciones mostrarán la misma vista:

```text
http://localhost:8080/spring-mvc-day1/
http://localhost:8080/spring-mvc-day1/home
```

El parámetro `Model` sirve para enviar datos desde el controlador hasta la vista:

```java
model.addAttribute("pageTitle", "Bienvenida a Spring MVC");
model.addAttribute("message", "Ahora estamos usando controladores con anotaciones.");
model.addAttribute("courseName", "Curso de Spring MVC - Día 2");
```

Cada llamada a `addAttribute` añade un dato al modelo.

Por ejemplo:

```java
model.addAttribute("pageTitle", "Bienvenida a Spring MVC");
```

permite que en la JSP podamos escribir:

```jsp
${pageTitle}
```

Finalmente, el método devuelve:

```java
return "home";
```

Ese valor es el nombre lógico de la vista.

Como en `app-servlet.xml` tenemos:

```xml
<property name="prefix" value="/WEB-INF/views/" />
<property name="suffix" value=".jsp" />
```

Spring buscará:

```text
/WEB-INF/views/home.jsp
```

El segundo método es:

```java
@GetMapping("/about")
public String about(Model model) {
    model.addAttribute("pageTitle", "Sobre este curso");
    model.addAttribute("description",
            "Este curso introduce el desarrollo de aplicaciones web con Spring MVC paso a paso.");

    return "about";
}
```

Este método atiende la ruta:

```text
/about
```

Añade al modelo el título y una descripción, y devuelve la vista:

```text
about
```

Por tanto, Spring buscará:

```text
/WEB-INF/views/about.jsp
```

---

## 10. Creación del controlador `CourseController`

Ahora vamos a crear un segundo controlador para las rutas relacionadas con cursos.

La ruta será:

```text
src/main/java/com/example/springmvcday1/controller/CourseController.java
```

### Código completo de `CourseController.java`

```java
package com.example.springmvcday1.controller;

import com.example.springmvcday1.model.Course;
import com.example.springmvcday1.service.CourseService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
}
```

### Explicación del código

La clase empieza así:

```java
@Controller
@RequestMapping("/courses")
public class CourseController {
```

`@Controller` marca la clase como controlador web.

`@RequestMapping("/courses")` define una ruta base para todo el controlador.

Esto significa que todos los métodos de esta clase empiezan por:

```text
/courses
```

Por ejemplo, este método:

```java
@GetMapping
public String listCourses(Model model) {
    ...
}
```

responde a:

```text
/courses
```

Y este otro:

```java
@GetMapping("/detail")
public String courseDetail(...) {
    ...
}
```

responde a:

```text
/courses/detail
```

---

## 11. Inyección de dependencias en `CourseController`

Dentro del controlador tenemos este atributo:

```java
private final CourseService courseService;
```

El controlador necesita usar `CourseService` para obtener los cursos.

Después aparece el constructor:

```java
public CourseController(CourseService courseService) {
    this.courseService = courseService;
}
```

Spring ve que `CourseController` necesita un objeto de tipo `CourseService`.

Como `CourseService` está anotado con `@Service`, Spring ya tiene un objeto de esa clase y se lo pasa automáticamente al controlador.

Esto se llama **inyección de dependencias**.

La idea es:

```text
Spring crea CourseService.
Spring crea CourseController.
Spring pasa CourseService al constructor de CourseController.
CourseController puede usar CourseService sin hacer new CourseService().
```

Gracias a esto evitamos escribir código como este:

```java
private CourseService courseService = new CourseService();
```

En aplicaciones Spring, normalmente dejamos que Spring cree y conecte los objetos principales de la aplicación.

---

## 12. Método para listar cursos

El método que muestra el listado de cursos es este:

```java
@GetMapping
public String listCourses(Model model) {
    model.addAttribute("pageTitle", "Listado de cursos");
    model.addAttribute("courses", courseService.findAll());

    return "courses/list";
}
```

Como la clase tiene:

```java
@RequestMapping("/courses")
```

y el método tiene:

```java
@GetMapping
```

este método responde a:

```text
GET /courses
```

Dentro del método añadimos dos datos al modelo:

```java
model.addAttribute("pageTitle", "Listado de cursos");
model.addAttribute("courses", courseService.findAll());
```

El atributo `pageTitle` contiene el título de la página.

El atributo `courses` contiene la lista de cursos.

Esa lista viene del servicio:

```java
courseService.findAll()
```

Finalmente, el método devuelve:

```java
return "courses/list";
```

Eso significa que Spring buscará esta vista:

```text
/WEB-INF/views/courses/list.jsp
```

---

## 13. Método para ver el detalle de un curso

El método que muestra un curso concreto es este:

```java
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
```

Este método responde a URLs como esta:

```text
/courses/detail?id=1
```

La parte:

```java
@RequestParam("id") Long id
```

le dice a Spring:

```text
Busca en la URL un parámetro llamado id.
Convierte ese valor a Long.
Guárdalo en la variable id.
```

Por ejemplo, si el usuario entra en:

```text
/courses/detail?id=2
```

Spring asignará:

```java
id = 2L;
```

Después buscamos el curso:

```java
Course course = courseService.findById(id);
```

Si el curso no existe, `course` será `null`.

En ese caso se ejecuta este bloque:

```java
if (course == null) {
    model.addAttribute("pageTitle", "Curso no encontrado");
    model.addAttribute("courseId", id);

    return "courses/not-found";
}
```

Esto envía a la vista el identificador que no se encontró y devuelve la vista:

```text
courses/not-found
```

Spring buscará:

```text
/WEB-INF/views/courses/not-found.jsp
```

Si el curso sí existe, se ejecuta esta parte:

```java
model.addAttribute("pageTitle", course.getTitle());
model.addAttribute("course", course);

return "courses/detail";
```

Enviamos el curso completo a la vista con el nombre:

```text
course
```

Y devolvemos la vista:

```text
courses/detail
```

Spring buscará:

```text
/WEB-INF/views/courses/detail.jsp
```

---

## 14. Actualización de la vista `home.jsp`

Ahora modificaremos la vista de inicio para añadir navegación a las nuevas páginas.

La ruta del archivo es:

```text
src/main/webapp/WEB-INF/views/home.jsp
```

### Código completo de `home.jsp`

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
            ${message}
        </p>

        <p>
            Estás viendo el contenido de:
            <strong>${courseName}</strong>
        </p>

        <hr>

        <p>
            En el Día 1 usamos un controlador clásico configurado manualmente en XML.
        </p>

        <p>
            En el Día 2 estamos usando controladores con anotaciones como
            <code>@Controller</code> y <code>@GetMapping</code>.
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/courses">
                Ver listado de cursos
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación del código

La vista recibe estos datos desde el controlador:

```jsp
${pageTitle}
${message}
${courseName}
```

Esos datos se añadieron en el método `home()`:

```java
model.addAttribute("pageTitle", "Bienvenida a Spring MVC");
model.addAttribute("message", "Ahora estamos usando controladores con anotaciones.");
model.addAttribute("courseName", "Curso de Spring MVC - Día 2");
```

También hemos añadido un menú de navegación:

```jsp
<nav class="nav">
    <a href="${pageContext.request.contextPath}/home">Inicio</a>
    <a href="${pageContext.request.contextPath}/courses">Cursos</a>
    <a href="${pageContext.request.contextPath}/about">Sobre el curso</a>
</nav>
```

Usamos:

```jsp
${pageContext.request.contextPath}
```

para construir rutas correctas independientemente del nombre con el que se despliegue la aplicación.

Si la aplicación está desplegada como:

```text
/spring-mvc-day1
```

el enlace:

```jsp
${pageContext.request.contextPath}/courses
```

se convierte en:

```text
/spring-mvc-day1/courses
```

Esto evita problemas cuando la aplicación no está desplegada directamente en la raíz del servidor.

---

## 15. Creación de la vista `about.jsp`

Ahora crearemos una página informativa sobre el curso.

La ruta será:

```text
src/main/webapp/WEB-INF/views/about.jsp
```

### Código completo de `about.jsp`

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
            ${description}
        </p>

        <p>
            En esta aplicación estamos aprendiendo cómo Spring MVC conecta URLs,
            controladores, modelos y vistas.
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

### Explicación del código

Esta vista recibe los datos desde este método:

```java
@GetMapping("/about")
public String about(Model model) {
    model.addAttribute("pageTitle", "Sobre este curso");
    model.addAttribute("description",
            "Este curso introduce el desarrollo de aplicaciones web con Spring MVC paso a paso.");

    return "about";
}
```

La JSP muestra:

```jsp
${pageTitle}
```

y:

```jsp
${description}
```

El controlador devuelve:

```java
return "about";
```

Por tanto, Spring usa el `ViewResolver` para buscar:

```text
/WEB-INF/views/about.jsp
```

---

## 16. Creación de la vista `courses/list.jsp`

Ahora crearemos la vista que muestra la lista de cursos.

La ruta será:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

Es importante crear la carpeta `courses` dentro de `views`.

### Código completo de `list.jsp`

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
            <a class="button" href="${pageContext.request.contextPath}/home">
                Volver al inicio
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación del código

La primera línea configura la página JSP:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
```

La segunda línea activa JSTL:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

Esta línea es necesaria para poder usar etiquetas como:

```jsp
<c:forEach>
```

El controlador envía a esta vista dos datos:

```java
model.addAttribute("pageTitle", "Listado de cursos");
model.addAttribute("courses", courseService.findAll());
```

En la JSP usamos el título así:

```jsp
<h1>${pageTitle}</h1>
```

La lista de cursos se recorre con:

```jsp
<c:forEach var="course" items="${courses}">
    ...
</c:forEach>
```

Esto significa:

```text
Recorre todos los elementos de la lista courses.
En cada vuelta, guarda el curso actual en una variable llamada course.
```

Dentro del bucle podemos acceder a las propiedades de cada curso:

```jsp
${course.title}
${course.level}
${course.durationInHours}
${course.id}
```

Por ejemplo:

```jsp
<td>${course.title}</td>
```

muestra el título del curso.

El enlace al detalle se construye así:

```jsp
<a href="${pageContext.request.contextPath}/courses/detail?id=${course.id}">
    Ver detalle
</a>
```

Si el curso actual tiene `id` igual a `1`, la URL generada será:

```text
/spring-mvc-day1/courses/detail?id=1
```

Esa URL será atendida por este método del controlador:

```java
@GetMapping("/detail")
public String courseDetail(@RequestParam("id") Long id, Model model) {
    ...
}
```

---

## 17. Creación de la vista `courses/detail.jsp`

Ahora crearemos la vista que muestra la información de un curso concreto.

La ruta será:

```text
src/main/webapp/WEB-INF/views/courses/detail.jsp
```

### Código completo de `detail.jsp`

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
        <h1>${course.title}</h1>

        <p class="message">
            Información detallada del curso seleccionado.
        </p>

        <ul class="details">
            <li>
                <strong>Identificador:</strong> ${course.id}
            </li>
            <li>
                <strong>Nivel:</strong> ${course.level}
            </li>
            <li>
                <strong>Duración:</strong> ${course.durationInHours} horas
            </li>
        </ul>

        <p>
            Esta página recibe un único objeto <code>Course</code> desde el controlador.
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/courses">
                Volver al listado
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación del código

Esta vista recibe un objeto llamado `course`.

El objeto se añade al modelo en el controlador:

```java
model.addAttribute("course", course);
```

Por eso en la JSP podemos escribir:

```jsp
${course.title}
${course.id}
${course.level}
${course.durationInHours}
```

El flujo es:

```text
El usuario entra en /courses/detail?id=1.
Spring ejecuta el método courseDetail().
El controlador lee el id.
El servicio busca el curso.
El controlador añade el curso al Model.
Spring muestra detail.jsp.
La JSP imprime los datos del curso.
```

---

## 18. Creación de la vista `courses/not-found.jsp`

Ahora crearemos una vista para el caso en el que el usuario intente ver un curso que no existe.

La ruta será:

```text
src/main/webapp/WEB-INF/views/courses/not-found.jsp
```

### Código completo de `not-found.jsp`

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
            No se ha encontrado ningún curso con el identificador ${courseId}.
        </p>

        <p>
            En el tema de gestión de excepciones veremos cómo tratar estos casos
            de una forma más completa.
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

### Explicación del código

Esta vista se usa cuando el servicio no encuentra ningún curso con el identificador recibido.

En el controlador teníamos:

```java
if (course == null) {
    model.addAttribute("pageTitle", "Curso no encontrado");
    model.addAttribute("courseId", id);

    return "courses/not-found";
}
```

Por eso la JSP puede mostrar:

```jsp
${pageTitle}
```

y:

```jsp
${courseId}
```

Esta solución es sencilla y manual. Más adelante se puede mejorar usando excepciones y controladores globales de errores.

---

## 19. Actualización del archivo `styles.css`

Ahora actualizaremos el archivo CSS para que todas las vistas tengan un aspecto común.

La ruta será:

```text
src/main/webapp/resources/css/styles.css
```

### Código completo de `styles.css`

```css
body {
  margin: 0;
  font-family: Arial, sans-serif;
  background-color: #f3f4f6;
  color: #1f2937;
}

.header {
  background-color: #111827;
  padding: 16px 32px;
}

.nav {
  display: flex;
  gap: 20px;
}

.nav a {
  color: white;
  text-decoration: none;
  font-weight: bold;
}

.nav a:hover {
  text-decoration: underline;
}

.container {
  min-height: calc(100vh - 64px);
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 32px;
}

.card {
  width: 600px;
  padding: 32px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
}

.card.wide {
  width: 850px;
}

h1 {
  margin-top: 0;
  color: #111827;
}

.message {
  font-size: 18px;
  margin-bottom: 24px;
}

.small {
  font-size: 14px;
  color: #6b7280;
}

.button {
  display: inline-block;
  margin-top: 16px;
  padding: 10px 16px;
  background-color: #2563eb;
  color: white;
  border-radius: 8px;
  text-decoration: none;
}

.button:hover {
  background-color: #1d4ed8;
  text-decoration: none;
}

.table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 24px;
  margin-bottom: 24px;
}

.table th,
.table td {
  border-bottom: 1px solid #e5e7eb;
  padding: 12px;
  text-align: left;
}

.table th {
  background-color: #f9fafb;
}

.details {
  padding-left: 20px;
  line-height: 1.8;
}

a {
  color: #2563eb;
}

code {
  background-color: #f3f4f6;
  padding: 2px 6px;
  border-radius: 4px;
}
```

### Explicación del código

Este archivo no contiene lógica de Spring MVC. Es un recurso estático.

Recordemos que en `app-servlet.xml` teníamos esta línea:

```xml
<mvc:resources mapping="/resources/**" location="/resources/" />
```

Gracias a esa configuración, el navegador puede acceder al CSS usando rutas como:

```text
/resources/css/styles.css
```

En las JSP lo enlazamos así:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
```

La clase `.header` da estilo a la parte superior de la página.

```css
.header {
  background-color: #111827;
  padding: 16px 32px;
}
```

La clase `.nav` organiza los enlaces del menú:

```css
.nav {
  display: flex;
  gap: 20px;
}
```

La clase `.card` se usa para mostrar el contenido principal como una tarjeta:

```css
.card {
  width: 600px;
  padding: 32px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
}
```

La clase `.table` se usa para el listado de cursos.

```css
.table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 24px;
  margin-bottom: 24px;
}
```

---

## 20. Flujo completo de `/home`

Cuando el usuario entra en:

```text
http://localhost:8080/spring-mvc-day1/home
```

ocurre lo siguiente:

```text
1. Tomcat recibe la petición.
2. DispatcherServlet intercepta la petición.
3. Spring busca un método que atienda /home.
4. Encuentra el método home() de HomeController.
5. El método añade datos al Model.
6. El método devuelve "home".
7. ViewResolver convierte "home" en /WEB-INF/views/home.jsp.
8. La JSP genera HTML.
9. El navegador muestra la página.
```

El método responsable es:

```java
@GetMapping({"/", "/home"})
public String home(Model model) {
    model.addAttribute("pageTitle", "Bienvenida a Spring MVC");
    model.addAttribute("message", "Ahora estamos usando controladores con anotaciones.");
    model.addAttribute("courseName", "Curso de Spring MVC - Día 2");

    return "home";
}
```

---

## 21. Flujo completo de `/courses`

Cuando el usuario entra en:

```text
http://localhost:8080/spring-mvc-day1/courses
```

ocurre lo siguiente:

```text
1. Tomcat recibe la petición.
2. DispatcherServlet intercepta la petición.
3. Spring busca un método que atienda /courses.
4. Encuentra el método listCourses() de CourseController.
5. CourseController llama a CourseService.
6. CourseService devuelve la lista de cursos.
7. El controlador añade la lista al Model.
8. El controlador devuelve "courses/list".
9. ViewResolver convierte ese nombre en /WEB-INF/views/courses/list.jsp.
10. La JSP recorre la lista usando c:forEach.
11. El navegador muestra una tabla con los cursos.
```

El método responsable es:

```java
@GetMapping
public String listCourses(Model model) {
    model.addAttribute("pageTitle", "Listado de cursos");
    model.addAttribute("courses", courseService.findAll());

    return "courses/list";
}
```

---

## 22. Flujo completo de `/courses/detail?id=1`

Cuando el usuario pulsa en el enlace `Ver detalle`, se genera una URL como esta:

```text
http://localhost:8080/spring-mvc-day1/courses/detail?id=1
```

Entonces ocurre lo siguiente:

```text
1. Tomcat recibe la petición.
2. DispatcherServlet intercepta la petición.
3. Spring busca un método que atienda /courses/detail.
4. Encuentra el método courseDetail() de CourseController.
5. Spring lee el parámetro id de la URL.
6. Spring convierte el valor "1" a Long.
7. El controlador llama a CourseService.
8. El servicio busca el curso con id 1.
9. El controlador añade el curso al Model.
10. El controlador devuelve "courses/detail".
11. ViewResolver busca /WEB-INF/views/courses/detail.jsp.
12. La JSP muestra los datos del curso.
```

El método responsable es:

```java
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
```

---

## 23. Comparación entre `ModelAndView` y `Model`

En el Tema 1 usamos `ModelAndView`:

```java
ModelAndView modelAndView = new ModelAndView("home");

modelAndView.addObject("pageTitle", "Bienvenida a Spring MVC");
modelAndView.addObject("message", "Nuestra primera aplicación Spring MVC funciona correctamente.");

return modelAndView;
```

En este tema usamos `Model` y devolvemos un `String`:

```java
model.addAttribute("pageTitle", "Bienvenida a Spring MVC");
model.addAttribute("message", "Ahora estamos usando controladores con anotaciones.");

return "home";
```

Las dos formas son válidas.

La diferencia es que `ModelAndView` junta en un solo objeto:

```text
Datos del modelo + nombre de la vista
```

Mientras que con `Model` y `String` usamos dos elementos separados:

```text
Model → contiene los datos.
String → contiene el nombre lógico de la vista.
```

Con controladores anotados suele ser más cómodo trabajar con `Model` y devolver un `String`.

---

## 24. Comparación entre XML y anotaciones

En el Tema 1, para asociar `/home` con un controlador escribíamos algo así en XML:

```xml
<prop key="/home">homeController</prop>
```

En el Tema 2, para hacer lo mismo escribimos esto en Java:

```java
@GetMapping("/home")
public String home(Model model) {
    return "home";
}
```

La ventaja del enfoque con anotaciones es que la ruta está junto al método que se ejecuta.

Eso hace que el código sea más fácil de entender:

```java
@GetMapping("/about")
public String about(Model model) {
    return "about";
}
```

Solo mirando este método ya sabemos que:

```text
La URL /about ejecuta este método.
Este método devuelve la vista about.jsp.
```

---

## 25. Resumen de las anotaciones principales

| Anotación         | Uso                                                 |
| ----------------- | --------------------------------------------------- |
| `@Controller`     | Marca una clase como controlador web                |
| `@Service`        | Marca una clase como servicio gestionado por Spring |
| `@RequestMapping` | Define una ruta base o una ruta general             |
| `@GetMapping`     | Asocia una petición GET con un método               |
| `@RequestParam`   | Lee un parámetro de la URL                          |

### Ejemplo de `@Controller`

```java
@Controller
public class HomeController {
    ...
}
```

Indica que la clase es un controlador web.

### Ejemplo de `@Service`

```java
@Service
public class CourseService {
    ...
}
```

Indica que la clase es un servicio.

### Ejemplo de `@RequestMapping`

```java
@RequestMapping("/courses")
public class CourseController {
    ...
}
```

Define una ruta común para todos los métodos del controlador.

### Ejemplo de `@GetMapping`

```java
@GetMapping("/about")
public String about(Model model) {
    return "about";
}
```

Indica que el método responde a una petición GET a `/about`.

### Ejemplo de `@RequestParam`

```java
@GetMapping("/detail")
public String courseDetail(@RequestParam("id") Long id, Model model) {
    ...
}
```

Lee el parámetro `id` de una URL como esta:

```text
/courses/detail?id=1
```

---

## 26. Errores habituales

### Error 1: olvidar `<mvc:annotation-driven />`

Si falta esta línea en `app-servlet.xml`:

```xml
<mvc:annotation-driven />
```

Spring MVC puede no procesar correctamente los controladores con anotaciones.

Debe aparecer dentro de `app-servlet.xml`.

---

### Error 2: olvidar `<context:component-scan />`

Si falta esta línea:

```xml
<context:component-scan base-package="com.example.springmvcday1" />
```

Spring no encontrará automáticamente los controladores anotados con `@Controller` ni los servicios anotados con `@Service`.

Un síntoma habitual será recibir un error 404 al entrar en una ruta que debería existir.

---

### Error 3: escanear el paquete incorrecto

Si en `app-servlet.xml` escribimos:

```xml
<context:component-scan base-package="com.example.otherpackage" />
```

pero nuestras clases están en:

```text
com.example.springmvcday1
```

Spring no las encontrará.

El paquete indicado en `base-package` debe coincidir con el paquete raíz real de nuestra aplicación.

---

### Error 4: devolver mal el nombre de la vista

Si el controlador devuelve:

```java
return "course/list";
```

pero la vista real está en:

```text
/WEB-INF/views/courses/list.jsp
```

Spring buscará:

```text
/WEB-INF/views/course/list.jsp
```

Como esa ruta no existe, aparecerá un error.

El nombre correcto sería:

```java
return "courses/list";
```

---

### Error 5: escribir mal los enlaces en las JSP

Si escribimos un enlace así:

```jsp
<a href="/courses">Cursos</a>
```

puede fallar si la aplicación está desplegada con un contexto como:

```text
/spring-mvc-day1
```

Es mejor escribir:

```jsp
<a href="${pageContext.request.contextPath}/courses">Cursos</a>
```

Así la ruta se construye correctamente.

---

### Error 6: olvidar las dependencias de JSTL

Si usamos:

```jsp
<c:forEach>
```

pero no hemos añadido las dependencias de JSTL en `pom.xml`, la página puede fallar.

Debemos tener estas dos dependencias:

```xml
<dependency>
    <groupId>jakarta.servlet.jsp.jstl</groupId>
    <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
    <version>3.0.2</version>
</dependency>

<dependency>
    <groupId>org.glassfish.web</groupId>
    <artifactId>jakarta.servlet.jsp.jstl</artifactId>
    <version>3.0.1</version>
</dependency>
```

---

### Error 7: olvidar crear la carpeta `courses`

Si el controlador devuelve:

```java
return "courses/list";
```

Spring buscará:

```text
/WEB-INF/views/courses/list.jsp
```

Por tanto, debe existir la carpeta:

```text
src/main/webapp/WEB-INF/views/courses
```

Y dentro debe estar el archivo:

```text
list.jsp
```

---

## 27. Resumen final del tema

En este tema hemos aprendido a construir una aplicación Spring MVC usando controladores con anotaciones.

Hemos visto que una aplicación Spring MVC puede organizarse así:

```text
Controlador → recibe la petición.
Servicio → proporciona o procesa datos.
Modelo → transporta datos hacia la vista.
Vista JSP → genera el HTML final.
```

El flujo general es:

```text
Navegador
   ↓
DispatcherServlet
   ↓
Método del controlador anotado con @GetMapping
   ↓
Model
   ↓
ViewResolver
   ↓
JSP
   ↓
HTML final
```

También hemos visto cómo crear varias rutas:

| Ruta                   | Método responsable | Vista                |
| ---------------------- | ------------------ | -------------------- |
| `/`                    | `home()`           | `home.jsp`           |
| `/home`                | `home()`           | `home.jsp`           |
| `/about`               | `about()`          | `about.jsp`          |
| `/courses`             | `listCourses()`    | `courses/list.jsp`   |
| `/courses/detail?id=1` | `courseDetail()`   | `courses/detail.jsp` |

La idea más importante es esta:

```text
En Spring MVC, una URL no apunta directamente a una JSP.
La URL es recibida por Spring MVC.
Spring ejecuta un controlador.
El controlador prepara datos.
Spring decide qué vista mostrar.
```

En el siguiente tema se trabajará el procesamiento de formularios, que permitirá enviar datos desde una página HTML hacia un controlador usando métodos GET y POST.
