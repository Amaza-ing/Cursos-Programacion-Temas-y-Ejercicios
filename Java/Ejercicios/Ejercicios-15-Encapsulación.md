# Exercises - Topic 15: Encapsulation, getters & setters and access modifiers

Below you will find **10 practical exercises** on **encapsulation**, **getters & setters** and **access modifiers**: using `private`, controlling state, validation in setters, `public` vs _package-private_, `protected` (introduction) and typical cases.

Try to solve them before looking at the solution.

---

## Exercise 1: Encapsulate basic attributes

Create a class `Profile` with these `private` attributes:

- `username` (String)
- `age` (int)

Create:

- Constructor with both parameters
- `getUsername()`, `getAge()`
- `setAge(int age)`, which must not allow negative values (if the value is negative, don't change it)

In `main`, create an object, print the age, try setting it to `-5` and print it again.

<details><summary>Show solution</summary>

```java
public class Profile {
    private String username;
    private int age;

    public Profile(String username, int age) {
        this.username = username;
        this.age = age;
    }

    public String getUsername() {
        return username;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        if (age < 0) {
            return;
        }

        this.age = age;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Profile profile = new Profile("laura", 28);

        System.out.println(profile.getAge());
        profile.setAge(-5);
        System.out.println(profile.getAge());
    }
}
```

</details>

---

## Exercise 2: Setter with `String` validation

Create a class `Account` with:

- `private String email`

Create:

- Constructor
- `getEmail()`
- `setEmail(String email)`, which ignores `null` and empty/blank strings (`isBlank()`)

Test it in `main` by assigning `"   "` and then a valid email.

<details><summary>Show solution</summary>

```java
public class Account {
    private String email;

    public Account(String email) {
        setEmail(email);
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        if (email == null || email.isBlank()) {
            return;
        }

        this.email = email;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Account account = new Account("laura@example.com");

        account.setEmail("   "); // se ignora
        System.out.println(account.getEmail());

        account.setEmail("new@example.com");
        System.out.println(account.getEmail());
    }
}
```

</details>

---

## Exercise 3: Avoid dangerous setters

Create a class `BankAccount` with:

- `private double balance`

Requirements:

- DO NOT create `setBalance`
- Create `getBalance()`
- Create `deposit(double amount)` (only if amount > 0)
- Create `withdraw(double amount)` (only if amount > 0 and <= balance; it returns a boolean)

<details><summary>Show solution</summary>

```java
public class BankAccount {
    private double balance;

    public BankAccount(double balance) {
        this.balance = Math.max(0, balance);
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

</details>

---

## Exercise 4: Boolean getter with the `is...` convention

Create a class `FeatureFlag` with:

- `private boolean enabled`

Create:

- Constructor that receives `enabled`
- Getter called `isEnabled()`
- `enable()` and `disable()` methods

<details><summary>Show solution</summary>

```java
public class FeatureFlag {
    private boolean enabled;

    public FeatureFlag(boolean enabled) {
        this.enabled = enabled;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void enable() {
        enabled = true;
    }

    public void disable() {
        enabled = false;
    }
}
```

</details>

---

## Exercise 5: Constructor reusing setters

Create a class `User` with:

- `private String name`
- `private int age`

Create setters with validation:

- `setName`: if `null` or `isBlank()`, assign `"Unknown"`
- `setAge`: if `< 0`, assign `0`

In the constructor, call the setters instead of assigning the values directly.

<details><summary>Show solution</summary>

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
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
}
```

</details>

---

## Exercise 6: “Read-only” field (no setter)

Create a class `Ticket` with:

- `private String id`
- `private String description`

Requirements:

- `id` is assigned in the constructor and has NO setter
- `description` can change through `setDescription(String description)`, validated with `isBlank()`

<details><summary>Show solution</summary>

```java
public class Ticket {
    private String id;
    private String description;

    public Ticket(String id, String description) {
        this.id = id;
        setDescription(description);
    }

    public String getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        if (description == null || description.isBlank()) {
            return;
        }

        this.description = description;
    }
}
```

</details>

---

## Exercise 7: _Package-private_ (no modifier) in a helper class

Create an `app.model` package with:

- `User` class (`public`)
- `InternalLogger` class (no modifier, _package-private_)

`InternalLogger` must have a `log(String message)` method.
In `User`, create a method `printInfo()` that uses `InternalLogger`.

Check that you CANNOT use `InternalLogger` from a `Main` class in another package.

<details><summary>Show solution</summary>

```java
package app.model;

class InternalLogger {
    void log(String message) {
        System.out.println("LOG: " + message);
    }
}
```

```java
package app.model;

public class User {
    private String name;

    public User(String name) {
        this.name = name;
    }

    public void printInfo() {
        InternalLogger logger = new InternalLogger();
        logger.log("Printing user");

        System.out.println("Name: " + name);
    }
}
```

```java
package app;

import app.model.User;

public class Main {
    public static void main(String[] args) {
        User user = new User("Laura");
        user.printInfo();

        // InternalLogger logger = new InternalLogger(); // no compila
    }
}
```

</details>

---

## Exercise 8: `private` attributes and range checking

Create a class `Temperature` with:

- `private double celsius`

Create:

- Getter
- Setter that only allows values between `-100` and `100` (otherwise, don't change the value)

<details><summary>Show solution</summary>

```java
public class Temperature {
    private double celsius;

    public Temperature(double celsius) {
        setCelsius(celsius);
    }

    public double getCelsius() {
        return celsius;
    }

    public void setCelsius(double celsius) {
        if (celsius < -100 || celsius > 100) {
            return;
        }

        this.celsius = celsius;
    }
}
```

</details>

---

## Exercise 9: `protected` (introduction) with inheritance

Create a class `BaseMessage` with:

- `protected String prefix`

Create a constructor that initializes the prefix and a `print(String text)` method that prints:

```
prefix + text
```

Create a class `ErrorMessage extends BaseMessage` that uses the same prefix but adds `"ERROR: "` in its constructor.

<details><summary>Show solution</summary>

```java
public class BaseMessage {
    protected String prefix;

    public BaseMessage(String prefix) {
        this.prefix = prefix;
    }

    public void print(String text) {
        System.out.println(prefix + text);
    }
}
```

```java
public class ErrorMessage extends BaseMessage {
    public ErrorMessage(String prefix) {
        super("ERROR: " + prefix);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        ErrorMessage msg = new ErrorMessage("[App] ");
        msg.print("Something went wrong");
    }
}
```

</details>

---

## Exercise 10: Design a “safe” object with intention-revealing methods

Create a class `InventoryItem` with:

- `private String name`
- `private int stock`

Requirements:

- Constructor with `name` and `stock` (if stock < 0, use 0)
- Getters for both
- DO NOT create `setStock`
- Create these methods:
  - `addStock(int amount)` (only if amount > 0)
  - `removeStock(int amount)` (only if amount > 0 and <= stock; it returns a boolean)

<details><summary>Show solution</summary>

```java
public class InventoryItem {
    private String name;
    private int stock;

    public InventoryItem(String name, int stock) {
        this.name = name;
        this.stock = Math.max(0, stock);
    }

    public String getName() {
        return name;
    }

    public int getStock() {
        return stock;
    }

    public void addStock(int amount) {
        if (amount <= 0) {
            return;
        }

        stock += amount;
    }

    public boolean removeStock(int amount) {
        if (amount <= 0) {
            return false;
        }

        if (amount > stock) {
            return false;
        }

        stock -= amount;
        return true;
    }
}
```

</details>

---
