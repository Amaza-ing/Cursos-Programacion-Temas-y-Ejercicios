# Ejercicios Tema 1: Arquitectura y configuración inicial de Spring MVC

# Ejercicio 1 - Identificar las partes de una aplicación Spring MVC

## Enunciado

Observa esta estructura de proyecto:

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

Indica qué función tiene cada uno de estos archivos o carpetas:

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
<summary>mostrar solución</summary>

## Solución

```text
pom.xml
```

Es el archivo de configuración de Maven. Define el nombre del proyecto, la versión de Java, el empaquetado de la aplicación y las dependencias necesarias, como `spring-webmvc` o `jakarta.servlet-api`.

---

```text
web.xml
```

Es el descriptor de despliegue de la aplicación web. En él se configura el `DispatcherServlet`, que será el servlet principal de Spring MVC.

---

```text
app-servlet.xml
```

Es el archivo de configuración de Spring MVC. Aquí se pueden registrar controladores, mapeos de URL, el `ViewResolver` y la configuración de recursos estáticos.

---

```text
WelcomeController.java
```

Es el controlador. Su función es recibir una petición, preparar los datos necesarios y devolver un `ModelAndView` indicando qué vista debe mostrarse.

---

```text
welcome.jsp
```

Es la vista JSP. Recibe los datos enviados por el controlador y genera el HTML final que verá el usuario.

---

```text
resources/css/styles.css
```

Es un recurso estático. Contiene estilos CSS para dar formato visual a las páginas.

---

```text
WEB-INF/views
```

Es la carpeta donde guardamos las vistas JSP. Al estar dentro de `WEB-INF`, el usuario no puede acceder directamente a esos archivos desde el navegador. Solo pueden mostrarse a través de Spring MVC.

</details>

---

# Ejercicio 2 - Completar el `pom.xml` de una aplicación Spring MVC

## Enunciado

Queremos crear una aplicación llamada `spring-mvc-library` empaquetada como archivo `.war`.

Completa el siguiente `pom.xml` para que incluya:

1. Java versión 17 o superior.
2. Spring MVC.
3. Servlet API de Jakarta.
4. Empaquetado tipo `war`.
5. Nombre final del archivo: `spring-mvc-library`.

Código incompleto:

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
<summary>mostrar solución</summary>

## Solución

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

## Explicación

La línea:

```xml
<packaging>war</packaging>
```

indica que el proyecto se empaquetará como aplicación web.

La dependencia:

```xml
<artifactId>spring-webmvc</artifactId>
```

incluye las clases principales de Spring MVC.

La dependencia:

```xml
<artifactId>jakarta.servlet-api</artifactId>
```

permite compilar clases que usan la Servlet API. El `scope` es `provided` porque Tomcat ya proporciona esa API al ejecutar la aplicación.

</details>

---

# Ejercicio 3 - Configurar `DispatcherServlet` en `web.xml`

## Enunciado

Crea el archivo `web.xml` para una aplicación Spring MVC con estas condiciones:

1. El servlet de Spring MVC se llamará `library`.
2. La clase del servlet será `org.springframework.web.servlet.DispatcherServlet`.
3. El servlet cargará su configuración desde `/WEB-INF/spring/library-servlet.xml`.
4. El servlet debe cargarse al arrancar la aplicación.
5. Todas las peticiones deben pasar por el servlet.

<details>
<summary>mostrar solución</summary>

## Solución

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

## Explicación

Este bloque registra el servlet principal de Spring MVC:

```xml
<servlet>
    <servlet-name>library</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
</servlet>
```

El parámetro:

```xml
<contextConfigLocation>
```

no se escribe directamente como etiqueta, sino dentro de `init-param`:

```xml
<init-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>/WEB-INF/spring/library-servlet.xml</param-value>
</init-param>
```

Esta parte indica dónde está el archivo XML de configuración de Spring MVC.

Finalmente, el mapeo:

```xml
<url-pattern>/</url-pattern>
```

hace que las peticiones entren por `DispatcherServlet`.

</details>

---

# Ejercicio 4 - Crear un controlador clásico con `ModelAndView`

## Enunciado

Crea un controlador llamado `LibraryHomeController` que cumpla estas condiciones:

1. Debe estar en el paquete `com.example.springmvclibrary.controller`.
2. Debe implementar la interfaz `Controller` de Spring MVC.
3. Debe devolver la vista lógica `library-home`.
4. Debe enviar a la vista tres datos:

```text
pageTitle = Biblioteca Spring MVC
mainMessage = Bienvenido a la biblioteca online.
sectionName = Inicio de la biblioteca
```

<details>
<summary>mostrar solución</summary>

## Solución

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

## Explicación

La clase implementa:

```java
Controller
```

por eso debe sobrescribir el método:

```java
handleRequest(HttpServletRequest request, HttpServletResponse response)
```

Dentro del método creamos:

```java
ModelAndView modelAndView = new ModelAndView("library-home");
```

El texto `library-home` es el nombre lógico de la vista.

Si el `ViewResolver` está configurado con:

```xml
<property name="prefix" value="/WEB-INF/views/" />
<property name="suffix" value=".jsp" />
```

Spring buscará:

```text
/WEB-INF/views/library-home.jsp
```

Los datos se envían a la JSP mediante:

```java
modelAndView.addObject("pageTitle", "Biblioteca Spring MVC");
```

Después, en la JSP podremos escribir:

```jsp
${pageTitle}
```

</details>

---

# Ejercicio 5 - Configurar mapeos y vistas en XML

## Enunciado

Crea el archivo `library-servlet.xml` para que:

1. Registre como bean el controlador `LibraryHomeController`.
2. La URL `/` apunte a ese controlador.
3. La URL `/library` también apunte a ese controlador.
4. Las vistas JSP estén dentro de `/WEB-INF/views/`.
5. Las vistas tengan extensión `.jsp`.
6. Los recursos estáticos estén dentro de `/resources/`.

<details>
<summary>mostrar solución</summary>

## Solución

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

## Explicación

Primero registramos el controlador:

```xml
<bean id="libraryHomeController"
      class="com.example.springmvclibrary.controller.LibraryHomeController" />
```

Después asociamos URLs con ese controlador:

```xml
<prop key="/">libraryHomeController</prop>
<prop key="/library">libraryHomeController</prop>
```

Esto significa que tanto `/` como `/library` ejecutarán el mismo controlador.

El `ViewResolver` convierte un nombre lógico como:

```text
library-home
```

en esta ruta real:

```text
/WEB-INF/views/library-home.jsp
```

La línea:

```xml
<mvc:resources mapping="/resources/**" location="/resources/" />
```

permite cargar CSS, JavaScript o imágenes desde la carpeta `resources`.

</details>

---

# Ejercicio 6 - Crear una vista JSP que reciba datos del controlador

## Enunciado

Crea una vista llamada:

```text
src/main/webapp/WEB-INF/views/library-home.jsp
```

La vista debe:

1. Usar codificación UTF-8.
2. Mostrar el valor de `pageTitle` en el `<title>` y en un `<h1>`.
3. Mostrar el valor de `mainMessage` en un párrafo.
4. Mostrar el valor de `sectionName` en negrita.
5. Cargar un archivo CSS desde `/resources/css/library.css`.
6. Incluir un enlace a `/library` usando `pageContext.request.contextPath`.

<details>
<summary>mostrar solución</summary>

## Solución

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

## Explicación

La línea:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
```

hace que la página use UTF-8.

Los valores:

```jsp
${pageTitle}
${mainMessage}
${sectionName}
```

vienen del controlador.

Por ejemplo, este dato del controlador:

```java
modelAndView.addObject("pageTitle", "Biblioteca Spring MVC");
```

se muestra en JSP así:

```jsp
${pageTitle}
```

La ruta del CSS usa:

```jsp
${pageContext.request.contextPath}
```

para que funcione aunque la aplicación se despliegue con otro nombre de contexto.

</details>

---

# Ejercicio 7 - Crear un recurso CSS y configurarlo correctamente

## Enunciado

Crea un archivo CSS llamado:

```text
src/main/webapp/resources/css/library.css
```

Debe aplicar estos estilos:

1. El `body` no debe tener margen.
2. La fuente debe ser Arial o sans-serif.
3. El fondo debe ser claro.
4. La tarjeta principal debe estar centrada.
5. La tarjeta debe tener fondo blanco, bordes redondeados y sombra.
6. El mensaje debe tener un tamaño de fuente algo mayor.

<details>
<summary>mostrar solución</summary>

## Solución

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

## Explicación

El archivo debe estar en:

```text
src/main/webapp/resources/css/library.css
```

Y en el XML debe existir esta configuración:

```xml
<mvc:resources mapping="/resources/**" location="/resources/" />
```

Si falta esa línea, puede que la JSP cargue, pero el CSS no se aplique.

En la JSP lo cargamos con:

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/library.css">
```

</details>

---

