# Topic 20. Abstract classes and abstract methods

## 1. Introduction

In the inheritance topic you learned that you can create hierarchies like:

- `Person` → `Student`
- `Employee` → `Manager`

That allows you to reuse code and create specialized child classes.

Now a very common need appears:

> What if I want a “base” class that **should not be instantiable**, but that I want to use as a template for its children?

Typical examples:

- `Shape` (form) → `Circle`, `Rectangle`
- `Animal` → `Dog`, `Cat`
- `PaymentMethod` → `CardPayment`, `PaypalPayment`

In these cases, the base class is a general idea, but:

- There is no point in creating a “generic” `Shape` object
- There is no point in creating an “untyped” `Animal` object.

For that there are:

- **Abstract classes**
- **Abstract methods**

In this topic you will learn:

- What is an abstract class
- What is an abstract method
- When to use them and why they are useful
- How to combine common code + mandatory behavior
- `abstract` vs normal inheritance
- Polymorphism with abstract classes
- Typical errors and good practices

---

[![Abstract Classes and Methods](https://img.youtube.com/vi/do2XG0T4mR8/0.jpg)](https://www.youtube.com/watch?v=do2XG0T4mR8&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is an abstract class

An **abstract class** is a class that:

- Cannot instantiate (`new`)
- Used as a base for other classes

It is declared with `abstract`:

```java
public abstract class Shape {
}
```

This DOES NOT compile:

```java
// Shape shape = new Shape(); // error
```

But you can do:

```java
Shape shape = new Circle(3.0);
```

Because `Circle` is a concrete subclass.

---

## 3. What is an abstract method

An **abstract method** is a method that:

- It is declared in the abstract class
- Has no body (`{}`)
- Forces child classes to implement it

Example:

```java
public abstract class Shape {
    public abstract double area();
}
```

That method has to be implemented in each child class:

```java
public class Circle extends Shape {
    @Override
    public double area() {
        return Math.PI * radius * radius;
    }
}
```

---

## 4. What is all this for?

Abstract classes are used to:

1. Define a **partial contract** (what daughters should do)
2. Reuse **common code** in the base class
3. Force each subclass to implement what is specific

In summary:

- Common code in the parent
- Specific implementation in the child

---

## 5. Important rules

### 5.1. An abstract class can have:

- Attributes
- Normal methods (with body)
- Abstract methods (without body)
- Builders (yes, too)

### 5.2. An abstract method:

- Cannot be `private` (because the subclass must override it)
- It must be implemented in the subclass, or the subclass will also be abstract

### 5.3. An abstract class:

- Can extend another abstract or concrete class
- You can have `static` methods (but those are not inherited as abstracts)

---

## 6. Example 1: `Shape`, `Circle` and `Rectangle`

This is the classic example and the clearest to understand the concept.

### 6.1. `Shape.java` (abstract)

```java
public abstract class Shape {
    private String color;

    public Shape(String color) {
        setColor(color);
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        if (color == null || color.isBlank()) {
            this.color = "Unknown";
            return;
        }

        this.color = color;
    }

    public void printInfo() {
        System.out.println("Color: " + color + " | Area: " + area());
    }

    public abstract double area();
}
```

Observe:

- `Shape` has `color` attribute and normal methods (`getColor`, `setColor`, `printInfo`)
- `area()` is abstract: each shape calculates the area differently
- `printInfo` uses `area()` without knowing what the concrete form will be → this is polymorphism

### 6.2. `Circle.java` (specific)

```java
public class Circle extends Shape {
    private double radius;

    public Circle(String color, double radius) {
        super(color);
        setRadius(radius);
    }

    public double getRadius() {
        return radius;
    }

    public void setRadius(double radius) {
        if (radius <= 0) {
            this.radius = 1.0;
            return;
        }

        this.radius = radius;
    }

    @Override
    public double area() {
        return Math.PI * radius * radius;
    }
}
```

### 6.3. `Rectangle.java` (specific)

```java
public class Rectangle extends Shape {
    private double width;
    private double height;

    public Rectangle(String color, double width, double height) {
        super(color);
        setWidth(width);
        setHeight(height);
    }

    public void setWidth(double width) {
        if (width <= 0) {
            this.width = 1.0;
            return;
        }

        this.width = width;
    }

    public void setHeight(double height) {
        if (height <= 0) {
            this.height = 1.0;
            return;
        }

        this.height = height;
    }

    @Override
    public double area() {
        return width * height;
    }
}
```

### 6.4. `Main.java` (polymorphism)

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Shape> shapes = new ArrayList<>();

        shapes.add(new Circle("Blue", 3.0));
        shapes.add(new Rectangle("Green", 4.0, 2.0));
        shapes.add(new Circle("Orange", 1.5));

        for (Shape shape : shapes) {
            shape.printInfo();
        }
    }
}
```

Something very important happens here:

- The list is from `Shape`
- But inside you keep `Circle` and `Rectangle`
- When you call `shape.area()` the correct version is executed based on the real object

---

## 7. Constructors in abstract classes

Although you cannot instantiate an abstract directly, it **can have a constructor**.

So that?

- To initialize the common part of the object that belongs to the base class

Example: In `Shape`, the constructor initializes `color` and is called from `Circle` and `Rectangle` with `super(color)`.

---

## 8. Abstract methods vs “normal” methods in the parent

A very common pattern is:

- The parent defines a normal method that calls an abstract one

Example: `printInfo()` in `Shape` calls `area()`.

This allows:

- Common code in the parent
- Mandatory personalization in the son

---

## 9. Example 2: “employee” template with salary calculation

Let's use an example closer to a real case.

Objective:

- `Employee` is a general idea, there is no point in creating an untyped `Employee`
- Each type of employee calculates their payment differently

### 9.1. `Employee.java` (abstract)

```java
public abstract class Employee {
    private String name;

