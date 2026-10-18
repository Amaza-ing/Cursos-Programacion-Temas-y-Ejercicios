# Topic 2: Mappings, annotated controllers and views in Spring MVC

## 1. Objectives of the topic

In Topic 1 we created a first Spring MVC application using a classic XML-based setup. We manually register a controller and associate URLs to that controller from the `app-servlet.xml` file.

In this Topic 2 we are going to move towards a more common way of working in Spring MVC: the use of **controllers with annotations**.

By the end of this topic you should be able to:

- Understand the difference between mappings defined in XML and mappings defined with annotations.
- Create drivers using `@Controller`.
- Associate routes to methods using `@GetMapping` and `@RequestMapping`.
- Send data from controller to view using `Model`.
- Create multiple JSP views connected with different routes.
- Display data lists in a JSP using JSTL.
- Read URL parameters using `@RequestParam`.
- Understand the complete flow between browser, controller, model and view.

The main idea of the topic is this:

```text
El usuario escribe una URL.
Spring MVC busca un método de un controlador que atienda esa URL.
El controlador prepara los datos.
Spring MVC busca la vista correspondiente.
La vista genera el HTML que verá el usuario.
```

---

## 2. Starting point

We start from the project created in Topic 1:

```text
spring-mvc-day1
```

In Topic 1 we had a very simple application with:

- An `web.xml` file.
- An `app-servlet.xml` file.
- A classic controller implementing the `Controller` interface.
- A JSP view named `home.jsp`.
- A CSS file.

In this topic we are going to modify and expand that project to have multiple pages.

The final application will have these routes:

| Route | Description |
| ---------------------- | --------------------------------- |
| `/` | Home page |
| `/home` | Home page |
| `/about` | Information page about the course |
| `/courses` | List of courses |
| `/courses/detail?id=1` | Detail of a specific course |

---

## 3. Final project structure

At the end of this topic, the structure of the project will be approximately this:

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

Not all files are completely new. Some, such as `pom.xml`, `app-servlet.xml`, `home.jsp`, and `styles.css`, already existed in Topic 1, but we will modify them now.

---

