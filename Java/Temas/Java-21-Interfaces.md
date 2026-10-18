# Topic 21. Interfaces

## 1. Introduction

In the previous topic you saw the **abstract classes** and **abstract methods**, which allow you to create a common base for several child classes.

Now we are going to study another fundamental concept of Java and Object-Oriented Programming:

- **Interfaces**

Interfaces serve to define a **contract**: they indicate what methods a class should have, without forcing the sharing of state or a complete common implementation.

This is very useful when several different classes:

- do not share a clear inheritance hierarchy
- but they do share an expected behavior

Typical examples:

- `Printable`
- `Payable`
- `Comparable`
- `Runnable`

An interface allows you to say:

> “Any class that implements this must know how to do these operations.”

In this topic you will learn:

- What is an interface
- How it is declared and how it is implemented
- Differences between interface and abstract class
- What are the `default` and `static` methods in interfaces
- What does it mean that a class can implement several interfaces?
- How to use interfaces with polymorphism
- Real examples and good practices

---

[![Interfaces](https://img.youtube.com/vi/wpI-eBLVaQI/0.jpg)](https://www.youtube.com/watch?v=wpI-eBLVaQI&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is an interface

An **interface** is a special type of Java that defines a contract.

That contract indicates:

- what methods should exist
- but does not force a classical concrete implementation in all cases

Basic syntax:

```java
public interface Printable {
    void print();
}
```

This means:

- any class that implements `Printable`
- must have an `print()` method

---

## 3. How to implement an interface

A class implements an interface using `implements`.

Example:

```java
public interface Printable {
    void print();
}
```

```java
public class Invoice implements Printable {
    @Override
    public void print() {
        System.out.println("Printing invoice...");
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Invoice invoice = new Invoice();
        invoice.print();
    }
}
```

---

## 4. Interface as a contract, not as a “normal” object

Like an abstract class, an interface is not directly instantiated.

This cannot be done:

```java
// Printable p = new Printable(); // error
```

But you can do:

```java
Printable p = new Invoice();
p.print();
```

This is polymorphism: you work with the interface, not the concrete class.

---

## 5. What interfaces can contain

In modern Java, an interface can contain:

- abstract methods
- `default` methods
- `static` methods
- constants (`public static final`)

### 5.1. Abstract method

It is the classic case:

```java
public interface Payable {
    double calculatePayment();
}
```

### 5.2. Constants

Every attribute declared in an interface is, implicitly:

- `public`
- `static`
- `final`

Example:

```java
public interface AppConfig {
    int MAX_USERS = 100;
}
```

Usage:

```java
System.out.println(AppConfig.MAX_USERS);
```

---

## 6. First complete example: `Playable`

We want different classes to know how to “reproduce.”

### 6.1. Interface

```java
public interface Playable {
    void play();
}
```

### 6.2. Classes that implement the interface

```java
public class Song implements Playable {
    private String title;

    public Song(String title) {
        this.title = title;
    }

    @Override
    public void play() {
        System.out.println("Playing song: " + title);
    }
}
```

```java
public class Video implements Playable {
    private String name;

    public Video(String name) {
        this.name = name;
    }

    @Override
    public void play() {
        System.out.println("Playing video: " + name);
    }
}
```

### 6.3. Polymorphic use

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Playable> items = new ArrayList<>();

        items.add(new Song("Imagine"));
        items.add(new Video("Java Course Intro"));

        for (Playable item : items) {
            item.play();
        }
    }
}
```

Notice how powerful this is:

- `Song` and `Video` do not have to inherit from the same concrete class
- but both fulfill the `Playable` contract
- so you can treat them evenly

---

## 7. Difference between `extends` and `implements`

- `extends` is used to inherit from a class or extend another interface
- `implements` is used when a class implements an interface

Example:

```java
public class Dog extends Animal implements Playable {
}
```

Here:
- `Dog` inherits from `Animal`
- `Dog` implements `Playable`

---

## 8. Interface vs abstract class

This comparison is very important.

### 8.1. Use an abstract class when

- you want to share common status (attributes)
- you want to reuse common implementation
- there is a clear inheritance relationship (_is-a_)

Example:

- `Animal`
- `Employee`
- `Shape`

### 8.2. Use an interface when

- you want to define capabilities or behaviors
- several unrelated classes must fulfill the same contract
- you don't need to share common status required

Example:

- `Printable`
- `Payable`
- `Sortable`

### 8.3. Simple rule of thumb

- Abstract class = common base
- Interface = capacity or contract

---

## 9. A class can implement multiple interfaces

Here is a big difference regarding class inheritance.

In Java:

- a class can only inherit from one class
- but can implement multiple interfaces

Example:

```java
public interface Printable {
    void print();
}
```

```java
public interface Exportable {
    void export();
}
```

```java
public class Report implements Printable, Exportable {
    @Override
    public void print() {
        System.out.println("Printing report...");
    }

