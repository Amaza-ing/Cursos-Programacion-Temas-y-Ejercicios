# Exercises Topic 4 (Optional): Connecting to MySQL with DBeaver

## Introduction

In this optional topic you'll practice how to connect a **classic Spring MVC** application to a **MySQL** database using **DBeaver** and **Spring JDBC**.

The idea is to replace an in-memory list with persistent data in a database.

In the exercises we'll work with a small **product inventory** application, different from the course's main example.

You'll practice:

- Creating a database from DBeaver.
- Creating tables with SQL.
- Inserting initial data.
- Adding the necessary dependencies to `pom.xml`.
- Configuring a `DataSource`.
- Configuring `JdbcTemplate`.
- Creating a DAO interface.
- Creating a DAO implementation with JDBC.
- Converting SQL rows into Java objects with `RowMapper`.
- Running `SELECT` queries.
- Running `INSERT` queries.
- Retrieving automatically generated keys.
- Connecting the controller, service, DAO and database.

Each solution is hidden under the **show solution** button.

---

# Exercise 1 — Create the database in MySQL from DBeaver

## Statement

Create a database for an inventory application.

The database must be called:

```text
spring_mvc_inventory
```

It must use an encoding that supports accents, the letter ñ and special characters.

Write the SQL script needed to create and select it.

---

<details>
<summary>Show solution</summary>

```sql
CREATE DATABASE IF NOT EXISTS spring_mvc_inventory
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE spring_mvc_inventory;
```

### Explanation

The statement:

```sql
CREATE DATABASE IF NOT EXISTS spring_mvc_inventory
```

creates the database only if it does not already exist.

We use:

```sql
CHARACTER SET utf8mb4
```

to allow special characters, accents, the letter ñ and symbols.

Then we use:

```sql
USE spring_mvc_inventory;
```

to indicate that the following SQL statements will run in that database.

</details>

---

# Exercise 2 — Create the `items` table

## Statement

Create a table named `items` to store inventory products.

The table must have these columns:

| Column | Type | Constraint |
|---|---|---|
| `id` | `BIGINT` | Auto-increment primary key |
| `name` | `VARCHAR(80)` | Required |
| `brand` | `VARCHAR(60)` | Required |
| `price` | `DECIMAL(10,2)` | Required |
| `quantity` | `INT` | Required |

Write the SQL to create the table.

---

<details>
<summary>Show solution</summary>

```sql
CREATE TABLE IF NOT EXISTS items (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    brand VARCHAR(60) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL
);
```

### Explanation

The table is called:

```sql
items
```

The column:

```sql
id BIGINT PRIMARY KEY AUTO_INCREMENT
```

will be the unique identifier of each product.

`AUTO_INCREMENT` makes MySQL generate the next identifier automatically.

The columns:

```sql
name
brand
price
quantity
```

have `NOT NULL`, so they can't be saved empty in the database.

</details>

---

# Exercise 3 — Insert initial data

## Statement

Insert four initial products into the `items` table.

The products must be different from the ones in the main course.

You can use this data:

| name | brand | price | quantity |
|---|---|---|---|
| 24-inch monitor | ViewMax | 139.99 | 8 |
| Ergonomic chair | ComfortPro | 189.50 | 5 |
| LED lamp | BrightHome | 24.90 | 20 |
| Bluetooth headphones | SoundBeat | 49.99 | 14 |

Then write a query to verify that they were inserted correctly.

---

<details>
<summary>Show solution</summary>

```sql
INSERT INTO items (name, brand, price, quantity)
VALUES
    ('Monitor 24 pulgadas', 'ViewMax', 139.99, 8),
    ('Silla ergonómica', 'ComfortPro', 189.50, 5),
    ('Lámpara LED', 'BrightHome', 24.90, 20),
    ('Auriculares Bluetooth', 'SoundBeat', 49.99, 14);

SELECT * FROM items;
```

### Explanation

We don't insert the `id` manually because MySQL generates it automatically.

That's why we write:

```sql
INSERT INTO items (name, brand, price, quantity)
```

and not:

```sql
INSERT INTO items (id, name, brand, price, quantity)
```

The query:

```sql
SELECT * FROM items;
```

lets you check in DBeaver that the records have been saved correctly.

</details>

---

# Exercise 4 — Create the complete SQL script

## Statement

Combine the previous exercises into a single SQL script that:

