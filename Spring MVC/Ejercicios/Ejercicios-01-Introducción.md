# Exercises Topic 1: Spring MVC architecture and initial configuration

# Exercise 1 - Identify the parts of a Spring MVC application

## Statement

Look at this project structure:

```text
spring-mvc-books
│
├── pom.xml
│
└── src
    └── main
        ├── java
        │   └── com
        │       └── example
        │           └── springmvcbooks
        │               └── controller
        │                   └── WelcomeController.java
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
                    └── welcome.jsp
```

Indicate what function each of these files or folders has:

```text
pom.xml
web.xml
app-servlet.xml
WelcomeController.java
welcome.jsp
resources/css/styles.css
WEB-INF/views
```

<details>
<summary>show solution</summary>

## Solution

```text
pom.xml
```

It is the Maven configuration file. Defines the project name, Java version, application packaging, and required dependencies, such as `spring-webmvc` or `jakarta.servlet-api`.

---

```text
web.xml
```

It is the deployment descriptor of the web application. In it, the `DispatcherServlet` is configured, which will be the main Spring MVC servlet.

---

```text
app-servlet.xml
```

It is the Spring MVC configuration file. Drivers, URL mappings, the `ViewResolver` and static resource configuration can be registered here.

---

```text
WelcomeController.java
```

It's the controller. Its function is to receive a request, prepare the necessary data and return an `ModelAndView` indicating which view should be shown.

---

```text
welcome.jsp
```

It is the JSP view. Receives the data sent by the controller and generates the final HTML that the user will see.

---

```text
resources/css/styles.css
```

It is a static resource. Contains CSS styles to visually format pages.

---

```text
WEB-INF/views
```

It is the folder where we save the JSP views. Being inside `WEB-INF`, the user cannot directly access those files from the browser. They can only be displayed through Spring MVC.

</details>

---

# Exercise 2 - Complete the `pom.xml` of a Spring MVC application

## Statement

We want to create an application called `spring-mvc-library` packaged as `.war` file.

Complete the following `pom.xml` to include:

1. Java version 17 or higher.
2.SpringMVC.
3. Jakarta Servlet API.
4. `war` type packaging.
5. Final file name: `spring-mvc-library`.

Incomplete code:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="
            http://maven.apache.org/POM/4.0.0
            https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>spring-mvc-library</artifactId>
    <version>1.0-SNAPSHOT</version>

    <!-- Completar aquí -->

</project>
```

<details>
<summary>show solution</summary>

## Solution

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="
            http://maven.apache.org/POM/4.0.0
            https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>spring-mvc-library</artifactId>
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

    </dependencies>

    <build>
        <finalName>spring-mvc-library</finalName>

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

## Explanation

The line:

```xml
<packaging>war</packaging>
```

indicates that the project will be packaged as a web application.

The dependency:

```xml
<artifactId>spring-webmvc</artifactId>
```

includes the core Spring MVC classes.

The dependency:

```xml
<artifactId>jakarta.servlet-api</artifactId>
```

allows you to compile classes that use the Servlet API. The `scope` is `provided` because Tomcat already provides that API when running the application.

</details>

---

# Exercise 3 – Set `DispatcherServlet` to `web.xml`

## Statement

Create the `web.xml` file for a Spring MVC application with these conditions:

1. The Spring MVC servlet will be named `library`.
2. The servlet class will be `org.springframework.web.servlet.DispatcherServlet`.
3. The servlet will load its configuration from `/WEB-INF/spring/library-servlet.xml`.
4. The servlet must be loaded when the application starts.
5. All requests must go through the servlet.

<details>
<summary>show solution</summary>

## Solution

```xml
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="
            https://jakarta.ee/xml/ns/jakartaee
            https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">

    <display-name>Spring MVC Library</display-name>

    <servlet>
        <servlet-name>library</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>

        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>/WEB-INF/spring/library-servlet.xml</param-value>
        </init-param>

        <load-on-startup>1</load-on-startup>
    </servlet>

    <servlet-mapping>
        <servlet-name>library</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>

</web-app>
```

## Explanation

This block registers the main Spring MVC servlet:

```xml
<servlet>
    <servlet-name>library</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
