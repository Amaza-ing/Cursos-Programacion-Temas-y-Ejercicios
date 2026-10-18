# Topic 18. Class inheritance

## 1. Introduction

In previous topics you have learned how to create classes with:

- Attributes and methods
- Encapsulation (`private` attributes, getters and setters)
- Constructors and overloading
- Static members (`static`)

Now you are going to learn a central concept of Object-Oriented Programming (OOP):

- **Inheritance**

Inheritance allows you to create a new class from another, **reusing** code and extending behavior.

Mental example:

- `Animal` (base class)
- `Dog` and `Cat` (derived classes)

All pets share things (name, age), but each one has special behaviors.

In this topic you will learn:

- What is inheritance and when does it make sense to use it?
- `extends` and the _is-a_ (es-un) relationship
- What is `super` and what is it for?
- How constructors work in inheritance
- `protected` vs `private`
- Method override (`@Override`)
- Basic polymorphism (use a parent reference for a child)
- Complete examples ready to run

---

[![Inheritance and Polymorphism](https://img.youtube.com/vi/y677D9OB1IE/0.jpg)](https://www.youtube.com/watch?v=y677D9OB1IE&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is inheritance

Inheritance means:

- A “child” class (subclass) inherits the attributes and methods of a “parent” class (superclass).
- The child class can:
  - Add new attributes and methods
  - Reuse what is inherited
  - Modify behaviors (override methods)

The syntax is:

```java
public class Child extends Parent {
}
```

---

## 3. Relationship _is-a_ (is-a)

A very important rule of thumb:

> Use inheritance when the child class **is a** type of the parent class.

Correct examples (_is-a_):

- `Car` is an `Vehicle`
- `Student` is an `Person`
- `Dog` is an `Animal`

Incorrect examples (is not _is-a_):

- `Engine` is an `Car` (no, an engine is **not** a car)
- `Address` is an `User` (not)

If the relationship is more like “has-a_”, it is usually composition (you will see this later).

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

### 4.2. Daughter class: `Student`

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

### 4.3. Use

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

## 5. `super`: access parent

`super` is used for two main things:

1. Call the parent's constructor: `super(...)`
2. Call a parent method from an overridden method: `super.method()`

---

## 6. Constructors in inheritance

When you create an object of a child class:

- First the “parent” part is built
- Then the “daughter” part

That's why Java requires the daughter's constructor to call `super(...)`.

Example:

```java
public class Student extends Person {
    public Student(String name, int age) {
        super(name, age);
    }
}
```

### 6.1. `super(...)` should be the first line

This is mandatory.

```java
public Student(String name, int age) {
    // System.out.println("Hi"); // no puede ir antes de super
    super(name, age);
}
```

---

## 7. `private` vs `protected` in inheritance

- `private`: only accessible within the parent class
- `protected`: accessible within the parent and also within the child classes

In this course, since you are starting, the most common thing is:

- `private` attributes
- Access from the daughter using getters and setters of the parent (recommended)

If `name` is `private` in `Person`, you cannot do:

```java
// this.name = "Laura"; // no se puede si es private
```

But you can do:

```java
setName("Laura"); // método heredado
```

---

## 8. Method Override (`@Override`)

A child class can **override** a parent method to change its behavior.

Example: we want `Student.printInfo()` to also show the note.

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

- `@Override` tells Java: “this overwrites a parent method.”
- `super.printInfo()` reuses the parent printout and then we add information.

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

If `Student` overwrites `printInfo`, the correct version will be executed.

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

### 10.2. `Manager.java` (daughter)

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

## 11. Typical errors

- Forget to call `super(...)` when parent has no empty constructor
- Try to access `private` attributes of the father from the daughter
- Use inheritance where an _is-a_ relationship does not exist

---

## 12. Good initial practices

- Use inheritance for clear _is-a_ relationships.
- Maintain `private` attributes and expose methods.
- Use `@Override` whenever you overwrite.
- Reuse logic with `super.method()` when it makes sense.

---

## 13. To take into account

- `extends` creates an inheritance relationship.
- `super(...)` calls the parent's constructor and must be the first line.
- `private` is not accessible in the daughter; `protected` yes.
- `@Override` helps to write correct code.
- Polymorphism: you can save a child as a parent and the correct method is executed.

---

In the next topic we will learn how to organize the project into **Packages** or packages, which help you design more robust hierarchies and organize the code.
