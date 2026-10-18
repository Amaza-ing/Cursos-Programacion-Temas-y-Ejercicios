# Topic 5. Conditionals (if and switch)

## 1. Introduction

So far you have learned to:

- Store information with **variables**
- Operate on values using **operators**
- Convert types when necessary

The next step is for the program to **make decisions**.

In programming, making decisions means:

- Evaluating a condition (something that is `true` or `false`)
- Running one block of code or another depending on the result

In Java, the main conditionals are:

- `if`, `else if`, `else`
- `switch` (including the **modern switch**)

In this topic you will learn how to use them clearly and with guided examples.

---

[![if / else conditionals](https://img.youtube.com/vi/ogHYPSBWS9A/0.jpg)](https://www.youtube.com/watch?v=ogHYPSBWS9A&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. The `if` conditional

### 2.1. What does an `if` do?

An `if` executes a block of code **only if a condition is true**.

Basic syntax:

```java
if (condition) {
    // code to run if condition is true
}
```

- `condition` must be an expression that returns a `boolean` (`true` or `false`).
- The block is enclosed in braces `{}`.

---

### 2.2. Example 1: checking whether a person is of legal age

```java
int age = 20;

if (age >= 18) {
    System.out.println("You are an adult.");
}
```

If `age` is 20, the condition `age >= 18` is `true`, so the message is printed.

---

### 2.3. Example 2: false condition (nothing happens)

```java
int age = 15;

if (age >= 18) {
    System.out.println("You are an adult.");
}
```

Here the condition is `false`, so the block **is not executed**.

---

## 3. `if` with `else`

### 3.1. What does `else` do?

`else` defines what to do **if the `if` condition is false**.

```java
if (condition) {
    // if true
} else {
    // if false
}
```

---

### 3.2. Example: adult or minor

```java
int age = 15;

if (age >= 18) {
    System.out.println("You are an adult.");
} else {
    System.out.println("You are a minor.");
}
```

With `age = 15`, it prints:

```
You are a minor.
```

---

## 4. `if` with `else if` (several conditions)

### 4.1. When should you use `else if`?

When you need to evaluate **more than two cases**.

```java
if (condition1) {
    // case 1
} else if (condition2) {
    // case 2
} else {
    // default case
}
```

Java evaluates from top to bottom and picks the **first case that is true**.

---

### 4.2. Example: classifying a grade

```java
int score = 82;

if (score >= 90) {
    System.out.println("Grade: A");
} else if (score >= 80) {
    System.out.println("Grade: B");
} else if (score >= 70) {
    System.out.println("Grade: C");
} else {
    System.out.println("Grade: D");
}
```

If `score = 82`, it prints:

```
Grade: B
```

---

### 4.3. Common mistake: wrong order

This example is wrong:

```java
int score = 82;

if (score >= 70) {
    System.out.println("Grade: C");
} else if (score >= 80) {
    System.out.println("Grade: B");
}
```

With `82`, the first `if` is already `true`, so it never reaches `score >= 80`.

**Rule of thumb:** place the **most restrictive** or “highest” conditions first.

---

## 5. Compound conditions (AND, OR, NOT)

This is where logical operators come in handy.

### 5.1. AND (`&&`)

Both conditions must be true.

```java
int age = 20;
boolean hasId = true;

if (age >= 18 && hasId) {
    System.out.println("Access granted.");
} else {
    System.out.println("Access denied.");
}
```

---

### 5.2. OR (`||`)

It's enough for one condition to be true.

```java
boolean isVip = true;
boolean hasInvitation = false;

if (isVip || hasInvitation) {
    System.out.println("Welcome!");
} else {
    System.out.println("No access.");
}
```

---

### 5.3. NOT (`!`)

Negates a boolean value.

```java
boolean isBlocked = false;

if (!isBlocked) {
    System.out.println("You can log in.");
}
```

---

## 6. Good practices with `if`

### 6.1. Avoid hard-to-read conditions

Bad (hard to understand):

```java
if (age >= 18 && (country.equals("ES") || country.equals("FR")) && !isBlocked) {
    System.out.println("OK");
}
```

Better (intermediate variables):

```java
boolean isAdult = age >= 18;
boolean isAllowedCountry = country.equals("ES") || country.equals("FR");
boolean canAccess = isAdult && isAllowedCountry && !isBlocked;

if (canAccess) {
    System.out.println("OK");
}
```

This is longer, but much more readable.

---

### 6.2. Comparisons with `String` (very important)

In Java, to compare `String` values you must use `.equals(...)`, not `==`.

Incorrect:

```java
String role = "admin";

if (role == "admin") {
    System.out.println("Admin access");
}
```

Correct:

```java
String role = "admin";

if (role.equals("admin")) {
    System.out.println("Admin access");
}
```

---
[![switch conditionals](https://img.youtube.com/vi/9cBYs_NqWuE/0.jpg)](https://www.youtube.com/watch?v=9cBYs_NqWuE&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 7. The `switch` conditional

### 7.1. What is `switch`?

`switch` is used when you want to compare **the same value** against multiple cases.

Typical example: menus, options, days of the week, types, states, etc.

---

## 8. Classic `switch` (with `case` and `break`)

Syntax:

```java
switch (value) {
    case option1:
        // code
        break;
    case option2:
        // code
        break;
    default:
        // code if none match
}
```

`break` is crucial to prevent the program from “continuing” with the following cases.

---

### 8.1. Example: simple menu

```java
int option = 2;

switch (option) {
    case 1:
        System.out.println("You selected: Play");
        break;
    case 2:
        System.out.println("You selected: Settings");
        break;
    case 3:
        System.out.println("You selected: Exit");
        break;
    default:
        System.out.println("Invalid option");
}
```

---

### 8.2. Common mistake: forgetting `break`

```java
int option = 2;

switch (option) {
    case 1:
        System.out.println("Play");
    case 2:
        System.out.println("Settings");
    case 3:
        System.out.println("Exit");
}
```

With `option = 2`, it will print:

```
Settings
Exit
```

Because there is no `break`, it goes into `case 2` and keeps going.

---

## 9. Modern switch (recommended in modern Java)

Modern Java lets you write `switch` in a safer and more compact way.

Features:

- Uses `->` instead of `:`
- Doesn't need `break`
- Makes it easy to return values
- Avoids “fall-through” errors

---

### 9.1. Example: modern switch (expression)

```java
int option = 2;

String message = switch (option) {
    case 1 -> "You selected: Play";
    case 2 -> "You selected: Settings";
    case 3 -> "You selected: Exit";
    default -> "Invalid option";
};

System.out.println(message);
```

Here `switch` returns a `String`, as if it were an expression.

---

### 9.2. Example: multiple values per case

```java
String day = "SAT";

String type = switch (day) {
    case "MON", "TUE", "WED", "THU", "FRI" -> "Weekday";
    case "SAT", "SUN" -> "Weekend";
    default -> "Unknown";
};

System.out.println(type);
```

---

### 9.3. Example: block with `yield`

When you need more than one line in a case, you can use a `{}` block and `yield`.

```java
int score = 85;

String grade = switch (score / 10) {
    case 10, 9 -> "A";
    case 8 -> {
        System.out.println("Good job!");
        yield "B";
    }
    case 7 -> "C";
    default -> "D";
};

System.out.println(grade);
```

---

## 10. When should you use `if` and when `switch`?

### 10.1. Use `if` when

- The condition is a complex comparison (`&&`, `||`, ranges, etc.)
- You need to evaluate expressions like “between 0 and 10”
- You have conditions that do not depend on a single value

Typical example for `if`:

```java
if (age >= 18 && hasId) {
    System.out.println("Access granted");
}
```

---

### 10.2. Use `switch` when

- You compare a value with several possible options
- It is a menu or a clear selection
- The cases are discrete (1, 2, 3 or "A", "B", "C")

Typical example for `switch`:

```java
switch (option) {
    case 1 -> System.out.println("Play");
    case 2 -> System.out.println("Settings");
    default -> System.out.println("Invalid option");
}
```

---

## 11. Guided examples (to really understand it)

### 11.1. Example 1: validating a simple password with `if`

We want to check:

- That the password has at least 8 characters
- That the user is not blocked

```java
public class Main {
    public static void main(String[] args) {
        String password = "mySecret1";
        boolean isBlocked = false;

        boolean isLongEnough = password.length() >= 8;

        if (isLongEnough && !isBlocked) {
            System.out.println("Password accepted");
        } else {
            System.out.println("Password rejected");
        }
    }
}
```

Key points:

- `password.length()` returns the number of characters
- `isLongEnough` makes the condition more readable
- `!isBlocked` means “not blocked”

---

### 11.2. Example 2: a level system with `else if`

We want to classify a level based on points:

- 0 to 99: Beginner
- 100 to 199: Intermediate
- 200 or more: Advanced

```java
public class Main {
    public static void main(String[] args) {
        int points = 165;

        if (points < 100) {
            System.out.println("Level: Beginner");
        } else if (points < 200) {
            System.out.println("Level: Intermediate");
        } else {
            System.out.println("Level: Advanced");
        }
    }
}
```

Key points:

- You don't need to write `points >= 100` in the second case
- If it reaches the `else if`, we already know that `points >= 100`

---

### 11.3. Example 3: selecting an action with a modern switch

```java
public class Main {
    public static void main(String[] args) {
        int option = 3;

        String action = switch (option) {
            case 1 -> "Creating new file";
            case 2 -> "Opening settings";
            case 3 -> "Exiting";
            default -> "Unknown option";
        };

        System.out.println(action);
    }
}
```

Key points:

- `switch` returns a value
- There is no `break`
- The code is cleaner

---

## 12. Things to keep in mind

- `if` is used for condition-based decisions.
- `else` covers the opposite case.
- `else if` allows multiple paths, but the order matters.
- `switch` is ideal when you compare a single value against several options.
- The **modern switch** avoids errors and is usually more readable.

---

In the next topic we'll learn to repeat actions with **loops** (`while` and `for`), where conditionals will be key to controlling when to stop or keep going.
