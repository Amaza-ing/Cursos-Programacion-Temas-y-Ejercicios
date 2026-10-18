# Exercises - Topic 14: Classes and Objects

Below you will find **10 practical exercises** on **Classes and Objects**: defining classes, attributes, methods, constructors, using `this`, getters and setters.

Try to solve them before looking at the solution.

---

## Exercise 1: Create a simple class

Create a class `Book` with:

- `title` (String)
- `pages` (int)

Create a constructor that receives both values and a `printInfo()` method that prints:

```
Title: X | Pages: Y
```

In `main`, create an object and call `printInfo()`.

<details><summary>Show solution</summary>

```java
public class Book {
    private String title;
    private int pages;

    public Book(String title, int pages) {
        this.title = title;
        this.pages = pages;
    }

    public void printInfo() {
        System.out.println("Title: " + title + " | Pages: " + pages);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Book book = new Book("Java Basics", 250);
        book.printInfo();
    }
}
```

</details>

---

## Exercise 2: Use `this` correctly

Create a class `Car` with:

- `brand`
- `year`

In the constructor, use `this` to tell attributes and parameters apart.

Create a method `printInfo()`.

<details><summary>Show solution</summary>

```java
public class Car {
    private String brand;
    private int year;

    public Car(String brand, int year) {
        this.brand = brand;
        this.year = year;
    }

    public void printInfo() {
        System.out.println("Brand: " + brand + " | Year: " + year);
    }
}
```

</details>

---

## Exercise 3: Getters and setters

Create a class `Student` with:

- `name`
- `grade`

Make the attributes `private` and create:

- A constructor
- Getters for both
- A setter for `grade` that checks the value is between 0 and 10

<details><summary>Show solution</summary>

```java
public class Student {
    private String name;
    private double grade;

    public Student(String name, double grade) {
        this.name = name;
        setGrade(grade);
    }

    public String getName() {
        return name;
    }

    public double getGrade() {
        return grade;
    }

    public void setGrade(double grade) {
        if (grade < 0 || grade > 10) {
            this.grade = 0;
        } else {
            this.grade = grade;
        }
    }
}
```

</details>

---

## Exercise 4: Method that modifies state

Create a class `BankAccount` with:

- `balance`

Include:

- Constructor that initializes the balance
- `deposit(double amount)` method
- `withdraw(double amount)` method (don't allow a negative balance)

<details><summary>Show solution</summary>

```java
public class BankAccount {
    private double balance;

    public BankAccount(double balance) {
        this.balance = balance;
    }

    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }

    public boolean withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            return true;
        }
        return false;
    }

    public double getBalance() {
        return balance;
    }
}
```

</details>

---

## Exercise 5: Constructor with default values

Create a class `User` with:

- `username`
- `active`

The constructor should receive only `username` and set `active = true` by default.

<details><summary>Show solution</summary>

```java
public class User {
    private String username;
    private boolean active;

    public User(String username) {
        this.username = username;
        this.active = true;
    }

    public boolean isActive() {
        return active;
    }
}
```

</details>

---

## Exercise 6: Method that returns formatted information

Create a class `Product` with:

- `name`
- `price`

Add a `getFormattedPrice()` method that returns:

```
Product: X | Price: Y
```

<details><summary>Show solution</summary>

```java
public class Product {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getFormattedPrice() {
        return "Product: " + name + " | Price: " + price;
    }
}
```

</details>

---

## Exercise 7: Create multiple objects

Create a class `Rectangle` with:

- `width`
- `height`

Include an `area()` method.

In `main`, create 3 different objects and print their areas.

<details><summary>Show solution</summary>

```java
public class Rectangle {
    private double width;
    private double height;

    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }

    public double area() {
        return width * height;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Rectangle r1 = new Rectangle(2, 3);
        Rectangle r2 = new Rectangle(4, 5);
        Rectangle r3 = new Rectangle(6, 7);

        System.out.println(r1.area());
        System.out.println(r2.area());
        System.out.println(r3.area());
    }
}
```

</details>

---

## Exercise 8: Method that changes a boolean attribute

Create a class `Light` with:

- `isOn` (boolean)

Include:

- `turnOn()` method
- `turnOff()` method
- `toggle()` method

<details><summary>Show solution</summary>

```java
public class Light {
    private boolean isOn;

    public void turnOn() {
        isOn = true;
    }

    public void turnOff() {
        isOn = false;
    }

    public void toggle() {
        isOn = !isOn;
    }

    public boolean isOn() {
        return isOn;
    }
}
```

</details>

---

## Exercise 9: Method that uses attributes to calculate a result

Create a class `Circle` with:

- `radius`

Include an `area()` method that uses `Math.PI`.

<details><summary>Show solution</summary>

```java
public class Circle {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    public double area() {
        return Math.PI * radius * radius;
    }
}
```

</details>

---
## Exercise 10: Class with a method that uses another method

Create a class `Employee` with:

- `name`
- `salary`

Include:

- `increaseSalary(double percentage)` method
- `getAnnualSalary()` method

`increaseSalary` should increase the salary by the percentage it receives.

<details><summary>Show solution</summary>

```java
public class Employee {
    private String name;
    private double salary;

    public Employee(String name, double salary) {
        this.name = name;
        this.salary = salary;
    }

    public void increaseSalary(double percentage) {
        if (percentage > 0) {
            salary += salary * (percentage / 100);
        }
    }

    public double getAnnualSalary() {
        return salary * 12;
    }
}
```

</details>

---
