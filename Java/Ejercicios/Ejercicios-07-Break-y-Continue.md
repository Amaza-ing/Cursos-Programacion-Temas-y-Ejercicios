# Exercises - Topic 7: Flow control in loops (break and continue)

Below you will find **10 practical exercises** to learn how to use `break` and `continue` within `for` and `while` loops.

Try to solve them before looking at the solution.

---

## Exercise 1: Stop a loop when reaching a value

Use a `for` loop from 1 to 20.  
When the counter reaches `13`, display `"Found 13"` and stop the loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 20; i++) {
            if (i == 13) {
                System.out.println("Found 13");
                break;
            }
        }
    }
}
```

</details>

---

## Exercise 2: Skip multiples of 4

Use a `for` loop from 1 to 30.  
Don't print the numbers that are multiples of `4`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 30; i++) {
            if (i % 4 == 0) {
                continue;
            }

            System.out.println(i);
        }
    }
}
```

</details>

---

## Exercise 3: Find the first multiple of 7

Use a `for` loop from 1 to 100.  
Find the **first** multiple of `7`, print it and exit the loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 100; i++) {
            if (i % 7 == 0) {
                System.out.println(i);
                break;
            }
        }
    }
}
```

</details>

---

## Exercise 4: Ignore zero to avoid division by zero

Use a `for` loop from `-5` to `5`.  
Print the result of `50 / i`, but you **must not** divide by 0.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = -5; i <= 5; i++) {
            if (i == 0) {
                continue;
            }

            System.out.println("50 / " + i + " = " + (50 / i));
        }
    }
}
```

</details>

---

## Exercise 5: Count only the numbers that meet a condition (using `continue`)

Use a loop from 1 to 50 and count how many numbers are:

- multiples of 3
- but NOT multiples of 6

Print the final counter.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int count = 0;

        for (int i = 1; i <= 50; i++) {
            if (i % 3 != 0) {
                continue;
            }

            if (i % 6 == 0) {
                continue;
            }

            count++;
        }

        System.out.println(count);
    }
}
```

</details>

---

## Exercise 6: `while (true)` loop with controlled output

Create an infinite loop (`while (true)`) that increments an `attempts` variable starting from 1.  
When `attempts` reaches `5`, print `"Stop"` and end the loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int attempts = 0;

        while (true) {
            attempts++;

            if (attempts == 5) {
                System.out.println("Stop");
                break;
            }
        }
    }
}
```

</details>

---

## Exercise 7: Skip an iteration with `continue` in `while`

Use a `while` loop to count from 1 to 15.  
Do not print odd numbers (only even numbers should be displayed).

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int i = 1;

        while (i <= 15) {
            if (i % 2 != 0) {
                i++;
                continue;
            }

            System.out.println(i);
            i++;
        }
    }
}
```

</details>

---

## Exercise 8: Stop when you find a character

Declare a variable `text` with value `"java_programming"`.  
Loop through its characters and stop when you find the character `'_'`.  
Print `"Underscore found"` just before exiting the loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String text = "java_programming";

        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);

            if (c == '_') {
                System.out.println("Underscore found");
                break;
            }
        }
    }
}
```

</details>

---

## Exercise 9: Add only valid values

Declare an array:

```java
int[] values = {3, 0, 5, -2, 0, 7};
```

Loop through the array and add only the values that are **greater than 0**.  
Use `continue` to ignore the rest.

Print the final sum.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {3, 0, 5, -2, 0, 7};
        int sum = 0;

        for (int i = 0; i < values.length; i++) {
            if (values[i] <= 0) {
                continue;
            }

            sum += values[i];
        }

        System.out.println(sum);
    }
}
```

</details>

---

## Exercise 10: Stop when the sum exceeds a limit

Declare an array:

```java
int[] values = {10, 20, 15, 30, 5};
```

Loop through the array, adding up the values in order.  
When the sum is **greater than 40**, stop the loop with `break`.  
Print the sum reached.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {10, 20, 15, 30, 5};
        int sum = 0;

        for (int i = 0; i < values.length; i++) {
            sum += values[i];

            if (sum > 40) {
                break;
            }
        }

        System.out.println(sum);
    }
}
```

</details>

---
