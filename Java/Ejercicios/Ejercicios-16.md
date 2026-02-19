# Ejercicios - Tema 16: Sobrecarga de constructores

A continuación encontrarás **10 ejercicios prácticos** sobre **sobrecarga de constructores**: múltiples constructores con distintas firmas, valores por defecto, uso de `this(...)` para delegar entre constructores, inicialización consistente y errores típicos (como bucles de llamadas).

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: `User` con 3 constructores

Crea una clase `User` con atributos `private`:

- `name` (String)
- `age` (int)

Crea estos constructores:

1. `User()` → `name = "Unknown"`, `age = 0`
2. `User(String name)` → `age = 0`
3. `User(String name, int age)` → ambos valores

Usa `this(...)` para delegar y evitar duplicar lógica.

<details><summary>Mostrar solución</summary>

```java
public class User {
    private String name;
    private int age;

    public User() {
        this("Unknown", 0);
    }

    public User(String name) {
        this(name, 0);
    }

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Age: " + age);
    }
}
```

</details>

---

## Ejercicio 2: `Product` con valores por defecto

Crea una clase `Product` con:

- `name` (String)
- `price` (double)
- `stock` (int)

Constructores:

1. `Product(String name)` → `price = 0.0`, `stock = 0`
2. `Product(String name, double price)` → `stock = 0`
3. `Product(String name, double price, int stock)`

Usa `this(...)` para delegar al constructor más completo.

<details><summary>Mostrar solución</summary>

```java
public class Product {
    private String name;
    private double price;
    private int stock;

    public Product(String name) {
        this(name, 0.0, 0);
    }

    public Product(String name, double price) {
        this(name, price, 0);
    }

    public Product(String name, double price, int stock) {
        this.name = name;
        this.price = price;
        this.stock = stock;
    }
}
```

</details>

---

## Ejercicio 3: Constructor principal con validación reutilizable

Crea una clase `Student` con:

- `name` (String)
- `grade` (double)

Constructores:

1. `Student(String name)` → `grade = 0`
2. `Student(String name, double grade)`

Implementa `setGrade(double grade)` con validación (0..10).  
En el constructor principal, usa el setter.

<details><summary>Mostrar solución</summary>

```java
public class Student {
    private String name;
    private double grade;

    public Student(String name) {
        this(name, 0.0);
    }

    public Student(String name, double grade) {
        this.name = name;
        setGrade(grade);
    }

    public void setGrade(double grade) {
        if (grade < 0 || grade > 10) {
            this.grade = 0.0;
            return;
        }

        this.grade = grade;
    }
}
```

</details>

---

## Ejercicio 4: `Order` con `id` autoincremental

Crea una clase `Order` con:

- `private static int nextId`
- `private int id`
- `private String customer`
- `private double total`

Constructores:

1. `Order()` → customer `"Unknown"`, total `0.0`
2. `Order(String customer)` → total `0.0`
3. `Order(String customer, double total)`

El `id` debe asignarse usando `nextId` en el constructor principal.

<details><summary>Mostrar solución</summary>

```java
public class Order {
    private static int nextId = 1;

    private int id;
    private String customer;
    private double total;

    public Order() {
        this("Unknown", 0.0);
    }

    public Order(String customer) {
        this(customer, 0.0);
    }

    public Order(String customer, double total) {
        this.id = nextId;
        nextId++;

        this.customer = customer;
        this.total = total;
    }

    public int getId() {
        return id;
    }
}
```

</details>

---

## Ejercicio 5: `Rectangle` con constructor “cuadrado”

Crea una clase `Rectangle` con:

- `width` (double)
- `height` (double)

Constructores:

1. `Rectangle(double width, double height)`
2. `Rectangle(double side)` → crea un cuadrado (`width = side`, `height = side`)

El constructor de un parámetro debe delegar al de dos parámetros con `this(...)`.

<details><summary>Mostrar solución</summary>

```java
public class Rectangle {
    private double width;
    private double height;

    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }

    public Rectangle(double side) {
        this(side, side);
    }
}
```

</details>

---

## Ejercicio 6: `Point` con constructor sin parámetros

Crea una clase `Point` con:

- `x` (int)
- `y` (int)

Constructores:

1. `Point()` → `(0, 0)`
2. `Point(int x, int y)`

Añade método `print()` que muestre:

```
(x, y)
```

<details><summary>Mostrar solución</summary>

```java
public class Point {
    private int x;
    private int y;

    public Point() {
        this(0, 0);
    }

    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public void print() {
        System.out.println("(" + x + ", " + y + ")");
    }
}
```

</details>

---

## Ejercicio 7: Evitar duplicación con `this(...)` en `Car`

Crea una clase `Car` con:

- `brand` (String)
- `model` (String)
- `year` (int)

Constructores:

1. `Car(String brand)` → model `"Unknown"`, year `0`
2. `Car(String brand, String model)` → year `0`
3. `Car(String brand, String model, int year)`

Delegación obligatoria usando `this(...)`.

<details><summary>Mostrar solución</summary>

```java
public class Car {
    private String brand;
    private String model;
    private int year;

    public Car(String brand) {
        this(brand, "Unknown", 0);
    }

    public Car(String brand, String model) {
        this(brand, model, 0);
    }

    public Car(String brand, String model, int year) {
        this.brand = brand;
        this.model = model;
        this.year = year;
    }
}
```

</details>

---

## Ejercicio 8: Constructor con parámetros opcionales “simulados”

Crea una clase `Notification` con:

- `message` (String)
- `priority` (int)
- `sender` (String)

Constructores:

1. `Notification(String message)` → `priority = 1`, `sender = "System"`
2. `Notification(String message, int priority)` → `sender = "System"`
3. `Notification(String message, int priority, String sender)`

Centraliza todo en el constructor principal.

<details><summary>Mostrar solución</summary>

```java
public class Notification {
    private String message;
    private int priority;
    private String sender;

    public Notification(String message) {
        this(message, 1, "System");
    }

    public Notification(String message, int priority) {
        this(message, priority, "System");
    }

    public Notification(String message, int priority, String sender) {
        this.message = message;
        this.priority = priority;
        this.sender = sender;
    }
}
```

</details>

---

## Ejercicio 9: Identificar un error de “bucle” de constructores

Crea una clase `Demo` y escribe dos constructores que NO causen bucle infinito.

- `Demo()` debe delegar a `Demo(String value)`
- `Demo(String value)` debe asignar `value` a un atributo

Evita este error:

- `Demo()` → `this("x")`
- `Demo(String value)` → `this()` (esto crearía bucle)

<details><summary>Mostrar solución</summary>

```java
public class Demo {
    private String value;

    public Demo() {
        this("x");
    }

    public Demo(String value) {
        this.value = value;
    }
}
```

</details>

---

## Ejercicio 10: `this(...)` debe ser la primera línea

Crea una clase `Logger` con:

- `prefix` (String)

Constructores:

1. `Logger()` → prefix `"APP"`
2. `Logger(String prefix)`

Asegúrate de que el constructor sin parámetros llama a `this("APP")` como primera línea.

<details><summary>Mostrar solución</summary>

```java
public class Logger {
    private String prefix;

    public Logger() {
        this("APP");
    }

    public Logger(String prefix) {
        this.prefix = prefix;
    }

    public void log(String message) {
        System.out.println(prefix + ": " + message);
    }
}
```

</details>

---
