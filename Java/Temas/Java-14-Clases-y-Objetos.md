# Topic 14. Classes and Objects (OOP): attributes, methods, constructors, getters and setters

## 1. Introduction

So far you've been programming with:

- Variables and types
- Conditionals and loops
- Methods
- Arrays, lists and basic collections

With that you can do loads of things, but as your programs grow, a problem shows up:

- You need to organize code and data in a more structured way
- You want to represent “things from the real world” inside the program (a user, a product, a task, a car…)
- You want to group data and actions that are related

This is where **Object-Oriented Programming** (OOP) comes in.

OOP is based on two main concepts:

- **Class**: the “mold” or template
- **Object**: an “instance” created from that mold

In this topic you will learn:

- What a class is and what an object is
- How to create attributes (state) and methods (behavior)
- How to create constructors (initialization)
- What encapsulation is and why to use `private`
- How to create getters and setters correctly
- Complete examples and some first good practices

---

[![What is object-oriented programming](https://img.youtube.com/vi/q-2cUZENGd4/0.jpg)](https://www.youtube.com/watch?v=q-2cUZENGd4&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

[![Classes and Objects](https://img.youtube.com/vi/v8GXjxagGFU/0.jpg)](https://www.youtube.com/watch?v=v8GXjxagGFU&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What a class is and what an object is

### 2.1. Class

A **class** is a template that describes:

- What data something has (attributes)
- What it can do (methods)

Example: the `User` class can have:

- Attributes: `name`, `age`, `email`
- Methods: `printInfo()`, `isAdult()`

### 2.2. Object

An **object** is a concrete instance of a class.

Example: if `User` is the template, then:

- `User laura = new User(...);` is a real object.

You can create multiple objects from the same class, each with its own data.

---

## 3. Basic structure of a class

A class in Java typically has this structure:

- Attributes (fields)
- Constructors
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

An **attribute** (also called a _field_ or _property_) is a variable declared inside a class.

Example:

```java
public class Product {
    private String name;
    private double price;
}
```

Each `Product` object has its own `name` and `price`.

### 4.1. `private` and encapsulation

In Java, it's good practice to make attributes `private`:

- To protect the state of the object
- To control how it is modified
- To avoid “uncontrolled” changes from outside

Example (bad practice):

```java
public class Product {
    public double price;
}
```

If `price` is public, any part of the program could set invalid values:

```java
product.price = -999; // mal
```

With `private`, you control it with setters or specific methods.

---

## 5. Methods (behavior of an object)

A method inside a class represents what the object “can do.”

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
- Each object applies the discount to **its own state**.

---

## 6. Creating objects with `new`

To use a class, you must create objects.

Example:

```java
Product mouse = new Product();
```

But this only works if the class has a parameterless constructor (default or created by you).

In practice, to properly initialize an object, we use constructors.

---

## 7. Constructors

A **constructor** is a special method that runs when you create an object with `new`.

Characteristics:

- It has the same name as the class
- It has no return type (not even `void`)
- It's used to initialize attributes

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

### 7.2. What `this` is

`this` refers to the current object (the current instance).

In the constructor:

- `this.name` is the attribute of the object
- `name` (without `this`) is the constructor parameter

```java
this.name = name;
```

### 7.3. Using the constructor from `main`

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

But if you define at least one constructor, the default constructor no longer exists, and if you need it you have to create it yourself.

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

### 9.2. Using them from `main`

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

## 10. Validation inside setters (good practice)

A setter doesn't have to accept just any value. You can validate it.

Example: preventing a negative age

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

### 11.1. The `isAdult()` method

```java
public boolean isAdult() {
    return age >= 18;
}
```

### 11.2. The `printInfo()` method

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

A different example, so you can see that the idea applies to any “thing”.

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

## 14. Common mistakes when starting out with classes

### 14.1. Trying to access `private` attributes from outside

If an attribute is `private`, you can't do this:

```java
// user.age = 30; // error
```

You must use a setter or a method:

```java
user.setAge(30);
```

### 14.2. Forgetting to initialize attributes

If you don't initialize them, you'll get default values:

- `int` → 0
- `double` → 0.0
- `boolean` → false
- `String` → null

That's why constructors are important.

### 14.3. Confusing a class with an object

- Class: `User`
- Object: `User laura = new User("Laura", 28);`

---

## 15. Things to keep in mind

- A **class** is a template; an **object** is an instance.
- **Attributes** represent the state of the object.
- **Methods** represent its behavior.
- **Constructors** initialize the object when it's created.
- `this` refers to the current object.
- Using `private` attributes + getters/setters improves state control and security.
- Setters can and should validate values when it makes sense.

---

In the next topic we'll dive deeper into fundamental OOP concepts such as **encapsulation**, **access modifiers**, `this` in more detail, and how to organize classes better for real projects.