    @Override
    public void export() {
        System.out.println("Exporting report...");
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Report report = new Report();

        report.print();
        report.export();
    }
}
```

This is very useful because a class can have several “abilities”.

---

## 10. Polymorphism with interfaces

As in inheritance, interfaces allow polymorphism.

Example:

```java
Printable p1 = new Report();
Printable p2 = new Invoice();
```

If both classes implement `Printable`, you can treat them as `Printable`.

### 10.1. Complete example

```java
public interface Printable {
    void print();
}
```

```java
public class Invoice implements Printable {
    @Override
    public void print() {
        System.out.println("Printing invoice...");
    }
}
```

```java
public class Ticket implements Printable {
    @Override
    public void print() {
        System.out.println("Printing ticket...");
    }
}
```

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Printable> documents = new ArrayList<>();

        documents.add(new Invoice());
        documents.add(new Ticket());

        for (Printable document : documents) {
            document.print();
        }
    }
}
```

---

## 11. `default` methods in interfaces

Since Java 8, an interface can have `default` methods, that is, methods with default implementation.

This allows common behavior to be added without forcing all classes to rewrite it.

Example:

```java
public interface Greeter {
    void greet();

    default void sayGoodbye() {
        System.out.println("Goodbye!");
    }
}
```

Class that implements:

```java
public class Person implements Greeter {
    @Override
    public void greet() {
        System.out.println("Hello!");
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Person person = new Person();

        person.greet();
        person.sayGoodbye();
    }
}
```

Here:

- `greet()` must be implemented
- `sayGoodbye()` is already “gifted” by the interface

### 11.1. Overriding an `default` method

You can also overwrite it:

```java
public class FriendlyPerson implements Greeter {
    @Override
    public void greet() {
        System.out.println("Hi!");
    }

    @Override
    public void sayGoodbye() {
        System.out.println("See you soon!");
    }
}
```

---

## 12. `static` methods in interfaces

An interface can also have static methods.

They are called with the name of the interface, not the object.

Example:

```java
public interface TemperatureConverter {
    static double celsiusToFahrenheit(double celsius) {
        return celsius * 9 / 5 + 32;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        double result = TemperatureConverter.celsiusToFahrenheit(25);
        System.out.println(result);
    }
}
```

You don't need to create any class that implements the interface to use that static method.

---

## 13. Interfaces that extend other interfaces

An interface can also inherit from another interface using `extends`.

Example:

```java
public interface Printable {
    void print();
}
```

```java
public interface AdvancedPrintable extends Printable {
    void preview();
}
```

Any class that implements `AdvancedPrintable` must implement:

- `print()`
- `preview()`

Example:

```java
public class Report implements AdvancedPrintable {
    @Override
    public void print() {
        System.out.println("Printing report...");
    }

    @Override
    public void preview() {
        System.out.println("Previewing report...");
    }
}
```

---

## 14. Complete example: payment system with interface

This is a very realistic example.

We want different payment methods to share the same contract.

### 14.1. `Payable` interface

```java
public interface Payable {
    double calculatePayment();
    void processPayment();
}
```

### 14.2. `CardPayment`

```java
public class CardPayment implements Payable {
    private double amount;

    public CardPayment(double amount) {
        this.amount = amount;
    }

    @Override
    public double calculatePayment() {
        return amount;
    }

    @Override
    public void processPayment() {
        System.out.println("Processing card payment: " + amount);
    }
}
```

