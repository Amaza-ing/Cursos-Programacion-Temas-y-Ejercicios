# Exercises - Topic 12: Arrays

Below you will find **10 practical exercises** for working with **arrays**: creating them, accessing elements by index, modifying them, `length` and looping through them.

Try to solve them before looking at the solution.

---

## Exercise 1: Create an array and show its size

Create an `int[] numbers` array of size `5`.  
Print the value of `numbers.length`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] numbers = new int[5];
        System.out.println(numbers.length);
    }
}
```

</details>

---

## Exercise 2: Literal initialization and element access

Create a `String[] colors` array with these values:

- `"Blue"`, `"Orange"`, `"Purple"`

Print the first and last elements.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String[] colors = {"Blue", "Orange", "Purple"};

        System.out.println(colors[0]);
        System.out.println(colors[colors.length - 1]);
    }
}
```

</details>

---

## Exercise 3: Modify an array element

Create an `int[] scores` array with the values `{10, 20, 30, 40}`.

Change the value at the second position (index 1) to `25` and print the entire array using a loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] scores = {10, 20, 30, 40};

        scores[1] = 25;

        for (int i = 0; i < scores.length; i++) {
            System.out.println(scores[i]);
        }
    }
}
```

</details>

---

## Exercise 4: Add up all the elements of an array

Declare `int[] values = {3, 6, 2, 9}` and calculate the total sum with a loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {3, 6, 2, 9};
        int sum = 0;

        for (int i = 0; i < values.length; i++) {
            sum += values[i];
        }

        System.out.println(sum);
    }
}
```

</details>

---

## Exercise 5: Find the maximum value

Declare `int[] values = {7, 3, 11, 2, 9}`.

Find the maximum value using a loop and display the result.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {7, 3, 11, 2, 9};

        int max = values[0];

        for (int i = 1; i < values.length; i++) {
            if (values[i] > max) {
                max = values[i];
            }
        }

        System.out.println(max);
    }
}
```

</details>

---

## Exercise 6: Count values greater than a number

Declare `int[] values = {5, 12, 3, 18, 9}` and count how many values are greater than `10`.

Print the final counter.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {5, 12, 3, 18, 9};
        int count = 0;

        for (int i = 0; i < values.length; i++) {
            if (values[i] > 10) {
                count++;
            }
        }

        System.out.println(count);
    }
}
```

</details>

---

## Exercise 7: Create an array and fill it with a pattern

Create an `int[] numbers` array of size `6`.

Fill it with the values:

```
2, 4, 6, 8, 10, 12
```

Print all values with a loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] numbers = new int[6];

        for (int i = 0; i < numbers.length; i++) {
            numbers[i] = (i + 1) * 2;
        }

        for (int i = 0; i < numbers.length; i++) {
            System.out.println(numbers[i]);
        }
    }
}
```

</details>

---

## Exercise 8: Search for a value and stop when you find it

Declare `int[] values = {4, 8, 15, 16, 23, 42}` and a variable `target` with value `16`.

Loop through the array and when you find the value, print `"Found"` and stop the loop.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {4, 8, 15, 16, 23, 42};
        int target = 16;

        for (int i = 0; i < values.length; i++) {
            if (values[i] == target) {
                System.out.println("Found");
                break;
            }
        }
    }
}
```

</details>

---

## Exercise 9: Method that receives an array

Create a method `printFirstAndLast` that receives `int[] values` and prints:

- The first element
- The last element

Call the method from `main` with an example array.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {10, 20, 30, 40};
        printFirstAndLast(values);
    }

    public static void printFirstAndLast(int[] values) {
        int first = values[0];
        int last = values[values.length - 1];

        System.out.println(first);
        System.out.println(last);
    }
}
```

</details>

---

## Exercise 10: Copy values to another array

Declare `int[] source = {2, 4, 6, 8}` and create an `int[] copy` array of the same size.

Copy all the values from `source` to `copy` using a loop.

Print `copy` to check it.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] source = {2, 4, 6, 8};
        int[] copy = new int[source.length];

        for (int i = 0; i < source.length; i++) {
            copy[i] = source[i];
        }

        for (int i = 0; i < copy.length; i++) {
            System.out.println(copy[i]);
        }
    }
}
```

</details>

---