</servlet>
```

The parameter:

```xml
<contextConfigLocation>
```

It is not written directly as a tag, but inside `init-param`:
```xml
<init-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>/WEB-INF/spring/library-servlet.xml</param-value>
</init-param>
```

This part indicates where the Spring MVC configuration XML file is.

Finally, the mapping:

```xml
<url-pattern>/</url-pattern>
```

makes requests come in through `DispatcherServlet`.

</details>

---

# Exercise 4 – Create a classic controller with `ModelAndView`

## Statement

Create a driver named `LibraryHomeController` that meets these conditions:

1. It must be in the `com.example.springmvclibrary.controller` package.
2. You must implement Spring MVC's `Controller` interface.
3. It should return the logical view `library-home`.
4. You must send three pieces of information to the view:

```text
pageTitle = Biblioteca Spring MVC
mainMessage = Bienvenido a la biblioteca online.
sectionName = Inicio de la biblioteca
```

<details>
<summary>show solution</summary>

## Solution

```java
package com.example.springmvclibrary.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class LibraryHomeController implements Controller {

    @Override
    public ModelAndView handleRequest(
            HttpServletRequest request,
            HttpServletResponse response) {

        ModelAndView modelAndView = new ModelAndView("library-home");

        modelAndView.addObject("pageTitle", "Biblioteca Spring MVC");
        modelAndView.addObject("mainMessage", "Bienvenido a la biblioteca online.");
        modelAndView.addObject("sectionName", "Inicio de la biblioteca");

        return modelAndView;
    }
}
```

## Explanation

The class implements:

```java
Controller
```

that's why you must override the method:

```java
handleRequest(HttpServletRequest request, HttpServletResponse response)
```

Inside the method we create:

```java
ModelAndView modelAndView = new ModelAndView("library-home");
```

The text `library-home` is the logical name of the view.

If the `ViewResolver` is configured with:

```xml
<property name="prefix" value="/WEB-INF/views/" />
<property name="suffix" value=".jsp" />
```

Spring will look for:

```text
/WEB-INF/views/library-home.jsp
```

Data is sent to the JSP using:

```java
modelAndView.addObject("pageTitle", "Biblioteca Spring MVC");
```

Then, in the JSP we can write:

```jsp
${pageTitle}
```

</details>

---

# Exercise 5 - Configure mappings and views in XML

## Statement

Create the file `library-servlet.xml` so that:

1. Register the `LibraryHomeController` driver as a bean.
2. The `/` URL points to that controller.
3. The URL `/library` also points to that controller.
4. JSP views are inside `/WEB-INF/views/`.
5. The views have extension `.jsp`.
6. Static resources are inside `/resources/`.

<details>
<summary>show solution</summary>

## Solution

```xml
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="
          http://www.springframework.org/schema/beans
          https://www.springframework.org/schema/beans/spring-beans.xsd
          http://www.springframework.org/schema/mvc
          https://www.springframework.org/schema/mvc/spring-mvc.xsd">

    <!-- Controlador registrado manualmente -->
    <bean id="libraryHomeController"
          class="com.example.springmvclibrary.controller.LibraryHomeController" />

    <!-- Mapeo de URLs mediante XML -->
    <bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
        <property name="mappings">
            <props>
                <prop key="/">libraryHomeController</prop>
                <prop key="/library">libraryHomeController</prop>
            </props>
        </property>
    </bean>

    <!-- Resolución de vistas JSP -->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/views/" />
        <property name="suffix" value=".jsp" />
    </bean>

    <!-- Recursos estáticos -->
    <mvc:resources mapping="/resources/**" location="/resources/" />

</beans>
```

## Explanation

First we register the controller:

```xml
<bean id="libraryHomeController"
      class="com.example.springmvclibrary.controller.LibraryHomeController" />
