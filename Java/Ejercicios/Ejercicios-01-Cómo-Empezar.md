# Exercises - Topic 1: What Java is and your first program with IntelliJ

Below you will find **4 practical exercises** about your first contact with Java, the IntelliJ environment and the basic structure of a program.

Try to solve them before looking at the solution.

---

## Exercise 1: Identify the elements of a Java program

Look at the following code:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, Java!");
    }
}
```

Identify:

- The name of the class
- The name of the main method
- Which line prints text to the console

Don't modify the code, just analyze it.

<details><summary>Show solution</summary>

- The class is called `Main`.
- The main method is `main`.
- The line that prints text to the console is:

```java
System.out.println("Hello, Java!");
```

</details>

---

## Exercise 2: Change the text shown in the console

Starting from this program:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, Java!");
    }
}
```

Modify the text to display the message:

```
My first Java program
```

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("My first Java program");
    }
}
```

</details>

---

## Exercise 3: Show several messages in the console

Write a program that prints **three different lines** to the console:

- Your name
- The name of the language (`Java`)
- The message `Learning programming`

Each message must appear on a different line.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Alex");
        System.out.println("Java");
        System.out.println("Learning programming");
    }
}
```

</details>

---

## Exercise 4: Recognize basic errors

This code is not correct. Read it and answer:

```java
public class main {
    public static void Main(String args) {
        system.out.println("Hello");
    }
}
```

Point out **at least three errors** that would prevent the program from running correctly.

<details><summary>Show solution</summary>

Errors in the code:

1. The class name must begin with a capital letter: `Main`.
2. The main method must be called exactly `main` (lowercase).
3. The correct signature is `public static void main(String[] args)`.
4. `System` must be capitalized.
5. `[]` is missing from `String[] args`.

A corrected version would be:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello");
    }
}
```

</details>

---
