# Topic 16. Constructor overloading

## 1. Introduction

In earlier topics you've already used **constructors** to initialize objects when you create them with `new`.

Example:

```java
User user = new User("Laura", 28);
```

But in real projects it's common to be able to create an object in **several ways**.

For example, imagine a `User` class:

- Sometimes you have a name and age
- Sometimes you only have the name
- Sometimes you just want to create an “empty” user with default values
- Sometimes you have a name, age and email

In Java, this is solved with:

- **Constructor overloading**

The idea is the same as in method overloading:

- Same name (the class's name)
- Different parameters (number and/or types)

In this topic you will learn:

- What constructor overloading is and why it's used
- How to create multiple constructors in one class
- What `this(...)` is and why it's key to avoid duplicating code
- Good initialization and validation practices
- Complete examples ready to copy and run

---

[![Constructor overloading](https://img.youtube.com/vi/sfm4Cu2Q1fw/0.jpg)](https://www.youtube.com/watch?v=sfm4Cu2Q1fw&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What constructor overloading is

A class can have **multiple constructors**, as long as their parameters are different.

Example of different signatures:

```java
public User() { ... }
public User(String name) { ... }
public User(String name, int age) { ... }
public User(String name, int age, String email) { ... }
```

This allows you to create objects in different ways:

```java
User u1 = new User();
User u2 = new User("Laura");
User u3 = new User("Laura", 28);
User u4 = new User("Laura", 28, "laura@example.com");
```

---

## 3. Default values and consistency

When you have multiple constructors, you have to make sure the object is always left in a consistent state.

Example of typical default values:

- `name` → `"Unknown"`
- `age` → `0`
- `email` → `null` (depending on your design)
- `active` → `true`

---

## 4. Typical problem: code duplication

A first (but bad) approach to overloading is to repeat the same code in each constructor.

Example to avoid:

```java
public class User {
    private String name;
    private int age;

    public User() {
        name = "Unknown";
        age = 0;
    }

    public User(String name) {
        this.name = name;
        age = 0;
    }

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

This works, but:

- If you change the logic (e.g. validation), you have to change it in multiple places
- It's easy to forget to update a constructor
- Over time, it becomes a source of errors

To fix this, you use `this(...)`.

---

## 5. `this(...)`: calling another constructor

`this(...)` lets you call another constructor **inside the same class**.

Important rules:

1. `this(...)` must be **the first line** of the constructor
2. It's used to reuse code and centralize initialization

Example:

```java
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
```

Here:

- The parameterless constructor delegates to the most complete constructor
- The constructor with `name` delegates to the most complete constructor
- The actual initialization logic is in one place

---

## 6. Complete example 1: `User` with constructor overloading

### 6.1. Objective

We want to be able to create users like this:

- `new User()` → default values
- `new User("Laura")` → name only
- `new User("Laura", 28)` → name and age
- `new User("Laura", 28, "laura@example.com")` → name, age and email

### 6.2. `User.java`

```java
public class User {
    private String name;
    private int age;
    private String email;
    private boolean active;

    public User() {
        this("Unknown", 0, null);
    }

    public User(String name) {
        this(name, 0, null);
    }

    public User(String name, int age) {
        this(name, age, null);
    }

    public User(String name, int age, String email) {
        this.active = true;

        setName(name);
        setAge(age);
        setEmail(email);
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public String getEmail() {
        return email;
    }

    public boolean isActive() {
        return active;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            this.name = "Unknown";
            return;
        }

        this.name = name;
    }

    public void setAge(int age) {
        if (age < 0) {
            this.age = 0;
            return;
        }

        this.age = age;
    }

    public void setEmail(String email) {
        if (email == null || email.isBlank()) {
            this.email = null;
            return;
        }

        this.email = email;
    }

    public void deactivate() {
        this.active = false;
    }

    public void printInfo() {
        System.out.println(
                "Name: " + name +
                " | Age: " + age +
                " | Email: " + email +
                " | Active: " + active
        );
    }
}
```

Key points from the example:

- The “small” constructors call the “big” one (`this(...)`).
- The main constructor reuses setters to validate.
- The object always ends up with consistent values.

### 6.3. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        User u1 = new User();
        User u2 = new User("Laura");
        User u3 = new User("Laura", 28);
        User u4 = new User("Laura", 28, "laura@example.com");
        User u5 = new User("   ", -5, "   ");

        u1.printInfo();
        u2.printInfo();
        u3.printInfo();
        u4.printInfo();
        u5.printInfo();
    }
}
```

---
## 7. Complete example 2: `Order` with overloading and initial state

### 7.1. Objective

Creating orders in several ways:

- `new Order()` → id + status `"CREATED"` + total 0
- `new Order(String customer)` → the same but with a customer
- `new Order(String customer, double total)` → customer and total

### 7.2. `Order.java`

```java
public class Order {
    private static int nextId = 1;

    private int id;
    private String customer;
    private double total;
    private String status;

    public Order() {
        this("Unknown", 0.0);
    }

    public Order(String customer) {
        this(customer, 0.0);
    }

    public Order(String customer, double total) {
        this.id = nextId;
        nextId++;

        this.status = "CREATED";

        setCustomer(customer);
        setTotal(total);
    }

    public int getId() {
        return id;
    }

    public String getCustomer() {
        return customer;
    }

    public double getTotal() {
        return total;
    }

    public String getStatus() {
        return status;
    }

    public void setCustomer(String customer) {
        if (customer == null || customer.isBlank()) {
            this.customer = "Unknown";
            return;
        }

        this.customer = customer;
    }

    public void setTotal(double total) {
        if (total < 0) {
            this.total = 0.0;
            return;
        }

        this.total = total;
    }

    public void markAsPaid() {
        this.status = "PAID";
    }

    public void printInfo() {
        System.out.println(
                "Order #" + id +
                " | Customer: " + customer +
                " | Total: " + total +
                " | Status: " + status
        );
    }
}
```

### 7.3. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        Order o1 = new Order();
        Order o2 = new Order("Laura");
        Order o3 = new Order("Laura", 49.99);
        Order o4 = new Order("   ", -10);

        o1.printInfo();
        o2.printInfo();
        o3.printInfo();
        o4.printInfo();

        o3.markAsPaid();
        o3.printInfo();
    }
}
```

Key points:

- `nextId` is `static`: it belongs to the class, not to each object.
- The constructors delegate to a main one.
- The default state (`status`) is initialized consistently.

---

## 8. Common mistakes in constructor overloading

### 8.1. Calling `this(...)` after other lines

This is invalid:

```java
public User() {
    System.out.println("Creating user");
    this("Unknown"); // error: this(...) debe ser la primera línea
}
```

### 8.2. Creating constructors that call each other in a loop

Example of the mistake (infinite loop):

```java
public User() {
    this("Unknown");
}

public User(String name) {
    this(); // vuelve a llamar al primero => bucle
}
```

### 8.3. Leaving attributes uninitialized in some overloads

If one constructor doesn't initialize the same thing as the others, you can end up with inconsistent states.  
That's why the recommended pattern is:

- A “main” constructor
- The rest delegate to it

---

## 9. Good practices

- Use overloading to provide different ways to create objects.
- Centralize initialization with `this(...)` to avoid duplicating logic.
- The most complete constructor is usually the one that does the real work.
- Reuse setters with validation if they already exist and it makes sense.
- Define consistent default values (and keep them in one place).

---

## 10. Things to keep in mind

- Constructor overloading = multiple constructors with different parameters.
- `this(...)` calls another constructor of the same class.
- `this(...)` must always be the first statement in the constructor.
- Avoid duplicating logic: always delegate to a “main” constructor.
- Design consistent defaults to avoid “half-baked” objects.

---

In the next topic we'll keep digging into OOP with concepts such as **`static`**, class vs instance members, and common patterns for organizing models in real projects.
