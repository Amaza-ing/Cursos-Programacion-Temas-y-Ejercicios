# Tema 4 — (Opcional) Persistencia de datos con MySQL y DBeaver en Spring MVC

## Objetivo de este tema opcional

En el Tema 3 aprendimos a crear y procesar formularios en Spring MVC. Hasta ahora, los cursos se guardaban en una lista en memoria dentro de Java:

```java
private final List<Course> courses = new ArrayList<>();
```

Esto era suficiente para aprender el flujo de un formulario, pero tiene una limitación importante: cuando reiniciamos la aplicación, los datos añadidos desaparecen.

En este tema vamos a cambiar esa lista por una base de datos MySQL. Usaremos DBeaver para crear y consultar la base de datos, y Spring JDBC para conectar nuestra aplicación Spring MVC con MySQL.

Al terminar este tema opcional, el flujo será el siguiente:

```text
Formulario JSP
    ↓
CourseController
    ↓
CourseService
    ↓
CourseDao
    ↓
JdbcCourseDao
    ↓
JdbcTemplate
    ↓
MySQL
```

El usuario seguirá usando la aplicación igual que antes: verá un listado de cursos, podrá entrar al detalle de un curso y podrá crear un nuevo curso mediante formulario. La diferencia estará en que los datos se guardarán de forma persistente en MySQL.

---

## 1. Qué vamos a modificar

Partimos del proyecto que ya teníamos en el Tema 3.

Hasta ahora, la aplicación tenía estas rutas:

```text
GET  /courses             → muestra el listado de cursos
GET  /courses/detail?id=1 → muestra el detalle de un curso
GET  /courses/new         → muestra el formulario de creación
POST /courses             → procesa el formulario y crea un curso
```

Estas rutas no van a cambiar.

Lo que cambia es la forma de obtener y guardar los datos.

Antes teníamos esta estructura interna:

```text
CourseController
        ↓
CourseService
        ↓
ArrayList<Course>
```

Ahora tendremos esta:

```text
CourseController
        ↓
CourseService
        ↓
CourseDao
        ↓
JdbcCourseDao
        ↓
MySQL
```

El controlador seguirá llamando al servicio. El servicio seguirá ofreciendo métodos como `findAll()`, `findById()` y `save()`. Pero por dentro, esos métodos ya no trabajarán con una lista en memoria, sino con una base de datos.

---

## 2. Estructura final del proyecto

Añadiremos un nuevo paquete llamado `dao`.

La estructura del proyecto quedará así:

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
        │               ├── dao
        │               │   ├── CourseDao.java
        │               │   └── JdbcCourseDao.java
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
                        ├── form.jsp
                        └── not-found.jsp
```

Los archivos nuevos serán:

```text
CourseDao.java
JdbcCourseDao.java
```

Los archivos que modificaremos serán:

```text
pom.xml
app-servlet.xml
CourseService.java
```

El controlador y las vistas no necesitan cambios importantes, porque ya estaban bien separados de la lógica de datos.

---

[![Conexión con MySQL](https://img.youtube.com/vi/ulrXpghgoqM/0.jpg)](https://www.youtube.com/watch?v=ulrXpghgoqM&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 3. Crear la base de datos en DBeaver

Primero abrimos DBeaver y creamos una conexión a MySQL.

Los datos habituales de conexión son:

```text
Host: localhost
Port: 3306
User: root
Password: la contraseña de MySQL de cada alumno
```

Si DBeaver pide descargar el driver de MySQL, aceptamos.

Después abrimos un editor SQL y ejecutamos el siguiente script.

---

## 4. Script SQL completo

```sql
CREATE DATABASE IF NOT EXISTS spring_mvc_courses
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE spring_mvc_courses;

CREATE TABLE IF NOT EXISTS courses (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(80) NOT NULL,
    level VARCHAR(30) NOT NULL,
    duration_in_hours INT NOT NULL
);

INSERT INTO courses (title, level, duration_in_hours)
VALUES
    ('Spring MVC desde cero', 'Inicial', 20),
    ('Spring MVC con formularios', 'Intermedio', 15),
    ('Spring MVC avanzado', 'Avanzado', 25);