# Ejercicio 8 - Explicar el flujo completo de una petición

## Enunciado

Explica paso a paso qué ocurre cuando el usuario entra en esta URL:

```text
http://localhost:8080/spring-mvc-library/library
```

Usa estos elementos en tu explicación:

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
<summary>mostrar solución</summary>

## Solución

Cuando el usuario entra en:

```text
http://localhost:8080/spring-mvc-library/library
```

ocurre este flujo:

```text
1. El navegador envía una petición HTTP GET a /spring-mvc-library/library.
```

```text
2. Tomcat recibe la petición.
```

Tomcat comprueba el `web.xml` de la aplicación y ve que las peticiones pasan por el servlet llamado `library`.

```text
3. La petición entra en DispatcherServlet.
```

El servlet configurado es:

```xml
<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
```

```text
4. DispatcherServlet carga la configuración de library-servlet.xml.
```

Esa configuración se indicó en `web.xml`:

```xml
<param-value>/WEB-INF/spring/library-servlet.xml</param-value>
```

```text
5. Spring consulta SimpleUrlHandlerMapping.
```

En `library-servlet.xml` existe este mapeo:

```xml
<prop key="/library">libraryHomeController</prop>
```

Por tanto, Spring sabe que debe ejecutar el controlador llamado `libraryHomeController`.

```text
6. Spring ejecuta LibraryHomeController.
```

El método `handleRequest` crea un `ModelAndView`:

```java
ModelAndView modelAndView = new ModelAndView("library-home");
```

También añade datos al modelo:

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

El `ViewResolver` tiene esta configuración:

```xml
<property name="prefix" value="/WEB-INF/views/" />
<property name="suffix" value=".jsp" />
```

Por eso convierte:

```text
library-home
```

en:

```text
/WEB-INF/views/library-home.jsp
```

```text
9. Se procesa la JSP.
```

La JSP usa los datos recibidos:

```jsp
${pageTitle}
${mainMessage}
${sectionName}
```

```text
10. Tomcat devuelve el HTML final al navegador.
```

El usuario no ve el archivo JSP directamente. Ve el HTML generado a partir de la JSP.

</details>

---

# Ejercicio 9 - Añadir una segunda página con otro controlador

## Enunciado

Amplía la aplicación de biblioteca creando una segunda página llamada `/info`.

Debe cumplir estas condiciones:

1. Crear un controlador llamado `LibraryInfoController`.
2. El controlador debe devolver la vista lógica `library-info`.
3. Debe enviar estos datos al modelo:

```text
pageTitle = Información de la biblioteca
mainMessage = Esta biblioteca permite consultar libros y autores.
```

4. Registrar el controlador en `library-servlet.xml`.
5. Mapear la URL `/info` a ese controlador.
6. Crear la vista `library-info.jsp`.

<details>
<summary>mostrar solución</summary>

## Solución

### 1. Crear `LibraryInfoController.java`

Ruta:

```text
src/main/java/com/example/springmvclibrary/controller/LibraryInfoController.java
```

Código:

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

### 2. Registrar el controlador en `library-servlet.xml`

Añadimos este bean:

```xml
<bean id="libraryInfoController"
      class="com.example.springmvclibrary.controller.LibraryInfoController" />
```

---

### 3. Añadir el mapeo `/info`

Dentro de `SimpleUrlHandlerMapping`, añadimos:

```xml
<prop key="/info">libraryInfoController</prop>
```

El bloque completo de mapeos puede quedar así:

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

### 4. Crear `library-info.jsp`

Ruta:

```text
src/main/webapp/WEB-INF/views/library-info.jsp
```

Código:

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

## Explicación

Ahora la aplicación tiene dos controladores clásicos:

```text
/library → LibraryHomeController
/info    → LibraryInfoController
```

Cada controlador devuelve una vista diferente:

```text
LibraryHomeController → library-home.jsp
LibraryInfoController → library-info.jsp
```

</details>

---

# Ejercicio 10 - Corregir errores habituales de configuración

## Enunciado

Un alumno tiene esta configuración en `library-servlet.xml`:

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

Y su controlador devuelve:

```java
return new ModelAndView("library-home");
```

La JSP está en:

```text
/WEB-INF/views/library-home.jsp
```

Explica qué errores hay y corrige la configuración.

<details>
<summary>mostrar solución</summary>

## Solución

Hay dos errores principales.

---

## Error 1: el mapeo apunta a un bean que no existe

En XML aparece:

```xml
<prop key="/library">homeController</prop>
```

Pero el bean registrado se llama:

