# Topic 2. Variables and data types

## 1. Introduction

In any programming language, if you can't **save information**, you can't build useful programs.

In Java, that information is mainly stored in:

- **Variables** (data that can change)
- **Constant** (data that should not change)

And in order to save information, Java forces you to be very explicit: **every variable has a type**.

In this topic you will learn:

- What is a variable and how is it used?
- What does it mean for Java to be a **strongly typed** language?
- **Primitive** data types (the basic ones of the language)
- Essential reference types like `String`
- Declaration, assignment and modification
- Typical mistakes when starting
- Good practices for writing clear code

---

[![Variables](https://img.youtube.com/vi/_fHPet6Tx5c/0.jpg)](https://www.youtube.com/watch?v=_fHPet6Tx5c&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is a variable?

A **variable** is a space in memory with:

- A **name** (so you can refer to it)
- A **type** (to define what values it can save)
- A **value** (the information it actually stores)

Think of a variable as a labeled “box”:

- The **type** defines what can be inside (numbers, true/false, text, etc.)
- **name** allows you to use that box in your code
- The **value** is the current content

---

## 3. Java is strongly typed

We say that Java is a **strongly typed** language because:

- Each variable has a fixed type
- That guy can't change
- The compiler checks that you use the types correctly

Example:

```java
int age = 25;
age = 30; // OK
```

But this is not valid:

```java
int age = 25;
age = "twenty five"; // Error: no se puede asignar texto a un int
```

This is an advantage because it avoids many errors before running the program.

---

## 4. Variable declaration

To declare a variable in Java you need:

1. The **type**
2. The **name**

Syntax:

```java
type variableName;
```

Example:

```java
int age;
```

Here it still has **no value** (and cannot be used without initializing).

---

## 5. Assignment and initialization

Assigning a value means saving data inside the variable, using `=`.

### 5.1. Assign after declare

```java
int age;
age = 25;
```

### 5.2. Declare and initialize on the same line (most common)

```java
int age = 25;
```

---

## 6. Modify a variable

A variable can change its value during execution.

```java
int score = 10;

score = 15;
score = 30;
```

The variable is still `int`, but its value changes.

---

## 7. Primitive data types

Java has **8 primitive types**. They are “basic” data that are not objects.

- Integers: `byte`, `short`, `int`, `long`
- Decimals: `float`, `double`
- Logical: `boolean`
- Characters: `char`

> Rule of thumb: When starting out, the most common are `int`, `double`, `boolean`, `char`.

| Primitive type | Size | Possible values |
| -------------- | ------- | ------------------------------------------------------------------------------- |
| byte | 8 bits | From -128 to 127 |
| short | 16 bit | From -32,768 to 32,767 |
| int | 32 bit | From -2,147,483,648 to 2,147,483,647 |
| long | 64 bit | From -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807 |
| float | 32 bit | Approximately ±1.4E-45 to ±3.4028235E38 (single precision) |
| double | 64 bit | Approximately ±4.9E-324 to ±1.7976931348623157E308 (double precision) |
| char | 16 bit | From '\u0000' (0) to '\uFFFF' (65,535), Unicode characters |
| boolean | 1 bit\* | true or false |

---

## 8. Integers: `byte`, `short`, `int`, `long`

They are used for numbers **without decimals**.

### 8.1. `int` (most used)

```java
int age = 25;
int year = 2026;
int points = -10;
```

### 8.2. `long` (for larger numbers)

When the number may be very large, use `long`.

```java
long worldPopulation = 8_000_000_000L;
```

- The `L` suffix is important to indicate that it is an `long` literal.

### 8.3. `byte` and `short`

They are little used at the beginning, but they exist for memory efficiency.

```java
byte smallNumber = 120;
short mediumNumber = 30_000;
```

---

## 9. Decimals: `float` and `double`

For numbers with decimals.

### 9.1. `double` (recommended by default)

```java
double price = 19.99;
double average = 7.5;
```

### 9.2. `float` (less precision)

```java
float temperature = 36.5f;
```

- The `f` suffix is required for `float` literals.

> Recommendation: use `double` unless you have a clear reason to use `float`.

---

## 10. Booleans: `boolean`

It can only be `true` or `false`.

```java
boolean isActive = true;
boolean hasPermission = false;
```

Very used condition (`if`, `while`, etc.).

---

## 11. Characters: `char`

Stores a single character, enclosed in single quotes `' '`.

```java
char initial = 'S';
char grade = 'A';
```

Important:

- `char` is a single character
- `"A"` (with double quotes) is an `String`, not an `char`

---

## 12. `String` (text) — not primitive, but essential

`String` is a **reference** type (an object), not a primitive, but you will use it from day one.

```java
String name = "Alberto";
String city = "Madrid";
```

- Use double quotes `" "`.
- Allows you to save complete text strings.

---

## 13. Print variables via console

To see the content of a variable, we use:

```java
System.out.println(variableName);
```

Example:

```java
String name = "Alex";
int age = 25;

System.out.println(name);
System.out.println(age);
```

---

## 14. Concatenation (join text with variables)

With the `+` operator you can join text and variables.

```java
String name = "Alex";
int age = 25;

System.out.println("Name: " + name);
System.out.println("Age: " + age);
```

Output:

```
Name: Alex
Age: 25
```

---

## 15. Guided example: variables in a complete program

```java
public class Main {
    public static void main(String[] args) {
        String userName = "Alex";
        int userAge = 25;
        double accountBalance = 120.50;
        boolean isPremium = true;
        char userInitial = 'A';

        System.out.println("User name: " + userName);
        System.out.println("User age: " + userAge);
        System.out.println("Balance: " + accountBalance);
        System.out.println("Premium: " + isPremium);
        System.out.println("Initial: " + userInitial);
    }
}
```

What happens here:

- You declare variables of different types
- You initialize them with values
- Samples per console with descriptive text

---

## 16. Declare multiple variables of the same type

You can, but when you start it is usually less readable.

```java
int x = 1, y = 2, z = 3;
```

Recommendation (clearer):

```java
int x = 1;
int y = 2;
int z = 3;
```

---

## 17. Constants with `final`

A constant is a variable whose value should not change.

It is created using `final`.

```java
final int maxUsers = 100;
```

If you try to change it:

```java
final int maxUsers = 100;
maxUsers = 200; // Error
```

Naming convention for constants:

- `UPPER_SNAKE_CASE`

```java
final double VAT_RATE = 0.21;
```

---

## 18. Default values (very important)

In Java there is an important difference:

- **Local variables** (within methods) DO NOT have a default value
- **Attributes** (within classes) DO have a default value

### 18.1. Uninitialized local variable (error)

```java
public class Main {
    public static void main(String[] args) {
        int age;
        System.out.println(age); // Error: variable no inicializada
    }
}
```

Solution: initialize before use

```java
int age = 0;
System.out.println(age);
```

> You will see class attributes in OOP, later.

---

## 19. Literals and details that save you errors

### 19.1. Separators in numbers (more readable)

You can use `_` to separate thousands:

```java
int budget = 1_000_000;
long population = 8_000_000_000L;
```

### 19.2. `L` for long and `f` for float

```java
long distance = 9_000_000_000L;
float ratio = 0.75f;
```

---

## 20. Common mistakes when starting out

### 20.1. Confusing `=` with `==`

- `=` assigns a value
- `==` compares values

```java
int a = 10;      // asignación
boolean isTen = (a == 10); // comparación
```

### 20.2. Trying to save decimals in `int`

```java
int price = 19.99; // Error
```

Solution:

```java
double price = 19.99;
```

### 20.3. Confusing `char` with `String`

```java
char letter = "A"; // Error
```

Correct:

```java
char letter = 'A';
String text = "A";
```

---

## 21. Good practices when naming variables

### 21.1. Use camelCase

- `userName`
- `totalPrice`
- `isLoggedIn`

### 21.2. Descriptive, non-generic names

Bad:

```java
int x;
double a;
boolean flag;
```

Better:

```java
int userAge;
double totalPrice;
boolean isLoggedIn;
```

### 21.3. Booleans with clear prefix

Booleans usually start with:

- `is...`
- `has...`
- `can...`

Examples:

```java
boolean isActive;
boolean hasPermission;
boolean canAccess;
```

---

## 22. To take into account

- A variable is a space in memory with type, name and value.
- Java is strongly typed: the type always matters.
- Primitive types cover numbers, decimals, booleans and characters.
- `String` is essential for working with text.
- Initialize your variables before using them.
- Name your variables with intention: it saves you errors and improves reading.

---

In the next topic you will learn to work with **operators and expressions**, to start calculating, comparing and constructing conditions in Java.