1. Creates the database.
2. Selects it.
3. Creates the table.
4. Inserts the initial data.
5. Displays the inserted data.

---

<details>
<summary>Show solution</summary>

```sql
CREATE DATABASE IF NOT EXISTS spring_mvc_inventory
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE spring_mvc_inventory;

CREATE TABLE IF NOT EXISTS items (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    brand VARCHAR(60) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL
);

INSERT INTO items (name, brand, price, quantity)
VALUES
    ('Monitor 24 pulgadas', 'ViewMax', 139.99, 8),
    ('Silla ergonómica', 'ComfortPro', 189.50, 5),
    ('Lámpara LED', 'BrightHome', 24.90, 20),
    ('Auriculares Bluetooth', 'SoundBeat', 49.99, 14);

SELECT * FROM items;
```

### Explanation

This script can be run directly from DBeaver.

It's useful for quickly setting up the database for all the students.

If you run it twice, the database and the table aren't duplicated because we use:

```sql
IF NOT EXISTS
```

However, the `INSERT` statements would run again and could duplicate the products. If you want to avoid duplicates, you can drop the table first or use a more advanced kind of insert.

</details>

---

# Exercise 5 — Add dependencies to `pom.xml`

## Statement

To connect Spring MVC with MySQL using JDBC, add the necessary dependencies to `pom.xml` to:

1. Use `JdbcTemplate`.
2. Use the MySQL driver.

Write only the necessary dependencies.

---

<details>
<summary>Show solution</summary>

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
    <version>9.2.0</version>
</dependency>
```

### Explanation

The dependency:

```xml
spring-jdbc
```

allows us to use classes like:

```java
JdbcTemplate
RowMapper
GeneratedKeyHolder
```

The dependency:

```xml
mysql-connector-j
```

is the driver that lets Java connect to MySQL.

Without the MySQL driver, Java would not know how to interpret a URL like:

```text
jdbc:mysql://localhost:3306/spring_mvc_inventory
```

</details>

---

# Exercise 6 — Configure `DataSource` and `JdbcTemplate` in XML

## Statement

Modify the file:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

to add:

1. A `dataSource` bean using `DriverManagerDataSource`.
2. A `jdbcTemplate` bean using that `dataSource`.

Use these connection details:

```text
Driver: com.mysql.cj.jdbc.Driver
URL: jdbc:mysql://localhost:3306/spring_mvc_inventory?useSSL=false&serverTimezone=Europe/Madrid
Usuario: root
Contraseña: TU_PASSWORD
```

Remember that in XML the character `&` must be written as `&amp;`.

---

<details>
<summary>Show solution</summary>

```xml
<!-- Conexión a MySQL -->
<bean id="dataSource"
      class="org.springframework.jdbc.datasource.DriverManagerDataSource">

    <property name="driverClassName" value="com.mysql.cj.jdbc.Driver" />

    <property name="url"
              value="jdbc:mysql://localhost:3306/spring_mvc_inventory?useSSL=false&amp;serverTimezone=Europe/Madrid" />

    <property name="username" value="root" />
    <property name="password" value="TU_PASSWORD" />
</bean>

<!-- Objeto de Spring para ejecutar SQL -->
<bean id="jdbcTemplate"
      class="org.springframework.jdbc.core.JdbcTemplate">

    <property name="dataSource" ref="dataSource" />
</bean>
```

### Explanation

The bean:

```xml
<bean id="dataSource" ...>
```

contains the data necessary to open a connection with MySQL.

The bean:

```xml
<bean id="jdbcTemplate" ...>
```

uses that `dataSource` to run SQL queries.

The relationship is:

```text
JdbcTemplate
      ↓
DataSource
      ↓
MySQL
```

In XML we can't write this directly:

```xml
&serverTimezone=Europe/Madrid
```

because `&` has a special meaning.

That's why we write:

```xml
&amp;serverTimezone=Europe/Madrid
```

</details>

---

# Exercise 7 — Create the `Item` model

## Statement

Create a class called `Item` in the package:

```text
com.example.inventory.model
```

It must represent the data from the `items` table.

The class must have:

| Attribute | Java type |
|---|---|
| `id` | `Long` |
| `name` | `String` |
| `brand` | `String` |
| `price` | `Double` |
| `quantity` | `Integer` |

Add an empty constructor, a constructor with all the fields, getters and setters.

---

<details>
<summary>Show solution</summary>

```java
package com.example.inventory.model;

