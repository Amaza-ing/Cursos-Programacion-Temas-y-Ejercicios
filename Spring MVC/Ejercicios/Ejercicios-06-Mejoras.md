# Ejercicios resueltos — Tema 6: Mejoras del proyecto Spring MVC

## Introducción

En estos ejercicios vas a practicar pequeñas mejoras para un proyecto Spring MVC ya creado.

El objetivo no es añadir funcionalidades grandes, sino aprender a dejar el proyecto más limpio, mantenible y fácil de ampliar.

Trabajaremos con mejoras parecidas a las del tema, pero usando ejemplos diferentes para que puedas practicar sin copiar exactamente el código de la teoría.

Vas a practicar:

- Añadir Lombok al proyecto.
- Usar `@Data`, `@NoArgsConstructor` y `@AllArgsConstructor`.
- Reducir getters, setters y constructores en modelos.
- Externalizar configuración de MySQL en un archivo `.properties`.
- Cargar propiedades externas desde `app-servlet.xml`.
- Crear fragmentos JSP reutilizables.
- Reutilizar un `<head>` común.
- Reutilizar un menú común.
- Crear atributos globales con `@ControllerAdvice` y `@ModelAttribute`.
- Usar listas globales en formularios.
- Diagnosticar errores frecuentes.

Las soluciones están ocultas bajo el botón **mostrar solución**.

---

# Ejercicio 1 — Añadir Lombok al proyecto

## Enunciado

Queremos usar Lombok en un proyecto Spring MVC para reducir código repetitivo en los modelos.

Añade al `pom.xml` la dependencia necesaria para usar Lombok.

Para que sea fácil actualizar la versión más adelante, crea también una propiedad llamada:

```xml
<lombok.version>
```

El objetivo es poder usar anotaciones como:

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
```

---

<details>
<summary>mostrar solución</summary>

## Propiedad en el `pom.xml`

Dentro de `<properties>` añadimos:

```xml
<lombok.version>1.18.46</lombok.version>
```

El bloque de propiedades podría quedar así:

```xml
<properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <spring.version>6.2.12</spring.version>
    <lombok.version>1.18.46</lombok.version>
</properties>
```

## Dependencia de Lombok

Dentro de `<dependencies>` añadimos:

```xml
<!-- Lombok: reduce código repetitivo en modelos y clases Java -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>${lombok.version}</version>
    <scope>provided</scope>
</dependency>
```

### Explicación

La dependencia:

```xml
<artifactId>lombok</artifactId>
```

permite usar anotaciones de Lombok.

El `scope`:

```xml
<scope>provided</scope>
```

indica que Lombok se usa durante la compilación, pero no se empaqueta dentro del archivo `.war`.

Esto tiene sentido porque Lombok genera código al compilar. Cuando la aplicación se ejecuta en Tomcat, ese código ya está generado.

</details>

---

# Ejercicio 2 — Activar Lombok en IntelliJ

## Enunciado

Después de añadir Lombok al `pom.xml`, IntelliJ sigue marcando error en anotaciones como:

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
```

Explica qué configuración hay que revisar en IntelliJ.

---

<details>
<summary>mostrar solución</summary>

Hay que comprobar que IntelliJ tenga activado el procesamiento de anotaciones.

Ruta habitual:

```text
File
→ Settings
→ Build, Execution, Deployment
→ Compiler
→ Annotation Processors
```

Después activamos:

```text
Enable annotation processing
```

También conviene:

```text
1. Recargar Maven.
2. Comprobar que la dependencia de Lombok está bien escrita.
3. Comprobar que los imports de Lombok son correctos.
```

Los imports deberían ser, por ejemplo:

```java
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
```

### Explicación

Lombok genera código en tiempo de compilación.

Si IntelliJ no procesa anotaciones, puede parecer que los getters, setters o constructores no existen, aunque el código esté bien.

</details>

---

# Ejercicio 3 — Refactorizar un modelo usando Lombok

## Enunciado

Tenemos esta clase `Book`:

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

Refactoriza la clase usando Lombok.

Debe seguir teniendo:

1. Getters.
2. Setters.
3. Constructor vacío.
4. Constructor con todos los atributos.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

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

La anotación:

```java
@NoArgsConstructor
```

genera el constructor vacío.

La anotación:

```java
@AllArgsConstructor
```

genera el constructor con todos los atributos.

Aunque ya no veamos los métodos escritos manualmente, el resto de la aplicación podrá seguir usando:

```java
book.getTitle()
book.setTitle("Nuevo título")
```

</details>

---

# Ejercicio 4 — Refactorizar un modelo con validación usando Lombok

## Enunciado

Tenemos una clase `Student` que se usa en un formulario.

Queremos usar Lombok, pero sin perder las validaciones.

Crea la clase `Student` en el paquete:

```text
com.example.academy.model
```

Debe tener estos campos:

| Campo      | Tipo      | Validación                            |
| ---------- | --------- | ------------------------------------- |
| `id`       | `Long`    | Sin validación                        |
| `fullName` | `String`  | Obligatorio y entre 3 y 80 caracteres |
| `email`    | `String`  | Obligatorio                           |
| `age`      | `Integer` | Obligatorio y mínimo 16               |

Usa Lombok para generar getters, setters y constructores.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

Lombok no elimina las validaciones.

Podemos combinar perfectamente:

```java
@Data
```

con:

```java
@NotBlank
@Size
@NotNull
@Min
```

Las anotaciones de validación siguen funcionando igual.

Spring MVC seguirá validando el objeto cuando en el controlador usemos:

```java
@Valid @ModelAttribute("student") Student student
```

</details>

---

# Ejercicio 5 — Identificar qué genera cada anotación de Lombok

## Enunciado

Relaciona cada anotación con lo que genera.

| Anotación             | Qué genera |
| --------------------- | ---------- |
| `@Data`               | ?          |
| `@NoArgsConstructor`  | ?          |
| `@AllArgsConstructor` | ?          |

Después explica por qué `@NoArgsConstructor` es especialmente importante cuando usamos formularios en Spring MVC.

---

<details>
<summary>mostrar solución</summary>

| Anotación             | Qué genera                                                |
| --------------------- | --------------------------------------------------------- |
| `@Data`               | Getters, setters, `toString()`, `equals()` y `hashCode()` |
| `@NoArgsConstructor`  | Constructor vacío                                         |
| `@AllArgsConstructor` | Constructor con todos los atributos                       |

`@NoArgsConstructor` es importante porque Spring MVC suele necesitar crear un objeto vacío antes de rellenarlo con los datos enviados por un formulario.

Por ejemplo:

```java
model.addAttribute("student", new Student());
```

O al recibir datos de un formulario:

```java
@ModelAttribute("student") Student student
```

Spring necesita poder crear el objeto y después asignarle valores.

</details>

---

# Ejercicio 6 — Crear un archivo `database.properties`

## Enunciado

En un proyecto Spring MVC tenemos la configuración de MySQL escrita directamente en `app-servlet.xml`.

Queremos mover esos datos a un archivo externo.

Crea el archivo:

```text
src/main/resources/database.properties
```

para una base de datos llamada:

```text
spring_mvc_library
```

Los datos son:

```text
Driver: com.mysql.cj.jdbc.Driver
URL: jdbc:mysql://localhost:3306/spring_mvc_library?useSSL=false&serverTimezone=Europe/Madrid
Usuario: root
Contraseña: TU_PASSWORD
```

---

<details>
<summary>mostrar solución</summary>

```properties
db.driverClassName=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/spring_mvc_library?useSSL=false&serverTimezone=Europe/Madrid
db.username=root
db.password=TU_PASSWORD
```

### Explicación

El archivo debe colocarse en:

```text
src/main/resources/database.properties
```

porque después lo cargaremos desde XML usando:

```xml
classpath:database.properties
```

En este archivo escribimos:

```text
&
```

normal.

No escribimos:

```text
&amp;
```

porque eso solo es necesario dentro de XML.

</details>

---

# Ejercicio 7 — Cargar `database.properties` desde `app-servlet.xml`

## Enunciado

Modifica `app-servlet.xml` para cargar el archivo:

```text
database.properties
```

desde el classpath.

Escribe solo la línea necesaria.

---

<details>
<summary>mostrar solución</summary>

```xml
<context:property-placeholder location="classpath:database.properties" />
```

### Explicación

Esta línea le dice a Spring:

```text
Busca un archivo llamado database.properties dentro del classpath.
```

Como el archivo está en:

```text
src/main/resources
```

Maven lo copiará al classpath cuando compile el proyecto.

Gracias a esta línea podremos usar expresiones como:

```xml
${db.url}
${db.username}
${db.password}
```

</details>

---

# Ejercicio 8 — Sustituir valores fijos por propiedades

## Enunciado

Tienes este `dataSource` en `app-servlet.xml`:

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

Modifícalo para que lea los valores desde `database.properties`.

---

<details>
<summary>mostrar solución</summary>

```xml
<bean id="dataSource"
      class="org.springframework.jdbc.datasource.DriverManagerDataSource">

    <property name="driverClassName" value="${db.driverClassName}" />
    <property name="url" value="${db.url}" />
    <property name="username" value="${db.username}" />
    <property name="password" value="${db.password}" />
</bean>
```

### Explicación

Antes los valores estaban escritos directamente en XML.

Ahora se leen desde:

```properties
db.driverClassName
db.url
db.username
db.password
```

Por ejemplo:

```xml
<property name="url" value="${db.url}" />
```

Spring buscará en `database.properties` una línea como:

```properties
db.url=jdbc:mysql://localhost:3306/spring_mvc_library?useSSL=false&serverTimezone=Europe/Madrid
```

</details>

---

# Ejercicio 9 — Crear una configuración completa de MySQL con propiedades externas

## Enunciado

Escribe el bloque completo de configuración XML para:

1. Cargar `database.properties`.
2. Configurar `dataSource`.
3. Configurar `jdbcTemplate`.

Usa las propiedades:

```text
db.driverClassName
db.url
db.username
db.password
```

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La línea:

```xml
<context:property-placeholder location="classpath:database.properties" />
```

debe aparecer antes de usar:

```xml
${db.url}
```

El `JdbcTemplate` usa el `dataSource`:

```xml
<property name="dataSource" ref="dataSource" />
```

La relación queda así:

```text
JdbcTemplate
      ↓
DataSource
      ↓
MySQL
```

</details>

---

# Ejercicio 10 — Diagnosticar un error con `database.properties`

## Enunciado

La aplicación tiene esta línea en `app-servlet.xml`:

```xml
<context:property-placeholder location="classpath:database.properties" />
```

Pero al arrancar aparece un error indicando que no se encuentra el archivo.

El archivo está en:

```text
src/main/webapp/database.properties
```

¿Qué está mal y cómo lo solucionarías?

---

<details>
<summary>mostrar solución</summary>

El problema es la ubicación del archivo.

Si usamos:

```xml
classpath:database.properties
```

el archivo debe estar en:

```text
src/main/resources/database.properties
```

No en:

```text
src/main/webapp/database.properties
```

La solución es mover el archivo a:

```text
src/main/resources/database.properties
```

### Explicación

`src/main/resources` se copia automáticamente al classpath.

`src/main/webapp` pertenece a la parte web de la aplicación, pero no es el lugar adecuado para cargar propiedades con `classpath:`.

</details>

---

# Ejercicio 11 — Crear carpeta de fragmentos JSP

## Enunciado

Queremos evitar repetir el mismo menú y el mismo `<head>` en todas las vistas JSP.

Indica qué carpeta crearías y qué dos archivos pondrías dentro.

---

<details>
<summary>mostrar solución</summary>

Creamos esta carpeta:

```text
src/main/webapp/WEB-INF/views/fragments
```

Dentro creamos:

```text
head.jspf
header.jspf
```

### Explicación

`head.jspf` contendrá código común del `<head>`:

```text
meta charset
title
CSS base
CSS del tema oscuro
taglibs necesarias
```

`header.jspf` contendrá el menú común:

```text
Inicio
Libros / Cursos / Productos
Cambio de idioma
Cambio de tema
```

