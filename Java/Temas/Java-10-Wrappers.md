# Topic 10. Primitive data type wrappers

## 1. Introduction

In Java you've worked with **primitive types** such as:

- `int`, `double`, `boolean`, `char`, etc.

These types are fast and efficient, but they have an important limitation:

- **They aren't objects**, so they don't have methods and can't be used directly in some parts of the language.

To solve this, Java offers **wrappers** (wrapper classes) for the primitive types.

Wrappers let you:

- Treat primitive values as **objects**
- Use useful methods (parsing, comparisons, constants...)
- Work with collections (`List`, `Map`, etc.), which require objects
- Represent missing values with `null` (something impossible with primitives)

In this topic you will learn:

- What wrappers are and what they're for
- What **autoboxing** and **unboxing** are
- How to convert between `String` and numbers with `parseXxx` and `valueOf`
- Constants like `MAX_VALUE` and `MIN_VALUE`
- Comparing wrappers and typical mistakes

---

[![Wrappers](https://img.youtube.com/vi/T7usGsH1CdY/0.jpg)](https://www.youtube.com/watch?v=T7usGsH1CdY&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What a wrapper is

A **wrapper** is a class that “wraps” a primitive value inside an object.

Example: `Integer` wraps an `int`.

| Primitive | Wrapper |
| --------- | ----------- |
| `byte` | `Byte` |
| `short` | `Short` |
| `int` | `Integer` |
| `long` | `Long` |
| `float` | `Float` |
| `double` | `Double` |
| `boolean` | `Boolean` |
| `char` | `Character` |

They are all in `java.lang`, so you don't need to import them.

---

## 3. Why wrappers exist (when you need them)

### 3.1. Collections (they don't accept primitives)

Later you'll see collections like `List`, `Set` or `Map`. These structures store **objects**, not primitives.

For example, this is NOT valid:

```java
// List<int> numbers = new ArrayList<>(); // error
```

The correct way uses `Integer`:

```java
// List<Integer> numbers = new ArrayList<>();
```

---

### 3.2. You need `null` to represent “no value”

A primitive always has a value. For example, an `int` is always a number.

But sometimes you want to represent:

- “There is no age”
- “It has not been calculated yet”
- “Unknown data”

With primitives you can't use `null`; with wrappers you can:

```java
Integer age = null;
Double price = null;
Boolean isActive = null;
```

---

### 3.3. Useful methods

Wrappers offer methods to:

- Convert text to a number
- Convert a number to text
- Compare values
- Get the type's limits (maximums and minimums)
- Validate characters (`Character`)

---

## 4. Creating wrappers

### 4.1. Direct assignment (recommended)

```java
Integer score = 10;
Double price = 19.99;
Boolean isPremium = true;
Character initial = 'A';
```

**Autoboxing** happens here; we'll look at it shortly.

### 4.2. `valueOf(...)` (the explicit way, also widely used)

```java
Integer score = Integer.valueOf(10);
Double price = Double.valueOf(19.99);
Boolean isPremium = Boolean.valueOf(true);
```

---

## 5. Autoboxing and unboxing

### 5.1. Autoboxing

Autoboxing is when Java converts a primitive to its wrapper automatically.

```java
int number = 7;
Integer boxed = number; // autoboxing
```

### 5.2. Unboxing

Unboxing is when Java converts a wrapper to a primitive automatically.

```java
Integer boxed = 7;
int number = boxed; // unboxing
```

---

## 6. Unboxing and `null` (a common mistake)
If you try to unbox `null`, you'll get a `NullPointerException`.

Example:

```java
Integer value = null;
// int number = value; // NullPointerException
```

Safe pattern:

```java
Integer value = null;

if (value != null) {
    int number = value;
    System.out.println(number);
} else {
    System.out.println("No value");
}
```

---

## 7. Parsing: converting a `String` to a number (`parseXxx` methods)

### 7.1. `Integer.parseInt(...)`

```java
String text = "42";
int number = Integer.parseInt(text);

System.out.println(number + 1); // 43
```

### 7.2. `Double.parseDouble(...)`

```java
String text = "19.99";
double price = Double.parseDouble(text);

System.out.println(price * 2); // 39.98
```

### 7.3. `Boolean.parseBoolean(...)`

`parseBoolean` returns `true` only if the text (ignoring case) is `"true"`.

```java
System.out.println(Boolean.parseBoolean("true"));  // true
System.out.println(Boolean.parseBoolean("TRUE"));  // true
System.out.println(Boolean.parseBoolean("yes"));   // false
System.out.println(Boolean.parseBoolean("false")); // false
```

---

## 8. `valueOf(...)`: `String` to wrapper

`valueOf` returns a **wrapper**, not a primitive.

```java
String text = "42";
Integer number = Integer.valueOf(text);

System.out.println(number);
```

Quick comparison:

- `parseInt("42")` → `int`
- `valueOf("42")` → `Integer`

---

## 9. Converting a number to text

### 9.1. `String.valueOf(...)`

```java
int level = 5;
String text = String.valueOf(level);

System.out.println("Level: " + text);
```

### 9.2. `toString()` in wrappers

```java
Integer points = 100;
String text = points.toString();

System.out.println(text);
```

---

## 10. Useful constants: `MIN_VALUE` and `MAX_VALUE`

```java
System.out.println(Integer.MIN_VALUE);
System.out.println(Integer.MAX_VALUE);
```

Example with `Double`:

```java
System.out.println(Double.MIN_VALUE);
System.out.println(Double.MAX_VALUE);
```

---

## 11. Comparing wrappers

### 11.1. `equals(...)`

```java
Integer a = 100;
Integer b = 100;

System.out.println(a.equals(b)); // true
```

### 11.2. `==` (careful)

`==` on objects compares references. With wrappers it can give confusing results because of `Integer`'s internal cache.

```java
Integer a = 200;
Integer b = 200;

System.out.println(a == b); // probablemente false
```

Rule of thumb:

- For wrappers, use `equals`.
- For primitives, `==` is fine.

---

## 12. `compareTo(...)`

```java
Integer a = 10;
Integer b = 20;

System.out.println(a.compareTo(b));  // negativo
System.out.println(b.compareTo(a));  // positivo
System.out.println(a.compareTo(10)); // 0
```

---

## 13. `Character`: useful methods

```java
char c1 = '7';
System.out.println(Character.isDigit(c1)); // true

char c2 = 'A';
System.out.println(Character.isLetter(c2)); // true

char c3 = ' ';
System.out.println(Character.isWhitespace(c3)); // true
```

---

## 14. Complete guided examples

### 14.1. Checking whether a `String` is an integer before converting it

```java
public class Main {
    public static void main(String[] args) {
        String input = "120";
        boolean isNumeric = true;

        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            if (!Character.isDigit(c)) {
                isNumeric = false;
                break;
            }
        }

        if (isNumeric) {
            int value = Integer.parseInt(input);
            System.out.println("Number: " + value);
        } else {
            System.out.println("Invalid number");
        }
    }
}
```

---

### 14.2. Converting text to a number to calculate a total

```java
public class Main {
    public static void main(String[] args) {
        String unitPriceText = "19.99";
        String quantityText = "3";

        double unitPrice = Double.parseDouble(unitPriceText);
        int quantity = Integer.parseInt(quantityText);

        double total = unitPrice * quantity;

        System.out.println(String.format("Total: %.2f", total));
    }
}
```

---

### 14.3. Using `null` with wrappers

```java
public class Main {
    public static void main(String[] args) {
        Integer age = null;

        if (age == null) {
            System.out.println("Age not provided");
        } else {
            System.out.println("Age: " + age);
        }
    }
}
```

---

## 15. Things to keep in mind

- Wrappers represent primitives as objects.
- They're key for collections and for using `null` as “no value”.
- Autoboxing/unboxing simplifies the code, but be careful with `null`.
- `parseXxx` converts `String` → primitive.
- `valueOf` returns wrappers.
- To compare wrappers use `equals`, not `==`.

---

In the next topic we'll dive into **method overloading**, and you'll see how Java allows methods with the same name but different parameters.