public class Item {

    private Long id;
    private String name;
    private String brand;
    private Double price;
    private Integer quantity;

    public Item() {
    }

    public Item(Long id, String name, String brand, Double price, Integer quantity) {
        this.id = id;
        this.name = name;
        this.brand = brand;
        this.price = price;
        this.quantity = quantity;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getBrand() {
        return brand;
    }

    public Double getPrice() {
        return price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}
```

### Explanation

The `Item` class represents a row in the `items` table.

For example, this row:

```text
id: 1
name: Monitor 24 pulgadas
brand: ViewMax
price: 139.99
quantity: 8
```

will be converted into a Java object:

```java
new Item(1L, "Monitor 24 pulgadas", "ViewMax", 139.99, 8);
```

We use `Double` and `Integer` instead of `double` and `int` so that we can represent null values if necessary.

</details>

---

# Exercise 8 — Create the `ItemDao` interface

## Statement

Create an interface named `ItemDao` in the package:

```text
com.example.inventory.dao
```

It must declare these methods:

```java
List<Item> findAll();

Item findById(Long id);

void save(Item item);
```

---

<details>
<summary>Show solution</summary>

```java
package com.example.inventory.dao;

import com.example.inventory.model.Item;

import java.util.List;

public interface ItemDao {

    List<Item> findAll();

    Item findById(Long id);

    void save(Item item);
}
```

### Explanation

The DAO interface defines what data access operations the application needs.

It doesn't contain SQL.

It only declares operations:

```java
findAll()
findById()
save()
```

The advantage of using an interface is that we could change the implementation later.

For example, we'll use JDBC now, but later we could use JPA or Hibernate without changing the service.

</details>

---

# Exercise 9 — Create a `RowMapper` to convert rows into objects

## Statement

Let's create the class `JdbcItemDao`.

Before implementing all its methods, write a `RowMapper<Item>` called `itemRowMapper` inside the class.

It must convert the SQL columns:

```text
id
name
brand
price
quantity
```

into an `Item` object.

---

<details>
<summary>Show solution</summary>

```java
private final RowMapper<Item> itemRowMapper = (resultSet, rowNumber) ->
        new Item(
                resultSet.getLong("id"),
                resultSet.getString("name"),
                resultSet.getString("brand"),
                resultSet.getDouble("price"),
                resultSet.getInt("quantity")
        );
```

### Explanation

An SQL query returns rows.

Java works with objects.

The `RowMapper` is used to convert each row of the result into a Java object.

For example, if MySQL returns:

```text
id = 2
name = Silla ergonómica
brand = ComfortPro
price = 189.50
quantity = 5
```

the `RowMapper` creates:

```java
new Item(2L, "Silla ergonómica", "ComfortPro", 189.50, 5);
```

</details>

---

# Exercise 10 — Create `JdbcItemDao` with the `findAll` method

## Statement

Create the class:

```text
com.example.inventory.dao.JdbcItemDao
```

It must:

1. Be annotated with `@Repository`.
2. Implement `ItemDao`.
3. Receive a `JdbcTemplate` through its constructor.
4. Have a `RowMapper<Item>`.
5. Implement the `findAll()` method.

The query must get all the products ordered by `id`.

---

<details>
<summary>Show solution</summary>

```java
package com.example.inventory.dao;

import com.example.inventory.model.Item;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class JdbcItemDao implements ItemDao {

    private final JdbcTemplate jdbcTemplate;

    public JdbcItemDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Item> itemRowMapper = (resultSet, rowNumber) ->
            new Item(
                    resultSet.getLong("id"),
                    resultSet.getString("name"),
                    resultSet.getString("brand"),
                    resultSet.getDouble("price"),
                    resultSet.getInt("quantity")
            );

    @Override
    public List<Item> findAll() {
        String sql = """
                SELECT id, name, brand, price, quantity
                FROM items
                ORDER BY id
                """;

        return jdbcTemplate.query(sql, itemRowMapper);
    }

    @Override
    public Item findById(Long id) {
        return null;
    }

    @Override
    public void save(Item item) {
    }
}
```

### Explanation

The annotation:

```java
@Repository
```

indicates that this class belongs to the data access layer.

Spring will automatically detect it if the `component-scan` includes the correct base package.

The method:

```java
jdbcTemplate.query(sql, itemRowMapper)
```

runs the query and converts each row to an `Item` object.

The result is:

```java
List<Item>
```

In this exercise we leave `findById` and `save` unimplemented to focus on the listing first.

</details>

---

# Exercise 11 — Implement `findById`

## Statement

Complete the `findById(Long id)` method of `JdbcItemDao`.

It must run a query to look up a product by its ID.

If it exists, it must return it.

If it does not exist, it must return `null`.

---

<details>
<summary>Show solution</summary>

```java
@Override
public Item findById(Long id) {
    String sql = """
            SELECT id, name, brand, price, quantity
            FROM items
            WHERE id = ?
            """;

    List<Item> items = jdbcTemplate.query(sql, itemRowMapper, id);

    return items.stream()
            .findFirst()
            .orElse(null);
}
```

### Explanation
The query uses a parameter:

```sql
WHERE id = ?
```

That `?` is replaced by the value of `id` when we run:

```java
jdbcTemplate.query(sql, itemRowMapper, id);
```

It is better to use parameters than to manually concatenate SQL text.

We don't do this:

```java
"SELECT * FROM items WHERE id = " + id
```

because it is less secure and more prone to errors.

Since the query may not return results, we save the result in a list:

```java
List<Item> items
```

Then we return the first element or `null`:

```java
return items.stream()
        .findFirst()
        .orElse(null);
```

</details>

---

# Exercise 12 — Implement `save` with `INSERT`

## Statement

Complete the `save(Item item)` method of `JdbcItemDao`.

It must insert a new product into the `items` table.

It must not insert the `id`, because MySQL generates it automatically.

The SQL query must insert:

```text
name
brand
price
quantity
```

---

<details>
<summary>Show solution</summary>

```java
@Override
public void save(Item item) {
    String sql = """
            INSERT INTO items (name, brand, price, quantity)
            VALUES (?, ?, ?, ?)
            """;

    jdbcTemplate.update(
            sql,
            item.getName(),
            item.getBrand(),
            item.getPrice(),
            item.getQuantity()
    );
}
```

### Explanation

The query is:

```sql
INSERT INTO items (name, brand, price, quantity)
VALUES (?, ?, ?, ?)
```

We don't insert the `id` because the column is configured with:

```sql
AUTO_INCREMENT
```

The method:

```java
jdbcTemplate.update(...)
```

is used to run operations that modify the database, such as:

```sql
INSERT
UPDATE
DELETE
```

The values are passed in the same order as the `?` signs:

```java
item.getName()
item.getBrand()
item.getPrice()
item.getQuantity()
```

</details>

---

# Exercise 13 — Implement `save` and retrieve the generated id

## Statement

Improve the `save(Item item)` method so that, after inserting the product, it retrieves the `id` generated automatically by MySQL and assigns it to the `item` object.

Use:

```java
GeneratedKeyHolder
KeyHolder
Statement.RETURN_GENERATED_KEYS
```

---

<details>
<summary>Show solution</summary>

```java
@Override
public void save(Item item) {
    String sql = """
            INSERT INTO items (name, brand, price, quantity)
            VALUES (?, ?, ?, ?)
            """;

    KeyHolder keyHolder = new GeneratedKeyHolder();

    jdbcTemplate.update(connection -> {
        PreparedStatement preparedStatement = connection.prepareStatement(
                sql,
                Statement.RETURN_GENERATED_KEYS
        );

        preparedStatement.setString(1, item.getName());
        preparedStatement.setString(2, item.getBrand());
        preparedStatement.setDouble(3, item.getPrice());
        preparedStatement.setInt(4, item.getQuantity());

        return preparedStatement;
    }, keyHolder);

    Number generatedId = keyHolder.getKey();

    if (generatedId != null) {
        item.setId(generatedId.longValue());
    }
}
```

### Required imports

```java
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import java.sql.PreparedStatement;
import java.sql.Statement;
```

### Explanation

When MySQL inserts a row with `AUTO_INCREMENT`, it generates a new identifier.

If we want to retrieve that identifier from Java, we use:

```java
KeyHolder keyHolder = new GeneratedKeyHolder();
```

Then we prepare the query with:

```java
Statement.RETURN_GENERATED_KEYS
```

This indicates that we want to retrieve the generated key.

Finally we get the id:

```java
Number generatedId = keyHolder.getKey();
```

and we assign it to the object:

```java
item.setId(generatedId.longValue());
```

This way, the Java object stays in sync with the row inserted in MySQL.

</details>

---

# Exercise 14 — Create the `ItemService` service

## Statement

Create a class called `ItemService` in the package:

```text
com.example.inventory.service
```

It must:

1. Be annotated with `@Service`.
2. Receive `ItemDao` through its constructor.
3. Have the methods:
   - `findAll()`
   - `findById(Long id)`
   - `save(Item item)`

Each method must delegate to the DAO.

---

<details>
<summary>Show solution</summary>

```java
package com.example.inventory.service;

import com.example.inventory.dao.ItemDao;
import com.example.inventory.model.Item;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ItemService {

    private final ItemDao itemDao;

    public ItemService(ItemDao itemDao) {
        this.itemDao = itemDao;
    }

    public List<Item> findAll() {
        return itemDao.findAll();
    }

    public Item findById(Long id) {
        return itemDao.findById(id);
    }

    public void save(Item item) {
        itemDao.save(item);
    }
}
```

### Explanation

The service does not contain SQL.

The service coordinates application logic and delegates data access to the DAO.

The chain looks like this:

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

This separation means that the controller does not have to know how the database is accessed.

</details>

---

# Exercise 15 — Create a controller to list products from MySQL

## Statement

Create a controller named `ItemController` in the package:

```text
com.example.inventory.controller
```

It must:

1. Be annotated with `@Controller`.
2. Have the base path `/items`.
3. Receive `ItemService` through its constructor.
4. Have a `GET /items` method.
5. Add to the model:
   - `pageTitle` with the value `Inventario`
   - `items` with the data obtained from MySQL
6. Return the `items/list` view.

---

<details>
<summary>Show solution</summary>

```java
package com.example.inventory.controller;

import com.example.inventory.service.ItemService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/items")
public class ItemController {

    private final ItemService itemService;

    public ItemController(ItemService itemService) {
        this.itemService = itemService;
    }

    @GetMapping
    public String listItems(Model model) {
        model.addAttribute("pageTitle", "Inventario");
        model.addAttribute("items", itemService.findAll());

        return "items/list";
    }
}
```

### Explanation

The controller calls the service:

```java
itemService.findAll()
```

The service calls the DAO:

```java
itemDao.findAll()
```

The DAO executes the SQL query:

```sql
SELECT id, name, brand, price, quantity
FROM items
ORDER BY id
```

The result is returned to the controller as a list of `Item` objects.

</details>

---

# Exercise 16 — Create the `items/list.jsp` view

## Statement

Create the view:

```text
src/main/webapp/WEB-INF/views/items/list.jsp
```

It must show a table with:

```text
Nombre | Marca | Precio | Cantidad | Acción
```

The action column must have a link to the detail page:

```text
/items/detail?id=ID
```

Use JSTL to loop through the list.

---

<details>
<summary>Show solution</summary>

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
        <a href="${pageContext.request.contextPath}/items">Inventario</a>
    </nav>
</header>

<main class="container">
    <section class="card wide">
        <h1>${pageTitle}</h1>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/items/new">
                Añadir producto
            </a>
        </p>

        <table class="table">
            <thead>
            <tr>
                <th>Nombre</th>
                <th>Marca</th>
                <th>Precio</th>
                <th>Cantidad</th>
                <th>Acción</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="item" items="${items}">
                <tr>
                    <td>${item.name}</td>
                    <td>${item.brand}</td>
                    <td>${item.price} €</td>
                    <td>${item.quantity}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/items/detail?id=${item.id}">
                            Ver detalle
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </section>
</main>

</body>
</html>
```

### Explanation

The `items` list comes from the controller:

```java
model.addAttribute("items", itemService.findAll());
```

The view does not know if the data comes from MySQL, an in-memory list, or another system.

It only receives Java objects and displays them.

</details>

---

# Exercise 17 — Add a product detail page from MySQL

## Statement

Add a route to `ItemController`:

```text
GET /items/detail?id=1
```

The method must:

1. Receive the `id` parameter.
2. Look up the product with `itemService.findById(id)`.
3. If it does not exist, return `items/not-found`.
4. If it exists, add `item` and `pageTitle` to the model.
5. Return `items/detail`.

Then create the view `items/detail.jsp`.

---

<details>
<summary>Show solution</summary>

## Method in `ItemController`

```java
@GetMapping("/detail")
public String itemDetail(@RequestParam("id") Long id, Model model) {
    Item item = itemService.findById(id);

    if (item == null) {
        model.addAttribute("pageTitle", "Producto no encontrado");
        model.addAttribute("itemId", id);

        return "items/not-found";
    }

    model.addAttribute("pageTitle", item.getName());
    model.addAttribute("item", item);

    return "items/detail";
}
```

### Required imports

```java
import com.example.inventory.model.Item;
import org.springframework.web.bind.annotation.RequestParam;
```

## View `items/detail.jsp`

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
        <a href="${pageContext.request.contextPath}/items">Inventario</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${item.name}</h1>

        <ul class="details">
            <li>
                <strong>Marca:</strong> ${item.brand}
            </li>
            <li>
                <strong>Precio:</strong> ${item.price} €
            </li>
            <li>
                <strong>Cantidad disponible:</strong> ${item.quantity}
            </li>
            <li>
                <strong>Identificador:</strong> ${item.id}
            </li>
        </ul>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/items">
                Volver al inventario
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

## View `items/not-found.jsp`

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
        <a href="${pageContext.request.contextPath}/items">Inventario</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            No se ha encontrado ningún producto con el identificador ${itemId}.
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/items">
                Volver al inventario
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explanation

The detail method calls:

```java
itemService.findById(id)
```

That method ends up running a SQL query with:

```sql
WHERE id = ?
```

Therefore, the detail is no longer obtained from an in-memory list, but directly from MySQL.

</details>

---

# Exercise 18 — Create a form to insert into MySQL

## Statement

Add two methods to `ItemController`:

```text
GET  /items/new
POST /items
```

The `GET` method must show an empty form.

The `POST` method must receive an `Item` with `@ModelAttribute`, save it using `itemService.save(item)` and redirect to `/items`.

Don't add validation yet in this exercise.

---

<details>
<summary>Show solution</summary>

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    model.addAttribute("pageTitle", "Añadir producto");
    model.addAttribute("item", new Item());

    return "items/form";
}

@PostMapping
public String createItem(@ModelAttribute("item") Item item) {
    itemService.save(item);

    return "redirect:/items";
}
```

### Required imports

```java
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
```

### Explanation

The `GET` method creates an empty object:

```java
new Item()
```

and sends it to the form with the name:

```text
item
```

The `POST` method receives the already populated object:

```java
@ModelAttribute("item") Item item
```

Then it calls:

```java
itemService.save(item)
```

The service delegates to the DAO, and the DAO executes the `INSERT` in MySQL.

</details>

---

# Exercise 19 — Create the `items/form.jsp` view

## Statement

Create the view:

```text
src/main/webapp/WEB-INF/views/items/form.jsp
```

It must have a form that submits via `POST` to `/items`.

The form must be bound to the `item` attribute and have fields for:

```text
name
brand
price
quantity
```

Use Spring's form tags.

---

<details>
<summary>Show solution</summary>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
        <a href="${pageContext.request.contextPath}/items">Inventario</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <form:form
                method="post"
                action="${pageContext.request.contextPath}/items"
                modelAttribute="item"
                cssClass="form">

            <div class="form-group">
                <form:label path="name">Nombre</form:label>
                <form:input path="name" cssClass="input" />
            </div>

            <div class="form-group">
                <form:label path="brand">Marca</form:label>
                <form:input path="brand" cssClass="input" />
            </div>

            <div class="form-group">
                <form:label path="price">Precio</form:label>
                <form:input path="price" type="number" step="0.01" cssClass="input" />
            </div>

            <div class="form-group">
                <form:label path="quantity">Cantidad</form:label>
                <form:input path="quantity" type="number" cssClass="input" />
            </div>

            <div class="form-actions">
                <button type="submit" class="button">
                    Guardar producto
                </button>

                <a class="secondary-button" href="${pageContext.request.contextPath}/items">
                    Cancelar
                </a>
            </div>

        </form:form>
    </section>
</main>

</body>
</html>
```

### Explanation

The tag:
```jsp
<form:form modelAttribute="item">
```

binds the form to the `item` object sent from the controller.

Each `path` must match a property of the `Item` class:

```jsp
<form:input path="name" />
<form:input path="brand" />
<form:input path="price" />
<form:input path="quantity" />
```

When the user submits the form, Spring creates an `Item` object and fills in its properties.

</details>

---

# Exercise 20 — Check in DBeaver that the form inserts data

## Statement

After creating a product from the web application, write the SQL query that you need to run in DBeaver to verify that it has actually been saved in MySQL.

---

<details>
<summary>Show solution</summary>

```sql
SELECT * FROM items
ORDER BY id;
```

### Explanation

This query shows all products saved in the `items` table.

If the form worked correctly, a new row will appear with the product created from the web application.

This confirms that the data is no longer just in memory.

It's persisted in MySQL.

</details>

---

# Exercise 21 — Externalize the database configuration

## Statement

Currently the MySQL configuration is written directly in `app-servlet.xml`.

Create a file:

```text
src/main/resources/database.properties
```

with these properties:

```text
db.driverClassName
db.url
db.username
db.password
```

Then modify the XML to load that file and use the properties.

---

<details>
<summary>Show solution</summary>

## File `database.properties`

```properties
db.driverClassName=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/spring_mvc_inventory?useSSL=false&serverTimezone=Europe/Madrid
db.username=root
db.password=TU_PASSWORD
```

## Changes in `app-servlet.xml`

First we add:

```xml
<context:property-placeholder location="classpath:database.properties" />
```

Then we configure the `dataSource` like this:

```xml
<bean id="dataSource"
      class="org.springframework.jdbc.datasource.DriverManagerDataSource">

    <property name="driverClassName" value="${db.driverClassName}" />
    <property name="url" value="${db.url}" />
    <property name="username" value="${db.username}" />
    <property name="password" value="${db.password}" />
</bean>
```

### Explanation

The `.properties` file lets you keep specific configuration values separate.

That way, if the MySQL password changes, we only change:

```properties
db.password=...
```

and we don't have to touch the whole XML configuration.

In the `.properties` file we use:

```text
&
```

as is.

In XML we use:

```xml
&amp;
```

but in `.properties` it isn't needed.

</details>

---

# Exercise 22 — Diagnose common errors

## Statement

Read each case and explain the error.

## Case A

`app-servlet.xml` contains:

```xml
<property name="url"
          value="jdbc:mysql://localhost:3306/spring_mvc_inventory?useSSL=false&serverTimezone=Europe/Madrid" />
```

When the application starts, an XML error appears.

What's happening?

---

## Case B

The table was created like this:

```sql
CREATE TABLE items (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    brand VARCHAR(60) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL
);
```

But in Java the `RowMapper` does:

```java
resultSet.getDouble("price")
```

What's happening?

---

## Case C

The app shows this error:

```text
Communications link failure
```

What could be happening?

---

## Case D

IntelliJ does not recognize the class:

```java
JdbcTemplate
```

What is probably missing?

---

<details>
<summary>Show solution</summary>

## Case A

The problem is that in XML the `&` character must be escaped.

Incorrect:

```xml
useSSL=false&serverTimezone=Europe/Madrid
```

Correct:

```xml
useSSL=false&amp;serverTimezone=Europe/Madrid
```

The URL should look like this:

```xml
<property name="url"
          value="jdbc:mysql://localhost:3306/spring_mvc_inventory?useSSL=false&amp;serverTimezone=Europe/Madrid" />
```

---

## Case B

The problem is that the column name does not match.

The table has:

```sql
unit_price
```

but Java tries to read:

```java
price
```

The solution is one of these two:

Change the SQL of the table so that the column is named `price`.

Or change the `RowMapper`:

```java
resultSet.getDouble("unit_price")
```

The column names used in Java must match the actual column names in the table.

---

## Case C

`Communications link failure` usually indicates a connection problem with MySQL.

Possible causes:
```text
MySQL no está iniciado.
El puerto 3306 no es correcto.
La URL de conexión está mal escrita.
El servidor MySQL no acepta conexiones.
```

It's a good idea to first check in DBeaver whether the connection works.

---

## Case D

If IntelliJ does not recognize:

```java
JdbcTemplate
```

the dependency is probably missing:

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-jdbc</artifactId>
    <version>${spring.version}</version>
</dependency>
```

After adding it, you have to reload Maven.

</details>

---

# Exercise 23 — Final challenge: connect a supplier section with MySQL

## Statement

Create a new section for suppliers using MySQL.

The table should be called:

```text
suppliers
```

It must have:

| Column | Type |
|---|---|
| `id` | `BIGINT AUTO_INCREMENT PRIMARY KEY` |
| `name` | `VARCHAR(80)` |
| `city` | `VARCHAR(60)` |
| `phone` | `VARCHAR(30)` |

You must create:

1. A SQL script to create the table and insert data.
2. A `Supplier` class.
3. A `SupplierDao` interface.
4. A `JdbcSupplierDao` class.
5. A `SupplierService` class.
6. A `SupplierController` class.
7. A `suppliers/list.jsp` view.

The route will be:

```text
/suppliers
```

---

<details>
<summary>Show solution</summary>

## SQL script

```sql
USE spring_mvc_inventory;

CREATE TABLE IF NOT EXISTS suppliers (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    city VARCHAR(60) NOT NULL,
    phone VARCHAR(30) NOT NULL
);

INSERT INTO suppliers (name, city, phone)
VALUES
    ('Distribuciones Norte', 'Bilbao', '944123456'),
    ('Suministros Centro', 'Madrid', '910222333'),
    ('Comercial Mediterráneo', 'Valencia', '960111222');

SELECT * FROM suppliers;
```

## Model `Supplier.java`

```java
package com.example.inventory.model;

public class Supplier {