[![Notes](https://img.youtube.com/vi/xpHJwu2M088/0.jpg)](https://www.youtube.com/watch?v=xpHJwu2M088&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 4. From XML configuration to annotations

In Topic 1 we related a URL to a controller using XML.

For example:

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

That code said that routes `/` and `/home` should be served by the bean named `homeController`.

From now on we will make that association directly in Java:

```java
@GetMapping({"/", "/home"})
public String home(Model model) {
    return "home";
}
```

The main difference is that the URL now appears next to the method being executed. This makes the code easier to read and maintain.

Before we had to look at two places:

```text
XML → para saber qué URL llama al controlador.
Java → para saber qué hace el controlador.
```

Now almost everything remains in the Java class:

```text
Java → URL, método, modelo y vista.
```

---

## 5. Update `pom.xml` file

Since in this topic we are going to display a list of courses in a JSP, it is convenient for us to use JSTL.
JSTL allows us to write useful tags inside JSP. For example, to traverse a list we will use:

```jsp
<c:forEach var="course" items="${courses}">
    ...
</c:forEach>
```

In order to use those tags we need to add the JSTL dependencies to the `pom.xml` file.

### Full code of `pom.xml`

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

### Code explanation

We already had this dependency in Topic 1:

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-webmvc</artifactId>
    <version>${spring.version}</version>
</dependency>
```

It is the main dependency for working with Spring MVC.

We also maintain the dependency on the Servlet API:

```xml
<dependency>
    <groupId>jakarta.servlet</groupId>
    <artifactId>jakarta.servlet-api</artifactId>
    <version>6.0.0</version>
    <scope>provided</scope>
</dependency>
```

We use `scope` with value `provided` because Tomcat already provides this library when you run the application.

The new dependencies are these:

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

The first contains the JSTL API. The second contains the actual implementation.

If we don't add these dependencies and then use a tag like `c:forEach`, the application may fail to render the JSP.

---

## 6. `app-servlet.xml` update

In Topic 1 we registered the controller manually in XML. Now we want Spring to automatically find classes annotated with `@Controller` or `@Service`.

To do this we must activate two things:

1. Annotation-based MVC support.
2. Automatic component scanning.

The file is in:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

### Full code of `app-servlet.xml`

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

### Code explanation

This line is essential:

```xml
<mvc:annotation-driven />
```

Allows Spring MVC to work correctly with annotation-based controllers, for example with methods marked with `@GetMapping`.

We also add:

```xml
<context:component-scan base-package="com.example.springmvcday1" />
```

This tells Spring to look for annotated classes within the package:

```text
com.example.springmvcday1
```

For example, if we have this class:

```java
@Controller
public class HomeController {
    ...
}
```

Spring will detect it automatically.

And if we have this other one:

```java
@Service
public class CourseService {
    ...
}
```

Spring will also detect it automatically.

We no longer need to write this:

```xml
<bean id="homeController"
      class="com.example.springmvcday1.controller.HomeController" />
```

We also don't need to manually write the mappings for each URL in XML. Now the mappings will be in the controller methods themselves.

The `ViewResolver` configuration is maintained:

```xml
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
    <property name="prefix" value="/WEB-INF/views/" />
    <property name="suffix" value=".jsp" />
</bean>
```

This means that when a controller returns:

```java
return "home";
```

Spring will look for this JSP:

```text
/WEB-INF/views/home.jsp
```

And when you return:

```java
return "courses/list";
```

Spring will look for this JSP:

```text
/WEB-INF/views/courses/list.jsp
```

---

[![Models and Services](https://img.youtube.com/vi/t_Li68a1K7E/0.jpg)](https://www.youtube.com/watch?v=t_Li68a1K7E&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 7. Creating the `Course` model

Before creating the courses page, we need a class that represents a course.

We will create it in this route:

```text
src/main/java/com/example/springmvcday1/model/Course.java
```

### Full code of `Course.java`

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

### Code explanation

This class represents a course within our application.

It has four attributes:

```java
private Long id;
private String title;
private String level;
private int durationInHours;
```

Each attribute stores a part of the course information:

| Attribute | Meaning |
| ----------------- | -------------------------- |
| `id` | Unique course identifier |
| `title` | Course title |
| `level` | Course level |
| `durationInHours` | Duration in hours |

The builder allows you to easily create courses:

```java
public Course(Long id, String title, String level, int durationInHours) {
    this.id = id;
    this.title = title;
    this.level = level;
    this.durationInHours = durationInHours;
}
```

For example:
```java
new Course(1L, "Spring MVC desde cero", "Inicial", 20);
```

Create a course with this data:

```text
id: 1
title: Spring MVC desde cero
level: Inicial
durationInHours: 20
```

The `get` methods allow data to be read from other classes and from the JSP.

For example, if in a JSP we have an object called `course`, we can write:

```jsp
${course.title}
```

Internally, JSP will call the method:

```java
getTitle()
```

That is why it is important that the class has public `get` methods.

---

## 8. Creating the `CourseService` service

Now let's create a service class.

A service is a class that contains logic related to data or application operations.

In a real application, this service could query a MySQL database. In this topic we are not going to use a database yet. We will use a fixed list of courses to focus on Spring MVC.

The route will be:

```text
src/main/java/com/example/springmvcday1/service/CourseService.java
```

### Complete code of `CourseService.java`

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

### Code explanation

The class begins with this annotation:

```java
@Service
```

This annotation tells Spring:

```text
Esta clase es un componente de servicio.
Spring debe crear un objeto de esta clase y gestionarlo.
```

As in `app-servlet.xml` we have written:

```xml
<context:component-scan base-package="com.example.springmvcday1" />
```

Spring will automatically find this class.

Then we create a fixed list of courses:

```java
private final List<Course> courses = List.of(
        new Course(1L, "Spring MVC desde cero", "Inicial", 20),
        new Course(2L, "Spring MVC con formularios", "Intermedio", 15),
        new Course(3L, "Spring MVC avanzado", "Avanzado", 25)
);
```

This list simulates application data.

The `findAll()` method returns all courses:

```java
public List<Course> findAll() {
    return courses;
}
```

We will use it to display the list of courses.

The `findById()` method searches for a course by its identifier:

```java
public Course findById(Long id) {
    return courses.stream()
            .filter(course -> course.getId().equals(id))
            .findFirst()
            .orElse(null);
}
```

The idea is:

```text
Recorrer la lista de cursos.
Quedarse con el curso cuyo id coincida.
Devolver el primero que encuentre.
Si no encuentra ninguno, devolver null.
```

Later we will see more complete ways to handle cases where something is not found, especially when we study exception management.

---

## 9. Creating the `HomeController` driver

Now let's modify the main controller to use annotations.

The route will be:

```text
src/main/java/com/example/springmvcday1/controller/HomeController.java
```

### Full code of `HomeController.java`

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

### Code explanation

The class is marked with:

```java
@Controller
```

This indicates that the class is a Spring MVC controller.

Spring will detect this class automatically because we have enabled component scanning in `app-servlet.xml`.

The first method is:

```java
@GetMapping({"/", "/home"})
public String home(Model model) {
    ...
}
```

`@GetMapping` indicates that this method will serve HTTP GET requests.

In this case, the method serves two routes:

```text
/
/home
```

Therefore, these two addresses will show the same view:

```text
http://localhost:8080/spring-mvc-day1/
http://localhost:8080/spring-mvc-day1/home
```

The `Model` parameter is used to send data from the controller to the view:

```java
model.addAttribute("pageTitle", "Bienvenida a Spring MVC");
model.addAttribute("message", "Ahora estamos usando controladores con anotaciones.");
model.addAttribute("courseName", "Curso de Spring MVC - Día 2");
```

Each call to `addAttribute` adds one piece of information to the model.

For example:

```java
model.addAttribute("pageTitle", "Bienvenida a Spring MVC");
```

allows us to write in the JSP:

```jsp
${pageTitle}
```

Finally, the method returns:

```java
return "home";
```

That value is the logical name of the view.

As in `app-servlet.xml` we have:

```xml
<property name="prefix" value="/WEB-INF/views/" />
<property name="suffix" value=".jsp" />
```

Spring will look for:

```text
/WEB-INF/views/home.jsp
```

The second method is:

```java
@GetMapping("/about")
public String about(Model model) {
    model.addAttribute("pageTitle", "Sobre este curso");
    model.addAttribute("description",
            "Este curso introduce el desarrollo de aplicaciones web con Spring MVC paso a paso.");

    return "about";
}
```

This method serves the route:

```text
/about
```

Add the title and a description to the model, and return the view:

```text
about
```

Therefore, Spring will look for:

```text
/WEB-INF/views/about.jsp
```

---

[![Parametric Routes](https://img.youtube.com/vi/ENzHoMrjD8I/0.jpg)](https://www.youtube.com/watch?v=ENzHoMrjD8I&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 10. Creating the `CourseController` driver

Now let's create a second controller for course-related routes.

The route will be:

```text
src/main/java/com/example/springmvcday1/controller/CourseController.java
```

### Full code of `CourseController.java`

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

### Code explanation

The class starts like this:

```java
@Controller
@RequestMapping("/courses")
public class CourseController {
```

`@Controller` marks the class as a webdriver.

`@RequestMapping("/courses")` defines a base path for the entire controller.

This means that all methods in this class start with:

```text
/courses
```

For example, this method:

```java
@GetMapping
public String listCourses(Model model) {
    ...
}
```

responds to:

```text
/courses
```

And this other one:

```java
@GetMapping("/detail")
public String courseDetail(...) {
    ...
}
```

responds to:

```text
/courses/detail
```

---

## 11. Dependency injection in `CourseController`

Inside the controller we have this attribute:

```java
private final CourseService courseService;
```

The driver needs to use `CourseService` to get the courses.

Then the constructor appears:

```java
public CourseController(CourseService courseService) {
    this.courseService = courseService;
}
```

Spring sees that `CourseController` needs an object of type `CourseService`.

Since `CourseService` is annotated with `@Service`, Spring already has an object of that class and automatically passes it to the controller.

This is called **dependency injection**.

The idea is:

```text
Spring crea CourseService.
Spring crea CourseController.
Spring pasa CourseService al constructor de CourseController.
CourseController puede usar CourseService sin hacer new CourseService().
```

Thanks to this we avoid writing code like this:

```java
private CourseService courseService = new CourseService();
```

In Spring applications, we typically let Spring create and connect the main objects of the application.

---

## 12. Method for listing courses

The method that shows the list of courses is this:

```java
@GetMapping
public String listCourses(Model model) {
    model.addAttribute("pageTitle", "Listado de cursos");
    model.addAttribute("courses", courseService.findAll());

    return "courses/list";
}
```

As the class has:

```java
@RequestMapping("/courses")
```

and the method has:

```java
@GetMapping
```

This method responds to:

```text
GET /courses
```

Within the method we add two data to the model:

```java
model.addAttribute("pageTitle", "Listado de cursos");
model.addAttribute("courses", courseService.findAll());
```

The `pageTitle` attribute contains the page title.

The `courses` attribute contains the list of courses.

That list comes from the service:

```java
courseService.findAll()
```

Finally, the method returns:

```java
return "courses/list";
```

That means Spring will look for this view:

```text
/WEB-INF/views/courses/list.jsp
```

---

## 13. Method to view the details of a course

The method that shows a specific course is this:

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

This method responds to URLs like this:

```text
/courses/detail?id=1
```

The part:

```java
@RequestParam("id") Long id
```

He tells Spring:

```text
Busca en la URL un parámetro llamado id.
Convierte ese valor a Long.
Guárdalo en la variable id.
```

For example, if the user enters:

```text
/courses/detail?id=2
```

Spring will assign:

```java
id = 2L;
```

Then we look for the course:

```java
Course course = courseService.findById(id);
```

If the course does not exist, `course` will be `null`.

In that case this block is executed:

```java
if (course == null) {
    model.addAttribute("pageTitle", "Curso no encontrado");
    model.addAttribute("courseId", id);

    return "courses/not-found";
}
```

This sends the handle that was not found to the view and returns the view:

```text
courses/not-found
```

Spring will look for:

```text
/WEB-INF/views/courses/not-found.jsp
```

If the course does exist, this part is executed:

```java
model.addAttribute("pageTitle", course.getTitle());
model.addAttribute("course", course);

return "courses/detail";
```

We send the complete course in sight with the name:

```text
course
```

And we return the view:

```text
courses/detail
```

Spring will look for:

```text
/WEB-INF/views/courses/detail.jsp
```

---

## 14. Update `home.jsp` view

Now we will modify the home view to add navigation to the new pages.

The file path is:

```text
src/main/webapp/WEB-INF/views/home.jsp
```

### Full code of `home.jsp`

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

### Code explanation

The view receives this data from the controller:

```jsp
${pageTitle}
${message}
${courseName}
```

This data was added in the `home()` method:

```java
model.addAttribute("pageTitle", "Bienvenida a Spring MVC");
model.addAttribute("message", "Ahora estamos usando controladores con anotaciones.");
model.addAttribute("courseName", "Curso de Spring MVC - Día 2");
```

We have also added a navigation menu:

```jsp
<nav class="nav">
    <a href="${pageContext.request.contextPath}/home">Inicio</a>
    <a href="${pageContext.request.contextPath}/courses">Cursos</a>
    <a href="${pageContext.request.contextPath}/about">Sobre el curso</a>
</nav>
```

We use:

```jsp
${pageContext.request.contextPath}
```

to construct correct routes regardless of the name with which the application is deployed.

If the application is deployed as:

```text
/spring-mvc-day1
```

the link:

```jsp
${pageContext.request.contextPath}/courses
```

becomes:

```text
/spring-mvc-day1/courses
```

This avoids problems when the application is not deployed directly to the root of the server.

---

## 15. Creating the `about.jsp` view

Now we will create an information page about the course.

The route will be:

```text
src/main/webapp/WEB-INF/views/about.jsp
```

### Complete code of `about.jsp`

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

### Code explanation

This view receives the data from this method:

```java
@GetMapping("/about")
public String about(Model model) {
    model.addAttribute("pageTitle", "Sobre este curso");
    model.addAttribute("description",
            "Este curso introduce el desarrollo de aplicaciones web con Spring MVC paso a paso.");

    return "about";
}
```

The JSP shows:

```jsp
${pageTitle}
```

and:

```jsp
${description}
```

The controller returns:

```java
return "about";
```

Therefore, Spring uses the `ViewResolver` to look up:

```text
/WEB-INF/views/about.jsp
```

---

## 16. Creating the `courses/list.jsp` view

Now we will create the view that shows the list of courses.

The route will be:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

It is important to create the `courses` folder inside `views`.

### Full code of `list.jsp`

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

### Code explanation

The first line configures the JSP page:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
```

The second line activates JSTL:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

This line is necessary to be able to use tags like:

```jsp
<c:forEach>
```

The controller sends two pieces of data to this view:

```java
model.addAttribute("pageTitle", "Listado de cursos");
model.addAttribute("courses", courseService.findAll());
```

In the JSP we use the title like this:

```jsp
<h1>${pageTitle}</h1>
```

The list of courses is traversed with:

```jsp
<c:forEach var="course" items="${courses}">
    ...
</c:forEach>
```

This means:

```text
Recorre todos los elementos de la lista courses.
En cada vuelta, guarda el curso actual en una variable llamada course.
```

Within the loop we can access the properties of each course:

```jsp
${course.title}
${course.level}
${course.durationInHours}
${course.id}
```

For example:

```jsp
<td>${course.title}</td>
```

shows the course title.

The link to the detail is constructed like this:

```jsp
<a href="${pageContext.request.contextPath}/courses/detail?id=${course.id}">
    Ver detalle
</a>
```

If the current course has `id` equal to `1`, the generated URL will be:

```text
/spring-mvc-day1/courses/detail?id=1
```

That URL will be served by this controller method:

```java
@GetMapping("/detail")
public String courseDetail(@RequestParam("id") Long id, Model model) {
    ...
}
```

---

## 17. Creating the `courses/detail.jsp` view

Now we will create the view that shows the information of a specific course.

The route will be:

```text
src/main/webapp/WEB-INF/views/courses/detail.jsp
```

### Full code of `detail.jsp`

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

### Code explanation

This view receives an object called `course`.

The object is added to the model in the controller:

```java
model.addAttribute("course", course);
```

That's why in the JSP we can write:

```jsp
${course.title}
${course.id}
${course.level}
${course.durationInHours}
```

The flow is:

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

## 18. Creating the `courses/not-found.jsp` view

Now we will create a view for the case in which the user tries to view a course that does not exist.

The route will be:

```text
src/main/webapp/WEB-INF/views/courses/not-found.jsp
```

### Complete code of `not-found.jsp`

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

### Code explanation

This view is used when the service does not find any course with the received identifier.

In the controller we had:

```java
if (course == null) {
    model.addAttribute("pageTitle", "Curso no encontrado");
    model.addAttribute("courseId", id);

    return "courses/not-found";
}
```

That's why the JSP can display:

```jsp
${pageTitle}
```

and:

```jsp
${courseId}
```

This solution is simple and manual. Later it can be improved by using exceptions and global error handlers.

---

## 19. Update `styles.css` file

Now we will update the CSS file so that all views have a common look.

The route will be:

```text
src/main/webapp/resources/css/styles.css
```

### Full code of `styles.css`

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

### Code explanation

This file does not contain Spring MVC logic. It is a static resource.

Let's remember that in `app-servlet.xml` we had this line:

```xml
<mvc:resources mapping="/resources/**" location="/resources/" />
```

Thanks to that configuration, the browser can access the CSS using paths like:

```text
/resources/css/styles.css
```

In the JSP we link it like this:
```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
```

The `.header` class styles the top of the page.

```css
.header {
  background-color: #111827;
  padding: 16px 32px;
}
```

The `.nav` class organizes the menu links:

```css
.nav {
  display: flex;
  gap: 20px;
}
```

The `.card` class is used to display the main content as a card:

```css
.card {
  width: 600px;
  padding: 32px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
}
```

The `.table` class is used for course listing.

```css
.table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 24px;
  margin-bottom: 24px;
}
```

---

## 20. `/home` Complete Flow

When the user enters:

```text
http://localhost:8080/spring-mvc-day1/home
```

the following occurs:

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

The responsible method is:

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

## 21. `/courses` Complete Flow

When the user enters:

```text
http://localhost:8080/spring-mvc-day1/courses
```

the following occurs:

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

The responsible method is:

```java
@GetMapping
public String listCourses(Model model) {
    model.addAttribute("pageTitle", "Listado de cursos");
    model.addAttribute("courses", courseService.findAll());

    return "courses/list";
}
```

---

## 22. `/courses/detail?id=1` complete flow

When the user clicks on the `Ver detalle` link, a URL like this is generated:

```text
http://localhost:8080/spring-mvc-day1/courses/detail?id=1
```

Then the following happens:

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

The responsible method is:

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

## 23. Comparison between `ModelAndView` and `Model`

In Topic 1 we use `ModelAndView`:

```java
ModelAndView modelAndView = new ModelAndView("home");

modelAndView.addObject("pageTitle", "Bienvenida a Spring MVC");
modelAndView.addObject("message", "Nuestra primera aplicación Spring MVC funciona correctamente.");

return modelAndView;
```

In this topic we use `Model` and return an `String`:

```java
model.addAttribute("pageTitle", "Bienvenida a Spring MVC");
model.addAttribute("message", "Ahora estamos usando controladores con anotaciones.");

return "home";
```

Both forms are valid.

The difference is that `ModelAndView` joins into a single object:

```text
Datos del modelo + nombre de la vista
```

While with `Model` and `String` we use two separate elements:

```text
Model → contiene los datos.
String → contiene el nombre lógico de la vista.
```

With annotated drivers it is usually more convenient to work with `Model` and return an `String`.

---

## 24. Comparison between XML and annotations

In Topic 1, to associate `/home` with a controller we wrote something like this in XML:

```xml
<prop key="/home">homeController</prop>
```

In Topic 2, to do the same we write this in Java:

```java
@GetMapping("/home")
public String home(Model model) {
    return "home";
}
```

The advantage of the annotated approach is that the path is next to the method being executed.

That makes the code easier to understand:

```java
@GetMapping("/about")
public String about(Model model) {
    return "about";
}
```

Just by looking at this method we already know that:

```text
La URL /about ejecuta este método.
Este método devuelve la vista about.jsp.
```

---

## 25. Summary of main notes

| Annotation | Usage |
| ----------------- | --------------------------------------------------- |
| `@Controller` | Mark a class as a web controller |
| `@Service` | Mark a class as a Spring managed service |
| `@RequestMapping` | Defines a base route or a general route |
| `@GetMapping` | Associate a GET request with a |
| `@RequestParam` | Read a parameter from the URL |

### `@Controller` example

```java
@Controller
public class HomeController {
    ...
}
```

Indicates that the class is a web controller.

### `@Service` example

```java
@Service
public class CourseService {
    ...
}
```

Indicates that the class is a service.

### `@RequestMapping` example

```java
@RequestMapping("/courses")
public class CourseController {
    ...
}
```

Defines a common path for all controller methods.

### `@GetMapping` example

```java
@GetMapping("/about")
public String about(Model model) {
    return "about";
}
```

Indicates that the method responds to a GET request to `/about`.

### `@RequestParam` example

```java
@GetMapping("/detail")
public String courseDetail(@RequestParam("id") Long id, Model model) {
    ...
}
```

Reads the `id` parameter from a URL like this:

```text
/courses/detail?id=1
```

---

## 26. Common mistakes

### Error 1: Forget `<mvc:annotation-driven />`

If this line is missing from `app-servlet.xml`:

```xml
<mvc:annotation-driven />
```

Spring MVC may not process annotated controllers correctly.

It should appear inside `app-servlet.xml`.

---

### Error 2: Forget `<context:component-scan />`

If this line is missing:

```xml
<context:component-scan base-package="com.example.springmvcday1" />
```

Spring will not automatically find drivers annotated with `@Controller` or services annotated with `@Service`.

A common symptom will be receiving a 404 error when entering a route that should exist.

---

### Error 3: Scanning the wrong package

If in `app-servlet.xml` we write:

```xml
<context:component-scan base-package="com.example.otherpackage" />
```

but our classes are in:

```text
com.example.springmvcday1
```

Spring won't find them.

The package indicated in `base-package` must match the actual root package of our application.

---

### Error 4: Returning wrong view name

If the controller returns:

```java
return "course/list";
```

but the real view is in:

```text
/WEB-INF/views/courses/list.jsp
```

Spring will look for:

```text
/WEB-INF/views/course/list.jsp
```

Since that route does not exist, an error will appear.

The correct name would be:

```java
return "courses/list";
```

---

### Error 5: misspelling links in JSPs

If we write a link like this:

```jsp
<a href="/courses">Cursos</a>
```

may fail if the application is deployed with a context like:

```text
/spring-mvc-day1
```

It is better to write:

```jsp
<a href="${pageContext.request.contextPath}/courses">Cursos</a>
```

This way the route is built correctly.

---

### Error 6: Forgetting JSTL dependencies

If we use:

```jsp
<c:forEach>
```

but we have not added the JSTL dependencies in `pom.xml`, the page may crash.

We must have these two dependencies:

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

### Error 7: Forgetting to create `courses` folder

If the controller returns:

```java
return "courses/list";
```

Spring will look for:

```text
/WEB-INF/views/courses/list.jsp
```

Therefore, the folder must exist:

```text
src/main/webapp/WEB-INF/views/courses
```

And inside there should be the file:

```text
list.jsp
```

---

## 27. Final summary of the topic

In this topic we have learned how to build a Spring MVC application using annotated controllers.

We have seen that a Spring MVC application can be organized like this:

```text
Controlador → recibe la petición.
Servicio → proporciona o procesa datos.
Modelo → transporta datos hacia la vista.
Vista JSP → genera el HTML final.
```

The general flow is:

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

We have also seen how to create several routes:

| Route | Responsible method | View |
| ---------------------- | ------------------ | -------------------- |
| `/` | `home()` | `home.jsp` |
| `/home` | `home()` | `home.jsp` |
| `/about` | `about()` | `about.jsp` |
| `/courses` | `listCourses()` | `courses/list.jsp` |
| `/courses/detail?id=1` | `courseDetail()` | `courses/detail.jsp` |

The most important idea is this:

```text
En Spring MVC, una URL no apunta directamente a una JSP.
La URL es recibida por Spring MVC.
Spring ejecuta un controlador.
El controlador prepara datos.
Spring decide qué vista mostrar.
```

In the next topic we will work on form processing, which will allow data to be sent from an HTML page to a controller using GET and POST methods.
