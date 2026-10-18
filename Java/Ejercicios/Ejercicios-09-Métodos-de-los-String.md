# Exercises - Topic 9: `String` Methods

Below you will find **10 practical exercises** to work with the most used methods of `String` (`length`, `charAt`, `substring`, `equals`, `contains`, `indexOf`, `replace`, `strip/trim`, `split`, `String.format`, etc.).

Try to solve them before consulting the solution.

---

## Exercise 1: Length and first letter

Declare a variable `text` with value `"Programming"`.

- Print the length of the string
- Print the first character

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String text = "Programming";

        System.out.println(text.length());
        System.out.println(text.charAt(0));
    }
}
```

</details>

---

## Exercise 2: Get the first 3 letters

Declares a variable `word` with value `"IntelliJ"`.

Use `substring` to get `"Int"` and show it in the console.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String word = "IntelliJ";

        String result = word.substring(0, 3);
        System.out.println(result);
    }
}
```

</details>

---

## Exercise 3: Case-insensitive comparison

Declares a variable `input` with value `"YeS"`.

Checks whether the value means `"yes"`, ignoring case, and prints the result.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String input = "YeS";

        boolean isYes = input.equalsIgnoreCase("yes");
        System.out.println(isYes);
    }
}
```

</details>

---

## Exercise 4: Remove spaces and validate

Declare a variable `rawName` with value `"   Laura   "`.

- Eliminates spaces on the sides
- Check if the result is NOT empty
- Print the name clean

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String rawName = "   Laura   ";

        String cleanName = rawName.strip();

        if (!cleanName.isEmpty()) {
            System.out.println(cleanName);
        }
    }
}
```

</details>

---

## Exercise 5: Check if an email contains `@` and ends in `.com`

Declare a variable `email` with value `"user@example.com"`.

Create a variable `isValid` that is `true` if:

- Contains `@`
- Ends in `.com`

Print `isValid`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String email = "user@example.com";

        boolean isValid = email.contains("@") && email.endsWith(".com");
        System.out.println(isValid);
    }
}
```

</details>

---

## Exercise 6: Finding the position of a character

Declare a variable `fileName` with value `"report_2026.pdf"`.

Use `indexOf` to find the position of the first underscore (`_`) and print it.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String fileName = "report_2026.pdf";

        int index = fileName.indexOf("_");
        System.out.println(index);
    }
}
```

</details>

---

## Exercise 7: Extract the extension of a file

Declare `fileName` with value `"photo.backup.png"`.

Extract the extension using `lastIndexOf` and `substring` and print it.

Expected output:

```
png
```

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String fileName = "photo.backup.png";

        int dotIndex = fileName.lastIndexOf(".");

        String extension = fileName.substring(dotIndex + 1);
        System.out.println(extension);
    }
}
```

</details>

---

## Exercise 8: Replace text

Declares a variable `sentence` with value `"Java is hard"`.

Replace `"hard"` with `"powerful"` and print the result.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String sentence = "Java is hard";

        String updated = sentence.replace("hard", "powerful");
        System.out.println(updated);
    }
}
```

</details>

---

## Exercise 9: Split a CSV String

Declares a variable `line` with value `"Laura;28;Madrid"`.

- Split the chain by `;`
- Print each part on a different line

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String line = "Laura;28;Madrid";

        String[] parts = line.split(";");

        System.out.println(parts[0]);
        System.out.println(parts[1]);
        System.out.println(parts[2]);
    }
}
```

</details>

---

## Exercise 10: Format a message with `String.format`

Declares:
- `product` with `"Mouse"` value
- `unitPrice` with `12.5` value
- `quantity` with `3` value

Calculates the total and displays text formatted with two decimal places using `String.format`, for example:

```
Product: Mouse | Total: 37.50
```

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String product = "Mouse";
        double unitPrice = 12.5;
        int quantity = 3;

        double total = unitPrice * quantity;

        String message = String.format("Product: %s | Total: %.2f", product, total);
        System.out.println(message);
    }
}
```

</details>

---
