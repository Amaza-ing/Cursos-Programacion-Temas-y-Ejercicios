# Ejercicios Tema 4 (Opcional): Conexión con MySQL y DBeaver

## Introducción

En este tema opcional vas a practicar cómo conectar una aplicación **Spring MVC clásica** con una base de datos **MySQL** usando **DBeaver** y **Spring JDBC**.

La idea es sustituir una lista en memoria por datos persistentes en una base de datos.

En los ejercicios trabajaremos con una pequeña aplicación de **inventario de productos**, diferente al ejemplo principal del curso.

Vas a practicar:

- Crear una base de datos desde DBeaver.
- Crear tablas con SQL.
- Insertar datos iniciales.
- Añadir las dependencias necesarias al `pom.xml`.
- Configurar un `DataSource`.
- Configurar `JdbcTemplate`.
- Crear una interfaz DAO.
- Crear una implementación DAO con JDBC.
- Convertir filas SQL en objetos Java con `RowMapper`.
- Ejecutar consultas `SELECT`.
- Ejecutar consultas `INSERT`.
- Recuperar claves generadas automáticamente.
- Conectar controlador, servicio, DAO y base de datos.

Cada solución está oculta bajo el botón **mostrar solución**.

---

# Ejercicio 1 — Crear la base de datos en MySQL desde DBeaver

## Enunciado

Crea una base de datos para una aplicación de inventario.

La base de datos debe llamarse:

```text
spring_mvc_inventory
```

Debe usar codificación compatible con tildes, eñes y caracteres especiales.

Escribe el script SQL necesario para crearla y seleccionarla.

---

<details>
<summary>mostrar solución</summary>

```sql
CREATE DATABASE IF NOT EXISTS spring_mvc_inventory
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE spring_mvc_inventory;
```

### Explicación

La instrucción:

```sql
CREATE DATABASE IF NOT EXISTS spring_mvc_inventory
```

crea la base de datos solo si todavía no existe.

Usamos:

```sql
CHARACTER SET utf8mb4
```

para permitir caracteres especiales, tildes, eñes y símbolos.

Después usamos:

```sql
USE spring_mvc_inventory;
```

para indicar que las siguientes instrucciones SQL se ejecutarán dentro de esa base de datos.

</details>

---

# Ejercicio 2 — Crear la tabla `items`

## Enunciado

Crea una tabla llamada `items` para guardar productos de inventario.

La tabla debe tener estas columnas:

| Columna | Tipo | Restricción |
|---|---|---|
| `id` | `BIGINT` | Clave primaria y autoincremental |
| `name` | `VARCHAR(80)` | Obligatoria |
| `brand` | `VARCHAR(60)` | Obligatoria |
| `price` | `DECIMAL(10,2)` | Obligatoria |
| `quantity` | `INT` | Obligatoria |

Escribe el SQL de creación de la tabla.

---

<details>
<summary>mostrar solución</summary>

```sql
CREATE TABLE IF NOT EXISTS items (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    brand VARCHAR(60) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL
);
```

### Explicación

La tabla se llama:

```sql
items
```

La columna:

```sql
id BIGINT PRIMARY KEY AUTO_INCREMENT
```

será el identificador único de cada producto.

`AUTO_INCREMENT` hace que MySQL genere automáticamente el siguiente identificador.

Las columnas:

```sql
name
brand
price
quantity
```

tienen `NOT NULL`, por lo que no pueden guardarse vacías en la base de datos.

</details>

---

# Ejercicio 3 — Insertar datos iniciales

## Enunciado

Inserta cuatro productos iniciales en la tabla `items`.

Los productos deben ser diferentes a los del curso principal.

Puedes usar estos datos:

| name | brand | price | quantity |
|---|---|---|---|
| Monitor 24 pulgadas | ViewMax | 139.99 | 8 |
| Silla ergonómica | ComfortPro | 189.50 | 5 |
| Lámpara LED | BrightHome | 24.90 | 20 |
| Auriculares Bluetooth | SoundBeat | 49.99 | 14 |

Después escribe una consulta para comprobar que se han insertado correctamente.

---

<details>
<summary>mostrar solución</summary>

