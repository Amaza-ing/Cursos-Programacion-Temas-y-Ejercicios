# Exercises - Topic 3: Operators and expressions (Java)

Below you will find **10 practical exercises** on arithmetic, relational, logical and assignment operators, and on operator precedence.

Try to solve them before looking at the solution.

---

## Exercise 1: Basic arithmetic operations

Declare two variables:

- `a` with value `14`
- `b` with value `4`

Calculate and print to the console:

- The sum
- The difference
- The product
- The quotient
- The remainder

<details><summary>Show solution</summary>

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

Declare:

- `totalPoints` with value `9`
- `numberOfPlayers` with value `2`

Calculate the correct average using `double`.

<details><summary>Show solution</summary>

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

## Exercise 3: Even or odd

Declare a variable `number` with value `21`.

Check whether the number is even and print the result (`true` or `false`).

<details><summary>Show solution</summary>

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

Declare:

- `age` with value `16`

Create boolean variables that indicate whether:

- The person is an adult
- The person is a minor
- The person is exactly 18 years old

Print the results.

<details><summary>Show solution</summary>

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

## Exercise 5: Logical AND operator (`&&`)

Declare:

- `age` with value `22`
- `hasId` with value `true`

Create a variable `canEnter` that is `true` only if both conditions are met.

<details><summary>Show solution</summary>

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

## Exercise 6: Logical OR operator (`||`)

Declare:

- `isVip` with value `false`
- `hasInvitation` with value `true`

Create a variable `hasAccess` that is `true` if at least one condition is met.

<details><summary>Show solution</summary>

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

## Exercise 7: NOT operator (`!`)

Declare a variable `isBlocked` with value `true`.

Create a variable `canLogin` that holds the opposite value.

<details><summary>Show solution</summary>

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

## Exercise 8: Compound assignment operators

Declare a variable `score` with value `10`.

- Add 5 using `+=`
- Subtract 3 using `-=`
- Multiply by 2 using `*=`

Print the final value.

<details><summary>Show solution</summary>

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

- Increment it once
- Increment it again
- Decrement it once

Print the final result.

<details><summary>Show solution</summary>

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

## Exercise 10: Operator precedence

Without running the code, think about what the result will be:

```java
int result = 4 + 2 * 5;
System.out.println(result);
```

Then modify the expression so that the result is `30`.

<details><summary>Show solution</summary>

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
