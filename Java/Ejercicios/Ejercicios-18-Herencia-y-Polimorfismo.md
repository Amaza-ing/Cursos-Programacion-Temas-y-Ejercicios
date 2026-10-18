# Exercises - Topic 18: Inheritance and Polymorphism

Below you will find **10 practical exercises** on **inheritance** and **polymorphism**: `extends`, `super(...)`, overwriting with `@Override`, using parent references for child instances, polymorphic lists, and a first contact with `instanceof`.

Try to solve them before consulting the solution.

---

## Exercise 1: `Person` and `Student`

Create a class `Person` with:

- `private String name`
- `Person(String name)` Builder
- `printInfo()` method showing `Name: ...`

Create a class `Student extends Person` with:

- `private String studentId`
- `Student(String name, String studentId)` constructor that calls `super(name)`
- `printStudentId()` method

In `main`, create an `Student` and call both methods.

<details><summary>Show solution</summary>

```java
public class Person {
    private String name;

    public Person(String name) {
        this.name = name;
    }

    public void printInfo() {
        System.out.println("Name: " + name);
    }
}
```

```java
public class Student extends Person {
    private String studentId;

    public Student(String name, String studentId) {
        super(name);
        this.studentId = studentId;
    }

    public void printStudentId() {
        System.out.println("StudentId: " + studentId);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Student student = new Student("Laura", "S-100");
        student.printInfo();
        student.printStudentId();
    }
}
```

</details>

---

## Exercise 2: Overwrite `printInfo()` with `@Override`

Building on the previous exercise, overwrite `printInfo()` in `Student` so that it displays:

```
Name: ... | StudentId: ...
```

Reuse the parent's `printInfo()` with `super.printInfo()` or print everything yourself (choose an option).

<details><summary>Show solution</summary>

```java
public class Student extends Person {
    private String studentId;

    public Student(String name, String studentId) {
        super(name);
        this.studentId = studentId;
    }

    @Override
    public void printInfo() {
        super.printInfo();
        System.out.println("StudentId: " + studentId);
    }
}
```

</details>

---

## Exercise 3: `Vehicle`, `Car` and `Bike`

Create an `Vehicle` class with an `move()` method that prints:

```
Moving...
```

Create:

- `Car extends Vehicle` → overwrite `move()` to print `Driving...`
- `Bike extends Vehicle` → overwrite `move()` to print `Cycling...`

In `main`, create one `Vehicle` that is an `Car` and another that is an `Bike` and call `move()`.

<details><summary>Show solution</summary>

```java
public class Vehicle {
    public void move() {
        System.out.println("Moving...");
    }
}
```

```java
public class Car extends Vehicle {
    @Override
    public void move() {
        System.out.println("Driving...");
    }
}
```

```java
public class Bike extends Vehicle {
    @Override
    public void move() {
        System.out.println("Cycling...");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Vehicle v1 = new Car();
        Vehicle v2 = new Bike();

        v1.move();
        v2.move();
    }
}
```

</details>

---

## Exercise 4: Polymorphic list of vehicles

Using the classes from the previous exercise, create an `List<Vehicle>` list and add:

- 2 cars
- 1 bike

Loop through the list and call `move()` on each item.

<details><summary>Show solution</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Vehicle> vehicles = new ArrayList<>();

        vehicles.add(new Car());
        vehicles.add(new Car());
        vehicles.add(new Bike());

        for (Vehicle vehicle : vehicles) {
            vehicle.move();
        }
    }
}
```

</details>

---

## Exercise 5: `Animal` with overridden method

Create a class `Animal` with method `sound()` that prints:

```
Animal sound...
```

Create:

- `Dog extends Animal` → `sound()` prints `Woof`
- `Cat extends Animal` → `sound()` prints `Meow`

In `main`, save an `Dog` and an `Cat` in variables of type `Animal` and call `sound()`.

<details><summary>Show solution</summary>

```java
public class Animal {
    public void sound() {
        System.out.println("Animal sound...");
    }
}
```

```java
public class Dog extends Animal {
    @Override
    public void sound() {
        System.out.println("Woof");
    }
}
```

```java
public class Cat extends Animal {
    @Override
    public void sound() {
        System.out.println("Meow");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Animal a1 = new Dog();
        Animal a2 = new Cat();

        a1.sound();
        a2.sound();
    }
}
```

</details>

---

## Exercise 6: Access to exclusive methods of the child

Create a class `Employee` with method `work()` that prints:

```
Working...
```

Create a class `Manager extends Employee` with additional method `approveVacation()`.

In `main`:

1. Create an `Employee` that is an `Manager` (parent reference)
2. Call `work()`
3. To call `approveVacation()`, cast `Manager`

<details><summary>Show solution</summary>

```java
public class Employee {
    public void work() {
        System.out.println("Working...");
    }
}
```

```java
public class Manager extends Employee {
    public void approveVacation() {
        System.out.println("Vacation approved");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Employee employee = new Manager();
        employee.work();

        Manager manager = (Manager) employee;
        manager.approveVacation();
    }
}
```

</details>

---

## Exercise 7: `instanceof` to avoid an unsafe cast

Use the classes in exercise 6.

In `main`, create:

- `Employee e1 = new Employee();`
- `Employee e2 = new Manager();`

Write a static method:

```java
public static void tryApprove(Employee employee)
```

What:

- If `employee` is `Manager`, call `approveVacation()`
- If not, print `Not a manager`

<details><summary>Show solution</summary>

```java
public class Employee {
    public void work() {
        System.out.println("Working...");
    }
}
```

```java
public class Manager extends Employee {
    public void approveVacation() {
        System.out.println("Vacation approved");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Employee e1 = new Employee();
        Employee e2 = new Manager();

        tryApprove(e1);
        tryApprove(e2);
    }