```xml
<bean id="libraryHomeController"
      class="com.example.springmvclibrary.controller.LibraryHomeController" />
```

Por tanto, el mapeo debería apuntar a:

```text
libraryHomeController
```

No a:

```text
homeController
```

Corrección:

```xml
<prop key="/library">libraryHomeController</prop>
```

---

## Error 2: el `ViewResolver` busca en una carpeta incorrecta

El `ViewResolver` tiene:

```xml
<property name="prefix" value="/WEB-INF/pages/" />
```

Eso significa que Spring buscará:

```text
/WEB-INF/pages/library-home.jsp
```

Pero la JSP está realmente en:

```text
/WEB-INF/views/library-home.jsp
```

Por tanto, el `prefix` correcto es:

```xml
<property name="prefix" value="/WEB-INF/views/" />
```

---

## Configuración corregida

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

## Explicación final

El controlador devuelve:

```java
new ModelAndView("library-home");
```

Con esta configuración:

```xml
<property name="prefix" value="/WEB-INF/views/" />
<property name="suffix" value=".jsp" />
```

Spring buscará correctamente:

```text
/WEB-INF/views/library-home.jsp
```

</details>

---

# Ejercicio 11 - Crear una miniaplicación completa desde cero

## Enunciado

Crea una miniaplicación Spring MVC llamada `spring-mvc-events`.

La aplicación tendrá una única página accesible desde:

```text
/
/events
```

La página debe mostrar:

```text
Título: Gestión de eventos
Mensaje: Bienvenido al panel de eventos.
Categoría: Eventos académicos
```

Debes crear:

1. `pom.xml`.
2. `web.xml`.
3. `events-servlet.xml`.
4. `EventsHomeController.java`.
5. `events-home.jsp`.
6. `events.css`.

<details>
<summary>mostrar solución</summary>

## Solución

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

Ruta:

```text
src/main/webapp/WEB-INF/web.xml
```

Código:

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

Ruta:

```text
src/main/webapp/WEB-INF/spring/events-servlet.xml
```

Código:

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

Ruta:

```text
src/main/java/com/example/springmvcevents/controller/EventsHomeController.java
```

Código:

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

Ruta:

```text
src/main/webapp/WEB-INF/views/events-home.jsp
```

Código:

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

Ruta:

```text
src/main/webapp/resources/css/events.css
```

Código:

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

## Resultado esperado

Al entrar en:

```text
http://localhost:8080/spring-mvc-events/events
```

el usuario debería ver la página de inicio del panel de eventos.

</details>

---

# Ejercicio 12 - Diagnóstico final: encontrar por qué aparece un 404

## Enunciado

Una aplicación Spring MVC arranca correctamente en Tomcat, pero al entrar en:

```text
http://localhost:8080/spring-mvc-events/events
```

aparece un error 404.

El proyecto tiene estos archivos:

```text
src/main/webapp/WEB-INF/web.xml
src/main/webapp/WEB-INF/spring/events-servlet.xml
src/main/java/com/example/springmvcevents/controller/EventsHomeController.java
src/main/webapp/WEB-INF/views/events-home.jsp
```

El archivo `web.xml` contiene:

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

El archivo `events-servlet.xml` contiene:

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

Detecta los errores y corrígelos.

<details>
<summary>mostrar solución</summary>

## Solución

Hay dos errores principales.

---

## Error 1: el nombre del servlet no coincide

En la declaración del servlet aparece:

```xml
<servlet-name>event</servlet-name>
```

Pero en el mapeo aparece:

```xml
<servlet-name>events</servlet-name>
```

Deben llamarse exactamente igual.

Podemos corregirlo usando `events` en ambos lugares:

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

## Error 2: la URL configurada no coincide con la URL que visita el usuario

El usuario entra en:

```text
/events
```

Pero en `events-servlet.xml` está configurado:

```xml
<prop key="/event">eventsHomeController</prop>
```

Falta la `s` final.

La corrección es:

```xml
<prop key="/events">eventsHomeController</prop>
```

También podemos añadir `/` como ruta alternativa:

```xml
<prop key="/">eventsHomeController</prop>
<prop key="/events">eventsHomeController</prop>
```

---

## Configuración corregida completa del mapeo

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

## Conclusión

El error 404 no se debía a que faltara la JSP. Se debía a dos problemas de configuración:

```text
1. El servlet declarado y el servlet mapeado no tenían el mismo nombre.
2. La URL /events no estaba configurada en SimpleUrlHandlerMapping.
```

</details>
