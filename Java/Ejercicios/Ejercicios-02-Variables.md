# Exercises - Topic 2: Variables and data types (Java)

Below you will find **10 practical exercises** on variables, primitive types, `String`, constants and good naming practices.

Try to solve them before looking at the solution.

---

## Exercise 1: Declaring and initializing basic variables

Create a program with these variables (choose the right types):

- `userName` (username) with the value `"Laura"`
- `userAge` (age) with the value `28`
- `heightMeters` (height in meters) with the value `1.67`
- `hasDrivingLicense` with the value `true`
- `favoriteLetter` with the value `'L'`

Print each variable on a separate line.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String userName = "Laura";
        int userAge = 28;
        double heightMeters = 1.67;
        boolean hasDrivingLicense = true;
        char favoriteLetter = 'L';

        System.out.println(userName);
        System.out.println(userAge);
        System.out.println(heightMeters);
        System.out.println(hasDrivingLicense);
        System.out.println(favoriteLetter);
    }
}
```

</details>

---

## Exercise 2: Choose the correct type

Declare and initialize variables with the most appropriate type:

- `minutesInHour` with the value `60`
- `piApprox` with the value `3.1416`
- `isWeekend` with the value `false`
- `worldPopulation` with the value `8_000_000_000`

Print them all to the console.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int minutesInHour = 60;
        double piApprox = 3.1416;
        boolean isWeekend = false;
        long worldPopulation = 8_000_000_000L;

        System.out.println(minutesInHour);
        System.out.println(piApprox);
        System.out.println(isWeekend);
        System.out.println(worldPopulation);
    }
}
```

</details>

---

## Exercise 3: Modify a variable step by step

Create a variable `lives` with an initial value of `3`.

- Subtract 1 life (it should end up at 2)
- Subtract 1 life (it should end up at 1)
- Add 2 lives (it should end up at 3)

Print the final value of `lives`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int lives = 3;

        lives = lives - 1;
        lives = lives - 1;
        lives = lives + 2;

        System.out.println(lives); // 3
    }
}
```

</details>

---

## Exercise 4: Concatenation with text (avoid confusing results)

Create these variables:

- `productName` with value `"Keyboard"`
- `unitPrice` with value `29.99`
- `quantity` with value `2`

Print a sentence like this (same format, but with your variables):

```
Product: Keyboard | Units: 2 | Total: 59.98
```

Hint: calculate `total` before printing.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String productName = "Keyboard";
        double unitPrice = 29.99;
        int quantity = 2;

        double total = unitPrice * quantity;

        System.out.println("Product: " + productName + " | Units: " + quantity + " | Total: " + total);
    }
}
```

</details>

---

## Exercise 5: `char` vs `String` (fix the types)

This code has type errors. Fix it so it compiles and keeps the same meaning:

```java
public class Main {
    public static void main(String[] args) {
        char middleName = "A";
        String grade = 'B';

        System.out.println(middleName);
        System.out.println(grade);
    }
}
```

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        char middleName = 'A';
        String grade = "B";

        System.out.println(middleName);
        System.out.println(grade);
    }
}
```

</details>

---

## Exercise 6: Constants with `final`

Create a program that defines:

- A constant `MAX_ATTEMPTS` with value `5`
- A variable `attempts` with initial value `0`

Print:

- `MAX_ATTEMPTS`
- `attempts`

Then, increment `attempts` to `1` and print `attempts` again.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        final int MAX_ATTEMPTS = 5;
        int attempts = 0;

        System.out.println(MAX_ATTEMPTS);
        System.out.println(attempts);

        attempts = 1;
        System.out.println(attempts);
    }
}
```

</details>

---

## Exercise 7: Variable names (refactor following good practices)

Rewrite this code so the names are clearer, using **camelCase** and names that say what the values really mean:

```java
public class Main {
    public static void main(String[] args) {
        int a = 35;
        double b = 120.5;
        boolean c = true;

        System.out.println(a);
        System.out.println(b);
        System.out.println(c);
    }
}
```

Keep the values, but change the names to more descriptive ones.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int userAge = 35;
        double accountBalance = 120.5;
        boolean isPremiumUser = true;

        System.out.println(userAge);
        System.out.println(accountBalance);
        System.out.println(isPremiumUser);
    }
}
```

</details>

---

## Exercise 8: Numeric separators for readability
Declare a variable `annualBudget` with value `2500000` but written using underscores to make it more readable.

Print the value to the console.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int annualBudget = 2_500_000;

        System.out.println(annualBudget);
    }
}
```

</details>

---

## Exercise 9: Uninitialized local variable (find and fix the error)

This program does not compile. Fix it **without changing the type** of the variable:

```java
public class Main {
    public static void main(String[] args) {
        int points;
        System.out.println(points);
    }
}
```

<details><summary>Show solution</summary>

In Java, a local variable must be initialized before it is used:

```java
public class Main {
    public static void main(String[] args) {
        int points = 0;
        System.out.println(points);
    }
}
```

</details>

---

## Exercise 10: Create a “profile” with varied types (without copying the topic example)

Declare variables to represent a simple profile:

- `nickName` (text)
- `level` (integer)
- `accuracyRate` (decimal)
- `isOnline` (boolean)
- `rankLetter` (char)

Assign made-up values and show output like this (same style, with your data):

```
Nick: Neo | Level: 12 | Accuracy: 0.83 | Online: true | Rank: S
```

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String nickName = "Neo";
        int level = 12;
        double accuracyRate = 0.83;
        boolean isOnline = true;
        char rankLetter = 'S';

        System.out.println(
            "Nick: " + nickName +
            " | Level: " + level +
            " | Accuracy: " + accuracyRate +
            " | Online: " + isOnline +
            " | Rank: " + rankLetter
        );
    }
}
```

</details>

---
