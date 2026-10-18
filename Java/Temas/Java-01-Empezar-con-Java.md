# Topic 1. What is Java and first program with IntelliJ

## 1. What is Java and what is it used for?

Java is a general-purpose **object-oriented programming language** designed to be **portable**, **secure** and **robust**. It was created with the idea that the same program could be run on different systems without having to modify the code.

This characteristic is summarized in the famous phrase:

> _Write once, run anywhere_

Java is used in a wide variety of contexts:

- Desktop applications
- Web applications (backend)
- Business applications
- Mobile applications (Android)
- Embedded systems

It is one of the most used languages in the professional field and very common in academic environments.

---

[![How to Get Started with Java](https://img.youtube.com/vi/8qjZQZAvwBQ/0.jpg)](https://www.youtube.com/watch?v=8qjZQZAvwBQ&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. How Java works: JVM, JDK and JRE

Java does not run directly on the operating system like other languages. Its operation is based on several layers.

### 2.1. Source code and bytecode

1. The programmer writes Java code (`.java`).
2. The Java compiler transforms that code into **bytecode** (`.class`).
3. The bytecode is executed in the **Java Virtual Machine (JVM)**.

Thanks to this, the same bytecode can be executed on different systems.

---

### 2.2. JVM (Java Virtual Machine)

The JVM is a **virtual machine** that interprets the bytecode and executes it.

- There is a JVM for each operating system.
- The programmer does not interact directly with it.
- Ensures the portability of Java code.

---

### 23. JDK (Java Development Kit)

The JDK is the Java development kit. Includes:

- Compiler (`javac`)
-JVM
- Standard libraries
- Development tools

To program in Java **you always need the JDK**.

---

## 3. IntelliJ IDEA and Java 25

IntelliJ IDEA is one of the most used development environments for programming in Java.

Main advantages:

- Smart autocomplete
- Real-time error detection
- Direct integration with the JDK
- Widely used in the professional field

In this course we will work with **Java 25** using IntelliJ IDEA.

---

## 4. Create the first project in IntelliJ

1. Open IntelliJ IDEA.
2. Select **New Project**.
3. Choose **Java** as the project type.
4. Select **JDK 25**.
5. Choose a name for the project.
6. Finish.

IntelliJ will automatically create the basic structure of the project.

---

## 5. Basic structure of a Java project

A simple Java project usually has this structure:

```
project-name/
│── src/
│   └── Main.java
```

- `src` contains the source code.
- `Main.java` is the entry point of the program.

---

## 6. First program in Java

### 6.1. The `Main` class

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, Java!");
    }
}
```

Let's understand this code step by step.

---

### 6.2. Code explanation

- `public class Main`: defines a class called `Main`.
- `public static void main(String[] args)`: main method.
- `System.out.println`: display text per console.
- `"Hello, Java!"`: text that is printed.

The `main` method is the **starting point** of any Java program.

---

## 7. Run the program

To run the program in IntelliJ:

- Click the **Run** button.
- Or use the corresponding keyboard shortcut.

The console will appear:

```
Hello, Java!
```

This confirms that the program ran successfully.

---

## 8. To take into account

- Java is a compiled and interpreted language.
- All code lives inside **classes**.
- The `main` method is required to get started.
- IntelliJ greatly facilitates the work from the first moment.

---

In the next topic we will start working with **variables and data types**, the basis for starting to write useful programs in Java.