### 14.3. `PaypalPayment`

```java
public class PaypalPayment implements Payable {
    private double amount;
    private double fee;

    public PaypalPayment(double amount, double fee) {
        this.amount = amount;
        this.fee = fee;
    }

    @Override
    public double calculatePayment() {
        return amount + fee;
    }

    @Override
    public void processPayment() {
        System.out.println("Processing PayPal payment: " + calculatePayment());
    }
}
```

### 14.4. Use

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Payable> payments = new ArrayList<>();

        payments.add(new CardPayment(49.99));
        payments.add(new PaypalPayment(49.99, 1.50));

        for (Payable payment : payments) {
            System.out.println("Total: " + payment.calculatePayment());
            payment.processPayment();
        }
    }
}
```

The important thing here is not the specific class, but that they all comply with `Payable`.

---

## 15. Complete example: `Comparable` as a real Java interface

One of the most famous interfaces in Java is `Comparable<T>`.

It serves to indicate that the objects of a class can be compared with each other.

Simple example:
```java
public class Product implements Comparable<Product> {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    @Override
    public int compareTo(Product other) {
        return Double.compare(this.price, other.price);
    }

    @Override
    public String toString() {
        return "Product{name='" + name + "', price=" + price + "}";
    }
}
```

Usage:

```java
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Product> products = new ArrayList<>();
        products.add(new Product("Mouse", 19.99));
        products.add(new Product("Keyboard", 49.99));
        products.add(new Product("USB Cable", 5.99));

        Collections.sort(products);

        System.out.println(products);
    }
}
```

This shows that interfaces are everywhere in real Java.

---

## 16. Typical mistakes when starting

### 16.1. Thinking that an interface is a normal class

You cannot do:

```java
// Printable p = new Printable(); // error
```

### 16.2. Forget to implement all methods

If a class implements an interface, it must implement all of its abstract methods, or then the class must also be abstract.

### 16.3. Use interface when you actually need a base class with common state

If many classes share attributes and a lot of logic, perhaps an abstract class is a better option.

### 16.4. Confusing `extends` and `implements`

- class + interface → `implements`
- interface + interface → `extends`

---

## 17. Good practices

- Use interfaces to define clear contracts.
- Name the interfaces according to the capacity or responsibility (`Printable`, `Payable`, `Sortable`).
- Program against the interface when it makes sense:

```java
List<Printable> items = new ArrayList<>();
```

instead of always working with concrete classes.

- Use `default` methods sparingly: they help, but should not turn the interface into a “disguised class”.
- If several classes share a lot of state, consider whether an abstract class fits better.

---

## 18. Clean interfaces and design

Interfaces favor a more flexible design because they decouple:

- the **what** is done
- **how** it is done

For example, if you have a method that receives `Payable`, it doesn't care if the payment comes from:

- card
-PayPal
- transfer
- another future method

You just need to fulfill the contract.

Example:

```java
public static void executePayment(Payable payment) {
    payment.processPayment();
}
```

This style makes the code more maintainable and extensible.

---

## 19. To take into account

- An interface defines a contract.
- A class is implemented with `implements`.
- Interfaces allow polymorphism.
- A class can implement several interfaces.
- An interface can have abstract methods, `default`, `static` and constants.
- An interface does not always replace an abstract class: both tools have different purposes.
- In real Java, interfaces are constantly used.

---

## 20. Final summary

- **Abstract class**: good for sharing common base and state.
- **Interface**: good for defining capabilities and contracts.
- **`implements`**: used to implement interfaces.
- **Polymorphism**: you can work with interface references.
- **Multiple interfaces**: a class can have multiple capabilities.
- **`default` and `static`**: expand what an interface can offer.
- **Flexible design**: Interfaces help write more reusable and cleaner code.

---

[![The 4 Pillars of Object-Oriented Programming (OOP)](https://img.youtube.com/vi/RGHdVD7K-rE/0.jpg)](https://www.youtube.com/watch?v=RGHdVD7K-rE&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

In the next topic we will continue advancing in Java with new language tools and we will see how to compare objects correctly with `equals`.