SELECT * FROM courses;
```

---

## 5. Explicación del script SQL

Creamos la base de datos con:

```sql
CREATE DATABASE IF NOT EXISTS spring_mvc_courses
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
```

El nombre de la base de datos será:

```text
spring_mvc_courses
```

Usamos `utf8mb4` para que la base de datos acepte correctamente caracteres como tildes, eñes y otros símbolos.

Después seleccionamos esa base de datos:

```sql
USE spring_mvc_courses;
```

Luego creamos la tabla:

```sql
CREATE TABLE IF NOT EXISTS courses (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(80) NOT NULL,
    level VARCHAR(30) NOT NULL,
    duration_in_hours INT NOT NULL
);
```

La tabla se llama `courses` y tendrá estas columnas:

| Columna             | Tipo          | Significado                   |
| ------------------- | ------------- | ----------------------------- |
| `id`                | `BIGINT`      | Identificador único del curso |
| `title`             | `VARCHAR(80)` | Título del curso              |
| `level`             | `VARCHAR(30)` | Nivel del curso               |
| `duration_in_hours` | `INT`         | Duración en horas             |

La columna `id` tiene:

```sql
PRIMARY KEY AUTO_INCREMENT
```

Esto significa que MySQL generará automáticamente un identificador diferente para cada curso.

Después insertamos algunos cursos iniciales:

```sql
INSERT INTO courses (title, level, duration_in_hours)
VALUES
    ('Spring MVC desde cero', 'Inicial', 20),
    ('Spring MVC con formularios', 'Intermedio', 15),
    ('Spring MVC avanzado', 'Avanzado', 25);
```

No escribimos el `id`, porque MySQL lo genera automáticamente.

Finalmente comprobamos los datos con:

```sql
SELECT * FROM courses;
```

El resultado debería ser parecido a este:

```text
id | title                         | level      | duration_in_hours
1  | Spring MVC desde cero          | Inicial    | 20
2  | Spring MVC con formularios     | Intermedio | 15
3  | Spring MVC avanzado            | Avanzado   | 25
```

---

## 6. Actualizar el archivo `pom.xml`

Ahora tenemos que añadir las dependencias necesarias para conectar Java con MySQL.

Necesitamos dos dependencias nuevas:

```text
spring-jdbc
mysql-connector-j
```

La primera nos permite usar `JdbcTemplate`, una clase de Spring que simplifica el trabajo con SQL.

La segunda es el driver que permite que Java se comunique con MySQL.

Dentro de `<dependencies>`, añadimos:

```xml
<!-- Spring JDBC -->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-jdbc</artifactId>
    <version>${spring.version}</version>
</dependency>

<!-- Driver JDBC de MySQL -->
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>9.7.0</version>
</dependency>
```

El bloque completo de dependencias puede quedar así:

```xml
<dependencies>

    <!-- Spring MVC -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-webmvc</artifactId>
        <version>${spring.version}</version>
    </dependency>

    <!-- Spring JDBC -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-jdbc</artifactId>
        <version>${spring.version}</version>
    </dependency>

    <!-- Driver JDBC de MySQL -->
    <dependency>
        <groupId>com.mysql</groupId>
        <artifactId>mysql-connector-j</artifactId>
        <version>9.7.0</version>
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

    <!-- Implementación de Jakarta Bean Validation -->
    <dependency>
        <groupId>org.hibernate.validator</groupId>
        <artifactId>hibernate-validator</artifactId>
        <version>8.0.3.Final</version>
    </dependency>

</dependencies>
```

Después de modificar el `pom.xml`, en IntelliJ debemos recargar Maven para que descargue las nuevas dependencias.

Normalmente IntelliJ muestra un icono o mensaje para hacer `Reload Maven Project`. También podemos abrir la ventana de Maven y pulsar el icono de recarga.

---

## 7. Configurar la conexión en `app-servlet.xml`

Ahora tenemos que decirle a Spring cómo conectarse a MySQL.

Modificamos este archivo:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

Añadiremos dos beans:

```text
dataSource
jdbcTemplate
```

El archivo quedará así:

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

    <!-- Busca automáticamente controladores, servicios, DAOs y otros componentes -->
    <context:component-scan base-package="com.example.springmvcday1" />

    <!-- Conexión a MySQL -->
    <bean id="dataSource"
          class="org.springframework.jdbc.datasource.DriverManagerDataSource">

        <property name="driverClassName" value="com.mysql.cj.jdbc.Driver" />

        <property name="url"
                  value="jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&amp;serverTimezone=Europe/Madrid" />

        <property name="username" value="root" />
        <property name="password" value="TU_PASSWORD" />
    </bean>

    <!-- Objeto de Spring para ejecutar SQL de forma sencilla -->
    <bean id="jdbcTemplate"
          class="org.springframework.jdbc.core.JdbcTemplate">

        <property name="dataSource" ref="dataSource" />
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

---

## 8. Explicación del `dataSource`

El bean `dataSource` representa la conexión con MySQL:

```xml
<bean id="dataSource"
      class="org.springframework.jdbc.datasource.DriverManagerDataSource">
