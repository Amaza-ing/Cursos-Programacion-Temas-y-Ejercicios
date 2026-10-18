# Exercises - Topic 17: Static methods and the `Math` library

Below you will find **10 practical exercises** on **static methods** and the **`Math`** library: differences between instance methods and `static`, creation of utilities, `static final` (constants), `Math.abs`, `min/max`, `pow`, `sqrt`, `round/floor/ceil`, `random` with ranges, and common calculation cases.

Try to solve them before consulting the solution.

---

## Exercise 1: Static method `isEven`

Create an `NumberUtils` class with a static method:

```java
public static boolean isEven(int value)
```

It should return `true` if `value` is even and `false` if it is odd.

On `main`, try the method with `4`, `7` and `0`.

<details><summary>Show solution</summary>

```java
public class NumberUtils {
    public static boolean isEven(int value) {
        return value % 2 == 0;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(NumberUtils.isEven(4));
        System.out.println(NumberUtils.isEven(7));
        System.out.println(NumberUtils.isEven(0));
    }
}
```

</details>

---

## Exercise 2: Static method `clamp`

Create a static method on `NumberUtils`:

```java
public static int clamp(int value, int min, int max)
```

You must return:

- `min` yes `value < min`
- `max` yes `value > max`
- `value` if within range

In `main`, try:

- `clamp(5, 0, 10)`
- `clamp(-2, 0, 10)`
- `clamp(99, 0, 10)`

<details><summary>Show solution</summary>

```java
public class NumberUtils {
    public static int clamp(int value, int min, int max) {
        if (value < min) {
            return min;
        }

        if (value > max) {
            return max;
        }

        return value;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(NumberUtils.clamp(5, 0, 10));
        System.out.println(NumberUtils.clamp(-2, 0, 10));
        System.out.println(NumberUtils.clamp(99, 0, 10));
    }
}
```

</details>

---

## Exercise 3: `static final` constant for VAT

Create a class `TaxConfig` with a constant:

```java
public static final double VAT_RATE = 0.21;
```

In `main`, calculate the final price of a product with:

- `double basePrice = 100;`

Formula:

```
finalPrice = basePrice + basePrice * VAT_RATE
```

<details><summary>Show solution</summary>

```java
public class TaxConfig {
    public static final double VAT_RATE = 0.21;
}
```

```java
public class Main {
    public static void main(String[] args) {
        double basePrice = 100;
        double finalPrice = basePrice + basePrice * TaxConfig.VAT_RATE;

        System.out.println(finalPrice);
    }
}
```

</details>

---

## Exercise 4: Distance on a straight line with `Math.abs`

Declares:

- `int a = -8;`
- `int b = 3;`

Calculate the distance between them on the number line using `Math.abs`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int a = -8;
        int b = 3;

        int distance = Math.abs(b - a);
        System.out.println(distance);
    }
}
```

</details>

---

## Exercise 5: Greater and lesser than 3 values with `Math.max` and `Math.min`

Declares:

- `int x = 12;`
- `int y = 5;`
- `int z = 30;`

Calculate:

- The oldest of the 3
- The youngest of the 3

Use combinations of `Math.max` and `Math.min`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int x = 12;
        int y = 5;
        int z = 30;

        int max = Math.max(x, Math.max(y, z));
        int min = Math.min(x, Math.min(y, z));

        System.out.println("Max: " + max);
        System.out.println("Min: " + min);
    }
}
```

</details>

---

## Exercise 6: Hypotenuse with `Math.sqrt` and `Math.pow`

Declare a right triangle with:

- `double a = 3;`
- `double b = 4;`

Calculate the hypotenuse with:

```
c = sqrt(a^2 + b^2)
```

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        double a = 3;
        double b = 4;

        double c = Math.sqrt(Math.pow(a, 2) + Math.pow(b, 2));
        System.out.println(c);
    }
}
```

</details>

---

## Exercise 7: Round to 2 decimal places using `Math.round`

Declares:

- `double price = 19.987;`

Round to 2 decimal places with the technique of multiplying and dividing by 100.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        double price = 19.987;

        double rounded = Math.round(price * 100.0) / 100.0;
        System.out.println(rounded);
    }
}
```

</details>

---

## Exercise 8: `floor` and `ceil` to separate integer part

Declares:

- `double value = 7.3;`

Print:

- `Math.floor(value)`
- `Math.ceil(value)`

Then calculate the approximate decimal part as:

```
decimal = value - floor(value)
```

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        double value = 7.3;

        double floored = Math.floor(value);
        double ceiled = Math.ceil(value);

        System.out.println(floored);
        System.out.println(ceiled);

        double decimal = value - floored;
        System.out.println(decimal);
    }
}
```

</details>

---

## Exercise 9: Random integer in a range
Generates a random integer between `1` and `10` (inclusive).  
Print the result.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int min = 1;
        int max = 10;

        int randomValue = (int) (Math.random() * (max - min + 1)) + min;
        System.out.println(randomValue);
    }
}
```

</details>

---

## Exercise 10: Static method to roll a dice `rollDice`

Create an `RandomUtils` class with a static method:

```java
public static int rollDice()
```

You must return an integer between `1` and `6` using `Math.random()`.

In `main`, call the method 5 times and print each result.

<details><summary>Show solution</summary>

```java
public class RandomUtils {
    public static int rollDice() {
        int min = 1;
        int max = 6;

        return (int) (Math.random() * (max - min + 1)) + min;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 0; i < 5; i++) {
            System.out.println(RandomUtils.rollDice());
        }
    }
}
```

</details>

---
