# Topic 14. Classes and Objects (OPO): attributes, methods, constructors, getters and setters

## 1. Introduction

So far you have programmed using:

- Variables and types
- Conditionals and loops
- Methods
- Arrays, lists and basic collections

With that you can do a lot of things, but as your programs grow a problem appears:

- You need to organize code and data in a more structured way
- You want to represent “things from the real world” within the program (a user, a product, a task, a car…)
- You want to group data and actions that are related

This is where **Object Oriented Programming** (OOP) comes in.

The OOP is based on two main concepts:

- **Class**: the “mold” or template
- **Object**: an “instance” created from that mold

In this topic you will learn:

- What is a class and what is an object
- How to create attributes (state) and methods (behavior)
- How to create constructors (initialization)
- What is encapsulation and why use `private`
- How to create getters and setters correctly
- Complete examples and good initial practices

---

[![What is object-oriented programming](https://img.youtube.com/vi/q-2cUZENGd4/0.jpg)](https://www.youtube.com/watch?v=q-2cUZENGd4&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

[![Classes and Objects](https://img.youtube.com/vi/v8GXjxagGFU/0.jpg)](https://www.youtube.com/watch?v=v8GXjxagGFU&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is a class and what is an object

### 2.1. Class

A **class** is a template that describes:

- What data does something have (attributes)
- What it can do (methods)

Example: `User` class can have:

- Attributes: `name`, `age`, `email`
- Methods: `printInfo()`, `isAdult()`

### 2.2. Object

An **object** is a concrete instance of a class.

Example: If `User` is the template, then:

- `User laura = new User(...);` is a real item.

You can create multiple objects from the same class, each with its own data.

---

## 3. Basic structure of a class

A class in Java typically has this structure:

- Attributes (fields)
- Builders
- Methods
- Getters and setters (if applicable)

Minimal example:

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Age: " + age);
    }
}
```

---

## 4. Attributes (state of an object)

An **attribute** (also called a _field_ or _property_) is a variable declared within a class.

Example:

```java
public class Product {
    private String name;
    private double price;
}
```

Each `Product` object has its own `name` and `price`.

### 4.1. `private` and encapsulation

In Java, it is good practice for the attributes to be `private`:

- To protect the state of the object
- To control how it is modified
- To avoid “uncontrolled” changes from outside

Example (bad practice):

```java
public class Product {
    public double price;
}
```

If `price` is public, any part of the program could put invalid values:

```java
product.price = -999; // mal
```

With `private`, you control it with specific setters or methods.

---

## 5. Methods (behavior of an object)

A method within a class represents what the object “can do.”

Example in `Product`:

```java
public class Product {
    private String name;
    private double price;

    public void applyDiscount(double discountRate) {
        price = price - (price * discountRate);
    }
}
```

- The method uses and modifies attributes of the object (`price`).
- Each object applies the discount on **its own status**.

---

## 6. Create objects with `new`

To use a class, you must create objects.

Example:

```java
Product mouse = new Product();
```

But this only works if the class has a parameterless constructor (default or created by you).

In practice, to properly initialize an object, we use constructors.

---

## 7. Builders

A **constructor** is a special method that is executed when creating an object with `new`.

Features:

- Has the same name as the class
- It has no return type (nor `void`)
- Used to initialize attributes

### 7.1. Constructor with parameters

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

### 7.2. What is `this`

`this` refers to the current object (the current instance).

In the constructor:

- `this.name` is the attribute of the object
- `name` (without `this`) is the constructor parameter

```java
this.name = name;
```

### 7.3. Use the constructor from `main`

```java
public class Main {
    public static void main(String[] args) {
        User laura = new User("Laura", 28);
        User alex = new User("Alex", 35);

        // Cada objeto tiene su propio estado
    }
}
```

---

## 8. Default constructor (without parameters)

If you don't define any constructor, Java creates an “empty” one automatically.

But if you define at least one constructor, the default constructor ceases to exist, and if you need it you must create it yourself.

Example:

```java
public class User {
    private String name;
    private int age;

    public User() {
        this.name = "Unknown";
        this.age = 0;
    }

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

Now you can do:

```java
User u1 = new User();
User u2 = new User("Laura", 28);
```

---

## 9. Getters and setters

Since attributes are usually `private`, you need a controlled way to access and modify values:

- **Getter**: returns the value of an attribute
- **Setter**: modifies the value of an attribute

### 9.1. Complete example with getters and setters

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAge(int age) {
        this.age = age;
    }
}
```

### 9.2. Use them from `main`

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", 28);

        System.out.println(user.getName());
        System.out.println(user.getAge());

        user.setName("Laura M.");
        user.setAge(29);

        System.out.println(user.getName());
        System.out.println(user.getAge());
    }
}
```

---

## 10. Validation within setters (good practice)

A setter does not have to accept any value. You can validate.

Example: avoid negative age

```java
public void setAge(int age) {
    if (age < 0) {
        return;
    }

    this.age = age;
}
```

More explicit:

```java
public void setAge(int age) {
    if (age < 0) {
        System.out.println("Invalid age");
        return;
    }

    this.age = age;
}
```

This protects the consistency of the object.

---

## 11. Methods that use attributes (useful examples)

### 11.1. `isAdult()` method

```java
public boolean isAdult() {
    return age >= 18;
}
```

### 11.2. `printInfo()` method

```java
public void printInfo() {
    System.out.println("Name: " + name + " | Age: " + age);
}
```

---

## 12. Complete example: `User` class

Here's a complete example, ready to copy and run.

### 12.1. `User.java`

```java
public class User {
    private String name;
    private int age;

    public User() {
        this.name = "Unknown";
        this.age = 0;
    }

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            return;
        }

        this.name = name;
    }

    public void setAge(int age) {
        if (age < 0) {
            return;
        }

        this.age = age;
    }

    public boolean isAdult() {
        return age >= 18;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Age: " + age);
    }
}
```

### 12.2. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        User user1 = new User("Laura", 28);
        User user2 = new User();

        user1.printInfo();
        user2.printInfo();

        System.out.println(user1.isAdult()); // true
        System.out.println(user2.isAdult()); // false

        user2.setName("Alex");
        user2.setAge(35);

        user2.printInfo();
    }
}
```

---

## 13. Complete example: `Product` class

A different example to see that the idea applies to any “thing”.

### 13.1. `Product.java`

```java
public class Product {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        if (price < 0) {
            return;
        }

