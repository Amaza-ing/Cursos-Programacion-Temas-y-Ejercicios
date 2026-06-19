# Tema 1 — Arquitectura y configuración inicial de una aplicación Spring MVC

## Curso de Spring MVC — Día 1

Este documento acompaña la explicación teórica del primer día del curso. Está pensado para que puedas tener la teoría a mano mientras creas tu primera aplicación Spring MVC.

En este tema vamos a construir una aplicación web mínima usando:

- Java 17
- Spring MVC
- Maven
- IntelliJ IDEA
- Apache Tomcat 10.1
- JSP
- Configuración XML

> En este primer tema vamos a usar configuración clásica con XML. Más adelante veremos controladores con anotaciones como `@Controller`, `@RequestMapping`, `@GetMapping` y `@PostMapping`.

---

## 1. Objetivo del tema

Al terminar este tema deberías entender:

1. Qué es Spring MVC.
2. Qué papel tiene `DispatcherServlet`.
3. Cómo se estructura una aplicación web con Spring MVC.
4. Para qué sirve el archivo `web.xml`.
5. Para qué sirve el archivo de configuración de Spring MVC.
6. Cómo se conecta una URL con un controlador.
7. Cómo se conecta un controlador con una vista.
8. Cómo se envían datos desde Java hasta una página JSP.
9. Cómo se sirven recursos estáticos como CSS.
10. Cómo ejecutar la aplicación en Tomcat desde IntelliJ.

La aplicación que vamos a crear será muy sencilla: una página de bienvenida generada por Spring MVC.

---

## 2. ¿Qué es Spring MVC?

Spring MVC es el módulo de Spring que permite crear aplicaciones web siguiendo el patrón Modelo-Vista-Controlador.

MVC significa:

| Elemento    | Significado | Responsabilidad                                                  |
| ----------- | ----------- | ---------------------------------------------------------------- |
| Modelo      | Model       | Contiene los datos que queremos mostrar o procesar               |
| Vista       | View        | Es la página que verá el usuario                                 |
| Controlador | Controller  | Recibe la petición, prepara los datos y decide qué vista mostrar |

Por ejemplo, imaginemos que el usuario entra en esta dirección:

```text
http://localhost:8080/spring-mvc-day1/home
```

Spring MVC debe encargarse de responder a varias preguntas:

1. ¿Qué controlador debe atender la URL `/home`?
2. ¿Qué datos necesita la página?
3. ¿Qué vista se debe mostrar?
4. ¿Qué HTML final se devuelve al navegador?

---