```

Dentro indicamos el driver:

```xml
<property name="driverClassName" value="com.mysql.cj.jdbc.Driver" />
```

Después configuramos la URL de conexión:

```xml
<property name="url"
          value="jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&amp;serverTimezone=Europe/Madrid" />
```

La URL se puede dividir así:

```text
jdbc:mysql://localhost:3306/spring_mvc_courses
```

| Parte                | Significado                      |
| -------------------- | -------------------------------- |
| `jdbc:mysql://`      | Indica que usamos JDBC con MySQL |
| `localhost`          | MySQL está en nuestro ordenador  |
| `3306`               | Puerto habitual de MySQL         |
| `spring_mvc_courses` | Nombre de la base de datos       |

Después aparecen estos parámetros:

```text
useSSL=false
serverTimezone=Europe/Madrid
```

En XML no podemos escribir `&` directamente dentro de un atributo, por eso escribimos:

```xml
&amp;
```

Por tanto, la URL queda así:

```xml
?useSSL=false&amp;serverTimezone=Europe/Madrid
```

También indicamos usuario y contraseña:

```xml
<property name="username" value="root" />
<property name="password" value="TU_PASSWORD" />
```

Cada alumno debe sustituir:

```text
TU_PASSWORD
```

por la contraseña real de su MySQL.

En una aplicación real no conviene dejar contraseñas escritas directamente en un XML, pero para este curso introductorio nos permite entender el proceso de forma sencilla.

---

## 9. Explicación de `JdbcTemplate`

El segundo bean es:

```xml
<bean id="jdbcTemplate"
      class="org.springframework.jdbc.core.JdbcTemplate">

    <property name="dataSource" ref="dataSource" />
</bean>
```

`JdbcTemplate` es el objeto que usaremos para ejecutar consultas SQL desde Java.

Necesita un `DataSource` para saber a qué base de datos conectarse.

La relación es esta:

```text
JdbcTemplate
      ↓
DataSource
      ↓
MySQL
```

Gracias a `JdbcTemplate`, no tendremos que abrir y cerrar conexiones manualmente en cada consulta. Spring se encarga de gran parte del trabajo repetitivo de JDBC.

---

## 10. Crear la interfaz `CourseDao`

Ahora creamos un nuevo paquete:

```text
com.example.springmvcday1.dao
```

Dentro de ese paquete creamos el archivo:

```text
CourseDao.java
```

Código:

```java
package com.example.springmvcday1.dao;

import com.example.springmvcday1.model.Course;

import java.util.List;

public interface CourseDao {

    List<Course> findAll();

    Course findById(Long id);

    void save(Course course);
}
```

---

## 11. Explicación de `CourseDao`

DAO significa:

```text
Data Access Object
```

Un DAO es una clase o interfaz encargada de definir operaciones de acceso a datos.

En este caso, nuestra interfaz define tres operaciones:

```java
List<Course> findAll();
```

Sirve para obtener todos los cursos.

```java
Course findById(Long id);
```

Sirve para buscar un curso por su identificador.

```java
void save(Course course);
```

Sirve para guardar un nuevo curso.

Esta interfaz no tiene SQL. Solo dice qué operaciones necesitamos.

La implementación real la haremos en otra clase llamada `JdbcCourseDao`.

---

## 12. Crear la clase `JdbcCourseDao`

Dentro del mismo paquete:

```text
com.example.springmvcday1.dao
```

creamos el archivo:

```text
JdbcCourseDao.java
```

Código:

```java
package com.example.springmvcday1.dao;

import com.example.springmvcday1.model.Course;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;

@Repository
public class JdbcCourseDao implements CourseDao {

    private final JdbcTemplate jdbcTemplate;

    public JdbcCourseDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Course> courseRowMapper = (resultSet, rowNumber) ->
            new Course(
                    resultSet.getLong("id"),
                    resultSet.getString("title"),
                    resultSet.getString("level"),
                    resultSet.getInt("duration_in_hours")
            );

    @Override
    public List<Course> findAll() {
        String sql = """
                SELECT id, title, level, duration_in_hours
                FROM courses
                ORDER BY id
                """;

        return jdbcTemplate.query(sql, courseRowMapper);
    }

    @Override
    public Course findById(Long id) {
        String sql = """
                SELECT id, title, level, duration_in_hours
                FROM courses
                WHERE id = ?
                """;

        List<Course> courses = jdbcTemplate.query(sql, courseRowMapper, id);

        return courses.stream()
                .findFirst()
                .orElse(null);
    }

    @Override
    public void save(Course course) {
        String sql = """
                INSERT INTO courses (title, level, duration_in_hours)
                VALUES (?, ?, ?)
                """;

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    sql,
                    Statement.RETURN_GENERATED_KEYS
            );

            preparedStatement.setString(1, course.getTitle());
            preparedStatement.setString(2, course.getLevel());
            preparedStatement.setInt(3, course.getDurationInHours());

            return preparedStatement;
        }, keyHolder);

        Number generatedId = keyHolder.getKey();

        if (generatedId != null) {
            course.setId(generatedId.longValue());
        }
    }
}
```

---

## 13. Explicación de `JdbcCourseDao`

La clase empieza con:

```java
@Repository
public class JdbcCourseDao implements CourseDao {
```

La anotación `@Repository` le indica a Spring que esta clase pertenece a la capa de acceso a datos.

Como en `app-servlet.xml` tenemos esta línea:

```xml
<context:component-scan base-package="com.example.springmvcday1" />
```

Spring buscará clases anotadas dentro del paquete `com.example.springmvcday1` y registrará automáticamente `JdbcCourseDao` como bean.

La clase implementa la interfaz:

```java
implements CourseDao
```

Esto significa que debe implementar los métodos definidos en `CourseDao`:

```java
findAll()
findById(Long id)
save(Course course)
```

---

## 14. Inyección de `JdbcTemplate`

Dentro de `JdbcCourseDao` tenemos:

```java
private final JdbcTemplate jdbcTemplate;
```

Y el constructor:

```java
public JdbcCourseDao(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
}
```

Esto significa que `JdbcCourseDao` necesita un objeto `JdbcTemplate` para funcionar.

Spring lo inyectará automáticamente usando el bean que habíamos configurado en XML:

```xml
<bean id="jdbcTemplate"
      class="org.springframework.jdbc.core.JdbcTemplate">
```

La cadena de dependencias queda así:

```text
JdbcCourseDao necesita JdbcTemplate
JdbcTemplate necesita DataSource
DataSource contiene la conexión a MySQL
```

---

## 15. Convertir filas SQL en objetos Java con `RowMapper`

Una base de datos devuelve filas y columnas.

Java trabaja con objetos.

Por eso necesitamos convertir cada fila de la tabla `courses` en un objeto `Course`.

Eso lo hacemos con un `RowMapper`:

```java
private final RowMapper<Course> courseRowMapper = (resultSet, rowNumber) ->
        new Course(
                resultSet.getLong("id"),
                resultSet.getString("title"),
                resultSet.getString("level"),
                resultSet.getInt("duration_in_hours")
        );
```

`resultSet` representa una fila devuelta por MySQL.

Por ejemplo, si MySQL devuelve esta fila:

```text
id: 1
title: Spring MVC desde cero
level: Inicial
duration_in_hours: 20
```

el `RowMapper` crea este objeto:

```java
new Course(
        1L,
        "Spring MVC desde cero",
        "Inicial",
        20
);
```

El `RowMapper` se usará en las consultas `SELECT`.

---

## 16. Método `findAll()`

El método `findAll()` obtiene todos los cursos de la base de datos.

