# Exercises - Topic 4: Type conversion (Java)

Below you will find **10 practical exercises** on implicit conversion, explicit conversion (casting), division between integers and conversion between `String` and numeric types.

Try to solve them before looking at the solution.

---

## Exercise 1: Implicit conversion from `int` to `double`

Declare:

- A variable `points` of type `int` with value `7`
- A variable `finalPoints` of type `double` that receives the value of `points`

Print `finalPoints`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int points = 7;
        double finalPoints = points;

        System.out.println(finalPoints);
    }
}
```

</details>

---

## Exercise 2: Explicit conversion from `double` to `int`

Declare:

- A variable `price` of type `double` with value `24.75`

Convert that value to `int` and store it in `roundedPrice`.  
Print `roundedPrice`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        double price = 24.75;
        int roundedPrice = (int) price;

        System.out.println(roundedPrice);
    }
}
```

</details>

---

## Exercise 3: Integer division (spot the problem)

Declare:

- `totalScore` with value `5`
- `players` with value `2`

Calculate the **correct** average using `double`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int totalScore = 5;
        int players = 2;

        double average = (double) totalScore / players;
        System.out.println(average);
    }
}
```

</details>

---

## Exercise 4: Casting in the wrong place

This code does not give the expected result. Fix it:

```java
int a = 7;
int b = 2;

double result = (double) (a / b);
System.out.println(result);
```

<details><summary>Show solution</summary>

The problem is that the division happens before the cast.

```java
int a = 7;
int b = 2;

double result = (double) a / b;
System.out.println(result);
```

</details>

---

## Exercise 5: Conversion from `char` to `int`

Declare:

- A `char` named `symbol` with value `'B'`

Convert that character to `int` and print the result.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        char symbol = 'B';
        int code = symbol;

        System.out.println(code);
    }
}
```

</details>

---

## Exercise 6: Conversion from `String` to `int`

Declare:

- A variable `textValue` with value `"15"`

Convert the text to a number and calculate `textValue + 5`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String textValue = "15";
        int number = Integer.parseInt(textValue);

        System.out.println(number + 5);
    }
}
```

</details>

---

## Exercise 7: Conversion from `String` to `double`

Declare:

- `priceText` with value `"9.99"`

Convert the value to `double` and multiply it by `2`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String priceText = "9.99";
        double price = Double.parseDouble(priceText);

        System.out.println(price * 2);
    }
}
```

</details>

---

## Exercise 8: Convert a number to `String`

Declare:

- A variable `level` of type `int` with value `4`

Convert that value to `String` and concatenate it with the text `"Level: "`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int level = 4;
        String levelText = String.valueOf(level);

        System.out.println("Level: " + levelText);
    }
}
```

</details>

---

## Exercise 9: Dangerous casting

Declare:

- An `int` with value `130`

Cast it to `byte` and print the result.  
Think about why the value is not what you expected.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int value = 130;
        byte smallValue = (byte) value;

        System.out.println(smallValue);
    }
}
```

The result is wrong because `byte` can only hold values between -128 and 127.

</details>

---
## Exercise 10: Combined conversion in an expression

Declare:

- `hits` with value `7`
- `attempts` with value `3`

Calculate the hit percentage as `double`.

Expected result:

```
2.3333333333333335
```

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int hits = 7;
        int attempts = 3;

        double ratio = (double) hits / attempts;
        System.out.println(ratio);
    }
}
```

</details>

---