    public static void tryApprove(Employee employee) {
        if (employee instanceof Manager) {
            Manager manager = (Manager) employee;
            manager.approveVacation();
        } else {
            System.out.println("Not a manager");
        }
    }
}
```

</details>

---

## Exercise 8: Overwriting and calling `super.method()`

Create a class `BaseLogger` with a method `log(String message)` that prints:

```
LOG: message
```

Create a class `FileLogger extends BaseLogger` that overrides `log` to print first:

```
Saving to file...
```

And then call `super.log(message)`.

<details><summary>Show solution</summary>

```java
public class BaseLogger {
    public void log(String message) {
        System.out.println("LOG: " + message);
    }
}
```

```java
public class FileLogger extends BaseLogger {
    @Override
    public void log(String message) {
        System.out.println("Saving to file...");
        super.log(message);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        BaseLogger logger = new FileLogger();
        logger.log("Hello");
    }
}
```

</details>

---

## Exercise 9: Hierarchy with parent constructor

Create a class `Account` with:

- `private String id`
- `Account(String id)` Builder
- `printInfo()` method that prints `Account id: ...`

Create `PremiumAccount extends Account` with:

- `private int points`
- `PremiumAccount(String id, int points)` constructor that calls `super(id)`

Overwrite `printInfo()` to also include the points.

<details><summary>Show solution</summary>

```java
public class Account {
    private String id;

    public Account(String id) {
        this.id = id;
    }

    public void printInfo() {
        System.out.println("Account id: " + id);
    }
}
```

```java
public class PremiumAccount extends Account {
    private int points;

    public PremiumAccount(String id, int points) {
        super(id);
        this.points = points;
    }

    @Override
    public void printInfo() {
        super.printInfo();
        System.out.println("Points: " + points);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Account a = new PremiumAccount("A-10", 120);
        a.printInfo();
    }
}
```

</details>

---

## Exercise 10: Polymorphism with calculation in an overridden method

Create a class `Discount` with method:

```java
public double apply(double price)
```

By default, it returns the same `price` (no discount).

Create:

- `PercentageDiscount extends Discount` with attribute `percent` and `apply` that subtracts the percentage.
- `FixedDiscount extends Discount` with attribute `amount` and `apply` that subtracts a fixed amount (without going below 0).

In `main`, create an `List<Discount>` list with:

- a percentage discount of 10%
- a fixed discount of 5

It applies both to `price = 50` and shows the result of each.

<details><summary>Show solution</summary>

```java
public class Discount {
    public double apply(double price) {
        return price;
    }
}
```

```java
public class PercentageDiscount extends Discount {
    private double percent;

    public PercentageDiscount(double percent) {
        this.percent = percent;
    }

    @Override
    public double apply(double price) {
        return price - price * (percent / 100.0);
    }
}
```

```java
public class FixedDiscount extends Discount {
    private double amount;

    public FixedDiscount(double amount) {
        this.amount = amount;
    }

    @Override
    public double apply(double price) {
        return Math.max(0.0, price - amount);
    }
}
```

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Discount> discounts = new ArrayList<>();
        discounts.add(new PercentageDiscount(10));
        discounts.add(new FixedDiscount(5));

        double price = 50;

        for (Discount discount : discounts) {
            System.out.println(discount.apply(price));
        }
    }
}
```

</details>

---