```

Then we associate URLs with that controller:

```xml
<prop key="/">libraryHomeController</prop>
<prop key="/library">libraryHomeController</prop>
```

This means that both `/` and `/library` will run the same driver.

The `ViewResolver` converts a logical name like:

```text
library-home
```

on this actual route:

```text
/WEB-INF/views/library-home.jsp
```

The line:

```xml
<mvc:resources mapping="/resources/**" location="/resources/" />
```

allows you to load CSS, JavaScript or images from the `resources` folder.

</details>

---

# Exercise 6 - Create a JSP view that receives data from the controller

## Statement

Create a view called:

```text
src/main/webapp/WEB-INF/views/library-home.jsp
```

The view must:

1. Use UTF-8 encoding.
2. Display the value of `pageTitle` in the `<title>` and in an `<h1>`.
3. Display the value of `mainMessage` in a paragraph.
4. Display the value of `sectionName` in bold.
5. Load a CSS file from `/resources/css/library.css`.
6. Include a link to `/library` using `pageContext.request.contextPath`.

<details>
<summary>show solution</summary>

## Solution

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/library.css">
</head>
<body>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            ${mainMessage}
        </p>

        <p>
            Sección actual:
            <strong>${sectionName}</strong>
        </p>

        <p>
            <a href="${pageContext.request.contextPath}/library">
                Volver a la página de la biblioteca
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

## Explanation

The line:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
```

causes the page to use UTF-8.

The values:

```jsp
${pageTitle}
${mainMessage}
${sectionName}
```

They come from the controller.

For example, this controller data:

```java
modelAndView.addObject("pageTitle", "Biblioteca Spring MVC");
```

It is displayed in JSP like this:

```jsp
${pageTitle}
```

The CSS path uses:

```jsp
${pageContext.request.contextPath}
```

so that it works even if the application is deployed with another context name.

</details>

---

# Exercise 7 – Create a CSS resource and configure it correctly

## Statement

Create a CSS file called:

```text
src/main/webapp/resources/css/library.css
```

You should apply these styles:

1. The `body` must not have margin.
2. The font must be Arial or sans-serif.
3. The background must be clear.
4. The main card must be centered.
5. The card must have a white background, rounded edges and shadow.
6. The message should have a slightly larger font size.

<details>
<summary>show solution</summary>

## Solution

```css
body {
  margin: 0;
  font-family: Arial, sans-serif;
  background-color: #f3f4f6;
  color: #1f2937;
}

.container {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

.card {
  width: 600px;
  padding: 32px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
}

h1 {
  margin-top: 0;
  color: #111827;
}

.message {
  font-size: 18px;
  margin-bottom: 24px;
}

a {
  color: #2563eb;
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}
```

## Explanation

The file must be in:

```text
src/main/webapp/resources/css/library.css
```

And in the XML this configuration must exist:

```xml
<mvc:resources mapping="/resources/**" location="/resources/" />
```

If that line is missing, the JSP may load, but the CSS may not be applied.