    private Long id;
    private String name;
    private String city;
    private String phone;

    public Supplier() {
    }

    public Supplier(Long id, String name, String city, String phone) {
        this.id = id;
        this.name = name;
        this.city = city;
        this.phone = phone;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getCity() {
        return city;
    }

    public String getPhone() {
        return phone;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
```

## `SupplierDao.java` interface

```java
package com.example.inventory.dao;

import com.example.inventory.model.Supplier;

import java.util.List;

public interface SupplierDao {

    List<Supplier> findAll();
}
```

## `JdbcSupplierDao.java` implementation

```java
package com.example.inventory.dao;

import com.example.inventory.model.Supplier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class JdbcSupplierDao implements SupplierDao {

    private final JdbcTemplate jdbcTemplate;

    public JdbcSupplierDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Supplier> supplierRowMapper = (resultSet, rowNumber) ->
            new Supplier(
                    resultSet.getLong("id"),
                    resultSet.getString("name"),
                    resultSet.getString("city"),
                    resultSet.getString("phone")
            );

    @Override
    public List<Supplier> findAll() {
        String sql = """
                SELECT id, name, city, phone
                FROM suppliers
                ORDER BY id
                """;

        return jdbcTemplate.query(sql, supplierRowMapper);
    }
}
```

## `SupplierService.java` service

```java
package com.example.inventory.service;

import com.example.inventory.dao.SupplierDao;
import com.example.inventory.model.Supplier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SupplierService {

    private final SupplierDao supplierDao;

    public SupplierService(SupplierDao supplierDao) {
        this.supplierDao = supplierDao;
    }

    public List<Supplier> findAll() {
        return supplierDao.findAll();
    }
}
```

## `SupplierController.java` controller

```java
package com.example.inventory.controller;

import com.example.inventory.service.SupplierService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/suppliers")
public class SupplierController {

    private final SupplierService supplierService;

    public SupplierController(SupplierService supplierService) {
        this.supplierService = supplierService;
    }

    @GetMapping
    public String listSuppliers(Model model) {
        model.addAttribute("pageTitle", "Listado de proveedores");
        model.addAttribute("suppliers", supplierService.findAll());

        return "suppliers/list";
    }
}
```

## View `suppliers/list.jsp`

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
        <a href="${pageContext.request.contextPath}/items">Inventario</a>
        <a href="${pageContext.request.contextPath}/suppliers">Proveedores</a>
    </nav>
</header>

<main class="container">
    <section class="card wide">
        <h1>${pageTitle}</h1>

        <table class="table">
            <thead>
            <tr>
                <th>Nombre</th>
                <th>Ciudad</th>
                <th>Teléfono</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="supplier" items="${suppliers}">
                <tr>
                    <td>${supplier.name}</td>
                    <td>${supplier.city}</td>
                    <td>${supplier.phone}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </section>
</main>

</body>
</html>
```

### Explanation

This challenge brings together the entire persistence flow:

```text
Vista
↓
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

The view only receives a list of `Supplier` objects.

The controller doesn't know how that list is obtained.

The service delegates to the DAO.

The DAO executes the actual SQL query.

</details>