```sql
INSERT INTO items (name, brand, price, quantity)
VALUES
    ('Monitor 24 pulgadas', 'ViewMax', 139.99, 8),
    ('Silla ergonómica', 'ComfortPro', 189.50, 5),
    ('Lámpara LED', 'BrightHome', 24.90, 20),
    ('Auriculares Bluetooth', 'SoundBeat', 49.99, 14);

SELECT * FROM items;
```

### Explicación

No insertamos manualmente el `id` porque MySQL lo genera automáticamente.

Por eso escribimos:

```sql
INSERT INTO items (name, brand, price, quantity)
```

y no:

```sql
INSERT INTO items (id, name, brand, price, quantity)
```

La consulta:

```sql
SELECT * FROM items;
```

permite comprobar desde DBeaver que los registros se han guardado correctamente.

</details>

---

# Ejercicio 4 — Crear el script SQL completo

## Enunciado

Une los ejercicios anteriores en un único script SQL que:

1. Cree la base de datos.
2. La seleccione.
3. Cree la tabla.
4. Inserte datos iniciales.
5. Muestre los datos insertados.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

Este script puede ejecutarse directamente desde DBeaver.

Es útil para preparar rápidamente la base de datos de todos los alumnos.

Si se ejecuta dos veces, la base de datos y la tabla no se duplican porque usamos:

```sql
IF NOT EXISTS
```

Eso sí, los `INSERT` sí se volverían a ejecutar y podrían duplicar los productos. Si quieres evitar duplicados, puedes borrar previamente la tabla o usar otro tipo de inserción más avanzada.

</details>

---

# Ejercicio 5 — Añadir dependencias al `pom.xml`

## Enunciado

Para conectar Spring MVC con MySQL usando JDBC, añade al `pom.xml` las dependencias necesarias para:

1. Usar `JdbcTemplate`.
2. Usar el driver de MySQL.

Escribe solo las dependencias necesarias.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La dependencia:

```xml
spring-jdbc
```

nos permite usar clases como:

```java
JdbcTemplate
RowMapper
GeneratedKeyHolder
```

La dependencia:

```xml
mysql-connector-j
```

es el driver que permite que Java se conecte a MySQL.

Sin el driver de MySQL, Java no sabría interpretar una URL como:

```text
jdbc:mysql://localhost:3306/spring_mvc_inventory
```

</details>

---

# Ejercicio 6 — Configurar `DataSource` y `JdbcTemplate` en XML

## Enunciado

Modifica el archivo:

```text
src/main/webapp/WEB-INF/spring/app-servlet.xml
```

para añadir:

1. Un bean `dataSource` usando `DriverManagerDataSource`.
2. Un bean `jdbcTemplate` usando ese `dataSource`.

Usa estos datos de conexión:

```text
Driver: com.mysql.cj.jdbc.Driver
URL: jdbc:mysql://localhost:3306/spring_mvc_inventory?useSSL=false&serverTimezone=Europe/Madrid
Usuario: root
Contraseña: TU_PASSWORD
```

Recuerda que en XML el carácter `&` debe escribirse como `&amp;`.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

El bean:

```xml
<bean id="dataSource" ...>
```

contiene los datos necesarios para abrir una conexión con MySQL.

El bean:

```xml
<bean id="jdbcTemplate" ...>
```

usa ese `dataSource` para ejecutar consultas SQL.

La relación es:

```text
JdbcTemplate
      ↓
DataSource
      ↓
MySQL
```

En XML no podemos escribir directamente:

```xml
&serverTimezone=Europe/Madrid
```

porque `&` tiene un significado especial.

Por eso escribimos:

```xml
&amp;serverTimezone=Europe/Madrid
```

</details>

---

# Ejercicio 7 — Crear el modelo `Item`

## Enunciado

Crea una clase llamada `Item` en el paquete:

```text
com.example.inventory.model
```

Debe representar los datos de la tabla `items`.

La clase debe tener:

| Atributo | Tipo Java |
|---|---|
| `id` | `Long` |
| `name` | `String` |
| `brand` | `String` |
| `price` | `Double` |
| `quantity` | `Integer` |

Añade constructor vacío, constructor con todos los campos, getters y setters.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La clase `Item` representa una fila de la tabla `items`.

Por ejemplo, esta fila:

```text
id: 1
name: Monitor 24 pulgadas
brand: ViewMax
price: 139.99
quantity: 8
```

