# Exercises - Topic 3: Operators and expressions (Java)

Below, you will find **10 practical exercises** on arithmetic, relational, logical, assignment and operator priority operators.

Try to solve them before consulting the solution.

---

## Exercise 1: Basic arithmetic operations

Declare two variables:

- `a` with value `14`
- `b` with value `4`

Calculates and displays by console:

- The sum
- The subtraction
- Multiplication
- The division
- The rest

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int a = 14;
        int b = 4;

        System.out.println(a + b);
        System.out.println(a - b);
        System.out.println(a * b);
        System.out.println(a / b);
        System.out.println(a % b);
    }
}
```

</details>

---

## Exercise 2: Division with decimals

Declares:

- `totalPoints` with `9` value
- `numberOfPlayers` with `2` value

Calculate the correct mean using `double`.

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int totalPoints = 9;
        int numberOfPlayers = 2;

        double average = (double) totalPoints / numberOfPlayers;
        System.out.println(average);
    }
}
```

</details>

---

## Exercise 3: Even or Odd

Declares a variable `number` with value `21`.

Checks if the number is even and displays the result (`true` or `false`).

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int number = 21;

        boolean isEven = number % 2 == 0;
        System.out.println(isEven);
    }
}
```

</details>

---

## Exercise 4: Relational comparisons

Declares:

- `age` with `16` value

Create boolean variables that indicate whether:

- He is of legal age
- He is a minor
- He is exactly 18 years old

Print the results.

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int age = 16;

        boolean isAdult = age >= 18;
        boolean isMinor = age < 18;
        boolean isExactly18 = age == 18;

        System.out.println(isAdult);
        System.out.println(isMinor);
        System.out.println(isExactly18);
    }
}
```

</details>

---

## Exercise 5: Logical AND operators (`&&`)

Declares:

- `age` with `22` value
- `hasId` with `true` value

Create a variable `canEnter` that is `true` only if it meets both conditions.

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int age = 22;
        boolean hasId = true;

        boolean canEnter = age >= 18 && hasId;
        System.out.println(canEnter);
    }
}
```

</details>

---

## Exercise 6: Logical OR operators (`||`)

Declares:

- `isVip` with value `false`
- `hasInvitation` with `true` value

Create a variable `hasAccess` that is `true` if it meets at least one condition.

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        boolean isVip = false;
        boolean hasInvitation = true;

        boolean hasAccess = isVip || hasInvitation;
        System.out.println(hasAccess);
    }
}
```

</details>

---

## Exercise 7: NOT Operator (`!`)

Declare a variable `isBlocked` with value `true`.

Create a variable `canLogin` that is the opposite value.

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        boolean isBlocked = true;

        boolean canLogin = !isBlocked;
        System.out.println(canLogin);
    }
}
```

</details>

---

## Exercise 8: Composite assignment operators

Declare a variable `score` with value `10`.

- Add 5 using `+=`
- Subtract 3 using `-=`
- Multiply by 2 using `*=`

Print the final value.

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int score = 10;

        score += 5;
        score -= 3;
        score *= 2;

        System.out.println(score);
    }
}
```

</details>

---

## Exercise 9: Increment and decrement

Declare a variable `counter` with value `0`.

- Increase once
- Increase again
- Decrements once

Print the final result.

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int counter = 0;

        counter++;
        counter++;
        counter--;

        System.out.println(counter);
    }
}
```

</details>

---

## Exercise 10: Operator priority

Without running the code, think about what the result will be:

```java
int result = 4 + 2 * 5;
System.out.println(result);
```

Then modify the expression so that the result is `30`.

<details><summary>Show Solution</summary>

Original result:

```
14
```

Modified version:

```java
int result = (4 + 2) * 5;
System.out.println(result);
```

</details>

---