In the JSP we load it with:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/library.css">
```

</details>

---

# Exercise 8 - Explain the complete flow of a request

## Statement

Explain step by step what happens when the user enters this URL:

```text
http://localhost:8080/spring-mvc-library/library
```

Use these elements in your explanation:

```text
Tomcat
DispatcherServlet
library-servlet.xml
SimpleUrlHandlerMapping
LibraryHomeController
ModelAndView
InternalResourceViewResolver
library-home.jsp
HTML final
```

<details>
<summary>show solution</summary>

## Solution

When the user enters:

```text
http://localhost:8080/spring-mvc-library/library
```

this flow occurs:

```text
1. El navegador envía una petición HTTP GET a /spring-mvc-library/library.
```

```text
2. Tomcat recibe la petición.
```

Tomcat checks the `web.xml` of the application and sees that the requests go through the servlet named `library`.

```text
3. La petición entra en DispatcherServlet.
```

The configured servlet is:

```xml
<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
```

```text
4. DispatcherServlet carga la configuración de library-servlet.xml.
```

That setting was indicated in `web.xml`:

```xml
<param-value>/WEB-INF/spring/library-servlet.xml</param-value>
```

```text
5. Spring consulta SimpleUrlHandlerMapping.
```

In `library-servlet.xml` there is this mapping:

```xml
<prop key="/library">libraryHomeController</prop>
```

Therefore, Spring knows to run the handler called `libraryHomeController`.

```text
6. Spring ejecuta LibraryHomeController.
```

The `handleRequest` method creates an `ModelAndView`:

```java
ModelAndView modelAndView = new ModelAndView("library-home");
```

It also adds data to the model:

```java
modelAndView.addObject("pageTitle", "Biblioteca Spring MVC");
modelAndView.addObject("mainMessage", "Bienvenido a la biblioteca online.");
modelAndView.addObject("sectionName", "Inicio de la biblioteca");
```

```text
7. El controlador devuelve el ModelAndView a DispatcherServlet.
```

```text
8. DispatcherServlet usa InternalResourceViewResolver.
```

The `ViewResolver` has this configuration:

```xml
<property name="prefix" value="/WEB-INF/views/" />
<property name="suffix" value=".jsp" />
```

That's why it converts:

```text
library-home
```

in:

```text
/WEB-INF/views/library-home.jsp
```

```text
9. Se procesa la JSP.
```

The JSP uses the data received:

```jsp
${pageTitle}
${mainMessage}
${sectionName}
```

```text
10. Tomcat devuelve el HTML final al navegador.
```

The user does not see the JSP file directly. View the HTML generated from the JSP.

</details>

---

# Exercise 9 - Add a second page with another controller

## Statement

Extend the library application by creating a second page called `/info`.

You must meet these conditions:

1. Create a driver called `LibraryInfoController`.
2. The controller should return the logical view `library-info`.
3. You must send this data to the model:

```text
pageTitle = Información de la biblioteca
mainMessage = Esta biblioteca permite consultar libros y autores.
```

4. Register the driver in `library-servlet.xml`.
5. Map the `/info` URL to that controller.
6. Create the `library-info.jsp` view.

<details>
<summary>show solution</summary>

## Solution

### 1. Create `LibraryInfoController.java`

Route:

```text
src/main/java/com/example/springmvclibrary/controller/LibraryInfoController.java
```

Code:

```java
package com.example.springmvclibrary.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class LibraryInfoController implements Controller {

    @Override
    public ModelAndView handleRequest(
            HttpServletRequest request,
            HttpServletResponse response) {

        ModelAndView modelAndView = new ModelAndView("library-info");

        modelAndView.addObject("pageTitle", "Información de la biblioteca");
        modelAndView.addObject("mainMessage", "Esta biblioteca permite consultar libros y autores.");

        return modelAndView;
    }
}
```

---

### 2. Register the driver in `library-servlet.xml`

We add this bean:

```xml
<bean id="libraryInfoController"
      class="com.example.springmvclibrary.controller.LibraryInfoController" />
```

---

### 3. Add `/info` mapping

Inside `SimpleUrlHandlerMapping`, we add:

```xml
<prop key="/info">libraryInfoController</prop>
```

The complete block of mappings can look like this:

```xml
<bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
    <property name="mappings">
        <props>
            <prop key="/">libraryHomeController</prop>
            <prop key="/library">libraryHomeController</prop>
            <prop key="/info">libraryInfoController</prop>
        </props>
    </property>
</bean>
```

---

### 4. Create `library-info.jsp`

Route:

```text
src/main/webapp/WEB-INF/views/library-info.jsp
```

Code:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/library.css">
</head>
<body>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            ${mainMessage}
        </p>

        <p>
            Esta página es atendida por un controlador diferente al de inicio.
        </p>

        <p>
            <a href="${pageContext.request.contextPath}/library">
                Volver a la biblioteca
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

## Explanation

Now the application has two classic controllers:

```text
/library → LibraryHomeController
/info    → LibraryInfoController
```

Each controller returns a different view:

```text
LibraryHomeController → library-home.jsp
LibraryInfoController → library-info.jsp
```

</details>

---

# Exercise 10 - Correct common configuration errors

## Statement

A student has this configuration in `library-servlet.xml`:

```xml
<bean id="libraryHomeController"
      class="com.example.springmvclibrary.controller.LibraryHomeController" />

<bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
    <property name="mappings">
        <props>
            <prop key="/library">homeController</prop>
        </props>
    </property>
</bean>

<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
    <property name="prefix" value="/WEB-INF/pages/" />
    <property name="suffix" value=".jsp" />
</bean>
```

And your controller returns:
```java
return new ModelAndView("library-home");
```

The JSP is at:

```text
/WEB-INF/views/library-home.jsp
```

Explain what errors there are and correct the configuration.

<details>
<summary>show solution</summary>

## Solution

There are two main errors.

---

## Error 1: Mapping points to a bean that does not exist

In XML it appears:

```xml
<prop key="/library">homeController</prop>
```

But the registered bean is called:

```xml
<bean id="libraryHomeController"
      class="com.example.springmvclibrary.controller.LibraryHomeController" />