se convertirá en un objeto Java:

```java
new Item(1L, "Monitor 24 pulgadas", "ViewMax", 139.99, 8);
```

Usamos `Double` e `Integer` en lugar de `double` e `int` para poder representar valores nulos si fuera necesario.

</details>

---

# Ejercicio 8 — Crear la interfaz `ItemDao`

## Enunciado

Crea una interfaz llamada `ItemDao` en el paquete:

```text
com.example.inventory.dao
```

Debe declarar estos métodos:

```java
List<Item> findAll();

Item findById(Long id);

void save(Item item);
```

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La interfaz DAO define qué operaciones de acceso a datos necesita la aplicación.

No contiene SQL.

Solo declara operaciones:

```java
findAll()
findById()
save()
```

La ventaja de usar una interfaz es que podríamos cambiar la implementación más adelante.

Por ejemplo, ahora usaremos JDBC, pero más adelante podríamos usar JPA o Hibernate sin cambiar el servicio.

</details>

---

# Ejercicio 9 — Crear un `RowMapper` para convertir filas en objetos

## Enunciado

Vamos a crear la clase `JdbcItemDao`.

Antes de implementar todos sus métodos, escribe dentro de la clase un `RowMapper<Item>` llamado `itemRowMapper`.

Debe convertir las columnas SQL:

```text
id
name
brand
price
quantity
```

en un objeto `Item`.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

Una consulta SQL devuelve filas.

Java trabaja con objetos.

El `RowMapper` sirve para convertir cada fila del resultado en un objeto Java.

Por ejemplo, si MySQL devuelve:

```text
id = 2
name = Silla ergonómica
brand = ComfortPro
price = 189.50
quantity = 5
```

el `RowMapper` crea:

```java
new Item(2L, "Silla ergonómica", "ComfortPro", 189.50, 5);
```

</details>

---

# Ejercicio 10 — Crear `JdbcItemDao` con el método `findAll`

## Enunciado

Crea la clase:

```text
com.example.inventory.dao.JdbcItemDao
```

Debe:

1. Estar anotada con `@Repository`.
2. Implementar `ItemDao`.
3. Recibir un `JdbcTemplate` por constructor.
4. Tener un `RowMapper<Item>`.
5. Implementar el método `findAll()`.

La consulta debe obtener todos los productos ordenados por `id`.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La anotación:

```java
@Repository
```

indica que esta clase pertenece a la capa de acceso a datos.

Spring la detectará automáticamente si el `component-scan` incluye el paquete base correcto.

El método:

```java
jdbcTemplate.query(sql, itemRowMapper)
```

ejecuta la consulta y convierte cada fila en un objeto `Item`.

El resultado es:

```java
List<Item>
```

En este ejercicio dejamos `findById` y `save` sin implementar para centrarnos primero en el listado.

</details>

---

# Ejercicio 11 — Implementar `findById`

## Enunciado

Completa el método `findById(Long id)` de `JdbcItemDao`.

Debe ejecutar una consulta para buscar un producto por su identificador.

Si existe, debe devolverlo.

Si no existe, debe devolver `null`.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La consulta usa un parámetro:

```sql
WHERE id = ?
```

Ese `?` se sustituye por el valor de `id` cuando ejecutamos:

```java
jdbcTemplate.query(sql, itemRowMapper, id);
```

Es mejor usar parámetros que concatenar texto SQL manualmente.

No hacemos esto:

```java
"SELECT * FROM items WHERE id = " + id
```

porque es menos seguro y más propenso a errores.

Como la consulta puede no devolver resultados, guardamos el resultado en una lista:

```java
List<Item> items
```

Después devolvemos el primer elemento o `null`:

```java
return items.stream()
        .findFirst()
        .orElse(null);
```

</details>

---

# Ejercicio 12 — Implementar `save` con `INSERT`

## Enunciado

Completa el método `save(Item item)` de `JdbcItemDao`.

Debe insertar un nuevo producto en la tabla `items`.

No debe insertar el `id`, porque MySQL lo genera automáticamente.

La consulta SQL debe insertar:

```text
name
brand
price
quantity
```

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La consulta es:

```sql
INSERT INTO items (name, brand, price, quantity)
VALUES (?, ?, ?, ?)
```