    public Employee(String name) {
        setName(name);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            this.name = "Unknown";
            return;
        }

        this.name = name;
    }

    public void printPayslip() {
        System.out.println("Employee: " + name + " | Pay: " + calculatePay());
    }

    public abstract double calculatePay();
}
```

### 9.2. `SalariedEmployee.java` (fixed salary)

```java
public class SalariedEmployee extends Employee {
    private double monthlySalary;

    public SalariedEmployee(String name, double monthlySalary) {
        super(name);
        setMonthlySalary(monthlySalary);
    }

    public void setMonthlySalary(double monthlySalary) {
        if (monthlySalary < 0) {
            this.monthlySalary = 0.0;
            return;
        }

        this.monthlySalary = monthlySalary;
    }

    @Override
    public double calculatePay() {
        return monthlySalary;
    }
}
```

### 9.3. `HourlyEmployee.java` (hourly payment)

```java
public class HourlyEmployee extends Employee {
    private double hourlyRate;
    private int hoursWorked;

    public HourlyEmployee(String name, double hourlyRate, int hoursWorked) {
        super(name);
        setHourlyRate(hourlyRate);
        setHoursWorked(hoursWorked);
    }

    public void setHourlyRate(double hourlyRate) {
        if (hourlyRate < 0) {
            this.hourlyRate = 0.0;
            return;
        }

        this.hourlyRate = hourlyRate;
    }

    public void setHoursWorked(int hoursWorked) {
        if (hoursWorked < 0) {
            this.hoursWorked = 0;
            return;
        }

        this.hoursWorked = hoursWorked;
    }

    @Override
    public double calculatePay() {
        return hourlyRate * hoursWorked;
    }
}
```

### 9.4. `Main.java`

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Employee> employees = new ArrayList<>();

        employees.add(new SalariedEmployee("Laura", 2200));
        employees.add(new HourlyEmployee("Alex", 15, 120));
        employees.add(new HourlyEmployee("Maria", 18, 90));

        for (Employee employee : employees) {
            employee.printPayslip();
        }
    }
}
```

---

## 10. What happens if a subclass does NOT implement an abstract method?

If a subclass does not implement all of the parent's abstract methods, then:

- The subclass should be `abstract` as well

Example:

```java
public abstract class SpecialShape extends Shape {
    public SpecialShape(String color) {
        super(color);
    }

    // no implementa area() => debe ser abstract
}
```

---

## 11. Typical mistakes when starting

### 11.1. Try to instantiate an abstract class

```java
// Employee e = new Employee("Laura"); // error
```

### 11.2. Forget `@Override`

It is not mandatory, but it helps you detect errors if you make a mistake with the signature.

### 11.3. Declare abstract methods like `private`

You can't, because a subclass cannot override something private.

---

## 12. Good practices

- Use abstract classes when you have a common base and want to avoid generic instances.
- Places in the base class what all subclasses share (attributes, common methods).
- Declares as abstract what is mandatory to implement.
- Use normal methods on the parent that call abstract methods to reuse behavior.
- Keep classes small and with clear responsibility.

---

## 13. To take into account

- An abstract class **cannot be instantiated**.
- It can have attributes, normal methods, abstract methods and constructors.
- An abstract method **has no body** and forces subclasses to implement it.
- If a subclass does not implement all abstracts, it must also be abstract.
- Allows clean polymorphism: `List<Shape>` can contain `Circle`, `Rectangle`, etc.

---
In the next topic we will see **interfaces**, which are another way (very common in Java) of defining contracts, and we will compare when it is convenient to use interfaces vs abstract classes.
