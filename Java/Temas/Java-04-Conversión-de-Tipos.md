# Topic 4. Type conversion

## 1. Introduction

In Java, **every variable has a type**, and that type determines:

- What values it can store
- What operations you can do with it
- How that value is interpreted in memory

As you program, you'll run into typical situations such as:

- You want to store an `int` inside a `double`
- You are dividing whole numbers and need decimals
- You are reading data as text (`String`) and need to convert it to a number
- You are mixing `char`, `int` and `double` in the same expression

To solve all that you need to master **type conversion**.

In this topic you will learn:

- What **implicit conversion** is (widening)
- What **explicit conversion** or **casting** is (narrowing)
- Which mistakes are the most common
- How to convert between `String` and numeric types (used a lot with console input)

---

[![Data Type Conversion](https://img.youtube.com/vi/AHVLPDTGGqc/0.jpg)](https://www.youtube.com/watch?v=AHVLPDTGGqc&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. Key idea: converting means “changing the way a value is interpreted”

When you convert types, you don't “change” some magic value of the universe, but rather how Java interprets and handles it.

Quick example:

- An `int` stores integers.
- A `double` stores numbers with decimals.

If you convert an `int` to a `double`, the number stays the same, but now it can hold decimals.

---

## 3. Implicit conversion (widening conversion)

**Implicit conversion** happens when Java can convert a value **without risk of losing information**.

This usually happens when you go from a “smaller” type to a “larger” type, for example:

- `int` -> `double`
- `byte` -> `int`
- `char` -> `int`
- `int` -> `long`

### 3.1. A simple mental table (from smallest to largest capacity)

A practical way to remember it:

```
byte -> short -> int -> long -> float -> double
```

> Note: `char` is a case of its own, but it can be converted to `int` because internally it's a number (its Unicode code).

---

### 3.2. Example: `int` to `double`

```java
int number = 7;
double result = number;

System.out.println(result); // 7.0
```

Here Java automatically converts `7` to `7.0`.

---

### 3.3. Example: mixing types in expressions

When you mix types in an operation, Java often “promotes” the type to a larger one so it can perform the operation.

```java
int a = 5;
double b = 2.0;

double total = a + b;
System.out.println(total); // 7.0
```

- `a` (int) is implicitly converted to `double`
- the result is `double`

---

### 3.4. Example: `char` to `int` (Unicode code)

```java
char letter = 'A';
int code = letter;

System.out.println(code); // 65
```

`'A'` is converted to the number that represents that character in Unicode.

Another example:

```java
char letter = 'ñ';
int code = letter;

System.out.println(code);
```

This prints the number associated with that character.

---

## 4. Explicit conversion (casting / narrowing conversion)

**Explicit conversion** is necessary when there is **risk of losing information**.

This happens when you go from a type with more capacity to one with less, for example:

- `double` -> `int`
- `long` -> `int`
- `int` -> `short`

In these cases, Java forces you to indicate that you **accept the risk**, using a _cast_.
### 4.1. Casting syntax

```java
targetType newValue = (targetType) oldValue;
```

---

### 4.2. Example: `double` to `int` (the decimal part is lost)

```java
double price = 19.99;
int intPrice = (int) price;

System.out.println(intPrice); // 19
```

Important:

- This **does not round**, it simply **cuts** (truncates) the decimal part.

---

### 4.3. Example: `long` to `int` (possible loss due to size)

```java
long bigNumber = 3_000_000_000L;
int smallNumber = (int) bigNumber;

System.out.println(smallNumber);
```

Something very dangerous can happen here: the result will **not be correct**, because `int` cannot represent that value.

This is a typical example of why casting can be dangerous.

---

### 4.4. Example: `int` to `byte` (loss due to range)

`byte` can only store values between **-128 and 127**.

```java
int value = 130;
byte smallValue = (byte) value;

System.out.println(smallValue);
```

The result may be unexpected (due to overflow).

> Rule of thumb: if you cast to small types, make sure the value fits in that type.

---

## 5. The most important case: integer division

This is probably the most common mistake when you're starting out.

### 5.1. Dividing two `int` values gives an `int`

```java
int a = 5;
int b = 2;

int result = a / b;
System.out.println(result); // 2
```

Why? Because when dividing two integers, Java produces an integer, and discards the decimal part.

---

### 5.2. Solution: convert before dividing

You can convert one of the operands to `double`:

```java
int a = 5;
int b = 2;

double result = (double) a / b;
System.out.println(result); // 2.5
```

This would also work:

```java
double result = a / 2.0;
System.out.println(result); // 2.5
```

---

### 5.3. Practical example: calculating an average

If you do this, you'll get it wrong:

```java
int total = 7;
int count = 2;

double average = total / count;
System.out.println(average); // 3.0 (incorrecto)
```

The division is done as `int` before the result is stored.

The correct way:

```java
int total = 7;
int count = 2;

double average = (double) total / count;
System.out.println(average); // 3.5
```

---

## 6. Conversion between `String` and numeric types

Although you'll use this even more in the console input topic, it's essential to understand it here because it's a very common conversion in Java.

### 6.1. Converting `String` to `int`

```java
String text = "42";
int number = Integer.parseInt(text);

System.out.println(number + 1); // 43
```

If `text` does not contain a valid number, Java will throw an error (exception).

Problematic example:

```java
String text = "42a";
int number = Integer.parseInt(text); // error
```

---

### 6.2. Converting `String` to `double`

```java
String text = "19.99";
double price = Double.parseDouble(text);

System.out.println(price);
```

Be careful with this: in Java, the decimal separator is `.` (period), not a comma.

This would fail:

```java
String text = "19,99";
double price = Double.parseDouble(text); // error
```

---

### 6.3. Converting numbers to `String`

A very common way is to use `String.valueOf(...)`:

```java
int age = 30;
String ageText = String.valueOf(age);

System.out.println(ageText);
```

You can also concatenate with an empty string:

```java
int age = 30;
String ageText = age + "";

System.out.println(ageText);
```

> Recommendation: use `String.valueOf(...)` for clarity.

---

## 7. Type promotion in operations (why results change)

Java applies automatic rules in expressions. In general:

- If there is a `double` in the operation, the result tends to be `double`
- If there is a `long` and an `int`, the result tends to be `long`
- If there are small types (`byte`, `short`), Java usually promotes them to `int`

### 7.1. Example: `int` + `double`

```java
int a = 10;
double b = 0.5;

double total = a + b;
System.out.println(total); // 10.5
```

---

### 7.2. Example: `byte` is promoted to `int` in operations

This may surprise you at first:

```java
byte a = 10;
byte b = 20;

// byte c = a + b; // error
int c = a + b;
System.out.println(c); // 30
```

Why does `byte c = a + b;` fail?  
Because `a + b` is converted to `int` internally.

If you really want a `byte`, you would need a cast:

```java
byte a = 10;
byte b = 20;

byte c = (byte) (a + b);
System.out.println(c);
```

---

## 8. Common mistakes (and how to avoid them)

### 8.1. Thinking that a cast “rounds”
A cast from `double` to `int` **does not round**; it truncates.

```java
double value = 9.99;
int result = (int) value;

System.out.println(result); // 9
```

If you wanted to round, you would have to use `Math.round`, which you'll see later.

---

### 8.2. Casting late (instead of before the operation)

Incorrect:

```java
int a = 5;
int b = 2;

double result = (double) (a / b);
System.out.println(result); // 2.0
```

Here `a / b` happens first as an integer division (2), and then you convert it to `double` (2.0).

Correct:

```java
double result = (double) a / b;
System.out.println(result); // 2.5
```

---

### 8.3. Converting a `String` with decimal commas

```java
String text = "10,5";
double value = Double.parseDouble(text); // error
```

Typical solution if the text comes with a comma:

```java
String text = "10,5";
text = text.replace(",", ".");

double value = Double.parseDouble(text);
System.out.println(value); // 10.5
```

---

### 8.4. Overflow when converting to smaller types

```java
int value = 1000;
byte smallValue = (byte) value;

System.out.println(smallValue); // resultado inesperado
```

Solution:

- Don't cast to small types unless it's strictly necessary.
- If you do, make sure the range is correct.

---

## 9. Guided examples (step by step)

### 9.1. Example 1: calculating the total with VAT

We want to add a base price and apply VAT to it. If you work with integers, you can lose precision.

```java
public class Main {
    public static void main(String[] args) {
        int basePrice = 100;
        double vatRate = 0.21;

        double totalPrice = basePrice + (basePrice * vatRate);

        System.out.println(totalPrice); // 121.0
    }
}
```

Implicit conversion occurs here because `vatRate` is `double`.

---

### 9.2. Example 2: average of two grades

```java
public class Main {
    public static void main(String[] args) {
        int grade1 = 7;
        int grade2 = 8;

        double average = (double) (grade1 + grade2) / 2;

        System.out.println(average); // 7.5
    }
}
```

Notice the order:

- `grade1 + grade2` is done as `int`
- then we convert to `double` before dividing

This works because the cast happens **before** the division.

---

### 9.3. Example 3: converting text to a number and operating with it

```java
public class Main {
    public static void main(String[] args) {
        String countText = "10";
        int count = Integer.parseInt(countText);

        int newCount = count + 5;

        System.out.println(newCount); // 15
    }
}
```

Without conversion, `"10" + 5` doesn't do numerical addition, it does concatenation.

---

## 10. Things to keep in mind

- Implicit conversion occurs when there is no risk of loss.
- Explicit conversion (casting) may lose information.
- Integer division is a classic source of errors.
- Converting between `String` and numbers is essential in Java.
- Use parentheses and casts deliberately: clarity is better than “magic”.

---

In the next topic we'll look at **conditionals** (`if` and `switch`), where these conversions will be very useful for comparing values and making decisions in our programs.
