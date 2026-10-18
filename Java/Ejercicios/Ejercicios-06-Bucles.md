# Exercises - Topic 6: Loops (while and for)

Below you will find **10 practical exercises** on using `while`, `do-while` and `for` loops.

Try to solve them before consulting the solution.

---

## Exercise 1: Count from 1 to 10 with `while`

Write a program that displays the numbers **1 to 10** on the console using an `while` loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int i = 1;

        while (i <= 10) {
            System.out.println(i);
            i++;
        }
    }
}
```

</details>

---

## Exercise 2: Count from 10 to 1 with `for`

Display the numbers **10 to 1** via console using an `for` loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 10; i >= 1; i--) {
            System.out.println(i);
        }
    }
}
```

</details>

---

## Exercise 3: Show only even numbers

Use an `for` loop to display the **even numbers from 1 to 20** on the console.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 20; i++) {
            if (i % 2 == 0) {
                System.out.println(i);
            }
        }
    }
}
```

</details>

---

## Exercise 4: Add numbers from 1 to 100

Calculates the **sum of numbers 1 to 100** using a loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int sum = 0;

        for (int i = 1; i <= 100; i++) {
            sum += i;
        }

        System.out.println(sum);
    }
}
```

</details>

---

## Exercise 5: Count how many multiples of 3 there are between 1 and 50

Use a loop to count how many numbers between **1 and 50** are multiples of 3.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int count = 0;

        for (int i = 1; i <= 50; i++) {
            if (i % 3 == 0) {
                count++;
            }
        }

        System.out.println(count);
    }
}
```

</details>

---

## Exercise 6: Repeat a message 5 times with `do-while`

Displays the message `"Learning Java"` **5 times** using an `do-while` loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int i = 0;

        do {
            System.out.println("Learning Java");
            i++;
        } while (i < 5);
    }
}
```

</details>

---

## Exercise 7: Calculate the factorial of a number

Declare a variable `number` with value `5` and calculate its **factorial** using a loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int number = 5;
        int result = 1;

        for (int i = 1; i <= number; i++) {
            result *= i;
        }

        System.out.println(result);
    }
}
```

</details>

---

## Exercise 8: Add only the odd numbers from 1 to 20

Use a loop to add only the **odd numbers** between 1 and 20.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int sum = 0;

        for (int i = 1; i <= 20; i++) {
            if (i % 2 != 0) {
                sum += i;
            }
        }

        System.out.println(sum);
    }
}
```

</details>

---

## Exercise 9: Count characters in a string

Declare a variable `text` with the value `"Java"` and use a loop to count how many characters it has.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String text = "Java";
        int count = 0;

        for (int i = 0; i < text.length(); i++) {
            count++;
        }

        System.out.println(count);
    }
}
```

</details>

---

## Exercise 10: Simulate attempts until a value is reached

Declare an `progress` variable starting with `0`.  
In each iteration its value increases by `15` until it reaches or exceeds `100`.  
Shows how many attempts were necessary.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int progress = 0;
        int attempts = 0;

        while (progress < 100) {
            progress += 15;
            attempts++;
        }

        System.out.println("Attempts: " + attempts);
    }
}
```

</details>

---