```

Therefore, the mapping should point to:

```text
libraryHomeController
```

Not to:

```text
homeController
```

Correction:

```xml
<prop key="/library">libraryHomeController</prop>
```

---

## Error 2: `ViewResolver` looks in the wrong folder

The `ViewResolver` has:

```xml
<property name="prefix" value="/WEB-INF/pages/" />
```

That means Spring will look for:

```text
/WEB-INF/pages/library-home.jsp
```

But the JSP is actually in:

```text
/WEB-INF/views/library-home.jsp
```

Therefore, the correct `prefix` is:

```xml
<property name="prefix" value="/WEB-INF/views/" />
```

---

## Fixed configuration

```xml
<bean id="libraryHomeController"
      class="com.example.springmvclibrary.controller.LibraryHomeController" />

<bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
    <property name="mappings">
        <props>
            <prop key="/library">libraryHomeController</prop>
        </props>
    </property>
</bean>

<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
    <property name="prefix" value="/WEB-INF/views/" />
    <property name="suffix" value=".jsp" />
</bean>
```

## Final explanation

The controller returns:

```java
new ModelAndView("library-home");
```

With this configuration:

```xml
<property name="prefix" value="/WEB-INF/views/" />
<property name="suffix" value=".jsp" />
```

Spring will correctly search for:

```text
/WEB-INF/views/library-home.jsp
```

</details>

---

# Exercise 11 – Create a complete applet from scratch

## Statement

Create a Spring MVC applet called `spring-mvc-events`.

The application will have a single page accessible from:

```text
/
/events
```

The page should display:

```text
Título: Gestión de eventos
Mensaje: Bienvenido al panel de eventos.
Categoría: Eventos académicos
```

You must create:

1. `pom.xml`.
2. `web.xml`.
3. `events-servlet.xml`.
4. `EventsHomeController.java`.
5. `events-home.jsp`.
6. `events.css`.

<details>
<summary>show solution</summary>

## Solution

## 1. `pom.xml`

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="
            http://maven.apache.org/POM/4.0.0
            https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>spring-mvc-events</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>war</packaging>

    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <spring.version>6.2.12</spring.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
            <version>${spring.version}</version>
        </dependency>

        <dependency>
            <groupId>jakarta.servlet</groupId>
            <artifactId>jakarta.servlet-api</artifactId>
            <version>6.0.0</version>
            <scope>provided</scope>
        </dependency>
    </dependencies>

    <build>
        <finalName>spring-mvc-events</finalName>
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

---

## 2. `web.xml`

Route:

```text
src/main/webapp/WEB-INF/web.xml
```

Code:

```xml
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="
            https://jakarta.ee/xml/ns/jakartaee
            https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">

    <display-name>Spring MVC Events</display-name>

    <servlet>
        <servlet-name>events</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>

        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>/WEB-INF/spring/events-servlet.xml</param-value>
        </init-param>

        <load-on-startup>1</load-on-startup>
    </servlet>

    <servlet-mapping>
        <servlet-name>events</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>

</web-app>
```

---

## 3. `events-servlet.xml`

Route:

```text
src/main/webapp/WEB-INF/spring/events-servlet.xml
```

Code:

```xml
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="
          http://www.springframework.org/schema/beans
          https://www.springframework.org/schema/beans/spring-beans.xsd
          http://www.springframework.org/schema/mvc
          https://www.springframework.org/schema/mvc/spring-mvc.xsd">

    <bean id="eventsHomeController"
          class="com.example.springmvcevents.controller.EventsHomeController" />

    <bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
        <property name="mappings">
            <props>
                <prop key="/">eventsHomeController</prop>
                <prop key="/events">eventsHomeController</prop>
            </props>
        </property>
    </bean>

    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/views/" />
        <property name="suffix" value=".jsp" />
    </bean>

    <mvc:resources mapping="/resources/**" location="/resources/" />

