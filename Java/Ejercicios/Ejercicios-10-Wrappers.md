# Exercises - Topic 10: Primitive data type wrappers

Below you will find **10 practical exercises** to work with **wrappers**, autoboxing, unboxing, `parseXxx`, `valueOf`, comparisons and handling `null`.

Try to solve them before looking at the solution.

---

## Exercise 1: Basic autoboxing

Declare a primitive `int` variable with value `10` and assign it to an `Integer` variable using autoboxing.  
Print the wrapper's value.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int number = 10;
        Integer boxed = number;

        System.out.println(boxed);
    }
}
```

</details>

---

## Exercise 2: Basic unboxing

Declare an `Integer` variable with value `25` and assign it to an `int` variable using unboxing.  
Print the primitive value.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        Integer boxed = 25;
        int number = boxed;

        System.out.println(number);
    }
}
```

</details>

---

## Exercise 3: Convert text to integer

Declare a variable `text` with value `"42"`.

Convert the text to `int` using `Integer.parseInt` and add `8` to the result.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String text = "42";

        int value = Integer.parseInt(text);
        System.out.println(value + 8);
    }
}
```

</details>

---

## Exercise 4: Convert text to `Double`

Declare a variable `priceText` with value `"19.99"`.

Convert the text to `Double` using `Double.valueOf` and print the value.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String priceText = "19.99";

        Double price = Double.valueOf(priceText);
        System.out.println(price);
    }
}
```

</details>

---

## Exercise 5: Compare wrappers correctly

Declare two `Integer` variables with value `100`.

- Compare their values using `equals`
- Print the result

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        Integer a = 100;
        Integer b = 100;

        System.out.println(a.equals(b));
    }
}
```

</details>

---

## Exercise 6: Avoid `NullPointerException`

Declare an `Integer` variable called `age` with value `null`.

Check whether it is `null` before trying to convert it to `int`.  
If it is `null`, print `"No age provided"`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        Integer age = null;

        if (age == null) {
            System.out.println("No age provided");
        } else {
            int value = age;
            System.out.println(value);
        }
    }
}
```

</details>

---

## Exercise 7: Use the `MIN_VALUE` and `MAX_VALUE` constants

Print to the console:

- The minimum value of `Integer`
- The maximum value of `Integer`

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(Integer.MIN_VALUE);
        System.out.println(Integer.MAX_VALUE);
    }
}
```

</details>

---

## Exercise 8: Compare with `compareTo`

Declare two `Integer` variables with values `15` and `30`.

Use `compareTo` to compare both values and print the result.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        Integer a = 15;
        Integer b = 30;

        System.out.println(a.compareTo(b));
    }
}
```

</details>

---

## Exercise 9: Validate characters with `Character`

Declare a `char` variable with value `'7'`.

Use `Character.isDigit` to check whether it is a digit and print the result.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        char c = '7';

        boolean isDigit = Character.isDigit(c);
        System.out.println(isDigit);
    }
}
```

</details>

---

## Exercise 10: Convert a number to text

Declare an `int` variable with value `50`.

Convert the number to `String` using `String.valueOf` and print the result.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int value = 50;

        String text = String.valueOf(value);
        System.out.println(text);
    }
}
```

</details>
---
