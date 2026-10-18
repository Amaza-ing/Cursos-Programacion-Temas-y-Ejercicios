# Topic 11. Method overloading

## 1. Introduction

In the previous topics you learned how to create and use methods with parameters and with `return`. Now let's take it one step further: **use the same method name for different “versions”**.

This is called method overloading.

Overloading is a very common technique in Java because it allows:

- Have a consistent method name for the same action
- Adapt that action to different types of data or quantities of parameters
- Keep code cleaner and easier to read

Idea example:

- `sum(2, 3)`
- `sum(2, 3, 4)`
- `sum(2.5, 3.1)`

They all do “add”, but with different signatures.

---

[![Method Overload](https://img.youtube.com/vi/RPVgs7bGaso/0.jpg)](https://www.youtube.com/watch?v=RPVgs7bGaso&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is method overloading

Two methods are **overloaded** if:

- They have the same **name**
- They are in the same **class**
- But they have a **different parameter list**

The parameter list may be different because:

- Number of parameters
- Type of parameters
- Order of types in parameters

That combination is called the method signature.

---

## 3. The signature of a method (what Java uses to differentiate them)

Java identifies a method by:

- Method name
- Parameter types (including their order)

**Java DOES NOT use** the return type to differentiate methods.

Example of different signatures:

```java
sum(int, int)
sum(int, int, int)
sum(double, double)
sum(String, String)
```

---

## 4. Overloading by number of parameters

This is the easiest way to understand.

### 4.1. Example: `sum` with 2 and with 3 values

```java
public class Main {
    public static void main(String[] args) {
        int a = sum(2, 3);
        int b = sum(2, 3, 4);

        System.out.println(a);
        System.out.println(b);
    }

    public static int sum(int x, int y) {
        return x + y;
    }

    public static int sum(int x, int y, int z) {
        return x + y + z;
    }
}
```

What happens:

- `sum(2, 3)` calls `sum(int, int)`
- `sum(2, 3, 4)` calls `sum(int, int, int)`

Java automatically chooses the correct version.

---

## 5. Overloading by type of parameters

You can have methods with the same name and the same number of parameters, but with **different types**.

### 5.1. Example: `sum` for `int` and for `double`

```java
public class Main {
    public static void main(String[] args) {
        int a = sum(10, 5);
        double b = sum(10.5, 5.2);

        System.out.println(a);
        System.out.println(b);
    }

    public static int sum(int x, int y) {
        return x + y;
    }

    public static double sum(double x, double y) {
        return x + y;
    }
}
```

Here:

- If you pass integers, Java uses the `int` version
- If you pass decimals, Java uses the `double` version

---

## 6. Overloading by type order

You can also overload if you change the type order in the parameters.

### 6.1. Example: `formatUser` with different order

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(formatUser("Laura", 28));
        System.out.println(formatUser(28, "Laura"));
    }

    public static String formatUser(String name, int age) {
        return "Name: " + name + " | Age: " + age;
    }

    public static String formatUser(int age, String name) {
        return "Age: " + age + " | Name: " + name;
    }
}
```

This works because the signature is different:

- `formatUser(String, int)`
- `formatUser(int, String)`

---

## 7. What is NOT overload

### 7.1. It is not overhead to change only the return type

This DOES NOT compile:

```java
public static int getValue() {
    return 10;
}

public static double getValue() {
    return 10.0;
}
```

Java can't tell it apart because the parameters are identical (there are no parameters).

---

### 7.2. It is not overhead to change only the parameter names

This is NOT overloading, because the type and number are the same:

```java
public static int sum(int a, int b) {
    return a + b;
}

public static int sum(int x, int y) {
    return x + y;
}
```

For Java, both signatures are `sum(int, int)`.

---

## 8. How Java decides which method to call

When you call an overloaded method, Java chooses the version that “best fits” the arguments.

### 8.1. Example: exact call

```java
sum(2, 3);          // encaja con sum(int, int)
sum(2.0, 3.0);      // encaja con sum(double, double)
```

### 8.2. Example: implicit conversion

Remember the type conversion topic: Java can implicitly convert `int` to `double`.

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(sum(2, 3));   // llama a int
        System.out.println(sum(2, 3.5)); // llama a double
    }

    public static int sum(int x, int y) {
        return x + y;
    }

    public static double sum(double x, double y) {
        return x + y;
    }
}
```

In `sum(2, 3.5)`:

- `3.5` is now `double`
- Java converts `2` to `double`
- Choose `sum(double, double)`

---

## 9. Ambiguity (when Java doesn't know which version to use)

Sometimes you can create overloads that lead to ambiguous calls. In these cases, Java will give a compilation error.

A typical example is when there are several possible conversions and none is clearly “better”.

The rule of thumb to avoid it:

- Do not create overloads that depend on “dodgy” conversions
- Keep very clear and different signatures

---

## 10. Real case: “build” type methods with variants

A common use of overloading is to allow multiple ways of using a method to generate output or construct a value.

### 10.1. Example: `buildMessage` with variants

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(buildMessage("Welcome"));
        System.out.println(buildMessage("Welcome", "Laura"));
        System.out.println(buildMessage("Welcome", "Laura", 3));
    }

    public static String buildMessage(String text) {
        return text;
    }

    public static String buildMessage(String text, String userName) {
        return text + ", " + userName;
    }

    public static String buildMessage(String text, String userName, int attempts) {
        return text + ", " + userName + " | Attempts: " + attempts;
    }
}
```

---

## 11. Good practices when overloading

### 11.1. Keep the intention consistent

If the method is called `sum`, all versions must “sum up”.  
If the method is called `calculateTotal`, all versions must calculate a total.

---

### 11.2. Avoid overloads that confuse

Changing the order of parameters may be legal, but it can lead to calls that are difficult to read if you are not consistent.

---

### 11.3. Use overloading to simplify use

A common pattern is that a “simple” version calls for a more complete one.

```java
public static int sum(int x, int y) {
    return sum(x, y, 0);
}

public static int sum(int x, int y, int z) {
    return x + y + z;
}
```

---

## 12. Complete example: final price calculation with variants

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(calculateTotal(10.0, 3));            // 30.0
        System.out.println(calculateTotal(10.0, 3, 0.10));      // 27.0
        System.out.println(calculateTotal(10.0, 3, 0.10, 2.0)); // 29.0
    }

    public static double calculateTotal(double unitPrice, int quantity) {
        return unitPrice * quantity;
    }

    public static double calculateTotal(double unitPrice, int quantity, double discountRate) {
        double base = unitPrice * quantity;
        return base - (base * discountRate);
    }

    public static double calculateTotal(double unitPrice, int quantity, double discountRate, double extraFee) {
        double discounted = calculateTotal(unitPrice, quantity, discountRate);
        return discounted + extraFee;
    }
}
```

---

## 13. Common mistakes when starting out

- Thinking that the return creates overload (no).
- Create overloads that are too similar.
- Duplicate logic in each version (better to reuse).

---

## 14. To take into account

- Overloading allows multiple methods with the same name and different signatures.
- The signature depends on the name and parameters (not the return).
- You can overload by number, type or order of parameters.
- Java chooses the version that best fits the arguments.
- Used well, overloading makes the code cleaner and easier to use.

---

In the next topic we will continue working on good practices and code organization, preparing the ground for **arrays** and data structures.
