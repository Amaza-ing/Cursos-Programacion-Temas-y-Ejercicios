# Topic 20. Abstract classes and abstract methods

## 1. Introduction

In the inheritance topic you learned that you can create hierarchies like:

- `Person` → `Student`
- `Employee` → `Manager`

That lets you reuse code and create specialized child classes.

Now a very common need comes up:

> What if I want a “base” class that **should not be instantiable**, but that I want to use as a template for its children?

Typical examples:

- `Shape` → `Circle`, `Rectangle`
- `Animal` → `Dog`, `Cat`
- `PaymentMethod` → `CardPayment`, `PaypalPayment`

In these cases, the base class is a general idea, but:

- There's no point in creating a “generic” `Shape` object
- There's no point in creating an `Animal` object “with no type”

That's what these are for:

- **Abstract classes**
- **Abstract methods**

In this topic you will learn:

- What an abstract class is
- What an abstract method is
- When to use them and why they are useful
- How to combine common code + mandatory behavior
- `abstract` vs normal inheritance
- Polymorphism with abstract classes
- Typical mistakes and good practices

---

[![Abstract Classes and Methods](https://img.youtube.com/vi/do2XG0T4mR8/0.jpg)](https://www.youtube.com/watch?v=do2XG0T4mR8&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What an abstract class is

An **abstract class** is a class that:

- Can't be instantiated (`new`)
- Is used as a base for other classes

It's declared with `abstract`:

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

## 3. What an abstract method is

An **abstract method** is a method that:

- Is declared in the abstract class
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

1. Define a **partial contract** (what the child classes must do)
2. Reuse **common code** in the base class
3. Force each subclass to implement what's specific to it

In summary:

- Common code in the parent
- Specific implementation in the child

---

## 5. Important rules

### 5.1. An abstract class can have:

- Attributes
- Normal methods (with a body)
- Abstract methods (without a body)
- Constructors (yes, those too)

### 5.2. An abstract method:

- Cannot be `private` (because the subclass must override it)
- Must be implemented in the subclass, or the subclass will have to be abstract too

### 5.3. An abstract class:

- Can extend another abstract or concrete class
- Can have `static` methods (but those aren't inherited as abstract)

---

## 6. Example 1: `Shape`, `Circle` and `Rectangle`

This is the classic example and the clearest one for understanding the concept.

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

Notice:

- `Shape` has a `color` attribute and normal methods (`getColor`, `setColor`, `printInfo`)
- `area()` is abstract: each shape calculates the area differently
- `printInfo` uses `area()` without knowing which concrete shape it will be → this is polymorphism

### 6.2. `Circle.java` (concrete)

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

### 6.3. `Rectangle.java` (concrete)

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

- The list is of `Shape`
- But inside it you store `Circle` and `Rectangle`
- When you call `shape.area()`, the right version runs depending on the actual object

---

## 7. Constructors in abstract classes

Although you can't instantiate an abstract class directly, it **can have a constructor**.

What for?

- To initialize the common part of the object that belongs to the base class

Example: in `Shape`, the constructor initializes `color` and is called from `Circle` and `Rectangle` with `super(color)`.

---

## 8. Abstract methods vs “normal” methods in the parent

A very common pattern is:

- The parent defines a normal method that calls an abstract one

Example: `printInfo()` in `Shape` calls `area()`.

This gives you:

- Common code in the parent
- Mandatory customization in the child

---

## 9. Example 2: an “employee” template with salary calculation

Let's use an example closer to a real case.

Goal:

- `Employee` is a general idea; there's no point in creating an `Employee` with no type
- Each type of employee calculates its pay differently

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

### 9.3. `HourlyEmployee.java` (hourly pay)

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

- The subclass must be `abstract` as well

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

## 11. Common mistakes when you're starting out

### 11.1. Trying to instantiate an abstract class

```java
// Employee e = new Employee("Laura"); // error
```

### 11.2. Forgetting `@Override`

It isn't mandatory, but it helps you catch errors if you get the signature wrong.

### 11.3. Declaring abstract methods as `private`

You can't, because a subclass can't override something private.

---

## 12. Good practices

- Use abstract classes when you have a common base and want to avoid generic instances.
- Put in the base class what all subclasses share (attributes, common methods).
- Declare as abstract whatever must be implemented.
- Use normal methods in the parent that call abstract methods to reuse behavior.
- Keep classes small and with a clear responsibility.

---

## 13. Things to keep in mind

- An abstract class **cannot be instantiated**.
- It can have attributes, normal methods, abstract methods and constructors.
- An abstract method **has no body** and forces subclasses to implement it.
- If a subclass doesn't implement all the abstract methods, it must also be abstract.
- It allows clean polymorphism: `List<Shape>` can contain `Circle`, `Rectangle`, etc.

---
In the next topic we'll look at **interfaces**, another way (very common in Java) of defining contracts, and we'll compare when it's better to use interfaces vs abstract classes.