```java
@Override
public List<Course> findAll() {
    String sql = """
            SELECT id, title, level, duration_in_hours
            FROM courses
            ORDER BY id
            """;

    return jdbcTemplate.query(sql, courseRowMapper);
}
```

Primero definimos la consulta SQL:

```sql
SELECT id, title, level, duration_in_hours
FROM courses
ORDER BY id
```

Esta consulta pide todos los cursos ordenados por su identificador.

Después ejecutamos:

```java
jdbcTemplate.query(sql, courseRowMapper);
```

Esto significa:

```text
Ejecuta la consulta SQL.
Por cada fila devuelta, usa courseRowMapper.
Devuelve una lista de objetos Course.
```

El resultado final será un `List<Course>`.

---

## 17. Método `findById(Long id)`

Este método busca un curso concreto por su identificador.

```java
@Override
public Course findById(Long id) {
    String sql = """
            SELECT id, title, level, duration_in_hours
            FROM courses
            WHERE id = ?
            """;

    List<Course> courses = jdbcTemplate.query(sql, courseRowMapper, id);

    return courses.stream()
            .findFirst()
            .orElse(null);
}
```

La consulta SQL es:

```sql
SELECT id, title, level, duration_in_hours
FROM courses
WHERE id = ?
```

El signo `?` es un parámetro.

No hacemos esto:

```java
"SELECT * FROM courses WHERE id = " + id
```

porque concatenar valores dentro de una consulta SQL es menos seguro y menos limpio.

En su lugar hacemos:

```java
jdbcTemplate.query(sql, courseRowMapper, id);
```

Así `JdbcTemplate` pasa el valor de `id` como parámetro de la consulta.

El resultado será una lista. Puede contener un curso o puede estar vacía.

Por eso al final escribimos:

```java
return courses.stream()
        .findFirst()
        .orElse(null);
```

Esto significa:

```text
Si hay un curso, devuelve el primero.
Si no hay ninguno, devuelve null.
```

---

## 18. Método `save(Course course)`

Este método guarda un nuevo curso en la base de datos.

```java
@Override
public void save(Course course) {
    String sql = """
            INSERT INTO courses (title, level, duration_in_hours)
            VALUES (?, ?, ?)
            """;

    KeyHolder keyHolder = new GeneratedKeyHolder();

    jdbcTemplate.update(connection -> {
        PreparedStatement preparedStatement = connection.prepareStatement(
                sql,
                Statement.RETURN_GENERATED_KEYS
        );

        preparedStatement.setString(1, course.getTitle());
        preparedStatement.setString(2, course.getLevel());
        preparedStatement.setInt(3, course.getDurationInHours());

        return preparedStatement;
    }, keyHolder);

    Number generatedId = keyHolder.getKey();

    if (generatedId != null) {
        course.setId(generatedId.longValue());
    }
}
```

La consulta es:

```sql
INSERT INTO courses (title, level, duration_in_hours)
VALUES (?, ?, ?)
```

No insertamos el `id`, porque MySQL lo genera automáticamente.

Los tres signos `?` representan:

| Posición | Valor              |
| -------- | ------------------ |
| `1`      | título del curso   |
| `2`      | nivel del curso    |
| `3`      | duración del curso |

Después creamos un `KeyHolder`:

```java
KeyHolder keyHolder = new GeneratedKeyHolder();
```

Este objeto nos permite recuperar el identificador generado por MySQL.

Luego preparamos el `PreparedStatement`:

```java
PreparedStatement preparedStatement = connection.prepareStatement(
        sql,
        Statement.RETURN_GENERATED_KEYS
);
```

La parte importante es:

```java
Statement.RETURN_GENERATED_KEYS
```

Esto le dice a JDBC que queremos recuperar la clave generada automáticamente.

Después colocamos los valores:

```java
preparedStatement.setString(1, course.getTitle());
preparedStatement.setString(2, course.getLevel());
preparedStatement.setInt(3, course.getDurationInHours());
```

Si el usuario ha enviado el formulario con estos datos:

```text
Título: Java Web con Spring
Nivel: Inicial
Duración: 12
```

la consulta final insertará esos valores en la tabla.

Después recuperamos el id generado:

```java
Number generatedId = keyHolder.getKey();
```

Y se lo asignamos al objeto Java:

```java
if (generatedId != null) {
    course.setId(generatedId.longValue());
}
```

