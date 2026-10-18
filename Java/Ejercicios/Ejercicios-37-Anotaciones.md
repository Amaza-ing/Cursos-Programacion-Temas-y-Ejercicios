# Exercises - Topic 37: Modules and Modern Java

Below you will find **10 practical exercises** on **modules and modern Java**: `module-info.java`, `requires`, `exports`, `opens`, modular structure, compact source files, modern `switch`, text blocks, `var` and pattern matching.

Try to solve them before looking at the solution.

---

## Exercise 1: Create an empty module

Create a `module-info.java` file for a module called:

```text
com.amazaing.notes
```

Don't export any packages yet.

<details><summary>Show solution</summary>

```java
module com.amazaing.notes {
}
```

</details>

---

## Exercise 2: Export a package

Modify the `com.amazaing.notes` module to export the package:

```text
com.amazaing.notes.api
```

<details><summary>Show solution</summary>

```java
module com.amazaing.notes {
    exports com.amazaing.notes.api;
}
```

</details>

---

## Exercise 3: Require another module

Create a `module-info.java` for a module called:

```text
com.amazaing.app
```

It must require the module:

```text
com.amazaing.notes
```

<details><summary>Show solution</summary>

```java
module com.amazaing.app {
    requires com.amazaing.notes;
}
```

</details>

---

## Exercise 4: Use `requires java.sql`

Create a `module-info.java` for a module called:

```text
com.amazaing.database
```

It must declare that it needs `java.sql`.

<details><summary>Show solution</summary>

```java
module com.amazaing.database {
    requires java.sql;
}
```

</details>

---

## Exercise 5: Open a package with `opens`

Create a `module-info.java` for a module called:

```text
com.amazaing.users
```

It must open the package:

```text
com.amazaing.users.model
```

to allow reflection.

<details><summary>Show solution</summary>

```java
module com.amazaing.users {
    opens com.amazaing.users.model;
}
```

</details>

---

## Exercise 6: Write a modular structure

Write the folder structure for a module called:

```text
com.amazaing.shop
```

With a main class:

```text
com.amazaing.shop.Main
```

You don't need to write the complete code, just the structure.

<details><summary>Show solution</summary>

```text
src
└── com.amazaing.shop
    ├── module-info.java
    └── com
        └── amazaing
            └── shop
                └── Main.java
```

</details>

---

## Exercise 7: Compact source file

Write a simple program using modern Java's compact form to print:

```text
Hello modern Java
```

Do not use `public class Main`.

<details><summary>Show solution</summary>

```java
void main() {
    System.out.println("Hello modern Java");
}
```

</details>

---

## Exercise 8: Modern `switch`

Declare a variable:

```java
String role = "admin";
```

Use a modern `switch` to assign to a `message` variable:

- `"Full access"` if the role is `"admin"`
- `"Limited access"` if the role is `"user"`
- `"No access"` in any other case

Print the message.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String role = "admin";

        String message = switch (role) {
            case "admin" -> "Full access";
            case "user" -> "Limited access";
            default -> "No access";
        };

        System.out.println(message);
    }
}
```

</details>

---

## Exercise 9: Pattern matching with `instanceof`

Declare a variable:

```java
Object value = "Java";
```

Use pattern matching with `instanceof` to check whether it is a `String` and print its length.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        Object value = "Java";

        if (value instanceof String text) {
            System.out.println(text.length());
        }
    }
}
```

</details>

---

## Exercise 10: Text block for JSON

Create a `String json` using a text block with this content:

```json
{
  "name": "Laura",
  "active": true
}
```

Print the text.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String json = """
                {
                  "name": "Laura",
                  "active": true
                }
                """;

        System.out.println(json);
    }
}
```

</details>

---