        this.price = price;
    }

    public void applyDiscount(double discountRate) {
        if (discountRate < 0 || discountRate > 1) {
            return;
        }

        price = price - (price * discountRate);
    }

    public void printInfo() {
        System.out.println("Product: " + name + " | Price: " + price);
    }
}
```

### 13.2. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        Product keyboard = new Product("Keyboard", 49.99);

        keyboard.printInfo();

        keyboard.applyDiscount(0.20);
        keyboard.printInfo();

        keyboard.setPrice(-10); // no cambia
        keyboard.printInfo();
    }
}
```

---

## 14. Typical mistakes when starting classes

### 14.1. Trying to access `private` attributes from outside

If an attribute is `private`, you cannot do this:

```java
// user.age = 30; // error
```

You must use a setter or a method:

```java
user.setAge(30);
```

### 14.2. Forget to initialize attributes

If you do not initialize, you will have default values:

- `int` → 0
- `double` → 0.0
- `boolean` → false
- `String` → null

That's why builders are important.

### 14.3. Confuse class with object

- Class: `User`
- Object: `User laura = new User("Laura", 28);`

---

## 15. To take into account

- A **class** is a template; an **object** is an instance.
- **attributes** represent the state of the object.
- The **methods** represent its behavior.
- **Constructors** initialize the object when creating it.
- `this` refers to the current object.
- Using `private` attributes + getters/setters improves state control and security.
- Setters can and should validate values ​​when it makes sense.

---

In the next topic we will delve into fundamental OOP concepts like **encapsulation**, **access modifiers**, `this` in more detail and how to better organize classes for real projects.
