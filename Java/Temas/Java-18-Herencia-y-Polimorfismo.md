# Topic 18. Class inheritance

## 1. Introduction

In earlier topics you've learned how to create classes with:

- Attributes and methods
- Encapsulation (`private` attributes, getters and setters)
- Constructors and overloading
- Static members (`static`)

Now you're going to learn a core concept of Object-Oriented Programming (OOP):

- **Inheritance**

Inheritance lets you create a new class based on another one, **reusing** code and extending behavior.

A mental example:

- `Animal` (base class)
- `Dog` and `Cat` (derived classes)

All pets share things (name, age), but each one has special behaviors.

In this topic you will learn:

- What inheritance is and when it makes sense to use it
- `extends` and the _is-a_ relationship
- What `super` is and what it's for
- How constructors work in inheritance
- `protected` vs `private`
- Method overriding (`@Override`)
- Basic polymorphism (using a parent reference for a child object)
- Complete examples ready to run

---

[![Inheritance and Polymorphism](https://img.youtube.com/vi/y677D9OB1IE/0.jpg)](https://www.youtube.com/watch?v=y677D9OB1IE&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What inheritance is

Inheritance means:

- A “child” class (subclass) inherits the attributes and methods of a “parent” class (superclass).
- The child class can:
  - Add new attributes and methods
  - Reuse what it inherits
  - Modify behaviors (override methods)

The syntax is:

```java
public class Child extends Parent {
}
```

---

## 3. The _is-a_ relationship

A very important rule of thumb:

> Use inheritance when the child class **is a** type of the parent class.

Correct examples (_is-a_):

- `Car` is a `Vehicle`
- `Student` is a `Person`
- `Dog` is an `Animal`

Incorrect examples (not _is-a_):

- `Engine` is a `Car` (no, an engine is **not** a car)
- `Address` is a `User` (no)

If the relationship is more like “has a” (_has-a_), it's usually composition (you'll see it later).

---

## 4. First simple example: `Person` and `Student`

### 4.1. Parent class: `Person`

```java
public class Person {
    private String name;
    private int age;

    public Person(String name, int age) {
        setName(name);
        setAge(age);
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
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

    public void printInfo() {
        System.out.println("Name: " + name + " | Age: " + age);
    }
}
```

### 4.2. Child class: `Student`

`Student` inherits `name`, `age` and `printInfo()`, and adds `grade`.

```java
public class Student extends Person {
    private double grade;

    public Student(String name, int age, double grade) {
        super(name, age);
        setGrade(grade);
    }

    public double getGrade() {
        return grade;
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

### 4.3. Usage

```java
public class Main {
    public static void main(String[] args) {
        Person p = new Person("Laura", 28);
        p.printInfo();

        Student s = new Student("Alex", 21, 8.5);
        s.printInfo(); // heredado
        System.out.println(s.getGrade()); // propio de Student
    }
}
```

Key points:

- `Student extends Person`
- `Student` calls the parent's constructor with `super(name, age)`
- `Student` inherits public methods from the parent

---

## 5. `super`: accessing the parent

`super` is used for two main things:

1. Call the parent's constructor: `super(...)`
2. Call a parent method from an overridden method: `super.method()`

---

## 6. Constructors in inheritance

When you create an object of a child class:

- First the “parent” part is built
- Then the “child” part

That's why Java requires the child's constructor to call `super(...)`.

Example:

```java
public class Student extends Person {
    public Student(String name, int age) {
        super(name, age);
    }
}
```

### 6.1. `super(...)` must be the first line

This is mandatory.

```java
public Student(String name, int age) {
    // System.out.println("Hi"); // no puede ir antes de super
    super(name, age);
}
```

---

## 7. `private` vs `protected` in inheritance

- `private`: only accessible inside the parent class
- `protected`: accessible inside the parent and also inside the child classes

In this course, since you're just starting out, the most common approach is:

- `private` attributes
- Access from the child using the parent's getters and setters (recommended)

If `name` is `private` in `Person`, you can't do:

```java
// this.name = "Laura"; // no se puede si es private
```

But you can do:

```java
setName("Laura"); // método heredado
```

---

## 8. Method overriding (`@Override`)

A child class can **override** a parent method to change its behavior.

Example: we want `Student.printInfo()` to also show the grade.

```java
public class Student extends Person {
    private double grade;

    public Student(String name, int age, double grade) {
        super(name, age);
        setGrade(grade);
    }

    public void setGrade(double grade) {
        if (grade < 0 || grade > 10) {
            this.grade = 0.0;
            return;
        }

        this.grade = grade;
    }

    @Override
    public void printInfo() {
        super.printInfo();
        System.out.println("Grade: " + grade);
    }
}
```

- `@Override` tells Java: “this overrides a parent method.”
- `super.printInfo()` reuses the parent's printing and then we add more information.

---

## 9. Basic polymorphism

You can treat a child object as if it were of the parent type.

```java
Person p = new Student("Alex", 21, 8.5);
p.printInfo();
```

This is useful for collections:

```java
import java.util.ArrayList;
import java.util.List;

List<Person> people = new ArrayList<>();
people.add(new Person("Laura", 28));
people.add(new Student("Alex", 21, 8.5));

for (Person person : people) {
    person.printInfo();
}
```

If `Student` overrides `printInfo`, the right version will run.

---

## 10. Complete example: `Employee` and `Manager`

### 10.1. `Employee.java` (parent)

```java
public class Employee {
    private String name;
    private double salary;

    public Employee(String name, double salary) {
        setName(name);
        setSalary(salary);
    }

    public String getName() {
        return name;
    }

    public double getSalary() {
        return salary;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            this.name = "Unknown";
            return;
        }

        this.name = name;
    }

    public void setSalary(double salary) {
        if (salary < 0) {
            this.salary = 0.0;
            return;
        }

        this.salary = salary;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Salary: " + salary);
    }
}
```

### 10.2. `Manager.java` (child)

```java
public class Manager extends Employee {
    private double bonus;