La extensión `.jspf` suele usarse para fragmentos JSP.

</details>

---

# Ejercicio 12 — Crear un fragmento `head.jspf`

## Enunciado

Crea un fragmento llamado:

```text
head.jspf
```

Debe:

1. Importar las taglibs de Spring y JSTL.
2. Calcular el tema actual desde `sessionScope.theme`.
3. Usar `light` como tema por defecto.
4. Cargar siempre `styles.css`.
5. Cargar `styles-dark.css` solo si el tema es `dark`.
6. Mostrar el título usando `pageTitleCode` si existe, o `pageTitle` si no existe.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

Este fragmento evita repetir el mismo `<head>` en muchas JSP.

La parte:

```jsp
<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />
```

significa:

```text
Si no hay tema en sesión, usa light.
Si hay tema en sesión, usa ese valor.
```

La parte:

```jsp
<c:choose>
```

permite que algunas páginas usen un título internacionalizado y otras usen un título dinámico.

Por ejemplo:

```java
model.addAttribute("pageTitleCode", "books.list.title");
```

o:

```java
model.addAttribute("pageTitle", book.getTitle());
```

</details>

---

# Ejercicio 13 — Crear un fragmento `header.jspf`

## Enunciado

Crea un fragmento llamado:

```text
header.jspf
```

para una aplicación de biblioteca.

Debe incluir enlaces a:

```text
/home
/books
/authors
```

También debe incluir enlaces para:

```text
/home?lang=es
/home?lang=en
/theme/change?theme=light
/theme/change?theme=dark
```

Usa `<spring:message>` para los textos.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

Este fragmento centraliza el menú.

Si queremos añadir una nueva sección al menú, ya no tenemos que modificar todas las JSP.

Solo modificamos:

```text
header.jspf
```

Los textos salen de los archivos de mensajes gracias a:

```jsp
<spring:message code="nav.books" />
```

</details>

---

# Ejercicio 14 — Usar fragmentos en una JSP

## Enunciado

Tienes una vista llamada:

```text
books/list.jsp
```

Modifica su estructura para que use:

```text
head.jspf
header.jspf
```

Debe quedar una JSP con esta estructura:

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
<summary>mostrar solución</summary>

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

### Explicación

La línea:

```jsp
<%@ include file="/WEB-INF/views/fragments/head.jspf" %>
```

inserta el `<head>` común.

La línea:

```jsp
<%@ include file="/WEB-INF/views/fragments/header.jspf" %>
```

inserta el menú común.

La vista queda más limpia porque ya no repite el mismo código en todas las páginas.

</details>

---

# Ejercicio 15 — Crear atributos globales para un formulario

## Enunciado

En una aplicación de biblioteca, queremos que varios formularios tengan disponible una lista de géneros literarios.

Crea una clase llamada:

```text
GlobalModelAttributes
```

en el paquete:

```text
com.example.library.config
```

Debe añadir al modelo un atributo llamado:

```text
bookGenres
```

con esta lista:

```text
Novela
Ensayo
Poesía
Teatro
Ciencia ficción
```

La clase debe usar `@ControllerAdvice` y `@ModelAttribute`.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La anotación:

```java
@ControllerAdvice
```

permite aplicar lógica común a varios controladores.

El método:

```java
@ModelAttribute("bookGenres")
```

añade automáticamente al modelo un atributo llamado:

```text
bookGenres
```

Las JSP podrán usarlo así:

```jsp
${bookGenres}
```

sin que cada controlador tenga que añadirlo manualmente.

</details>

---

# Ejercicio 16 — Usar un atributo global en un desplegable

## Enunciado

Tienes este formulario de libros:

```jsp
<form:select path="genre" cssClass="input">
    <form:option value="" label="Selecciona un género" />
    <form:option value="Novela" label="Novela" />
    <form:option value="Ensayo" label="Ensayo" />
    <form:option value="Poesía" label="Poesía" />
</form:select>
```

Modifícalo para que las opciones salgan de:

```jsp
${bookGenres}
```

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

El bucle:

```jsp
<c:forEach var="genre" items="${bookGenres}">
```

