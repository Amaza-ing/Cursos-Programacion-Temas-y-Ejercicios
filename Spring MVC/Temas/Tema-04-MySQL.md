# Topic 4 — (Optional) Data Persistence with MySQL and DBeaver in Spring MVC

##Purpose of this optional topic

In Topic 3 we learned how to create and process forms in Spring MVC. Until now, courses were stored in an in-memory list within Java:

```java
private final List<Course> courses = new ArrayList<>();
```

This was enough to learn the flow of a form, but it has an important limitation: when we restart the application, the added data disappears.

In this topic we are going to change that list for a MySQL database. We will use DBeaver to create and query the database, and Spring JDBC to connect our Spring MVC application with MySQL.

At the end of this optional topic, the flow will be as follows:

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

The user will continue using the application the same as before: they will see a list of courses, they will be able to enter the details of a course and they will be able to create a new course using a form. The difference will be that the data will be saved persistently in MySQL.

---

## 1. What are we going to modify

We start from the project that we already had in Topic 3.

Until now, the application had these routes:

```text
GET  /courses             → muestra el listado de cursos
GET  /courses/detail?id=1 → muestra el detalle de un curso
GET  /courses/new         → muestra el formulario de creación
POST /courses             → procesa el formulario y crea un curso
```

These routes will not change.

What changes is the way of obtaining and saving the data.

Before we had this internal structure:

```text
CourseController
        ↓
CourseService
        ↓
ArrayList<Course>
```

Now we will have this:

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

The controller will continue to call the service. The service will continue to offer methods such as `findAll()`, `findById()` and `save()`. But inside, those methods will no longer work with an in-memory list, but with a database.

---

## 2. Final project structure

We will add a new package called `dao`.

The structure of the project will be like this:

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

The new files will be:

```text
CourseDao.java
JdbcCourseDao.java
```

The files that we will modify will be:

```text
pom.xml
app-servlet.xml
CourseService.java
```

The controller and views don't need any major changes, because they were already well separated from the data logic.

---

