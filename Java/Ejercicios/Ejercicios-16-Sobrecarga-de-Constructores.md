# Exercises - Topic 16: Constructor overloading

Below you will find **10 practical exercises** on **constructor overloading**: multiple constructors with different signatures, default values, using `this(...)` to delegate between constructors, consistent initialization and common mistakes (such as call loops).

Try to solve them before looking at the solution.

---

## Exercise 1: `User` with 3 constructors

Create a class `User` with these `private` attributes:

- `name` (String)
- `age` (int)

Create these constructors:

1. `User()` → `name = "Unknown"`, `age = 0`
2. `User(String name)` → `age = 0`
3. `User(String name, int age)` → both values

Use `this(...)` to delegate and avoid duplicate logic.

<details><summary>Show solution</summary>

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

## Exercise 2: `Product` with default values

Create a class `Product` with:

- `name` (String)
- `price` (double)
- `stock` (int)

Constructors:

1. `Product(String name)` → `price = 0.0`, `stock = 0`
2. `Product(String name, double price)` → `stock = 0`
3. `Product(String name, double price, int stock)`

Use `this(...)` to delegate to the most complete constructor.

<details><summary>Show solution</summary>

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

## Exercise 3: Main constructor with reusable validation

Create a class `Student` with:

- `name` (String)
- `grade` (double)

Constructors:

1. `Student(String name)` → `grade = 0`
2. `Student(String name, double grade)`

Implement `setGrade(double grade)` with validation (0..10).  
In the main constructor, use the setter.

<details><summary>Show solution</summary>

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

## Exercise 4: `Order` with an auto-incrementing `id`

Create a class `Order` with:

- `private static int nextId`
- `private int id`
- `private String customer`
- `private double total`

Constructors:

1. `Order()` → customer `"Unknown"`, total `0.0`
2. `Order(String customer)` → total `0.0`
3. `Order(String customer, double total)`

The `id` must be assigned using `nextId` in the main constructor.

<details><summary>Show solution</summary>

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

## Exercise 5: `Rectangle` with a “square” constructor

Create a class `Rectangle` with:

- `width` (double)
- `height` (double)

Constructors:

1. `Rectangle(double width, double height)`
2. `Rectangle(double side)` → create a square (`width = side`, `height = side`)

The one-parameter constructor must delegate to the two-parameter constructor with `this(...)`.

<details><summary>Show solution</summary>

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

## Exercise 6: `Point` with a parameterless constructor

Create a class `Point` with:

- `x` (int)
- `y` (int)

Constructors:

1. `Point()` → `(0, 0)`
2. `Point(int x, int y)`

Add a `print()` method that displays:

```
(x, y)
```

<details><summary>Show solution</summary>

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

## Exercise 7: Avoid duplication with `this(...)` in `Car`

Create a class `Car` with:

- `brand` (String)
- `model` (String)
- `year` (int)

Constructors:

1. `Car(String brand)` → model `"Unknown"`, year `0`
2. `Car(String brand, String model)` → year `0`
3. `Car(String brand, String model, int year)`

You must delegate using `this(...)`.

<details><summary>Show solution</summary>

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

## Exercise 8: Constructor with “simulated” optional parameters

Create a class `Notification` with:

- `message` (String)
- `priority` (int)
- `sender` (String)

Constructors:

1. `Notification(String message)` → `priority = 1`, `sender = "System"`
2. `Notification(String message, int priority)` → `sender = "System"`
3. `Notification(String message, int priority, String sender)`

Centralize everything in the main constructor.

<details><summary>Show solution</summary>

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

## Exercise 9: Identify a constructor “loop” error

Create a class `Demo` and write two constructors that DO NOT cause an infinite loop.

- `Demo()` must delegate to `Demo(String value)`
- `Demo(String value)` must assign `value` to an attribute

Avoid this mistake:

- `Demo()` → `this("x")`
- `Demo(String value)` → `this()` (this would create a loop)

<details><summary>Show solution</summary>

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

## Exercise 10: `this(...)` must be the first line

Create a class `Logger` with:

- `prefix` (String)

Constructors:

1. `Logger()` → prefix `"APP"`
2. `Logger(String prefix)`

Make sure the parameterless constructor calls `this("APP")` as the first line.

<details><summary>Show solution</summary>

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