Así el objeto `Course` también conoce su nuevo identificador.

---

## 19. Actualizar `CourseService`

Ahora el servicio ya no debe trabajar con una lista en memoria.

Antes teníamos algo parecido a esto:

```java
private final List<Course> courses = new ArrayList<>();
```

Ahora el servicio debe usar `CourseDao`.

Modificamos el archivo:

```text
src/main/java/com/example/springmvcday1/service/CourseService.java
```

Código actualizado:

```java
package com.example.springmvcday1.service;

import com.example.springmvcday1.dao.CourseDao;
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

    public void save(Course course) {
        courseDao.save(course);
    }
}
```

---

## 20. Explicación de `CourseService`

El servicio tiene ahora esta dependencia:

```java
private final CourseDao courseDao;
```

Y la recibe por constructor:

```java
public CourseService(CourseDao courseDao) {
    this.courseDao = courseDao;
}
```

Esto significa que `CourseService` no sabe exactamente cómo se guardan los datos.

Solo sabe que existe un objeto `CourseDao` capaz de hacer esto:

```java
findAll()
findById(id)
save(course)
```

La clase concreta que implementa esas operaciones es `JdbcCourseDao`, pero el servicio no necesita conocer los detalles.

Esto nos deja una arquitectura más limpia:

| Clase              | Responsabilidad                           |
| ------------------ | ----------------------------------------- |
| `CourseController` | Recibe peticiones web                     |
| `CourseService`    | Coordina la lógica relacionada con cursos |
| `CourseDao`        | Define las operaciones de acceso a datos  |
| `JdbcCourseDao`    | Ejecuta SQL contra MySQL                  |
| `JdbcTemplate`     | Facilita el uso de JDBC                   |
| `DataSource`       | Define la conexión a la base de datos     |

---

## 21. ¿Hay que cambiar el controlador?

En principio, no.

El controlador ya estaba llamando al servicio:

```java
courseService.findAll();
courseService.findById(id);
courseService.save(course);
```

Eso significa que el controlador no sabe si los datos vienen de una lista en memoria o de MySQL.

Esa es una ventaja de separar la aplicación en capas.

Por ejemplo, el método que guarda un curso puede quedarse igual:

```java
@PostMapping
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {

    if (bindingResult.hasErrors()) {
        model.addAttribute("pageTitle", "Crear nuevo curso");
        return "courses/form";
    }

    courseService.save(course);

    redirectAttributes.addFlashAttribute(
            "successMessage",
            "El curso se ha creado correctamente."
    );

    return "redirect:/courses";
}
```

Antes, esta línea:

```java
courseService.save(course);
```

añadía el curso a una lista.

Ahora esa misma línea termina ejecutando un `INSERT` en MySQL.

---

## 22. ¿Hay que cambiar las vistas JSP?

Tampoco.

Las vistas siguen recibiendo los mismos datos:

```text
courses
course
pageTitle
successMessage
```

Por ejemplo, `list.jsp` puede seguir recorriendo la lista así:

```jsp
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
```

La vista no necesita saber de dónde vienen los cursos.

Solo necesita recibir una lista de objetos `Course`.

---

## 23. Flujo completo al listar cursos

Cuando el usuario entra en:

```text
/courses
```

ocurre esto:

```text
1. Tomcat recibe la petición.
2. DispatcherServlet la envía al controlador correspondiente.
3. CourseController ejecuta listCourses().
4. CourseController llama a courseService.findAll().
5. CourseService llama a courseDao.findAll().
6. JdbcCourseDao ejecuta un SELECT en MySQL.
7. MySQL devuelve las filas de la tabla courses.
8. RowMapper convierte cada fila en un objeto Course.
9. El controlador añade la lista al Model.
10. Spring muestra la vista courses/list.jsp.
```

El método principal del DAO es:

```java
public List<Course> findAll() {
    String sql = """
            SELECT id, title, level, duration_in_hours
            FROM courses
            ORDER BY id
            """;

    return jdbcTemplate.query(sql, courseRowMapper);
}
```

---

## 24. Flujo completo al crear un curso

Cuando el usuario entra en:

```text
/courses/new
```

Spring muestra el formulario.

Cuando el usuario rellena el formulario y pulsa el botón, el navegador envía:

```text
POST /courses
```

