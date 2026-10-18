# Exercises - Topic 4: Type conversion (Java)

Below you will find **10 practical exercises** on implicit conversion, explicit conversion (casting), division between integers and conversion between `String` and numeric types.

Try to solve them before consulting the solution.

---

## Exercise 1: Implicit conversion from `int` to `double`

Declares:

- A variable `points` of type `int` with value `7`
- A variable `finalPoints` of type `double` that receives the value of `points`

Print `finalPoints`.

<details><summary>Show Solution</summary>

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

Declares:

- A variable `price` of type `double` with value `24.75`

Convert that value to `int` and save it to `roundedPrice`.  
Print `roundedPrice`.

<details><summary>Show Solution</summary>

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

## Exercise 3: Division by integers (detect the problem)

Declares:

- `totalScore` with `5` value
- `players` with `2` value

Calculate the **correct** mean using `double`.

<details><summary>Show Solution</summary>

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

This code does not give the expected result. Correct it:

```java
int a = 7;
int b = 2;

double result = (double) (a / b);
System.out.println(result);
```

<details><summary>Show Solution</summary>

The problem is that the division occurs before casting.

```java
int a = 7;
int b = 2;

double result = (double) a / b;
System.out.println(result);
```

</details>

---

## Exercise 5: Conversion from `char` to `int`

Declares:

- An `char` named `symbol` with value `'B'`

Converts that character to `int` and displays the result.

<details><summary>Show Solution</summary>

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

Declares:

- A variable `textValue` with value `"15"`

Convert text to number and calculate `textValue + 5`.

<details><summary>Show Solution</summary>

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

Declares:

- `priceText` with `"9.99"` value

Convert the value to `double` and multiply it by `2`.

<details><summary>Show Solution</summary>

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

Declares:

- A variable `level` of type `int` with value `4`

Convert that value to `String` and concatenate it with the text `"Level: "`.

<details><summary>Show Solution</summary>

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

Declares:

- An `int` with `130` value

Cast `byte` and show the result.  
Reflect on why the value is not what you expected.

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int value = 130;
        byte smallValue = (byte) value;

        System.out.println(smallValue);
    }
}
```

The result is not correct because `byte` only supports values between -128 and 127.

</details>

---
## Exercise 10: Combined conversion into an expression

Declares:

- `hits` with `7` value
- `attempts` with `3` value

Calculates the hit percentage as `double`.

Expected result:

```
2.3333333333333335
```

<details><summary>Show Solution</summary>

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
