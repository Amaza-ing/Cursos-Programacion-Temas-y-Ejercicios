# Topic 12. Arrays

## 1. Introduction

So far you've worked with variables that hold **a single value**:

- An `int` stores a number
- A `double` stores a decimal
- A `String` stores text
- A `boolean` stores `true` or `false`

But in programming it is very common to need **several values of the same type**:

- A student's grades
- The prices in a shopping cart
- The attempts in a game
- The days of the week
- The scores of several players

You could create many variables:

```java
int score1 = 10;
int score2 = 15;
int score3 = 8;
```

But this doesn't scale. That's why **arrays** exist.

An **array** is a structure that lets you store **several values of the same type** in a single variable.

---

[![Arrays](https://img.youtube.com/vi/Ls_qQdv0i5k/0.jpg)](https://www.youtube.com/watch?v=Ls_qQdv0i5k&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What an array is

An array:

- Stores a collection of elements of the **same type**
- Has a fixed size (decided when you create it)
- Lets you access each element by its **index** (position)
- Always starts at index **0**

If you have an array of 5 elements, its indices are:

```
0  1  2  3  4
```

---

## 3. Declaring an array

To declare an array, use `[]` after the type:

```java
int[] scores;
```

This just declares the variable. No array has been created yet (no memory has been reserved for the elements).

---

## 4. Creating an array (reserving memory)

To create an array, you use `new` and specify the size.

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

- Arrays use `length` (without parentheses)
- `String` uses `length()` (with parentheses)

---

## 6. Indices: accessing an element

To access a position, use `[]` with the index.

```java
int[] scores = new int[5];

System.out.println(scores[0]); // primer elemento
System.out.println(scores[4]); // último elemento
```

Remember:

- First element → index 0
- Last element → index `length - 1`

---

## 7. Assigning values to an array

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

## 8. Initializing an array with values (the quick way)

Sometimes you already know the values when creating the array. In that case you can use a literal initialization:

```java
int[] scores = {10, 15, 8, 20, 12};
```

Here Java:

- Creates the array automatically
- Gives it size 5
- Puts the values in order

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
- `String` (and other objects) → `null`

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
- If the size is 3, the valid indices are 0, 1 and 2.
- Index 3 is out of range.

Rule of thumb:

- Never use an index greater than or equal to `length`.

---

### 11.2. Forgetting that it starts at 0

If you have an array of size 5:

- First index: 0
- Last index: 4

This is key to avoiding errors.

---

### 11.3. Confusing declaration with creation

This declares an array, but does NOT create it:

```java
int[] scores;
```

If you try to use it like this, you'll get a compile error because it isn't initialized.

The right thing to do is create it:

```java
int[] scores = new int[5];
```

---

## 12. Guided examples (to understand how they're really used)

### 12.1. Example: storing and displaying data

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

### 12.2. Example: updating an array value

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

### 12.3. Example: using `length` to access the last element

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

### 13.1. A method that prints the first and last elements

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

Notice that:

- The `int[] values` parameter indicates that the method receives an array of int.
- Inside the method, `values` is used like any other array.

---

### 13.2. A method that modifies an array

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

This happens because the array is an object and the method receives a reference to the same array.

---

[![Arrays and Loops](https://img.youtube.com/vi/Hcln7CzL4Dc/0.jpg)](https://www.youtube.com/watch?v=Hcln7CzL4Dc&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 14. Arrays and loops (preview)

In this topic's exercises you'll practice looping through arrays, but it's useful to understand the basic idea now.

To loop through an array of size `n`, you typically go:

- From index 0
- Up to index `length - 1`

Conceptual example:

```java
int[] numbers = {10, 20, 30};

for (int i = 0; i < numbers.length; i++) {
    System.out.println(numbers[i]);
}
```

You don't need to memorize it yet, but notice:

- The loop starts at 0
- The condition is `i < numbers.length` (not `<=`)

---

## 15. Two-dimensional arrays (introduction)

An array can also be an “array of arrays”, creating a table-like structure.

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

In beginner courses, the most important thing is to master one-dimensional arrays first.

---

## 16. Things to keep in mind

- An array stores multiple values of the same type.
- The indices start at 0.
- The size is fixed and you check it with `length`.
- They are created with `new` or with `{...}` literal initialization.
- The most common mistakes are out-of-range indices.
- Arrays are used a lot along with loops and methods.

---

In the next topic you'll learn to use **`List` and `ArrayList`**, collections that, unlike arrays, can grow and shrink, and you'll see how to loop through them.