recorre la lista global creada en Java:

```java
@ModelAttribute("bookGenres")
public List<String> bookGenres() {
    return List.of("Novela", "Ensayo", "Poesía", "Teatro", "Ciencia ficción");
}
```

Por cada género, se crea una opción del desplegable.

Si mañana queremos añadir un género nuevo, lo cambiamos en Java, no en la JSP.

</details>

---

# Ejercicio 17 — Añadir el nombre de la aplicación como atributo global

## Enunciado

Modifica `GlobalModelAttributes` para añadir un atributo global llamado:

```text
appName
```

con el valor:

```text
Library Manager
```

Después muestra ese valor en `header.jspf`.

---

<details>
<summary>mostrar solución</summary>

## Clase `GlobalModelAttributes`

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

## Uso en `header.jspf`

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

### Explicación

`appName` está disponible en todas las vistas porque se añade desde una clase con:

```java
@ControllerAdvice
```

Esto evita repetir el nombre de la aplicación directamente en cada JSP.

</details>

---

# Ejercicio 18 — Añadir estilo para la marca de la aplicación

## Enunciado

Añade estilo CSS para la clase:

```css
.brand
```

Debe mostrarse en blanco, en negrita y con separación respecto al menú.

---

<details>
<summary>mostrar solución</summary>

Añadimos en:

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

Si el `header` usa flexbox, puede quedar mejor con:

```css
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
```

### Explicación

La clase:

```css
.brand
```

se aplica al nombre de la aplicación:

```jsp
<div class="brand">
    ${appName}
</div>
```

Así la aplicación tiene una pequeña identidad visual en el menú.

</details>

---

# Ejercicio 19 — Diagnosticar errores con Lombok

## Enunciado

Lee los siguientes casos y explica qué ocurre.

## Caso A

La clase tiene:

```java
@Data
@AllArgsConstructor
public class Book {
    private Long id;
    private String title;
}
```

Pero al mostrar el formulario, Spring falla al crear un objeto vacío.

¿Qué falta?

---

## Caso B

El proyecto compila en Maven, pero IntelliJ marca error en `getTitle()` diciendo que no existe.

¿Qué puede estar ocurriendo?

---

## Caso C

Se ha añadido Lombok al `pom.xml`, pero no se ha recargado Maven.

¿Qué problema puede aparecer?

---

<details>
<summary>mostrar solución</summary>

## Caso A

Falta:

```java
@NoArgsConstructor
```

La clase tiene constructor con todos los campos, pero no tiene constructor vacío.

Para formularios en Spring MVC normalmente necesitamos:

```java
@NoArgsConstructor
```

La clase debería quedar así:

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

## Caso B

Puede que IntelliJ no esté procesando las anotaciones de Lombok.

Hay que revisar:

```text
File
→ Settings
→ Build, Execution, Deployment
→ Compiler
→ Annotation Processors
→ Enable annotation processing
```

También conviene comprobar que los imports de Lombok son correctos.

---

## Caso C

Si no se recarga Maven, IntelliJ puede no descargar Lombok.

