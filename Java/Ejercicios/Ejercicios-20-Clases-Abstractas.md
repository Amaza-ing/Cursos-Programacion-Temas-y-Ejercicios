# Exercises - Topic 20: Abstract classes and abstract methods

Below you will find **10 practical exercises** on **abstract classes** and **abstract methods**: `abstract` declaration, bodyless methods, mandatory implementation in subclasses, constructors in abstract classes, `@Override`, polymorphism with lists, and a first comparison with “normal” classes.

Try to solve them before consulting the solution.

---

## Exercise 1: Abstract `Shape` with `area()`

Create an abstract class `Shape` with an abstract method:

```java
public abstract double area();
```

Create a class `Square extends Shape` with attribute `side` and that implements `area()`.

In `main`, create an `Shape` that is an `Square` and display the area.

<details><summary>Show solution</summary>

```java
public abstract class Shape {
    public abstract double area();
}
```

```java
public class Square extends Shape {
    private double side;

    public Square(double side) {
        this.side = side;
    }

    @Override
    public double area() {
        return side * side;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Shape shape = new Square(4);
        System.out.println(shape.area());
    }
}
```

</details>

---

## Exercise 2: Abstract class with constructor

Create an abstract class `Animal` with:

- `private String name`
- `Animal(String name)` Builder
-Getter `getName()`
- Abstract method `sound()`

Create `Dog extends Animal` and implement `sound()` to print `Woof`.

In `main`, create an `Dog` and display the name and sound.

<details><summary>Show solution</summary>

```java
public abstract class Animal {
    private String name;

    public Animal(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public abstract void sound();
}
```

```java
public class Dog extends Animal {
    public Dog(String name) {
        super(name);
    }

    @Override
    public void sound() {
        System.out.println("Woof");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Dog dog = new Dog("Rex");
        System.out.println(dog.getName());
        dog.sound();
    }
}
```

</details>

---

## Exercise 3: Normal method that calls an abstract one

Create an abstract class `Employee` with:

- `private String name`
- Builder
- Normal `printPayslip()` method that prints:
  - `Employee: name | Pay: X`
- Abstract method `calculatePay()`

Create `HourlyEmployee` with `hourlyRate` and `hoursWorked` and deploy `calculatePay()`.

In `main`, create an `HourlyEmployee` and call `printPayslip()`.

<details><summary>Show solution</summary>

```java
public abstract class Employee {
    private String name;

    public Employee(String name) {
        this.name = name;
    }

    public void printPayslip() {
        System.out.println("Employee: " + name + " | Pay: " + calculatePay());
    }

    public abstract double calculatePay();
}
```

```java
public class HourlyEmployee extends Employee {
    private double hourlyRate;
    private int hoursWorked;

    public HourlyEmployee(String name, double hourlyRate, int hoursWorked) {
        super(name);
        this.hourlyRate = hourlyRate;
        this.hoursWorked = hoursWorked;
    }

    @Override
    public double calculatePay() {
        return hourlyRate * hoursWorked;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Employee employee = new HourlyEmployee("Laura", 15, 120);
        employee.printPayslip();
    }
}
```

</details>

---

## Exercise 4: Subclass that does not implement an abstract

Creates an abstract class `Device` with abstract method `start()`.

Create an `SmartDevice extends Device` class that does NOT implement `start()`.

What should happen to `SmartDevice`?  
Make it compile.

<details><summary>Show solution</summary>

```java
public abstract class Device {
    public abstract void start();
}
```

```java
public abstract class SmartDevice extends Device {
    // no implementa start() => debe ser abstracta también
}
```

</details>

---

## Exercise 5: Polymorphism with `List<Shape>`

Create an abstract class `Shape` with `area()`.

Create two concrete classes:

- `Circle` with `radius`
- `Rectangle` with `width` and `height`

In `main`, create a list `List<Shape>` with 3 shapes (mix of Circle/Rectangle) and sum all the areas.

<details><summary>Show solution</summary>

```java
public abstract class Shape {
    public abstract double area();
}
```

```java
public class Circle extends Shape {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    @Override
    public double area() {
        return Math.PI * radius * radius;
    }
}
```

```java
public class Rectangle extends Shape {
    private double width;
    private double height;

    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }

    @Override
    public double area() {
        return width * height;
    }
}
```

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Shape> shapes = new ArrayList<>();
        shapes.add(new Circle(2));
        shapes.add(new Rectangle(3, 4));
        shapes.add(new Circle(1.5));

        double total = 0;

        for (Shape shape : shapes) {
            total += shape.area();
        }

        System.out.println(total);
    }
}
```

</details>

---

## Exercise 6: Abstract class with common state and validation

Create an abstract class `Document` with:

- `private String title`
- `Document(String title)` constructor that uses an `setTitle` setter
- `getTitle()`
- `setTitle(String title)` if it is `null` or `isBlank()` use `"Untitled"`
- Abstract method `printContent()`

Create `Note extends Document` with `text` attribute and print the content.
<details><summary>Show solution</summary>

```java
public abstract class Document {
    private String title;

