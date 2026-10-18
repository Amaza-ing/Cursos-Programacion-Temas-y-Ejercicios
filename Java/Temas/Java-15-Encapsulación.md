# Topic 15. Encapsulation, getters & setters and access modifiers

## 1. Introduction

In the previous topic you learned how to create **classes and objects** with:

- Attributes (state)
- Methods (behavior)
- Constructors
- Getters and setters

Now let's dig deeper into a key idea of OOP in Java:

- **Encapsulation**

Encapsulation is what makes a class “safe” and easy to maintain:  
it prevents the object's internal state from being modified incorrectly from the outside.

To achieve encapsulation, Java gives us two main tools:

- **Access modifiers** (`public`, `private`, `protected`, no modifier)
- **Getters and setters** (controlled access to attributes)

In this topic you will learn:

- What encapsulation is and why it matters
- What access modifiers exist and what they mean
- How to design getters and setters with validation
- When you should NOT create setters
- How to expose behavior with methods instead of “exposing data”
- Typical mistakes when you're starting out

---

[![Encapsulation](https://img.youtube.com/vi/Pnv8Bidh-vY/0.jpg)](https://www.youtube.com/watch?v=Pnv8Bidh-vY&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What encapsulation is

Encapsulating means:

- Hiding the internal state (attributes) of a class
- Allowing access/control through methods (getters, setters or other methods)

**Goal:** protect the consistency of the object.

### 2.1. Example: class without encapsulation (bad practice)

```java
public class BankAccount {
    public double balance;
}
```

From anywhere you could do:

```java
BankAccount account = new BankAccount();
account.balance = -5000; // estado inválido
```

This breaks the domain rules (in many cases, a balance shouldn't go negative “by magic”).

### 2.2. Encapsulated class (good practice)

```java
public class BankAccount {
    private double balance;

    public double getBalance() {
        return balance;
    }

    public void deposit(double amount) {
        if (amount <= 0) {
            return;
        }

        balance += amount;
    }

    public boolean withdraw(double amount) {
        if (amount <= 0) {
            return false;
        }

        if (amount > balance) {
            return false;
        }

        balance -= amount;
        return true;
    }
}
```

Here the balance only changes in controlled ways (`deposit`, `withdraw`).

---

## 3. Access modifiers in Java

An access modifier determines **from where** a class, attribute, or method can be accessed.

The main ones are:

- `public`
- `private`
- `protected`
- no modifier (_package-private_)

### 3.1. `public`

Accessible from any class, in any package.

```java
public class User {
    public String name;
}
```

### 3.2. `private`

Only accessible from the **same class**.

```java
public class User {
    private String name;
}
```

From outside the class you can't do:

```java
// user.name = "Laura"; // error
```

### 3.3. No modifier (package-private)

If you don't write anything, access is “package-level”:  
it can only be accessed from classes inside the same package.

```java
class Helper {
    void doWork() {}
}
```

### 3.4. `protected`

Accessible from:

- The same package
- Subclasses (even if they are in another package)

`protected` is used a lot when you work with inheritance (you'll see it later).

---

## 4. Access table (summary)

Simplified:

- `private` → only inside the class
- no modifier → inside the package
- `protected` → package + subclasses
- `public` → from anywhere

---

## 5. Encapsulation applied: `private` attributes

The typical rule in Java is:

- Attributes are almost always `private`
- They're accessed/modified through methods

Example:

```java
public class User {
    private String name;
    private int age;
}
```

---

## 6. Getters: reading the state in a controlled way

A **getter** returns the value of an attribute.

Naming convention:

- `getName()` for `name`
- `getAge()` for `age`
- `isActive()` for `boolean active`

Example:

```java
public class User {
    private String name;
    private boolean active;

    public String getName() {
        return name;
    }

    public boolean isActive() {
        return active;
    }
}
```

---

## 7. Setters: modifying the state in a controlled way

A **setter** modifies the value of an attribute.

Convention:

- `setName(String name)`
- `setAge(int age)`

Basic example:

```java
public void setAge(int age) {
    this.age = age;
}
```

But the important thing is that the setter can include **validation**.

---

## 8. Setters with validation

A setter should prevent the object from being left in an inconsistent state.

### 8.1. Validating age

```java
public void setAge(int age) {
    if (age < 0) {
        return;
    }

    this.age = age;
}
```

### 8.2. Validating a name

```java
public void setName(String name) {
    if (name == null || name.isBlank()) {
        return;
    }

    this.name = name;
}
```

---

## 9. When NOT to create setters

You don't always need setters.

If an attribute shouldn't change, you can:

- Not create a setter (only a getter)
- Make the attribute `final`

Example: an `id` that should not change:

```java
public class User {
    private String id;
    private String name;

    public User(String id, String name) {
        this.id = id;
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            return;
        }

        this.name = name;
    }
}
```

---

## 10. Better than a setter: methods with intent

Sometimes it's better to create methods that express the intent of the change, rather than exposing generic setters.

Example:

- Instead of `setBalance(...)` (dangerous)
- Better: `deposit(...)` and `withdraw(...)`

---

## 11. Complete example: `User` with encapsulation and validation

### 11.1. `User.java`

```java
public class User {
    private String name;
    private int age;
    private boolean active;

    public User(String name, int age) {
        setName(name);
        setAge(age);
        this.active = true;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public boolean isActive() {
        return active;
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

    public void deactivate() {
        this.active = false;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Age: " + age + " | Active: " + active);
    }
}
```

### 11.2. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", 28);

        user.printInfo();

        user.setAge(-10); // se ignora
        user.setName("   "); // se ignora

        user.printInfo();

        user.deactivate();
        user.printInfo();
    }
}
```

---

## 12. Complete example: `BankAccount` without dangerous setters

```java
public class BankAccount {
    private double balance;

    public BankAccount() {
        this.balance = 0;
    }

    public double getBalance() {
        return balance;
    }

    public void deposit(double amount) {
        if (amount <= 0) {
            return;
        }

        balance += amount;
    }

    public boolean withdraw(double amount) {
        if (amount <= 0) {
            return false;
        }

        if (amount > balance) {
            return false;
        }

        balance -= amount;
        return true;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        BankAccount account = new BankAccount();

        account.deposit(100);
        System.out.println(account.getBalance()); // 100

        boolean ok = account.withdraw(30);
        System.out.println(ok); // true
        System.out.println(account.getBalance()); // 70

        ok = account.withdraw(200);
        System.out.println(ok); // false
        System.out.println(account.getBalance()); // 70
    }
}
```

---

## 13. Common mistakes

- Using `public` attributes “for convenience”
- Creating setters without validation when the domain requires it
- Validating only in the constructor and not in setters (or the other way around)

Recommended pattern: the constructor can call the setters to reuse validation.

---

## 14. Things to keep in mind

- Encapsulation = private attributes + access controlled through methods.
- `public`, `private`, `protected` and package-private determine where you can access it from.
- Getters are used to read the state; setters to modify it with validation.
- You don't always need setters.
- A method with intent (`deposit`, `withdraw`) is often better than a generic setter (`setBalance`).

---

In the next topic we'll move on to more complete constructors, constructor overloading and typical object creation patterns.