No insertamos el `id` porque la columna está configurada con:

```sql
AUTO_INCREMENT
```

El método:

```java
jdbcTemplate.update(...)
```

sirve para ejecutar operaciones que modifican la base de datos, como:

```sql
INSERT
UPDATE
DELETE
```

Los valores se pasan en el mismo orden que los signos `?`:

```java
item.getName()
item.getBrand()
item.getPrice()
item.getQuantity()
```

</details>

---

# Ejercicio 13 — Implementar `save` recuperando el id generado

## Enunciado

Mejora el método `save(Item item)` para que, después de insertar el producto, recupere el `id` generado automáticamente por MySQL y lo asigne al objeto `item`.

Usa:

```java
GeneratedKeyHolder
KeyHolder
Statement.RETURN_GENERATED_KEYS
```

---

<details>
<summary>mostrar solución</summary>

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

### Imports necesarios

```java
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import java.sql.PreparedStatement;
import java.sql.Statement;
```

### Explicación

Cuando MySQL inserta una fila con `AUTO_INCREMENT`, genera un nuevo identificador.

Si queremos recuperar ese identificador desde Java, usamos:

```java
KeyHolder keyHolder = new GeneratedKeyHolder();
```

Después preparamos la consulta con:

```java
Statement.RETURN_GENERATED_KEYS
```

Eso indica que queremos recuperar la clave generada.

Finalmente obtenemos el id:

```java
Number generatedId = keyHolder.getKey();
```

y lo asignamos al objeto:

```java
item.setId(generatedId.longValue());
```

Así el objeto Java queda sincronizado con la fila insertada en MySQL.

</details>

---

# Ejercicio 14 — Crear el servicio `ItemService`

## Enunciado

Crea una clase llamada `ItemService` en el paquete:

```text
com.example.inventory.service
```

Debe:

1. Estar anotada con `@Service`.
2. Recibir `ItemDao` por constructor.
3. Tener los métodos:
   - `findAll()`
   - `findById(Long id)`
   - `save(Item item)`

Cada método debe delegar en el DAO.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

El servicio no contiene SQL.

El servicio coordina la lógica de la aplicación y delega el acceso a datos en el DAO.

La cadena queda así:

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

Esta separación hace que el controlador no tenga que saber cómo se accede a la base de datos.

</details>

---

# Ejercicio 15 — Crear un controlador para listar productos desde MySQL

## Enunciado

Crea un controlador llamado `ItemController` en el paquete:

```text
com.example.inventory.controller
```

Debe:

1. Estar anotado con `@Controller`.
2. Tener ruta base `/items`.
3. Recibir `ItemService` por constructor.
4. Tener un método `GET /items`.
5. Añadir al modelo:
   - `pageTitle` con el valor `Inventario`
   - `items` con los datos obtenidos desde MySQL
6. Devolver la vista `items/list`.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

El controlador llama al servicio:

```java
itemService.findAll()
```

El servicio llama al DAO:

```java
itemDao.findAll()
```

El DAO ejecuta la consulta SQL:

```sql
SELECT id, name, brand, price, quantity
FROM items
ORDER BY id
```

El resultado vuelve al controlador como una lista de objetos `Item`.

</details>

---

# Ejercicio 16 — Crear la vista `items/list.jsp`

## Enunciado

Crea la vista:

```text
src/main/webapp/WEB-INF/views/items/list.jsp
```

Debe mostrar una tabla con:

```text
Nombre | Marca | Precio | Cantidad | Acción
```

La columna acción debe tener un enlace al detalle:

```text
/items/detail?id=ID
```

Usa JSTL para recorrer la lista.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La lista `items` viene del controlador:

```java
model.addAttribute("items", itemService.findAll());
```

La vista no sabe si los datos vienen de MySQL, de una lista en memoria o de otro sistema.

Solo recibe objetos Java y los muestra.

</details>

---

# Ejercicio 17 — Añadir detalle de producto desde MySQL

## Enunciado

Añade a `ItemController` una ruta:

```text
GET /items/detail?id=1
```

El método debe:

1. Recibir el parámetro `id`.
2. Buscar el producto con `itemService.findById(id)`.
3. Si no existe, devolver `items/not-found`.
4. Si existe, añadir `item` y `pageTitle` al modelo.
5. Devolver `items/detail`.