En ese caso, las anotaciones:

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
```

aparecerán en rojo o no funcionarán correctamente.

La solución es recargar el proyecto Maven.

</details>

---

# Ejercicio 20 — Diagnosticar errores con fragmentos JSP

## Enunciado

Lee los siguientes casos y explica qué ocurre.

## Caso A

La vista contiene:

```jsp
<%@ include file="/WEB-INF/views/fragments/head.jspf" %>
```

pero el archivo está realmente en:

```text
/WEB-INF/views/common/head.jspf
```

¿Qué ocurrirá?

---

## Caso B

El archivo `header.jspf` usa:

```jsp
<spring:message code="nav.home" />
```

pero ninguna JSP incluye la taglib de Spring ni se incluye `head.jspf`.

¿Qué ocurrirá?

---

## Caso C

La JSP usa:

```jsp
<c:forEach var="genre" items="${bookGenres}">
```

pero no se ha declarado JSTL.

¿Qué falta?

---

<details>
<summary>mostrar solución</summary>

## Caso A

La ruta del fragmento está mal.

La JSP intenta incluir:

```text
/WEB-INF/views/fragments/head.jspf
```

pero el archivo está en:

```text
/WEB-INF/views/common/head.jspf
```

La solución es corregir la ruta:

```jsp
<%@ include file="/WEB-INF/views/common/head.jspf" %>
```

o mover el archivo a la carpeta esperada.

---

## Caso B

La etiqueta:

```jsp
<spring:message>
```

no funcionará si no está declarada la taglib de Spring.

Debe existir:

```jsp
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
```

Puede estar en la JSP directamente o en un fragmento incluido antes.

---

## Caso C

Falta declarar JSTL:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

Además, el proyecto debe tener las dependencias de JSTL en el `pom.xml`.

</details>

---

# Ejercicio 21 — Diagnosticar errores con atributos globales

## Enunciado

Lee los siguientes casos y explica qué ocurre.

## Caso A

La clase `GlobalModelAttributes` no tiene `@ControllerAdvice`.

¿Qué problema puede aparecer?

---

## Caso B

El método tiene:

```java
@ModelAttribute("genres")
public List<String> bookGenres() {
    return List.of("Novela", "Ensayo");
}
```

pero la JSP usa:

```jsp
${bookGenres}
```

¿Por qué no aparece la lista?

---

## Caso C

La clase `GlobalModelAttributes` está en:

```text
com.other.config
```

pero el `component-scan` solo escanea:

```text
com.example.library
```

¿Qué ocurre?

---

<details>
<summary>mostrar solución</summary>

## Caso A

Si falta:

```java
@ControllerAdvice
```

Spring no tratará esa clase como una clase global para controladores.

Los métodos con:

```java
@ModelAttribute
```

no se aplicarán globalmente.

---

## Caso B

El nombre del atributo no coincide.

Java crea un atributo llamado:

```text
genres
```

pero la JSP busca:

```text
bookGenres
```

La solución es usar el mismo nombre.

O cambiamos Java:

```java
@ModelAttribute("bookGenres")
```

o cambiamos la JSP:

```jsp
${genres}
```

---

## Caso C

Spring no encontrará la clase porque está fuera del paquete escaneado.

El `component-scan` debe incluir el paquete donde está la clase.

Por ejemplo:

```xml
<context:component-scan base-package="com.example.library" />
```

solo escanea clases dentro de:

```text
com.example.library
```

Si la clase está en:

```text
com.other.config
```

no será detectada.

</details>

---

# Ejercicio 22 — Reto final: mejorar una sección de películas

## Enunciado

Tienes una aplicación Spring MVC de películas.

Quieres aplicar varias mejoras del Tema 6.

Crea o modifica lo necesario para conseguir lo siguiente:

1. Añadir Lombok a `Movie`.
2. Crear `database.properties` para una base de datos `spring_mvc_movies`.
3. Configurar `dataSource` y `jdbcTemplate` usando propiedades externas.
4. Crear fragmentos `head.jspf` y `header.jspf`.
5. Crear una clase `GlobalModelAttributes`.
6. Añadir una lista global `movieGenres`.
7. Usar `movieGenres` en un formulario de películas.

---

<details>
<summary>mostrar solución</summary>

## 1. Dependencia de Lombok en `pom.xml`

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

## 2. Modelo `Movie.java`

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

Archivo:

```text
src/main/resources/database.properties
```

```properties
db.driverClassName=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/spring_mvc_movies?useSSL=false&serverTimezone=Europe/Madrid
db.username=root
db.password=TU_PASSWORD
```

## 4. Configuración en `app-servlet.xml`

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

## 5. Fragmento `head.jspf`

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

## 6. Fragmento `header.jspf`

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

## 8. Uso de `movieGenres` en `movies/form.jsp`

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

### Explicación del reto

Este reto reúne las principales mejoras del Tema 6:

```text
Lombok reduce código repetitivo.
database.properties separa configuración de MySQL.
Los fragmentos JSP evitan repetir código en vistas.
GlobalModelAttributes permite reutilizar datos comunes.
```

El proyecto seguirá funcionando igual para el usuario, pero estará mejor organizado internamente.

</details>