[![Connection with MySQL](https://img.youtube.com/vi/ulrXpghgoqM/0.jpg)](https://www.youtube.com/watch?v=ulrXpghgoqM&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 3. Create the database in DBeaver

First we open DBeaver and create a connection to MySQL.

The usual connection details are:

```text
Host: localhost
Port: 3306
User: root
Password: la contraseña de MySQL de cada alumno
```

If DBeaver asks to download the MySQL driver, we accept.

Then we open a SQL editor and execute the following script.

---

## 4. Complete SQL script

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

## 5. SQL script explanation

We create the database with:

```sql
CREATE DATABASE IF NOT EXISTS spring_mvc_courses
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
```

The database name will be:

```text
spring_mvc_courses
```

We use `utf8mb4` so that the database correctly accepts characters such as accents, eñes and other symbols.

Then we select that database:

```sql
USE spring_mvc_courses;
```

Then we create the table:

```sql
CREATE TABLE IF NOT EXISTS courses (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(80) NOT NULL,
    level VARCHAR(30) NOT NULL,
    duration_in_hours INT NOT NULL
);
```

The table is called `courses` and will have these columns:

| Column | Type | Meaning |
| ------------------- | ------------- | -------------------------- |
| `id` | `BIGINT` | Unique course identifier |
| `title` | `VARCHAR(80)` | Course title |
| `level` | `VARCHAR(30)` | Course level |
| `duration_in_hours` | `INT` | Duration in hours |
The `id` column has:

```sql
PRIMARY KEY AUTO_INCREMENT
```

This means that MySQL will automatically generate a different identifier for each course.

Then we insert some initial courses:

```sql
INSERT INTO courses (title, level, duration_in_hours)
VALUES
    ('Spring MVC desde cero', 'Inicial', 20),
    ('Spring MVC con formularios', 'Intermedio', 15),
    ('Spring MVC avanzado', 'Avanzado', 25);
```

We do not write the `id`, because MySQL generates it automatically.

Finally we check the data with:

```sql
SELECT * FROM courses;
```

The result should look like this:

```text
id | title                         | level      | duration_in_hours
1  | Spring MVC desde cero          | Inicial    | 20
2  | Spring MVC con formularios     | Intermedio | 15
3  | Spring MVC avanzado            | Avanzado   | 25
```

---

## 6. Update `pom.xml` file

Now we have to add the necessary dependencies to connect Java with MySQL.

We need two new dependencies:

```text
spring-jdbc
mysql-connector-j
```

The first allows us to use `JdbcTemplate`, a Spring class that simplifies working with SQL.

The second is the driver that allows Java to communicate with MySQL.

Inside `<dependencies>`, we add:

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

The complete block of dependencies can look like this:

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

After modifying the `pom.xml`, in IntelliJ we must reload Maven so that it downloads the new dependencies.

Normally IntelliJ displays an icon or message to make `Reload Maven Project`. We can also open the Maven window and press the reload icon.

---

## 7. Set the connection to `app-servlet.xml`

Now we have to tell Spring how to connect to MySQL.

We modify this file:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

We will add two beans:

```text
dataSource
jdbcTemplate
```

The file will look like this:

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

## 8. Explanation of `dataSource`

The `dataSource` bean represents the connection to MySQL:

```xml
<bean id="dataSource"
      class="org.springframework.jdbc.datasource.DriverManagerDataSource">
```

Inside we indicate the driver:

```xml
<property name="driverClassName" value="com.mysql.cj.jdbc.Driver" />
```

Then we configure the connection URL:

```xml
<property name="url"
          value="jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&amp;serverTimezone=Europe/Madrid" />
```

The URL can be split like this:

```text
jdbc:mysql://localhost:3306/spring_mvc_courses
```

| Part | Meaning |
| -------------------- | -------------------------------- |
| `jdbc:mysql://` | Indicates that we use JDBC with MySQL |
| `localhost` | MySQL is on our computer |
| `3306` | Usual MySQL port |
| `spring_mvc_courses` | Database name |

Then these parameters appear:

```text
useSSL=false
serverTimezone=Europe/Madrid
```

In XML we cannot write `&` directly inside an attribute, so we write:

```xml
&amp;
```

Therefore, the URL looks like this:

```xml
?useSSL=false&amp;serverTimezone=Europe/Madrid
```

We also indicate username and password:

```xml
<property name="username" value="root" />
<property name="password" value="TU_PASSWORD" />
```

Each student must replace:

```text
TU_PASSWORD
```

by the actual password of your MySQL.

In a real application it is not advisable to leave passwords written directly in an XML, but for this introductory course it allows us to understand the process in a simple way.

---

## 9. Explanation of `JdbcTemplate`

The second bean is:

```xml
<bean id="jdbcTemplate"
      class="org.springframework.jdbc.core.JdbcTemplate">

    <property name="dataSource" ref="dataSource" />
</bean>
```

`JdbcTemplate` is the object we will use to execute SQL queries from Java.

You need an `DataSource` to know which database to connect to.

The relationship is this:

```text
JdbcTemplate
      ↓
DataSource
      ↓
MySQL
```

Thanks to `JdbcTemplate`, we will not have to manually open and close connections on each query. Spring takes care of much of the repetitive work of JDBC.

---

## 10. Create the `CourseDao` interface

Now we create a new package:

```text
com.example.springmvcday1.dao
```

Inside that package we create the file:

```text
CourseDao.java
```

Code:

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

## 11. `CourseDao` Explanation
DAO means:

```text
Data Access Object
```

A DAO is a class or interface in charge of defining data access operations.

In this case, our interface defines three operations:

```java
List<Course> findAll();
```

It is used to obtain all the courses.

```java
Course findById(Long id);
```

Used to search for a course by its identifier.

```java
void save(Course course);
```

It is used to save a new course.

This interface does not have SQL. It just says what operations we need.

We will do the actual implementation in another class called `JdbcCourseDao`.

---

## 12. Create the `JdbcCourseDao` class

Within the same package:

```text
com.example.springmvcday1.dao
```

we create the file:

```text
JdbcCourseDao.java
```

Code:

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

## 13. `JdbcCourseDao` Explanation

The class starts with:

```java
@Repository
public class JdbcCourseDao implements CourseDao {
```

The `@Repository` annotation tells Spring that this class belongs to the data access layer.

As in `app-servlet.xml` we have this line:

```xml
<context:component-scan base-package="com.example.springmvcday1" />
```

Spring will look for classes annotated within the `com.example.springmvcday1` package and automatically register `JdbcCourseDao` as a bean.

The class implements the interface:

```java
implements CourseDao
```

This means that you must implement the methods defined in `CourseDao`:

```java
findAll()
findById(Long id)
save(Course course)
```

---

## 14. `JdbcTemplate` injection

Inside `JdbcCourseDao` we have:

```java
private final JdbcTemplate jdbcTemplate;
```

And the constructor:

```java
public JdbcCourseDao(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
}
```

This means that `JdbcCourseDao` needs an `JdbcTemplate` object to work.

Spring will automatically inject it using the bean we had configured in XML:

```xml
<bean id="jdbcTemplate"
      class="org.springframework.jdbc.core.JdbcTemplate">
```

The chain of dependencies looks like this:

```text
JdbcCourseDao necesita JdbcTemplate
JdbcTemplate necesita DataSource
DataSource contiene la conexión a MySQL
```

---

## 15. Convert SQL rows to Java objects with `RowMapper`

A database returns rows and columns.

Java works with objects.

That's why we need to convert each row of the `courses` table into an `Course` object.

We do that with an `RowMapper`:

```java
private final RowMapper<Course> courseRowMapper = (resultSet, rowNumber) ->
        new Course(
                resultSet.getLong("id"),
                resultSet.getString("title"),
                resultSet.getString("level"),
                resultSet.getInt("duration_in_hours")
        );
```

`resultSet` represents a row returned by MySQL.

For example, if MySQL returns this row:

```text
id: 1
title: Spring MVC desde cero
level: Inicial
duration_in_hours: 20
```

the `RowMapper` creates this object:

```java
new Course(
        1L,
        "Spring MVC desde cero",
        "Inicial",
        20
);
```

The `RowMapper` will be used in `SELECT` queries.

---

## 16. `findAll()` method

The `findAll()` method gets all the courses in the database.

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

First we define the SQL query:

```sql
SELECT id, title, level, duration_in_hours
FROM courses
ORDER BY id
```

This query asks for all courses sorted by their identifier.

Then we execute:

```java
jdbcTemplate.query(sql, courseRowMapper);
```

This means:

```text
Ejecuta la consulta SQL.
Por cada fila devuelta, usa courseRowMapper.
Devuelve una lista de objetos Course.
```

The final result will be an `List<Course>`.

---

## 17. `findById(Long id)` method

This method searches for a specific course by its identifier.

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

The SQL query is:

```sql
SELECT id, title, level, duration_in_hours
FROM courses
WHERE id = ?
```

The sign `?` is a parameter.

We don't do this:

```java
"SELECT * FROM courses WHERE id = " + id
```

because concatenating values within a SQL query is less safe and less clean.

Instead we do:

```java
jdbcTemplate.query(sql, courseRowMapper, id);
```

So `JdbcTemplate` passes the value of `id` as a query parameter.

The result will be a list. It may contain a course or it may be empty.

That's why in the end we write:

```java
return courses.stream()
        .findFirst()
        .orElse(null);
```

This means:

```text
Si hay un curso, devuelve el primero.
Si no hay ninguno, devuelve null.
```

---

## 18. `save(Course course)` method

This method saves a new course to the database.

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

The query is:

```sql
INSERT INTO courses (title, level, duration_in_hours)
VALUES (?, ?, ?)
```

We do not insert the `id`, because MySQL generates it automatically.
The three signs `?` represent:

| Position | Value |
| -------- | ------------------ |
| `1` | course title |
| `2` | course level |
| `3` | course duration |

Then we create an `KeyHolder`:

```java
KeyHolder keyHolder = new GeneratedKeyHolder();
```

This object allows us to retrieve the identifier generated by MySQL.

Then we prepare the `PreparedStatement`:

```java
PreparedStatement preparedStatement = connection.prepareStatement(
        sql,
        Statement.RETURN_GENERATED_KEYS
);
```

The important part is:

```java
Statement.RETURN_GENERATED_KEYS
```

This tells JDBC that we want to retrieve the automatically generated key.

Then we put the values:

```java
preparedStatement.setString(1, course.getTitle());
preparedStatement.setString(2, course.getLevel());
preparedStatement.setInt(3, course.getDurationInHours());
```

If the user has sent the form with this data:

```text
Título: Java Web con Spring
Nivel: Inicial
Duración: 12
```

the final query will insert those values into the table.

Then we recover the generated id:

```java
Number generatedId = keyHolder.getKey();
```

And we assign it to the Java object:

```java
if (generatedId != null) {
    course.setId(generatedId.longValue());
}
```

Thus the `Course` object also knows its new identifier.

---

## 19. Update `CourseService`

Now the service should no longer work with an in-memory list.

Before we had something similar to this:

```java
private final List<Course> courses = new ArrayList<>();
```

The service should now use `CourseDao`.

We modify the file:

```text
src/main/java/com/example/springmvcday1/service/CourseService.java
```

Updated code:

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

## 20. `CourseService` Explanation

The service now has this dependency:

```java
private final CourseDao courseDao;
```

And receives it by constructor:

```java
public CourseService(CourseDao courseDao) {
    this.courseDao = courseDao;
}
```

This means that `CourseService` does not know exactly how the data is saved.

It only knows that there is an `CourseDao` object capable of doing this:

```java
findAll()
findById(id)
save(course)
```

The specific class that implements those operations is `JdbcCourseDao`, but the service does not need to know the details.

This leaves us with a cleaner architecture:

| Class | Responsibility |
| ------------------ | ----------------------------------------- |
| `CourseController` | Receive web requests |
| `CourseService` | Coordinates logic related to courses |
| `CourseDao` | Defines data access operations |
| `JdbcCourseDao` | Run SQL against MySQL |
| `JdbcTemplate` | Makes JDBC easy to use |
| `DataSource` | Defines the connection to the database |

---

## 21. Should the driver be changed?

In principle, no.

The controller was already calling the service:

```java
courseService.findAll();
courseService.findById(id);
courseService.save(course);
```

That means the driver doesn't know if the data is coming from an in-memory list or from MySQL.

That's an advantage of separating the application into layers.

For example, the method that saves a course can stay the same:

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

Before, this line:

```java
courseService.save(course);
```

added the course to a list.

Now that same line ends up executing an `INSERT` in MySQL.

---

## 22. Do I have to change JSP views?

Neither.

The views still receive the same data:

```text
courses
course
pageTitle
successMessage
```

For example, `list.jsp` can continue looping through the list like this:

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

The eye does not need to know where the courses come from.

You only need to receive a list of `Course` objects.

---

## 23. Complete flow when listing courses

When the user enters:

```text
/courses
```

this happens:

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

The main method of the DAO is:

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
## 24. Complete flow when creating a course

When the user enters:

```text
/courses/new
```

Spring displays the form.

When the user fills out the form and presses the button, the browser sends:

```text
POST /courses
```

Then this happens:

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

The main method of the DAO is:

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

## 25. Checking in DBeaver

After creating a course from the web application, we return to DBeaver and run:

```sql
SELECT * FROM courses;
```

If everything has worked well, the new course will appear in the table.

For example:

```text
id | title                   | level      | duration_in_hours
1  | Spring MVC desde cero    | Inicial    | 20
2  | Spring MVC formularios   | Intermedio | 15
3  | Spring MVC avanzado      | Avanzado   | 25
4  | Java Web con Spring      | Inicial    | 12
```

This confirms that the course has no longer been saved just in memory, but in MySQL.

---

## 26. Comparison: in-memory version and version with MySQL

### Before

```text
CourseController
        ↓
CourseService
        ↓
ArrayList<Course>
```

Advantages:

```text
Es sencilla.
Es rápida para aprender formularios.
No necesita base de datos.
```

Limitations:

```text
Los datos se pierden al reiniciar.
No se pueden consultar desde DBeaver.
No representa una aplicación real con persistencia.
```

### Now

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

Advantages:

```text
Los datos permanecen.
Podemos consultar la tabla desde DBeaver.
La aplicación se parece más a un proyecto real.
La capa web queda separada de la capa de datos.
```

Limitations:

```text
Necesitamos tener MySQL funcionando.
Hay más configuración.
Pueden aparecer errores de conexión si los datos no son correctos.
```

---

## 27. Common mistakes and how to solve them

### Error 1: Do not change `TU_PASSWORD`

`app-servlet.xml` appears:

```xml
<property name="password" value="TU_PASSWORD" />
```

You must replace `TU_PASSWORD` with the real MySQL password.

---

### Error 2: MySQL is not started

If MySQL is not running, the application will not be able to connect.

The error may mention something like:

```text
Communications link failure
```

or:

```text
Connection refused
```

Solution: Start the MySQL service and check that DBeaver can connect.

---

### Error 3: Database does not exist

If in the URL we write:

```text
spring_mvc_courses
```

but we have not created that database, the application will fail.

Solution: Run in DBeaver:

```sql
CREATE DATABASE IF NOT EXISTS spring_mvc_courses;
```

---

### Error 4: `courses` table does not exist

If the database exists but the table does not, queries will fail.

Solution: run:

```sql
CREATE TABLE IF NOT EXISTS courses (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(80) NOT NULL,
    level VARCHAR(30) NOT NULL,
    duration_in_hours INT NOT NULL
);
```

---

### Error 5: `spring-jdbc` is missing

If IntelliJ does not recognize `JdbcTemplate`, this dependency may be missing:

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-jdbc</artifactId>
    <version>${spring.version}</version>
</dependency>
```

After adding it, you have to reload Maven.

---

### Error 6: MySQL driver is missing

If this dependency is missing:

```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>9.7.0</version>
</dependency>
```

the application will not be able to use the driver:

```text
com.mysql.cj.jdbc.Driver
```

Solution: add the dependency and reload Maven.

---

### Error 7: misspelling a column name

In Java we use:

```java
resultSet.getInt("duration_in_hours")
```

Therefore, the table must have a column named exactly:

```text
duration_in_hours
```

If the column is named `duration`, `durationInHours`, or anything else, the query will fail.

---

### Error 8: Using `&` instead of `&amp;` within the XML

Incorrect:

```xml
value="jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&serverTimezone=Europe/Madrid"
```

Correct:

```xml
value="jdbc:mysql://localhost:3306/spring_mvc_courses?useSSL=false&amp;serverTimezone=Europe/Madrid"
```

In XML, the character `&` must be written as `&amp;`.

---

### Error 9: Not reloading Maven after modifying `pom.xml`

After adding dependencies, IntelliJ needs to download them.

If Maven is not reloaded, it may appear as if the classes do not exist.

Solution: use `Reload Maven Project`.

---

### Error 10: inserting duplicate data when running the script multiple times

If we execute this block several times:

```sql
INSERT INTO courses (title, level, duration_in_hours)
VALUES
    ('Spring MVC desde cero', 'Inicial', 20),
    ('Spring MVC con formularios', 'Intermedio', 15),
    ('Spring MVC avanzado', 'Avanzado', 25);
```

the same courses will be inserted multiple times.

To avoid this during testing, we can first clear the table:

```sql
DELETE FROM courses;
```

And if we want to reset the id counter:

```sql
ALTER TABLE courses AUTO_INCREMENT = 1;
```

Then we can reinsert the initial data.

---

## 28. Final checklist
Before trying the app, check this:

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

## 29. Final summary

In this topic we have replaced in-memory storage with real persistence in MySQL.

Before, the data was here:

```text
ArrayList<Course>
```

Now they are here:

```text
Tabla courses en MySQL
```

The application maintains the same visual part:

```text
list.jsp
form.jsp
detail.jsp
```

And the same controller:

```text
CourseController
```

But internally we now have a more complete architecture:

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

The most important idea is that persistence should not be mixed with controller.

The controller takes care of the web part.

The DAO takes care of the database.

The service remains in the middle, coordinating the operations of the application.

With this extension, the form in Topic 3 no longer just creates objects in memory: it now creates actual records in a MySQL table that can be queried from DBeaver.