Después crea la vista `items/detail.jsp`.

---

<details>
<summary>mostrar solución</summary>

## Método en `ItemController`

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

### Imports necesarios

```java
import com.example.inventory.model.Item;
import org.springframework.web.bind.annotation.RequestParam;
```

## Vista `items/detail.jsp`

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

## Vista `items/not-found.jsp`

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

### Explicación

El método de detalle llama a:

```java
itemService.findById(id)
```

Ese método termina ejecutando una consulta SQL con:

```sql
WHERE id = ?
```

Por tanto, el detalle ya no se obtiene de una lista en memoria, sino directamente de MySQL.

</details>

---

# Ejercicio 18 — Crear formulario para insertar en MySQL

## Enunciado

Añade a `ItemController` dos métodos:

```text
GET  /items/new
POST /items
```

El método `GET` debe mostrar un formulario vacío.

El método `POST` debe recibir un `Item` con `@ModelAttribute`, guardarlo usando `itemService.save(item)` y redirigir a `/items`.

No añadas todavía validación en este ejercicio.

---

<details>
<summary>mostrar solución</summary>

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

### Imports necesarios

```java
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
```

### Explicación

El método `GET` crea un objeto vacío:

```java
new Item()
```

y lo envía al formulario con el nombre:

```text
item
```

El método `POST` recibe el objeto ya rellenado:

```java
@ModelAttribute("item") Item item
```

Después llama a:

```java
itemService.save(item)
```

El servicio delega en el DAO, y el DAO ejecuta el `INSERT` en MySQL.

</details>

---

# Ejercicio 19 — Crear la vista `items/form.jsp`

## Enunciado

Crea la vista:

```text
src/main/webapp/WEB-INF/views/items/form.jsp
```

Debe tener un formulario que envíe por `POST` a `/items`.

El formulario debe estar vinculado al atributo `item` y tener campos para:

```text
name
brand
price
quantity
```

Usa etiquetas de formulario de Spring.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La etiqueta:

```jsp
<form:form modelAttribute="item">
```

vincula el formulario con el objeto `item` enviado desde el controlador.

Cada `path` debe coincidir con una propiedad de la clase `Item`:

```jsp
<form:input path="name" />
<form:input path="brand" />
<form:input path="price" />
<form:input path="quantity" />
```

Cuando el usuario envía el formulario, Spring crea un objeto `Item` y rellena sus propiedades.

</details>

---

# Ejercicio 20 — Comprobar en DBeaver que el formulario inserta datos

## Enunciado

Después de crear un producto desde la aplicación web, escribe la consulta SQL que debes ejecutar en DBeaver para comprobar que se ha guardado realmente en MySQL.

---

<details>
<summary>mostrar solución</summary>

```sql
SELECT * FROM items
ORDER BY id;
```

### Explicación

Esta consulta muestra todos los productos guardados en la tabla `items`.

Si el formulario ha funcionado correctamente, aparecerá una nueva fila con el producto creado desde la aplicación web.

Esto confirma que los datos ya no están solo en memoria.

Están persistidos en MySQL.

</details>

---

# Ejercicio 21 — Externalizar la configuración de la base de datos

## Enunciado

Actualmente la configuración de MySQL está escrita directamente en `app-servlet.xml`.

Crea un archivo:

```text
src/main/resources/database.properties
```

con estas propiedades:

```text
db.driverClassName
db.url
db.username
db.password
```

Después modifica el XML para cargar ese archivo y usar las propiedades.

---

<details>
<summary>mostrar solución</summary>

## Archivo `database.properties`

```properties
db.driverClassName=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/spring_mvc_inventory?useSSL=false&serverTimezone=Europe/Madrid
db.username=root
db.password=TU_PASSWORD
```

## Modificación en `app-servlet.xml`

Primero añadimos:

```xml
<context:property-placeholder location="classpath:database.properties" />
```

Después configuramos el `dataSource` así:

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

El archivo `.properties` permite separar datos concretos de configuración.

Así, si cambia la contraseña de MySQL, solo modificamos:

```properties
db.password=...
```

y no tenemos que tocar toda la configuración XML.

En el archivo `.properties` usamos:

```text
&
```

normal.