Entonces ocurre esto:

```text
1. CourseController recibe los datos del formulario.
2. Spring crea un objeto Course con @ModelAttribute.
3. Spring valida el objeto con @Valid.
4. Si hay errores, se vuelve a mostrar form.jsp.
5. Si no hay errores, CourseController llama a courseService.save(course).
6. CourseService llama a courseDao.save(course).
7. JdbcCourseDao ejecuta un INSERT en MySQL.
8. MySQL guarda el curso y genera un id.
9. Spring redirige a /courses.
10. El listado se vuelve a cargar desde MySQL.
```

El método principal del DAO es:

```java
public void save(Course course) {
    String sql = """
            INSERT INTO courses (title, level, duration_in_hours)
            VALUES (?, ?, ?)
            """;

    KeyHolder keyHolder = new GeneratedKeyHolder();

    jdbcTemplate.update(connection -> {
        PreparedStatement preparedStatement = connection.prepareStatement(
                sql,
                Statement.RETURN_GENERATED_KEYS
        );

        preparedStatement.setString(1, course.getTitle());
        preparedStatement.setString(2, course.getLevel());
        preparedStatement.setInt(3, course.getDurationInHours());

        return preparedStatement;
    }, keyHolder);

    Number generatedId = keyHolder.getKey();

    if (generatedId != null) {
        course.setId(generatedId.longValue());
    }
}
```

---

## 25. Comprobación en DBeaver

Después de crear un curso desde la aplicación web, volvemos a DBeaver y ejecutamos:

```sql
SELECT * FROM courses;
```

Si todo ha funcionado bien, aparecerá el nuevo curso en la tabla.

Por ejemplo:

```text
id | title                   | level      | duration_in_hours
1  | Spring MVC desde cero    | Inicial    | 20
2  | Spring MVC formularios   | Intermedio | 15
3  | Spring MVC avanzado      | Avanzado   | 25
4  | Java Web con Spring      | Inicial    | 12
```

Esto confirma que el curso ya no se ha guardado solo en memoria, sino en MySQL.

---

## 26. Comparación: versión en memoria y versión con MySQL

### Antes

```text
CourseController
        ↓
CourseService
        ↓
ArrayList<Course>
```

Ventajas:

```text
Es sencilla.
Es rápida para aprender formularios.
No necesita base de datos.
```

Limitaciones:

```text
Los datos se pierden al reiniciar.
No se pueden consultar desde DBeaver.
No representa una aplicación real con persistencia.
```

### Ahora

```text
CourseController
        ↓
CourseService
        ↓
CourseDao
        ↓
JdbcCourseDao
        ↓
JdbcTemplate
        ↓
MySQL
```

Ventajas:

```text
Los datos permanecen.
Podemos consultar la tabla desde DBeaver.
La aplicación se parece más a un proyecto real.
La capa web queda separada de la capa de datos.
```

Limitaciones:

```text
Necesitamos tener MySQL funcionando.
Hay más configuración.
Pueden aparecer errores de conexión si los datos no son correctos.
```

---

## 27. Errores habituales y cómo solucionarlos

### Error 1: no cambiar `TU_PASSWORD`

En `app-servlet.xml` aparece:

```xml
<property name="password" value="TU_PASSWORD" />
```

Hay que sustituir `TU_PASSWORD` por la contraseña real de MySQL.

---

### Error 2: MySQL no está iniciado

Si MySQL no está ejecutándose, la aplicación no podrá conectarse.

El error puede mencionar algo como:

```text
Communications link failure
```

o:

```text
Connection refused
```

Solución: iniciar el servicio de MySQL y comprobar que DBeaver puede conectarse.

---

### Error 3: la base de datos no existe

Si en la URL escribimos:

```text
spring_mvc_courses
```

pero no hemos creado esa base de datos, la aplicación fallará.

Solución: ejecutar en DBeaver:

```sql
CREATE DATABASE IF NOT EXISTS spring_mvc_courses;
```

---

### Error 4: la tabla `courses` no existe

Si existe la base de datos pero no la tabla, fallarán las consultas.

Solución: ejecutar:

```sql
CREATE TABLE IF NOT EXISTS courses (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(80) NOT NULL,
    level VARCHAR(30) NOT NULL,
    duration_in_hours INT NOT NULL
);
```