</beans>
```

---

## 4. `EventsHomeController.java`

Route:

```text
src/main/java/com/example/springmvcevents/controller/EventsHomeController.java
```

Code:

```java
package com.example.springmvcevents.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class EventsHomeController implements Controller {

    @Override
    public ModelAndView handleRequest(
            HttpServletRequest request,
            HttpServletResponse response) {

        ModelAndView modelAndView = new ModelAndView("events-home");

        modelAndView.addObject("pageTitle", "Gestión de eventos");
        modelAndView.addObject("mainMessage", "Bienvenido al panel de eventos.");
        modelAndView.addObject("category", "Eventos académicos");

        return modelAndView;
    }
}
```

---

## 5. `events-home.jsp`

Route:

```text
src/main/webapp/WEB-INF/views/events-home.jsp
```

Code:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/events.css">
</head>
<body>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            ${mainMessage}
        </p>

        <p>
            Categoría:
            <strong>${category}</strong>
        </p>

        <p>
            <a href="${pageContext.request.contextPath}/events">
                Recargar panel de eventos
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

---

## 6. `events.css`

Route:

```text
src/main/webapp/resources/css/events.css
```

Code:

```css
body {
  margin: 0;
  font-family: Arial, sans-serif;
  background-color: #f3f4f6;
  color: #1f2937;
}

.container {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

.card {
  width: 600px;
  padding: 32px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
}

.message {
  font-size: 18px;
}

a {
  color: #2563eb;
  text-decoration: none;
}
```

---

## Expected result

Upon entering:

```text
http://localhost:8080/spring-mvc-events/events
```

The user should see the event panel home page.

</details>

---

# Exercise 12 - Final diagnosis: find why a 404 appears

## Statement

A Spring MVC application boots correctly in Tomcat, but upon entering:

```text
http://localhost:8080/spring-mvc-events/events
```

a 404 error appears.

The project has these files:

```text
src/main/webapp/WEB-INF/web.xml
src/main/webapp/WEB-INF/spring/events-servlet.xml
src/main/java/com/example/springmvcevents/controller/EventsHomeController.java
src/main/webapp/WEB-INF/views/events-home.jsp
```

The `web.xml` file contains:

```xml
<servlet>
    <servlet-name>event</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>

    <init-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>/WEB-INF/spring/events-servlet.xml</param-value>
    </init-param>

    <load-on-startup>1</load-on-startup>
</servlet>

<servlet-mapping>
    <servlet-name>events</servlet-name>
    <url-pattern>/</url-pattern>
</servlet-mapping>
```

The `events-servlet.xml` file contains:

```xml
<bean id="eventsHomeController"
      class="com.example.springmvcevents.controller.EventsHomeController" />

<bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
    <property name="mappings">
        <props>
            <prop key="/event">eventsHomeController</prop>
        </props>
    </property>
</bean>
```

Detect errors and correct them.

<details>
<summary>show solution</summary>

## Solution

There are two main errors.

---

##Error 1: servlet name does not match

In the servlet declaration it appears:

```xml
<servlet-name>event</servlet-name>
```

But in the mapping it appears:

```xml
<servlet-name>events</servlet-name>
```

They must be called exactly the same.

We can fix it by using `events` in both places:

```xml
<servlet>
    <servlet-name>events</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>

    <init-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>/WEB-INF/spring/events-servlet.xml</param-value>
    </init-param>

    <load-on-startup>1</load-on-startup>
</servlet>

<servlet-mapping>
    <servlet-name>events</servlet-name>
    <url-pattern>/</url-pattern>
</servlet-mapping>
```

---

## Error 2: The configured URL does not match the URL the user visits

The user enters:

```text
/events
```

But in `events-servlet.xml` it is set:

```xml
<prop key="/event">eventsHomeController</prop>
```

The final `s` is missing.

The correction is:

```xml
<prop key="/events">eventsHomeController</prop>
```

We can also add `/` as an alternative route:

```xml
<prop key="/">eventsHomeController</prop>
<prop key="/events">eventsHomeController</prop>
```

---

## Complete corrected mapping configuration

```xml
<bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
    <property name="mappings">
        <props>
            <prop key="/">eventsHomeController</prop>
            <prop key="/events">eventsHomeController</prop>
        </props>
    </property>
</bean>
```

## Conclusion
The 404 error was not due to the JSP being missing. It was due to two configuration problems:

```text
1. El servlet declarado y el servlet mapeado no tenían el mismo nombre.
2. La URL /events no estaba configurada en SimpleUrlHandlerMapping.
```

</details>