    public Manager(String name, double salary, double bonus) {
        super(name, salary);
        setBonus(bonus);
    }

    public double getBonus() {
        return bonus;
    }

    public void setBonus(double bonus) {
        if (bonus < 0) {
            this.bonus = 0.0;
            return;
        }

        this.bonus = bonus;
    }

    public double getTotalCompensation() {
        return getSalary() + bonus;
    }

    @Override
    public void printInfo() {
        System.out.println(
                "Name: " + getName() +
                " | Salary: " + getSalary() +
                " | Bonus: " + bonus +
                " | Total: " + getTotalCompensation()
        );
    }
}
```

### 10.3. `Main.java`

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Employee e = new Employee("Laura", 2500);
        Manager m = new Manager("Alex", 3000, 500);

        e.printInfo();
        m.printInfo();

        List<Employee> staff = new ArrayList<>();
        staff.add(e);
        staff.add(m);

        for (Employee employee : staff) {
            employee.printInfo();
        }
    }
}
```

---

## 11. Common mistakes

- Forgetting to call `super(...)` when the parent has no empty constructor
- Trying to access the parent's `private` attributes from the child
- Using inheritance where there's no _is-a_ relationship

---

## 12. Good practices to start with

- Use inheritance for clear _is-a_ relationships.
- Keep attributes `private` and expose methods.
- Use `@Override` whenever you override a method.
- Reuse logic with `super.method()` when it makes sense.

---

## 13. Things to keep in mind

- `extends` creates an inheritance relationship.
- `super(...)` calls the parent's constructor and must be the first line.
- `private` isn't accessible in the child; `protected` is.
- `@Override` helps you write correct code.
- Polymorphism: you can store a child as a parent and the right method runs.

---

In the next topic we'll learn how to organize the project into **packages**, which help you design more robust hierarchies and organize your code.