---

### Error 5: falta `spring-jdbc`

Si IntelliJ no reconoce `JdbcTemplate`, puede faltar esta dependencia:

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-jdbc</artifactId>
    <version>${spring.version}</version>
</dependency>
```

Después de añadirla, hay que recargar Maven.

---

### Error 6: falta el driver de MySQL

Si falta esta dependencia:

```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>9.7.0</version>
</dependency>
```

la aplicación no podrá usar el driver:

```text
com.mysql.cj.jdbc.Driver
```

Solución: añadir la dependencia y recargar Maven.

---

### Error 7: escribir mal el nombre de una columna

En Java usamos:

```java
resultSet.getInt("duration_in_hours")
```

Por tanto, la tabla debe tener una columna llamada exactamente:

```text
duration_in_hours
```

Si la columna se llama `duration`, `durationInHours` o de cualquier otra forma, la consulta fallará.

---

### Error 8: usar `&` en lugar de `&amp;` dentro del XML

Incorrecto:

```xml
value="jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&serverTimezone=Europe/Madrid"
```

Correcto:

```xml
value="jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&amp;serverTimezone=Europe/Madrid"
```

En XML, el carácter `&` debe escribirse como `&amp;`.

---

### Error 9: no recargar Maven después de modificar el `pom.xml`

Después de añadir dependencias, IntelliJ necesita descargarlas.

Si no se recarga Maven, puede aparecer como si las clases no existieran.

Solución: usar `Reload Maven Project`.

---

### Error 10: insertar datos duplicados al ejecutar varias veces el script

Si ejecutamos varias veces este bloque:

```sql
INSERT INTO courses (title, level, duration_in_hours)
VALUES
    ('Spring MVC desde cero', 'Inicial', 20),
    ('Spring MVC con formularios', 'Intermedio', 15),
    ('Spring MVC avanzado', 'Avanzado', 25);
```

se insertarán los mismos cursos varias veces.

Para evitarlo durante las pruebas, podemos borrar primero la tabla:

```sql
DELETE FROM courses;
```

Y si queremos reiniciar el contador de ids:

```sql
ALTER TABLE courses AUTO_INCREMENT = 1;
```

Después podemos volver a insertar los datos iniciales.

---

## 28. Checklist final

Antes de probar la aplicación, revisa esto:

```text
[ ] MySQL está iniciado.
[ ] DBeaver puede conectarse a MySQL.
[ ] Existe la base de datos spring_mvc_courses.
[ ] Existe la tabla courses.
[ ] La tabla courses tiene datos iniciales.
[ ] El pom.xml tiene spring-jdbc.
[ ] El pom.xml tiene mysql-connector-j.
[ ] Maven se ha recargado en IntelliJ.
[ ] app-servlet.xml tiene el bean dataSource.
[ ] app-servlet.xml tiene el bean jdbcTemplate.
[ ] La contraseña de MySQL está bien escrita.
[ ] Existe la interfaz CourseDao.
[ ] Existe la clase JdbcCourseDao.
[ ] CourseService usa CourseDao y no ArrayList.
[ ] La aplicación arranca en Tomcat sin errores.
[ ] /courses muestra los cursos de MySQL.
[ ] Al crear un curso, aparece en DBeaver.
```

---

## 29. Resumen final

En este tema hemos sustituido el almacenamiento en memoria por persistencia real en MySQL.

Antes, los datos estaban aquí:

```text
ArrayList<Course>
```

Ahora están aquí:

```text
Tabla courses en MySQL
```

La aplicación mantiene la misma parte visual:

```text
list.jsp
form.jsp
detail.jsp
```

Y el mismo controlador:

```text
CourseController
```

Pero internamente ahora tenemos una arquitectura más completa:

```text
Controller
    ↓
Service
    ↓
DAO
    ↓
JdbcTemplate
    ↓
MySQL
```

La idea más importante es que la persistencia no debe mezclarse con el controlador.

El controlador se ocupa de la parte web.

El DAO se ocupa de la base de datos.

El servicio queda en medio, coordinando las operaciones de la aplicación.

Con esta ampliación, el formulario del Tema 3 ya no solo crea objetos en memoria: ahora crea registros reales en una tabla MySQL que pueden consultarse desde DBeaver.
