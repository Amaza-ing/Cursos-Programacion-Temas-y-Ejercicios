# Topic 9. `String` methods

## 1. Introduction

In Java, `String` is the most important type for working with text. You will use it constantly:

- Usernames
- Console messages
- Data read from keyboard
- File paths
- Validations
- Formatting results

Although `String` is “used as a base type”, it is actually **an object** and therefore has many useful methods.

In this topic you will learn:

- What does it mean for `String` to be **immutable**
- Essential methods for measuring, comparing and searching text
- Methods for extracting parts (`substring`) and accessing characters (`charAt`)
- Typical transformations (`toLowerCase`, `strip`, `replace`…)
- Methods for splitting and joining text (`split`, `String.join`)
- Good practices and common mistakes (`==` vs `equals`, `null`, etc.)

---

[![String Methods](https://img.youtube.com/vi/y0D-t8WII6U/0.jpg)](https://www.youtube.com/watch?v=y0D-t8WII6U&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. `String` is immutable (key idea)

In Java, `String`s are **immutable**: you cannot change the contents of an existing `String`.  
When you “modify” an `String`, you are actually creating **a new one**.

Example:

```java
String text = "Hello";
text.toUpperCase();

System.out.println(text); // "Hello"
```

Why? Because `toUpperCase()` returns a new `String`, but you didn't save it.

Correct way:

```java
String text = "Hello";
text = text.toUpperCase();

System.out.println(text); // "HELLO"
```

---

## 3. Length: `length()`

`length()` returns the number of characters in an `String`.

```java
String userName = "Laura";
int size = userName.length();

System.out.println(size); // 5
```

This is very common in validations:

```java
String password = "mySecret1";
boolean isLongEnough = password.length() >= 8;

System.out.println(isLongEnough);
```

---

## 4. Character access: `charAt(index)`

`charAt(int index)` returns the character at the indicated position.

```java
String code = "A7X";
char first = code.charAt(0);
char last = code.charAt(2);

System.out.println(first); // 'A'
System.out.println(last);  // 'X'
```

Remember: indices start at 0.

### 4.1. Typical error: index out of range

```java
String text = "Hi";
char letter = text.charAt(2); // error
```

Valid indices are 0 and 1.

---

## 5. Extract parts: `substring(beginIndex)` and `substring(beginIndex, endIndex)`

`substring` is used to obtain a part of the text.

### 5.1. `substring(beginIndex)`

Returns from `beginIndex` to the end.

```java
String text = "JavaProgramming";
String part = text.substring(4);

System.out.println(part); // "Programming"
```

### 5.2. `substring(beginIndex, endIndex)`

Returns `beginIndex` through `endIndex`, but **not including** `endIndex`.

```java
String text = "JavaProgramming";
String part = text.substring(0, 4);

System.out.println(part); // "Java"
```

Rule of thumb:

- `beginIndex` included
- `endIndex` excluded

---

## 6. Compare `String`: `equals(...)` and `equalsIgnoreCase(...)`

### 6.1. Why NOT use `==`

`==` compares references (if they are the same object), not the content.

```java
String a = "admin";
String b = "admin";

System.out.println(a == b); // puede ser true o false dependiendo del caso
```

The correct content is `equals`:

```java
String a = "admin";
String b = "admin";

System.out.println(a.equals(b)); // true
```

### 6.2. Case-insensitive comparison: `equalsIgnoreCase`

```java
String input = "Admin";

boolean isAdmin = input.equalsIgnoreCase("admin");
System.out.println(isAdmin); // true
```

---

## 7. Alphabetical comparison: `compareTo(...)`

`compareTo` compares two `String` in “alphabetical” order (lexicographic order).

- Returns 0 if they are equal
- Returns a negative number if the first one “comes first”
- Returns a positive number if the first “comes after”

```java
String a = "apple";
String b = "banana";

System.out.println(a.compareTo(b)); // negativo
System.out.println(b.compareTo(a)); // positivo
System.out.println(a.compareTo("apple")); // 0
```

---

## 8. Search text within text

### 8.1. `contains(...)`

Returns `true` if the text contains a substring.

```java
String email = "laura@example.com";
boolean hasAt = email.contains("@");

System.out.println(hasAt); // true
```

### 8.2. `startsWith(...)` and `endsWith(...)`

```java
String fileName = "report_2026.pdf";

System.out.println(fileName.startsWith("report_")); // true
System.out.println(fileName.endsWith(".pdf"));      // true
```

---

## 9. Find positions: `indexOf(...)` and `lastIndexOf(...)`

### 9.1. `indexOf(...)`

Returns the index of the first occurrence. If not found, returns `-1`.
```java
String text = "Java is Java";
int first = text.indexOf("Java");

System.out.println(first); // 0
```

### 9.2. Search from an index

```java
String text = "Java is Java";
int second = text.indexOf("Java", 1);

System.out.println(second); // 8
```

### 9.3. `lastIndexOf(...)`

Returns the index of the last occurrence.

```java
String text = "Java is Java";
int last = text.lastIndexOf("Java");

System.out.println(last); // 8
```

---

## 10. Replace text: `replace(...)`, `replaceAll(...)`, `replaceFirst(...)`

### 10.1. `replace(old, new)` (simple)

```java
String text = "Hello world";
String updated = text.replace("world", "Java");

System.out.println(updated); // "Hello Java"
```

### 10.2. Replace characters

```java
String phone = "123-456-789";
String cleaned = phone.replace("-", "");

System.out.println(cleaned); // "123456789"
```

### 10.3. `replaceAll(...)` (uses regular expressions)

`replaceAll` works with patterns (regex). Use it if you need it, but if you're just replacing literal text, `replace` is usually better.

Example: removing multiple spaces (regex):

```java
String text = "Hello   Java   25";
String normalized = text.replaceAll("\\s+", " ");

System.out.println(normalized); // "Hello Java 25"
```

---

## 11. Case sensitive: `toUpperCase()` and `toLowerCase()`

```java
String country = "Es";
System.out.println(country.toUpperCase()); // "ES"
System.out.println(country.toLowerCase()); // "es"
```

This is used a lot before comparing inputs:

```java
String input = "YES";
boolean isYes = input.toLowerCase().equals("yes");

System.out.println(isYes);
```

---

## 12. Remove spaces: `trim()` and `strip()`

### 12.1. `trim()`

Eliminate “simple” spaces at the beginning and end.

```java
String raw = "   hello   ";
String clean = raw.trim();

System.out.println(clean); // "hello"
```

### 12.2. `strip()`

`strip()` is more modern and handles certain types of Unicode spaces better.

```java
String raw = "   hello   ";
String clean = raw.strip();

System.out.println(clean); // "hello"
```

---

## 13. Empty vs blank: `isEmpty()` and `isBlank()`

- `isEmpty()` is `true` if the length is 0 (`""`).
- `isBlank()` is `true` if it is empty or has only spaces.

```java
String a = "";
String b = "   ";

System.out.println(a.isEmpty()); // true
System.out.println(b.isEmpty()); // false

System.out.println(a.isBlank()); // true
System.out.println(b.isBlank()); // true
```

---

## 14. Split text: `split(...)`

`split` separates a text into parts and returns an array of `String`.

```java
String line = "Laura,28,Madrid";
String[] parts = line.split(",");

System.out.println(parts[0]); // "Laura"
System.out.println(parts[1]); // "28"
System.out.println(parts[2]); // "Madrid"
```

### 14.1. Beware: `split` uses regex

If you divide by a point `.` you have to escape it:

```java
String domain = "example.com";
String[] parts = domain.split("\\.");

System.out.println(parts[0]); // "example"
System.out.println(parts[1]); // "com"
```

---

## 15. Join text: `String.join(...)`

```java
String result = String.join(" - ", "Java", "IntelliJ", "JDK");
System.out.println(result); // "Java - IntelliJ - JDK"
```

---

## 16. Format text: `String.format(...)`

```java
String userName = "Laura";
int age = 28;

String message = String.format("User: %s | Age: %d", userName, age);
System.out.println(message);
```

Example with decimals:

```java
double price = 19.99;
String text = String.format("Price: %.2f", price);

System.out.println(text); // "Price: 19.99"
```

---

## 17. Convert to `String`: `String.valueOf(...)`

```java
int level = 5;
String text = String.valueOf(level);

System.out.println("Level: " + text);
```

---

## 18. Repeat text: `repeat(n)`

```java
String dash = "-";
System.out.println(dash.repeat(10)); // "----------"
```

---

## 19. `String` and special characters (escapes)

- `\n` line break
- `\t` tab
- `\"` double quote
- `\\` backslash

```java
String text = "Line 1\nLine 2";
System.out.println(text);
```

---

## 20. `null` and `String`: how to avoid errors

Secure pattern with verification:

```java
String name = null;

if (name != null && !name.isBlank()) {
    System.out.println(name.length());
}
```

Risk-free comparison:

```java
String role = null;

boolean isAdmin = "admin".equals(role);
System.out.println(isAdmin);
```

---

## 21. `+` vs `StringBuilder` (Preview)

For repeated concatenations, `StringBuilder` is usually better:

```java
StringBuilder builder = new StringBuilder();
builder.append("User: ");
builder.append("Laura");

String message = builder.toString();
System.out.println(message);
```

---

## 22. Complete Guided Examples

### 22.1. Normalize user input

```java
public class Main {
    public static void main(String[] args) {
        String input = "   StArT   ";

        String normalized = input.strip().toLowerCase();

        if (normalized.equals("start")) {
            System.out.println("Starting...");
        } else {
            System.out.println("Unknown command");
        }
    }
}
```

---

### 22.2. Extract extension from a file

```java
public class Main {
    public static void main(String[] args) {
        String fileName = "report_2026.pdf";

        int dotIndex = fileName.lastIndexOf(".");

        if (dotIndex == -1) {
            System.out.println("No extension");
        } else {
            String extension = fileName.substring(dotIndex + 1);
            System.out.println(extension);
        }
    }
}
```

---

### 22.3. Convert a CSV line to variables

```java
public class Main {
    public static void main(String[] args) {
        String line = "Laura,28,19.99";

        String[] parts = line.split(",");

        String userName = parts[0];
        int age = Integer.parseInt(parts[1]);
        double price = Double.parseDouble(parts[2]);

        String message = String.format("User: %s | Age: %d | Price: %.2f", userName, age, price);
        System.out.println(message);
    }
}
```

---

## 23. To take into account

- The `String` are immutable: save the result of the methods if you want to “modify” the text.
- To compare content use `equals` (and `equalsIgnoreCase` if applicable).
- `substring`, `indexOf` and `split` are essential for text processing.
- `strip/trim`, `isBlank/isEmpty` are key in validations.
- Avoid `NullPointerException` by checking `null` or comparing with `"literal".equals(variable)`.

---

In the next topic we will learn about **Primitive type Wrappers**, and you will see what advantages they have over using basic types.