    public Document(String title) {
        setTitle(title);
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        if (title == null || title.isBlank()) {
            this.title = "Untitled";
            return;
        }

        this.title = title;
    }

    public abstract void printContent();
}
```

```java
public class Note extends Document {
    private String text;

    public Note(String title, String text) {
        super(title);
        this.text = text;
    }

    @Override
    public void printContent() {
        System.out.println("Title: " + getTitle());
        System.out.println(text);
    }
}
```

</details>

---

## Exercise 7: Abstract method with boolean return

Create an abstract class `Validator` with abstract method:

```java
public abstract boolean isValid(String value);
```

Create:

- `EmailValidator` returns `true` if `value` contains `"@"` and `"."`
- `MinLengthValidator` that receives `minLength` in the constructor and validates by length

On `main`, try both validators.

<details><summary>Show solution</summary>

```java
public abstract class Validator {
    public abstract boolean isValid(String value);
}
```

```java
public class EmailValidator extends Validator {
    @Override
    public boolean isValid(String value) {
        if (value == null) {
            return false;
        }

        return value.contains("@") && value.contains(".");
    }
}
```

```java
public class MinLengthValidator extends Validator {
    private int minLength;

    public MinLengthValidator(int minLength) {
        this.minLength = minLength;
    }

    @Override
    public boolean isValid(String value) {
        if (value == null) {
            return false;
        }

        return value.length() >= minLength;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Validator v1 = new EmailValidator();
        Validator v2 = new MinLengthValidator(5);

        System.out.println(v1.isValid("laura@example.com"));
        System.out.println(v1.isValid("invalid"));

        System.out.println(v2.isValid("Java"));
        System.out.println(v2.isValid("ArrayList"));
    }
}
```

</details>

---

## Exercise 8: Abstract class with “template” method

Create an abstract class `Report` with normal method:

```java
public void printReport()
```

What:

1. Print `"=== Report ==="`
2. Call an abstract method `printBody()`
3. Print `"=== End ==="`

Create `SalesReport` that implements `printBody()`.

<details><summary>Show solution</summary>

```java
public abstract class Report {
    public void printReport() {
        System.out.println("=== Report ===");
        printBody();
        System.out.println("=== End ===");
    }

    public abstract void printBody();
}
```

```java
public class SalesReport extends Report {
    @Override
    public void printBody() {
        System.out.println("Total sales: 1200");
        System.out.println("Top product: Book");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Report report = new SalesReport();
        report.printReport();
    }
}
```

</details>

---

## Exercise 9: Compare abstract class vs “normal” class

Create a class `Printer` (normal) with method `print()` that prints `"Printing..."`.

Then create an abstract class `AbstractPrinter` with abstract method `print()`.

Create a class `ConsolePrinter extends AbstractPrinter` that implements `print()`.

In `main`, use `Printer` and `AbstractPrinter` (with `ConsolePrinter`).

<details><summary>Show solution</summary>

```java
public class Printer {
    public void print() {
        System.out.println("Printing...");
    }
}
```

```java
public abstract class AbstractPrinter {
    public abstract void print();
}
```

```java
public class ConsolePrinter extends AbstractPrinter {
    @Override
    public void print() {
        System.out.println("Printing...");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Printer p = new Printer();
        p.print();

        AbstractPrinter ap = new ConsolePrinter();
        ap.print();
    }
}
```

</details>

---

## Exercise 10: Abstract hierarchy with validation in the constructor

Create an abstract class `Payment` with:

- `private double amount`
- `Payment(double amount)` constructor that uses `setAmount`
- `getAmount()`
- `setAmount(double amount)` if negative use `0.0`
- Abstract method `process()`

Create:

- `CardPayment extends Payment` with attribute `cardNumber` and `process()` printing:
  - `Processing card payment: amount`
- `CashPayment extends Payment` with `process()` printing:
  - `Processing cash payment: amount`

In `main`, create both payments and call `process()` with references of type `Payment`.

<details><summary>Show solution</summary>

```java
public abstract class Payment {
    private double amount;

    public Payment(double amount) {
        setAmount(amount);
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        if (amount < 0) {
            this.amount = 0.0;
            return;
        }

        this.amount = amount;
    }

    public abstract void process();
}
```

```java
public class CardPayment extends Payment {
    private String cardNumber;

    public CardPayment(double amount, String cardNumber) {
        super(amount);
        this.cardNumber = cardNumber;
    }

    @Override
    public void process() {
        System.out.println("Processing card payment: " + getAmount());
    }
}
```

```java
public class CashPayment extends Payment {
    public CashPayment(double amount) {
        super(amount);
    }

    @Override
    public void process() {
        System.out.println("Processing cash payment: " + getAmount());
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Payment p1 = new CardPayment(49.99, "1234-0000-9999-8888");
        Payment p2 = new CashPayment(10);

        p1.process();
        p2.process();
    }
}
```

</details>

---
