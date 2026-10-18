# Topic 12. Arrays

## 1. Introduction

Until now you have worked with variables that hold **a single value**:

- An `int` stores a number
- An `double` stores a decimal
- An `String` saves a text
- An `boolean` stores `true` or `false`

But in programming it is very common to need **several values of the same type**:

- A student's notes
- The prices of a cart
- The attempts of a game
- The days of the week
- Multiplayer scores

You could create many variables:

```java
int score1 = 10;
int score2 = 15;
int score3 = 8;
```

But this doesn't scale. That's why **arrays** exist.

An **array** is a structure that allows storing **several values ​​of the same type** within a single variable.

---

[![Arrays](https://img.youtube.com/vi/Ls_qQdv0i5k/0.jpg)](https://www.youtube.com/watch?v=Ls_qQdv0i5k&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is an array

An array:

- Saves a collection of items of the **same type**
- It has a fixed size (decided when creating it)
- Allows access to each element by its **index** (position)
- Always starts at index **0**

If you have an array of 5 elements, its indexes are:

```
0  1  2  3  4
```

---

## 3. Declare an array

To declare an array, use `[]` after the type:

```java
int[] scores;
```

This just declares the variable. There is still no array created (there is no memory reserved for the elements).

---

## 4. Create an array (reserve memory)

To create an array, `new` is used and the size is indicated.

```java
int[] scores = new int[5];
```

Here:

- An array of `int` is created
- With size 5
- All elements are initialized with the default value of `int`, which is `0`

---

## 5. Array size: `length`

Arrays have a property called `length` that indicates how many elements they have.

```java
int[] scores = new int[5];
System.out.println(scores.length); // 5
```

Important:

- In arrays `length` is used (without parentheses)
- In `String` `length()` is used (with parentheses)

---

## 6. Indexes: access an element

To access a position, use `[]` with the index.

```java
int[] scores = new int[5];

System.out.println(scores[0]); // primer elemento
System.out.println(scores[4]); // último elemento
```

Remember:

- First element → index 0
- Last item → index `length - 1`

---

## 7. Assign values to an array

You can assign values to specific positions using the index.

```java
int[] scores = new int[5];

scores[0] = 10;
scores[1] = 15;
scores[2] = 8;
scores[3] = 20;
scores[4] = 12;

System.out.println(scores[3]); // 20
```

---

## 8. Initialize an array with values (quick way)

Sometimes you already know the values when creating the array. In that case you can use a literal initialization:

```java
int[] scores = {10, 15, 8, 20, 12};
```

Here Java:

- Create the array automatically
- Assigns size 5
- Put the values in order

---

## 9. Arrays of other types

### 9.1. `double[]`

```java
double[] prices = {19.99, 5.50, 12.00};
```

### 9.2. `boolean[]`

```java
boolean[] answers = {true, false, true, true};
```

### 9.3. `String[]`

```java
String[] names = {"Laura", "Alex", "Sara"};
```

---

## 10. Default values in arrays

When you create an array with `new`, Java automatically initializes its elements:

- `int` → 0
- `double` → 0.0
- `boolean` → false
- `char` → '\u0000' (“empty” character)
- `String` (and other items) → `null`

Example:

```java
String[] names = new String[3];

System.out.println(names[0]); // null
```

`null` means “no object” or “no value assigned”.

---

## 11. Common mistakes with arrays

### 11.1. `ArrayIndexOutOfBoundsException` (index out of range)

This is the most typical error:

```java
int[] scores = new int[3];
scores[3] = 10; // error
```

Why?
- If size is 3, valid indices are 0, 1 and 2.
- Index 3 is out of range.

Rule of thumb:

- Never use an index greater than or equal to `length`.

---

### 11.2. Forget that it starts at 0

If you have an array of 5:

- First index: 0
- Last index: 4

This is key to avoid errors.

---

### 11.3. Confuse declaration with creation

This declares an array, but does NOT create it:

```java
int[] scores;
```

If you try to use it like this, it will give a compile error because it is not initialized.

The correct thing is to create it:

```java
int[] scores = new int[5];
```

---

## 12. Guided Examples (to understand actual usage)

### 12.1. Example: save and display data

```java
public class Main {
    public static void main(String[] args) {
        String[] cities = {"Madrid", "Berlin", "Paris"};

        System.out.println(cities[0]);
        System.out.println(cities[1]);
        System.out.println(cities[2]);
    }
}
```

---

### 12.2. Example: update an array value

```java
public class Main {
    public static void main(String[] args) {
        int[] scores = {10, 15, 8};

        scores[1] = 20;

        System.out.println(scores[0]); // 10
        System.out.println(scores[1]); // 20
        System.out.println(scores[2]); // 8
    }
}
```

---

### 12.3. Example: Use `length` to access the last item

```java
public class Main {
    public static void main(String[] args) {
        int[] numbers = {3, 9, 12, 7};

        int lastIndex = numbers.length - 1;
        System.out.println(numbers[lastIndex]);
    }
}
```

---

## 13. Arrays and methods

It is very common to pass arrays to methods to process them.

### 13.1. Method that prints the first and last element

```java
public class Main {
    public static void main(String[] args) {
        int[] numbers = {4, 8, 15, 16, 23, 42};
        printFirstAndLast(numbers);
    }

    public static void printFirstAndLast(int[] values) {
        int first = values[0];
        int last = values[values.length - 1];

        System.out.println("First: " + first);
        System.out.println("Last: " + last);
    }
}
```

Look at:

- The `int[] values` parameter indicates that the method receives an array of int.
- Within the method, `values` is used the same as any array.

---

### 13.2. Method that modifies an array

In Java, when you pass an array to a method, the method can modify its contents.

```java
public class Main {
    public static void main(String[] args) {
        int[] scores = {10, 20, 30};

        increaseFirst(scores);

        System.out.println(scores[0]); // 11
    }

    public static void increaseFirst(int[] values) {
        values[0] = values[0] + 1;
    }
}
```

This occurs because the array is an object and the method receives a reference to the same array.

---

[![Arrays and Loops](https://img.youtube.com/vi/Hcln7CzL4Dc/0.jpg)](https://www.youtube.com/watch?v=Hcln7CzL4Dc&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 14. Arrays and loops (preview)

In the next topic you will see the traversal of arrays with loops, but it is useful to already understand the basic idea.

To loop through an array of size `n`, you typically do:

- From index 0
- Up to index `length - 1`

Conceptual example:

```java
int[] numbers = {10, 20, 30};

for (int i = 0; i < numbers.length; i++) {
    System.out.println(numbers[i]);
}
```

You don't need to memorize it yet, but look at:

- The loop starts at 0
- Condition is `i < numbers.length` (not `<=`)

---

## 15. Two-dimensional arrays (introduction)

An array can also be “of arrays”, creating a structure in the form of a table.

Example of a 2x3 matrix (2 rows, 3 columns):

```java
int[][] grid = new int[2][3];
```

Access:

- `grid[0][0]` → first row, first column
- `grid[1][2]` → second row, third column

Quick initialization:

```java
int[][] grid = {
    {1, 2, 3},
    {4, 5, 6}
};
```

In initial courses, the most important thing is to first master one-dimensional arrays.

---

## 16. To take into account

- An array stores multiple values of the same type.
- The indices start at 0.
- The size is fixed and is consulted with `length`.
- They are created with `new` or with `{...}` literal initialization.
- The most common errors are indexes out of range.
- Arrays are used a lot along with loops and methods.

---

In the next topic you will learn to **loop through arrays**, and to read/modify their values efficiently.
