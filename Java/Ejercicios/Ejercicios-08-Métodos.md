# Exercises - Topic 8: Methods

Below you will find **10 practical exercises** to work with **methods**, parameters, arguments and return values.

Try to solve them before consulting the solution.

---

## Exercise 1: Method without parameters or return

Create a method called `printHello` that displays the `"Hello Java"` message in the console.  
Call the method from `main`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        printHello();
    }

    public static void printHello() {
        System.out.println("Hello Java");
    }
}
```

</details>

---

## Exercise 2: Method with a parameter

Create a method `printName` that receives an `String` called `name` and returns  
`"Name: <name>"`.

Calls the method passing `"Laura"` as an argument.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        printName("Laura");
    }

    public static void printName(String name) {
        System.out.println("Name: " + name);
    }
}
```

</details>

---

## Exercise 3: Method with two parameters and `return`

Create a method `sum` that receives two `int` and returns their sum.  
Save the result in a variable and display it in the console.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int result = sum(4, 6);
        System.out.println(result);
    }

    public static int sum(int a, int b) {
        return a + b;
    }
}
```

</details>

---

## Exercise 4: Method that returns `boolean`

Create a method `isAdult` that receives an age (`int`) and returns `true` if it is greater than or equal to 18.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        boolean result = isAdult(20);
        System.out.println(result);
    }

    public static boolean isAdult(int age) {
        return age >= 18;
    }
}
```

</details>

---

## Exercise 5: Method that builds an `String`

Create a method `buildMessage` that takes a name and age, and returns text in the format:

```
Name: Laura | Age: 28
```

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String message = buildMessage("Laura", 28);
        System.out.println(message);
    }

    public static String buildMessage(String name, int age) {
        return "Name: " + name + " | Age: " + age;
    }
}
```

</details>

---

## Exercise 6: Method that uses another method

Create a method `doubleNumber` that returns double a number.  
Then create another `printDouble` method that uses `doubleNumber` to print the result.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        printDouble(7);
    }

    public static int doubleNumber(int number) {
        return number * 2;
    }

    public static void printDouble(int number) {
        int result = doubleNumber(number);
        System.out.println(result);
    }
}
```

</details>

---

## Exercise 7: Method with condition and early `return`

Create a method `clampToZero` that receives an `int`.  
If the value is negative, it returns `0`.  
If not, it returns the original value.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(clampToZero(-5));
        System.out.println(clampToZero(10));
    }

    public static int clampToZero(int value) {
        if (value < 0) {
            return 0;
        }

        return value;
    }
}
```

</details>

---

## Exercise 8: Method with `double` and calculation

Create a method `calculateArea` that receives the radius of a circle (`double`)  
and return the area (`π * r * r`). Use `Math.PI`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        double area = calculateArea(3.0);
        System.out.println(area);
    }

    public static double calculateArea(double radius) {
        return Math.PI * radius * radius;
    }
}
```

</details>

---

## Exercise 9: Method that validates text

Create a method `isValidName` that receives an `String` and returns `true` if:

- Not `null`
- It is not empty
- Not blank

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(isValidName("Laura"));
        System.out.println(isValidName("   "));
    }

    public static boolean isValidName(String name) {
        return name != null && !name.isBlank();
    }
}
```

</details>

---

## Exercise 10: Program organized with methods

Create a program that:

- Have an `printWelcome` method
- Have a method `calculateScore` that receives two numbers and returns a result
- From `main`, call both methods and display the result

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        printWelcome();

        int score = calculateScore(10, 5);
        System.out.println("Score: " + score);
    }

    public static void printWelcome() {
        System.out.println("Welcome!");
    }

    public static int calculateScore(int base, int bonus) {
        return base + bonus;
    }
}
```

</details>

---