[![Cómo empezar con Spring MVC](https://img.youtube.com/vi/1VVP5pDKAiI/0.jpg)](https://www.youtube.com/watch?v=1VVP5pDKAiI&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 3. Arquitectura general de Spring MVC

En una aplicación Spring MVC, el usuario no accede directamente a las páginas JSP.

El flujo habitual es este:

```text
Navegador
   ↓
Petición HTTP
   ↓
DispatcherServlet
   ↓
HandlerMapping
   ↓
Controller
   ↓
ModelAndView
   ↓
ViewResolver
   ↓
Vista JSP
   ↓
Respuesta HTML
```

Vamos a explicar cada parte poco a poco.

---

## 4. El papel de `DispatcherServlet`

`DispatcherServlet` es uno de los elementos más importantes de Spring MVC.

Es un servlet central que recibe las peticiones HTTP y coordina el resto del proceso.

No solemos escribir directamente el código de `DispatcherServlet`. Spring ya lo proporciona. Lo que hacemos es configurarlo.

Cuando llega una petición, `DispatcherServlet` hace algo parecido a esto:

```text
1. Recibe la petición HTTP.
2. Busca qué controlador debe atender esa petición.
3. Ejecuta el controlador.
4. Recibe el resultado del controlador.
5. Busca qué vista debe mostrarse.
6. Envía la respuesta HTML al navegador.
```

Por eso se dice que `DispatcherServlet` actúa como un **front controller**.

Un **front controller** es un punto de entrada centralizado para las peticiones de una aplicación web.

---

## 5. Proyecto que vamos a crear

Vamos a crear un proyecto llamado:

```text
spring-mvc-day1
```

La aplicación tendrá una página de bienvenida accesible desde estas dos rutas:

```text
/
```

y:

```text
/home
```

Cuando el usuario entre en una de esas rutas, Spring ejecutará un controlador y devolverá una vista JSP.

---

## 6. Estructura final del proyecto

La estructura final será esta:

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
        │               └── controller
        │                   └── HomeController.java
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
                    └── home.jsp
```

Vamos a crear estos archivos paso a paso.

---

## 7. Crear el proyecto en IntelliJ

Abre IntelliJ IDEA y crea un nuevo proyecto.

Pasos recomendados:

1. Haz clic en **New Project**.
2. Selecciona **Maven**.
3. Indica estos datos:
   - **GroupId:** `com.example`
   - **ArtifactId:** `spring-mvc-day1`
   - **Version:** `1.0-SNAPSHOT`
4. Selecciona Java 17.
5. Crea el proyecto.

Después, asegúrate de que existe esta estructura básica:

```text
src/main/java
```

Ahora crea manualmente esta carpeta:

```text
src/main/webapp
```

Dentro de `webapp` crearemos los archivos propios de una aplicación web.

---

## 8. Configurar Maven con `pom.xml`

El archivo `pom.xml` sirve para configurar el proyecto Maven.

En él indicamos:

- El nombre del proyecto.
- La versión de Java.
- Las dependencias que vamos a usar.
- El tipo de empaquetado de la aplicación.

Sustituye el contenido de tu `pom.xml` por este código:

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

### Explicación del `pom.xml`

Esta parte identifica el proyecto:

```xml
<groupId>com.example</groupId>
<artifactId>spring-mvc-day1</artifactId>
<version>1.0-SNAPSHOT</version>
```

`groupId` suele representar la organización o paquete base del proyecto.

`artifactId` es el nombre del proyecto.

`version` indica la versión actual del proyecto.

---

Esta línea es muy importante:

```xml
<packaging>war</packaging>
```

Con esto indicamos que queremos crear una aplicación web empaquetada como archivo `.war`.

Un archivo `.war` es el formato habitual de las aplicaciones Java web que se despliegan en servidores como Tomcat.

---

Después indicamos la versión de Java:

```xml
<maven.compiler.source>17</maven.compiler.source>
<maven.compiler.target>17</maven.compiler.target>
```

Estamos usando Java 17 porque Spring Framework 6 requiere Java 17 o superior.

---

Esta propiedad nos permite definir la versión de Spring en un solo lugar:

```xml
<spring.version>6.2.12</spring.version>
```

Así, si más adelante queremos cambiar la versión de Spring, solo tendremos que modificar esta línea.

---

La dependencia principal del proyecto es esta:

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-webmvc</artifactId>
    <version>${spring.version}</version>
</dependency>
```

Esta dependencia incluye las clases necesarias para trabajar con Spring MVC.

Por ejemplo:

- `DispatcherServlet`
- `ModelAndView`
- `ViewResolver`
- Controladores
- Mapeos de URL
- Configuración MVC

---

También añadimos la Servlet API:

```xml
<dependency>
    <groupId>jakarta.servlet</groupId>
    <artifactId>jakarta.servlet-api</artifactId>
    <version>6.0.0</version>
    <scope>provided</scope>
</dependency>
```

Esta dependencia contiene clases necesarias para trabajar con peticiones y respuestas HTTP.

Por ejemplo:

```java
HttpServletRequest
HttpServletResponse
```

Usamos:

```xml
<scope>provided</scope>
```

porque Tomcat ya proporciona esta librería cuando ejecuta la aplicación.

Es decir, necesitamos esta dependencia para compilar el proyecto, pero no hace falta incluirla dentro del `.war`.

---

Por último, configuramos el nombre final del archivo generado:

```xml
<finalName>spring-mvc-day1</finalName>
```

Esto hará que el `.war` generado tenga este nombre:

```text
spring-mvc-day1.war
```

---

[![Webapp](https://img.youtube.com/vi/oy_kIqiITCE/0.jpg)](https://www.youtube.com/watch?v=oy_kIqiITCE&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 9. Crear el archivo `web.xml`

Ahora vamos a configurar la aplicación web.

Crea este archivo:

```text
src/main/webapp/WEB-INF/web.xml
```

Si la carpeta `WEB-INF` no existe, créala manualmente.

El archivo `web.xml` sirve para configurar elementos propios de la aplicación web.

En nuestro caso, lo usaremos para registrar `DispatcherServlet`.

Código completo:

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

</web-app>
```

### Explicación de `web.xml`

Esta primera parte indica que estamos usando una aplicación web basada en Jakarta EE:

```xml
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         ...
         version="6.0">
```

Esto es importante porque Spring 6 usa `jakarta.*` en lugar de `javax.*`.

---

Después damos un nombre descriptivo a la aplicación:

```xml
<display-name>Spring MVC Day 1</display-name>
```

Este nombre no afecta al funcionamiento de la aplicación, pero ayuda a identificarla.

---

La parte más importante es esta:

```xml
<servlet>
    <servlet-name>app</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
</servlet>
```

Aquí estamos registrando un servlet llamado `app`.

Ese servlet será una instancia de:

```text
org.springframework.web.servlet.DispatcherServlet
```

Es decir, le estamos diciendo a Tomcat:

> Esta aplicación usará el servlet central de Spring MVC.

---

Después indicamos dónde está el archivo de configuración de Spring MVC:

```xml
<init-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>/WEB-INF/spring/app-servlet.xml</param-value>
</init-param>
```

Esto significa que, cuando arranque `DispatcherServlet`, deberá cargar su configuración desde:

```text
/WEB-INF/spring/app-servlet.xml
```

Ese archivo todavía no lo hemos creado. Lo crearemos en el siguiente paso.

---

También añadimos:

```xml
<load-on-startup>1</load-on-startup>
```

Esto indica que `DispatcherServlet` se cargará al arrancar la aplicación.

Si no pusiéramos esta línea, podría cargarse cuando llegara la primera petición.

---

Por último, configuramos qué URLs pasarán por `DispatcherServlet`:

```xml
<servlet-mapping>
    <servlet-name>app</servlet-name>
    <url-pattern>/</url-pattern>
</servlet-mapping>
```

Con esto indicamos que las peticiones de la aplicación pasarán por el servlet de Spring MVC.

---

[![Vista y Controlador](https://img.youtube.com/vi/a16QcdaHJFI/0.jpg)](https://www.youtube.com/watch?v=a16QcdaHJFI&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 10. Crear la configuración de Spring MVC con XML

Ahora vamos a crear el archivo que se indicó en `web.xml`.

Crea la carpeta:

```text
src/main/webapp/WEB-INF/spring
```

Dentro de esa carpeta crea el archivo:

```text
app-servlet.xml
```

La ruta completa será:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

Código completo:

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

    <!-- Controlador registrado manualmente como bean -->
    <bean id="homeController"
          class="com.example.springmvcday1.controller.HomeController" />

    <!-- Mapeo de URLs mediante XML -->
    <bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
        <property name="mappings">
            <props>
                <prop key="/">homeController</prop>
                <prop key="/home">homeController</prop>
            </props>
        </property>
    </bean>

    <!-- Resolución de vistas JSP -->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/views/" />
        <property name="suffix" value=".jsp" />
    </bean>

    <!-- Recursos estáticos: CSS, JS, imágenes, etc. -->
    <mvc:resources mapping="/resources/**" location="/resources/" />

</beans>
```

### Explicación de `app-servlet.xml`

Este archivo es la configuración propia de Spring MVC.

Aquí indicamos:

1. Qué controlador vamos a usar.
2. Qué URL ejecutará ese controlador.
3. Dónde están las vistas JSP.
4. Dónde están los recursos estáticos.

---

Primero registramos un controlador como bean de Spring:

```xml
<bean id="homeController"
      class="com.example.springmvcday1.controller.HomeController" />
```

Esto significa:

> Spring debe crear un objeto de la clase `HomeController` y guardarlo con el nombre `homeController`.

Todavía no hemos creado la clase `HomeController`, pero la crearemos en el siguiente paso.

---

Después configuramos los mapeos de URL:

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

Este bloque conecta URLs con controladores.

La configuración dice:

| URL     | Controlador que se ejecuta |
| ------- | -------------------------- |
| `/`     | `homeController`           |
| `/home` | `homeController`           |

Por tanto, estas dos rutas ejecutarán el mismo controlador:

```text
http://localhost:8080/spring-mvc-day1/
```

```text
http://localhost:8080/spring-mvc-day1/home
```

---

Después configuramos el resolvedor de vistas:

```xml
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
    <property name="prefix" value="/WEB-INF/views/" />
    <property name="suffix" value=".jsp" />
</bean>
```

Un `ViewResolver` sirve para convertir un nombre lógico de vista en una ruta real.

Por ejemplo, si un controlador devuelve esta vista:

```java
new ModelAndView("home");
```

Spring aplicará el prefijo y el sufijo configurados:

```text
/WEB-INF/views/ + home + .jsp
```

El resultado será:

```text
/WEB-INF/views/home.jsp
```

Así el controlador no necesita conocer la ruta completa del archivo JSP.

---

Por último, configuramos los recursos estáticos:

```xml
<mvc:resources mapping="/resources/**" location="/resources/" />
```

Esto permite servir archivos como:

- CSS
- JavaScript
- Imágenes

desde esta carpeta:

```text
src/main/webapp/resources
```

Por ejemplo, un archivo ubicado aquí:

```text
src/main/webapp/resources/css/styles.css
```

podrá cargarse desde el navegador usando una URL parecida a esta:

```text
/spring-mvc-day1/resources/css/styles.css
```

---

## 11. Crear el controlador `HomeController`

Ahora vamos a crear el controlador.

Crea el paquete:

```text
src/main/java/com/example/springmvcday1/controller
```

Dentro crea el archivo:

```text
HomeController.java
```

Código completo:

```java
package com.example.springmvcday1.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class HomeController implements Controller {

    @Override
    public ModelAndView handleRequest(
            HttpServletRequest request,
            HttpServletResponse response) {

        ModelAndView modelAndView = new ModelAndView("home");

        modelAndView.addObject("pageTitle", "Bienvenida a Spring MVC");
        modelAndView.addObject("message", "Nuestra primera aplicación Spring MVC funciona correctamente.");
        modelAndView.addObject("courseName", "Curso de Spring MVC - Día 1");

        return modelAndView;
    }
}
```

### Explicación de `HomeController.java`

La primera línea indica el paquete de la clase:

```java
package com.example.springmvcday1.controller;
```

Esto debe coincidir con la carpeta donde hemos creado el archivo.

---

Después importamos clases de Jakarta Servlet:

```java
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
```

`HttpServletRequest` representa la petición HTTP.

`HttpServletResponse` representa la respuesta HTTP.

En este primer ejemplo no las vamos a usar directamente, pero forman parte del método obligatorio del controlador clásico.

---

Después importamos clases de Spring MVC:

```java
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
```

`Controller` es una interfaz clásica de Spring MVC.

`ModelAndView` representa dos cosas a la vez:

1. El modelo, es decir, los datos que queremos enviar a la vista.
2. La vista, es decir, la página que queremos mostrar.

---

La clase implementa la interfaz `Controller`:

```java
public class HomeController implements Controller {
```

Esto significa que `HomeController` será un controlador de Spring MVC.

---

El método principal es este:

```java
@Override
public ModelAndView handleRequest(
        HttpServletRequest request,
        HttpServletResponse response) {
```

Este método se ejecuta cuando una petición llega a este controlador.

En nuestro caso, se ejecutará cuando el usuario entre en:

```text
/
```

o en:

```text
/home
```

porque así lo hemos configurado en `app-servlet.xml`.

---

Dentro del método creamos un objeto `ModelAndView`:

```java
ModelAndView modelAndView = new ModelAndView("home");
```

Aquí estamos diciendo que queremos mostrar la vista llamada:

```text
home
```

No estamos escribiendo directamente:

```text
/WEB-INF/views/home.jsp
```

Solo escribimos el nombre lógico de la vista.

Spring completará la ruta real usando el `ViewResolver`.

---

Después añadimos datos al modelo:

```java
modelAndView.addObject("pageTitle", "Bienvenida a Spring MVC");
modelAndView.addObject("message", "Nuestra primera aplicación Spring MVC funciona correctamente.");
modelAndView.addObject("courseName", "Curso de Spring MVC - Día 1");
```

Cada llamada a `addObject` añade un dato que luego podrá usarse en la vista JSP.

Por ejemplo, este dato:

```java
modelAndView.addObject("pageTitle", "Bienvenida a Spring MVC");
```

podrá mostrarse en JSP así:

```jsp
${pageTitle}
```

---

Finalmente devolvemos el objeto:

```java
return modelAndView;
```

Con esto el controlador le dice a Spring MVC:

> Muestra la vista `home` y envíale estos datos.

---

## 12. Crear la vista JSP

Ahora vamos a crear la vista.

Crea la carpeta:

```text
src/main/webapp/WEB-INF/views
```

Dentro crea el archivo:

```text
home.jsp
```

La ruta completa será:

```text
src/main/webapp/WEB-INF/views/home.jsp
```

Código completo:

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
                Esta página no se ha abierto directamente.
                Ha sido devuelta por un controlador de Spring MVC.
            </p>

            <p class="small">
                URL alternativa:
                <a href="${pageContext.request.contextPath}/home">/home</a>
            </p>
        </section>
    </main>

</body>
</html>
```

### Explicación de `home.jsp`

Esta primera línea configura la página JSP:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
```

Sirve para indicar que la página usará codificación UTF-8.

Esto es importante para que se vean correctamente las tildes, eñes y otros caracteres especiales.

---

Esta línea muestra el título que viene del controlador:

```jsp
<title>${pageTitle}</title>
```

El valor de `pageTitle` fue añadido en Java:

```java
modelAndView.addObject("pageTitle", "Bienvenida a Spring MVC");
```

---

También usamos:

```jsp
${message}
```

Ese dato viene de esta línea del controlador:

```java
modelAndView.addObject("message", "Nuestra primera aplicación Spring MVC funciona correctamente.");
```

---

Y usamos:

```jsp
${courseName}
```

Ese dato viene de:

```java
modelAndView.addObject("courseName", "Curso de Spring MVC - Día 1");
```

---

La línea del CSS es esta:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
```

Aquí usamos:

```jsp
${pageContext.request.contextPath}
```

para obtener automáticamente el contexto de la aplicación.

Si la aplicación se ejecuta en:

```text
http://localhost:8080/spring-mvc-day1
```

entonces:

```jsp
${pageContext.request.contextPath}
```

vale:

```text
/spring-mvc-day1
```

Así evitamos escribir rutas fijas.

La ruta final del CSS será:

```text
/spring-mvc-day1/resources/css/styles.css
```

---

## 13. ¿Por qué ponemos las vistas dentro de `WEB-INF`?

Las vistas JSP están dentro de:

```text
src/main/webapp/WEB-INF/views
```

Esto es intencionado.

Los archivos dentro de `WEB-INF` no se pueden abrir directamente desde el navegador.

Esto significa que el usuario no puede entrar directamente en:

```text
http://localhost:8080/spring-mvc-day1/WEB-INF/views/home.jsp
```

En su lugar, debe entrar en:

```text
http://localhost:8080/spring-mvc-day1/home
```

Así conseguimos que las vistas siempre pasen por un controlador.

Esto es importante porque el controlador es quien prepara los datos que necesita la vista.

---

## 14. Crear el archivo CSS

Ahora vamos a crear un recurso estático.

Crea la carpeta:

```text
src/main/webapp/resources/css
```

Dentro crea el archivo:

```text
styles.css
```

La ruta completa será:

```text
src/main/webapp/resources/css/styles.css
```

Código completo:

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

.small {
  font-size: 14px;
  color: #6b7280;
}

a {
  color: #2563eb;
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}
```

### Explicación de `styles.css`

Este archivo no contiene código de Spring.

Es un archivo CSS normal.

Lo importante es que está dentro de:

```text
src/main/webapp/resources
```

Y en `app-servlet.xml` hemos configurado:

```xml
<mvc:resources mapping="/resources/**" location="/resources/" />
```

Gracias a esa configuración, Spring MVC permite que el navegador cargue este archivo.

---

## 15. Flujo completo de la aplicación

Ahora que tenemos todos los archivos, vamos a repasar qué ocurre cuando el usuario entra en:

```text
http://localhost:8080/spring-mvc-day1/home
```

### Paso 1: el navegador envía una petición

El navegador solicita esta URL:

```text
GET /spring-mvc-day1/home
```

---

### Paso 2: Tomcat recibe la petición

Tomcat detecta que la petición pertenece a la aplicación:

```text
spring-mvc-day1
```

---

### Paso 3: la petición entra en `DispatcherServlet`

En `web.xml` tenemos esta configuración:

```xml
<servlet-mapping>
    <servlet-name>app</servlet-name>
    <url-pattern>/</url-pattern>
</servlet-mapping>
```

Eso hace que la petición pase por `DispatcherServlet`.

---

### Paso 4: Spring busca qué controlador debe ejecutar

En `app-servlet.xml` tenemos este mapeo:

```xml
<prop key="/home">homeController</prop>
```

Por tanto, Spring sabe que debe ejecutar:

```text
homeController
```

---

### Paso 5: se ejecuta `HomeController`

Spring llama al método:

```java
handleRequest(request, response)
```

Dentro de ese método se crea:

```java
ModelAndView modelAndView = new ModelAndView("home");
```

Y se añaden datos al modelo:

```java
modelAndView.addObject("pageTitle", "Bienvenida a Spring MVC");
modelAndView.addObject("message", "Nuestra primera aplicación Spring MVC funciona correctamente.");
modelAndView.addObject("courseName", "Curso de Spring MVC - Día 1");
```

---

### Paso 6: el controlador devuelve un `ModelAndView`

El controlador devuelve:

```java
return modelAndView;
```

Ese objeto contiene:

- El nombre lógico de la vista: `home`
- Los datos que la vista podrá mostrar

---

### Paso 7: Spring resuelve la vista

En `app-servlet.xml` tenemos:

```xml
<property name="prefix" value="/WEB-INF/views/" />
<property name="suffix" value=".jsp" />
```

Spring convierte:

```text
home
```

en:

```text
/WEB-INF/views/home.jsp
```

---

### Paso 8: se procesa la JSP

La JSP recibe los datos del modelo y genera HTML.

Por ejemplo:

```jsp
${pageTitle}
```

se transforma en:

```text
Bienvenida a Spring MVC
```

---

### Paso 9: Tomcat devuelve HTML al navegador

El usuario finalmente ve una página HTML.

Lo importante es que el usuario no ha abierto directamente `home.jsp`.

El usuario ha entrado en una URL, Spring MVC ha ejecutado un controlador y después ha mostrado una vista.

---

## 16. Ejecutar la aplicación en IntelliJ con Tomcat

Para ejecutar la aplicación necesitas tener configurado Apache Tomcat 10.1.

Pasos generales:

1. Abre IntelliJ IDEA.
2. Ve a **Run > Edit Configurations**.
3. Pulsa el botón `+`.
4. Selecciona **Tomcat Server > Local**.
5. Indica la ruta donde tienes instalado Tomcat.
6. En la pestaña **Deployment**, añade el artefacto:
   ```text
   spring-mvc-day1:war exploded
   ```
7. Configura el contexto de aplicación como:
   ```text
   /spring-mvc-day1
   ```
8. Guarda la configuración.
9. Ejecuta Tomcat desde IntelliJ.

Cuando el servidor arranque, abre en el navegador:

```text
http://localhost:8080/spring-mvc-day1/
```

o:

```text
http://localhost:8080/spring-mvc-day1/home
```

Deberías ver la página de bienvenida.

---

## 17. Comprobación rápida de archivos

Antes de ejecutar, revisa que tienes estos archivos en estas rutas exactas:

```text
pom.xml
```

```text
src/main/webapp/WEB-INF/web.xml
```

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

```text
src/main/java/com/example/springmvcday1/controller/HomeController.java
```

```text
src/main/webapp/WEB-INF/views/home.jsp
```

```text
src/main/webapp/resources/css/styles.css
```

Si una ruta está mal escrita, la aplicación puede compilar pero no funcionar correctamente.

---

## 18. Errores habituales y soluciones

### Error 1: usar Tomcat 9 con Spring 6

Spring 6 utiliza Jakarta EE y paquetes `jakarta.*`.

Tomcat 9 trabaja con Java EE antiguo y paquetes `javax.*`.

Por eso, para este proyecto debes usar Tomcat 10 o superior.

---

### Error 2: importar `javax.servlet`

Incorrecto para este proyecto:

```java
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
```

Correcto:

```java
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
```

---

### Error 3: la vista no aparece

Si ves un error 404, revisa que la JSP esté exactamente aquí:

```text
src/main/webapp/WEB-INF/views/home.jsp
```

También revisa que el controlador devuelve:

```java
new ModelAndView("home");
```

Si el controlador devuelve `"home"`, Spring buscará:

```text
/WEB-INF/views/home.jsp
```

---

### Error 4: el CSS no se carga

Revisa que el archivo esté aquí:

```text
src/main/webapp/resources/css/styles.css
```

También revisa que en `app-servlet.xml` exista esta línea:

```xml
<mvc:resources mapping="/resources/**" location="/resources/" />
```

Y que en la JSP esté escrito:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
```

---

### Error 5: el controlador no se encuentra

Revisa que la clase esté en este paquete:

```java
package com.example.springmvcday1.controller;
```

Y que en el XML aparezca la ruta completa correcta:

```xml
<bean id="homeController"
      class="com.example.springmvcday1.controller.HomeController" />
```

Si el paquete o el nombre de la clase no coinciden, Spring no podrá crear el bean.

---

### Error 6: el contexto de la aplicación no coincide

Si en IntelliJ configuras el contexto como:

```text
/spring-mvc-day1
```

debes entrar en:

```text
http://localhost:8080/spring-mvc-day1/home
```

Si entras solo en:

```text
http://localhost:8080/home
```

no funcionará, porque falta el contexto de la aplicación.

---

## 19. Resumen del tema

En este primer tema hemos creado una aplicación mínima de Spring MVC.

Los archivos principales han sido:

| Archivo               | Función                                            |
| --------------------- | -------------------------------------------------- |
| `pom.xml`             | Configura Maven, dependencias y empaquetado `.war` |
| `web.xml`             | Registra `DispatcherServlet`                       |
| `app-servlet.xml`     | Configura Spring MVC                               |
| `HomeController.java` | Atiende la petición y prepara los datos            |
| `home.jsp`            | Muestra la vista al usuario                        |
| `styles.css`          | Añade estilos a la página                          |

La idea principal es esta:

```text
El usuario no abre una JSP directamente.
El usuario entra en una URL.
Spring MVC recibe esa URL.
Spring ejecuta un controlador.
El controlador prepara datos.
Spring busca una vista.
La vista genera HTML.
El navegador muestra la respuesta.
```

---

## 20. Qué veremos en el siguiente tema

En el siguiente tema seguiremos trabajando con Spring MVC, pero empezaremos a usar controladores con anotaciones.

Pasaremos de esta forma clásica:

```java
public class HomeController implements Controller {
```

a una forma más habitual en proyectos modernos:

```java
@Controller
public class HomeController {
}
```

También veremos anotaciones como:

```java
@RequestMapping
@GetMapping
@PostMapping
```

y aprenderemos a crear varias rutas y varias vistas dentro de la misma aplicación.

---

## 21. Referencias oficiales recomendadas

Puedes consultar la documentación oficial de Spring para ampliar este tema:

- Spring Web MVC: https://docs.spring.io/spring-framework/reference/web/webmvc.html
- `DispatcherServlet`: https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-servlet.html
- Resolución de vistas: https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-servlet/viewresolver.html
- Recursos estáticos en Spring MVC: https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-config/static-resources.html
- Requisitos de Spring Framework 6: https://docs.spring.io/spring-framework/reference/overview.html
