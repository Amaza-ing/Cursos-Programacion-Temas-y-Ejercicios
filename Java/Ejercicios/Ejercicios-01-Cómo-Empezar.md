# Exercises - Topic 1: What is Java and first program with IntelliJ

Below, you will find **4 practical exercises** related to the first contact with Java, the IntelliJ environment and the basic structure of a program.

Try to solve them before consulting the solution.

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

Indicates:

- The name of the class
- The name of the main method
- Which line shows text per console

Don't modify the code, just analyze it.

<details><summary>Show Solution</summary>

- The class is called `Main`.
- The main method is `main`.
- The line that shows text through the console is:

```java
System.out.println("Hello, Java!");
```

</details>

---

## Exercise 2: Change the text displayed by the console

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

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("My first Java program");
    }
}
```

</details>

---

## Exercise 3: Show multiple messages per console

Write a program that displays **three different lines** per console:

- Your name
- The name of the language (`Java`)
- The message `Learning programming`

Each message must appear on a different line.

<details><summary>Show Solution</summary>

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

Indicates **at least three errors** that would prevent the program from running correctly.

<details><summary>Show Solution</summary>

Code errors:

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
