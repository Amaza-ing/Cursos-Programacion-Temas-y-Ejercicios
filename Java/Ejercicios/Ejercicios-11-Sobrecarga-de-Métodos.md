# Exercises - Topic 11: Method overloading

Below you will find **10 practical exercises** to work with **method overloading** (same name, different parameters).

Try to solve them before consulting the solution.

---

## Exercise 1: Overload `sum` (2 and 3 parameters)

Create two `sum` methods:

- One that receives 2 integers and returns the sum
- Another who receives 3 integers and returns the sum

From `main`, call both and display the results.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(sum(2, 3));
        System.out.println(sum(2, 3, 4));
    }

    public static int sum(int a, int b) {
        return a + b;
    }

    public static int sum(int a, int b, int c) {
        return a + b + c;
    }
}
```

</details>

---

## Exercise 2: Overload `sum` for `double`

Create two `sum` methods:

- `sum(int, int)`
- `sum(double, double)`

Call both from `main`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(sum(10, 5));
        System.out.println(sum(10.5, 5.2));
    }

    public static int sum(int a, int b) {
        return a + b;
    }

    public static double sum(double a, double b) {
        return a + b;
    }
}
```

</details>

---

## Exercise 3: Overload `printUser` with and without age

Create two `printUser` methods:

- One that receives only the name (`String`) and shows `"User: <name>"`
- Another that receives name and age (`String`, `int`) and shows `"User: <name> | Age: <age>"`

Call both from `main`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        printUser("Laura");
        printUser("Laura", 28);
    }

    public static void printUser(String name) {
        System.out.println("User: " + name);
    }

    public static void printUser(String name, int age) {
        System.out.println("User: " + name + " | Age: " + age);
    }
}
```

</details>

---

## Exercise 4: Overload `calculateTotal` (without discount and with discount)

Create two `calculateTotal` methods:

- One who receives `unitPrice` (`double`) and `quantity` (`int`) and returns the total
- Another person who also receives `discountRate` (`double`) and applies the discount

Call both from `main`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(calculateTotal(10.0, 3));
        System.out.println(calculateTotal(10.0, 3, 0.10));
    }

    public static double calculateTotal(double unitPrice, int quantity) {
        return unitPrice * quantity;
    }

    public static double calculateTotal(double unitPrice, int quantity, double discountRate) {
        double base = unitPrice * quantity;
        return base - (base * discountRate);
    }
}
```

</details>

---

## Exercise 5: Overload `isValid` for `int` and `String`

Create two `isValid` methods:

- `isValid(int value)` returns `true` if the value is greater than 0
- `isValid(String value)` returns `true` if it is not `null` and is not blank

Call both from `main` with test values.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(isValid(5));
        System.out.println(isValid(-2));
        System.out.println(isValid("Hello"));
        System.out.println(isValid("   "));
    }

    public static boolean isValid(int value) {
        return value > 0;
    }

    public static boolean isValid(String value) {
        return value != null && !value.isBlank();
    }
}
```

</details>

---

## Exercise 6: Overload `buildLabel` with different types

Create two `buildLabel` methods:

- `buildLabel(String text, int number)` → `"text-number"`
- `buildLabel(String text, String code)` → `"text-code"`

Print both results from `main`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(buildLabel("Item", 7));
        System.out.println(buildLabel("Item", "A7X"));
    }

    public static String buildLabel(String text, int number) {
        return text + "-" + number;
    }

    public static String buildLabel(String text, String code) {
        return text + "-" + code;
    }
}
```

</details>

---

## Exercise 7: Overloading by parameter order

Create two `formatPair` methods:

- `formatPair(String left, int right)` → `"left: <left> | right: <right>"`
- `formatPair(int left, String right)` → `"left: <left> | right: <right>"`

Call both from `main` to verify that Java chooses the correct version.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(formatPair("X", 10));
        System.out.println(formatPair(10, "X"));
    }

    public static String formatPair(String left, int right) {
        return "left: " + left + " | right: " + right;
    }

    public static String formatPair(int left, String right) {
        return "left: " + left + " | right: " + right;
    }
}
```

</details>

---

## Exercise 8: Overloading and implicit conversion

Create two `multiply` methods:

- `multiply(int a, int b)`
- `multiply(double a, double b)`

Call `multiply(3, 2.5)` from `main` and print the result.  
Note which version is used and why.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(multiply(3, 2.5));
    }

    public static int multiply(int a, int b) {
        return a * b;
    }

    public static double multiply(double a, double b) {
        return a * b;
    }
}
```

`multiply(double, double)` is used because `2.5` is `double` and Java converts `3` to `double`.

</details>

---
## Exercise 9: Avoid duplicating logic by using one overload that calls another

Create two `sum` methods:

- `sum(int a, int b)` should internally call `sum(int a, int b, int c)` using `0` as the third value
- `sum(int a, int b, int c)` returns the sum of the three

Call both from `main`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(sum(5, 6));
        System.out.println(sum(5, 6, 7));
    }

    public static int sum(int a, int b) {
        return sum(a, b, 0);
    }

    public static int sum(int a, int b, int c) {
        return a + b + c;
    }
}
```

</details>

---

## Exercise 10: Overload `calculateScore` with different inputs

Create two `calculateScore` methods:

- `calculateScore(int base)` returns `base * 10`
- `calculateScore(int base, int bonus)` returns `base * 10 + bonus`

Call both from `main` and display the results.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(calculateScore(7));
        System.out.println(calculateScore(7, 15));
    }

    public static int calculateScore(int base) {
        return base * 10;
    }

    public static int calculateScore(int base, int bonus) {
        return base * 10 + bonus;
    }
}
```

</details>

---