En XML se usa:

```xml
&amp;
```

pero dentro de `.properties` no hace falta.

</details>

---

# Ejercicio 22 — Diagnosticar errores frecuentes

## Enunciado

Lee cada caso y explica el error.

## Caso A

En `app-servlet.xml` aparece:

```xml
<property name="url"
          value="jdbc:mysql://localhost:3306/spring_mvc_inventory?useSSL=false&serverTimezone=Europe/Madrid" />
```

Al arrancar la aplicación aparece un error de XML.

¿Qué ocurre?

---

## Caso B

La tabla se creó así:

```sql
CREATE TABLE items (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    brand VARCHAR(60) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL
);
```

Pero en Java el `RowMapper` hace:

```java
resultSet.getDouble("price")
```

¿Qué ocurre?

---

## Caso C

La aplicación muestra este error:

```text
Communications link failure
```

¿Qué puede estar pasando?

---

## Caso D

IntelliJ no reconoce la clase:

```java
JdbcTemplate
```

¿Qué falta probablemente?

---

<details>
<summary>mostrar solución</summary>

## Caso A

El problema es que en XML el carácter `&` debe escaparse.

Incorrecto:

```xml
useSSL=false&serverTimezone=Europe/Madrid
```

Correcto:

```xml
useSSL=false&amp;serverTimezone=Europe/Madrid
```

La URL debe quedar así:

```xml
<property name="url"
          value="jdbc:mysql://localhost:3306/spring_mvc_inventory?useSSL=false&amp;serverTimezone=Europe/Madrid" />
```

---

## Caso B

El problema es que el nombre de la columna no coincide.

La tabla tiene:

```sql
unit_price
```

pero Java intenta leer:

```java
price
```

La solución es una de estas dos:

Cambiar el SQL de la tabla para que la columna se llame `price`.

O cambiar el `RowMapper`:

```java
resultSet.getDouble("unit_price")
```

Los nombres de columna usados en Java deben coincidir con los nombres reales de la tabla.

---

## Caso C

`Communications link failure` suele indicar un problema de conexión con MySQL.

Posibles causas:

```text
MySQL no está iniciado.
El puerto 3306 no es correcto.
La URL de conexión está mal escrita.
El servidor MySQL no acepta conexiones.
```

Primero conviene comprobar desde DBeaver si la conexión funciona.

---

## Caso D

Si IntelliJ no reconoce:

```java
JdbcTemplate
```

probablemente falta la dependencia:

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-jdbc</artifactId>
    <version>${spring.version}</version>
</dependency>
```

Después de añadirla, hay que recargar Maven.

</details>

---

# Ejercicio 23 — Reto final: conectar una sección de proveedores con MySQL

## Enunciado

Crea una nueva sección para proveedores usando MySQL.

La tabla debe llamarse:

```text
suppliers
```

Debe tener:

| Columna | Tipo |
|---|---|
| `id` | `BIGINT AUTO_INCREMENT PRIMARY KEY` |
| `name` | `VARCHAR(80)` |
| `city` | `VARCHAR(60)` |
| `phone` | `VARCHAR(30)` |

Debes crear:

1. Script SQL de creación de tabla e inserción de datos.
2. Clase `Supplier`.
3. Interfaz `SupplierDao`.
4. Clase `JdbcSupplierDao`.
5. Clase `SupplierService`.
6. Clase `SupplierController`.
7. Vista `suppliers/list.jsp`.

La ruta será:

```text
/suppliers
```

---

<details>
<summary>mostrar solución</summary>

## Script SQL

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

## Modelo `Supplier.java`

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

## Interfaz `SupplierDao.java`

```java
package com.example.inventory.dao;

import com.example.inventory.model.Supplier;

import java.util.List;

public interface SupplierDao {

    List<Supplier> findAll();
}
```

## Implementación `JdbcSupplierDao.java`

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

## Servicio `SupplierService.java`

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

## Controlador `SupplierController.java`

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

## Vista `suppliers/list.jsp`

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

### Explicación

Este reto reúne todo el flujo de persistencia:

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

La vista solo recibe una lista de objetos `Supplier`.

El controlador no sabe cómo se obtiene esa lista.

El servicio delega en el DAO.

El DAO ejecuta la consulta SQL real.

</details>