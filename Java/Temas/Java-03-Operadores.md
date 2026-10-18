# Topic 3. Operators and expressions

## 1. Introduction

You already know how to create variables and store values. Now it's time for what really makes a program useful: **doing things with those values**.

In Java, to work with values we use:

- **Operators**: symbols such as `+`, `-`, `==`, `&&`...
- **Expressions**: combinations of values, variables and operators that produce a result

For example:

```java
int total = 5 + 3;          // expresión aritmética
boolean isAdult = age >= 18; // expresión relacional
```

In this topic you will learn, with clear and guided examples:

- Arithmetic operators
- Relational operators (comparisons)
- Logical operators (combining conditions)
- Assignment operators (including compound ones)
- Increment and decrement (`++` and `--`)
- Operator precedence and the use of parentheses
- Typical mistakes (very common when you're starting out)

---

[![Operators](https://img.youtube.com/vi/72ushurVPRQ/0.jpg)](https://www.youtube.com/watch?v=72ushurVPRQ&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What an operator is and what an expression is

### 2.1. Operator

An **operator** is a symbol that indicates an operation:

- `+` adds
- `==` compares for equality
- `&&` combines conditions

### 2.2. Expression

An **expression** is something that can be evaluated and produces a value.

Examples of expressions:

```java
10 + 5
age >= 18
isPremium && hasPermission
```

And you usually store the result in a variable:

```java
int result = 10 + 5;
boolean isValid = age >= 18;
```

---

## 3. Arithmetic operators

Arithmetic operators are used for mathematical calculations.

### 3.1. Available arithmetic operators

| Operator | Name | Example |
| -------- | -------------- | ------- |
| `+` | Addition | `a + b` |
| `-` | Subtraction | `a - b` |
| `*` | Multiplication | `a * b` |
| `/` | Division | `a / b` |
| `%` | Modulo (remainder) | `a % b` |

---

### 3.2. Guided example: basic operations

```java
int a = 10;
int b = 3;

int sum = a + b;
int difference = a - b;
int product = a * b;
int quotient = a / b;
int remainder = a % b;

System.out.println("sum: " + sum);               // 13
System.out.println("difference: " + difference); // 7
System.out.println("product: " + product);       // 30
System.out.println("quotient: " + quotient);     // 3
System.out.println("remainder: " + remainder);   // 1
```

---

### 3.3. Integer division (a common mistake)

When you divide two `int` values, the result is an `int` and the decimals are lost:

```java
int result = 5 / 2;
System.out.println(result); // 2
```

If you need decimals, at least one of them must be a `double`:

```java
double result = 5 / 2.0;
System.out.println(result); // 2.5
```

Or using a cast:

```java
int a = 5;
int b = 2;

double result = (double) a / b;
System.out.println(result); // 2.5
```

---

### 3.4. Modulo `%` (very useful)

The modulo operator returns the remainder of a division.

Example:

```java
int remainder = 10 % 3;
System.out.println(remainder); // 1
```

Typical cases:

- Checking whether a number is even or odd
- Running something “every N” times
- Cycles

Example: even or odd

```java
int number = 7;

boolean isEven = (number % 2) == 0;
System.out.println(isEven); // false
```

---

## 4. Assignment operators

### 4.1. Basic assignment `=`

The `=` operator assigns a value to a variable.

```java
int age = 25;
```

---

### 4.2. Compound assignment (`+=`, `-=`, `*=`, `/=`, `%=`)

They let you update a variable more compactly.

| Operator | Example | Equivalent to |
| -------- | -------- | ----------- |
| `+=` | `a += 2` | `a = a + 2` |
| `-=` | `a -= 2` | `a = a - 2` |
| `*=` | `a *= 2` | `a = a * 2` |
| `/=` | `a /= 2` | `a = a / 2` |
| `%=` | `a %= 2` | `a = a % 2` |

Example:

```java
int score = 10;

score += 5; // 15
score -= 2; // 13
score *= 2; // 26
score /= 2; // 13

System.out.println(score);
```

---

## 5. Increment and decrement (`++` and `--`)
These operators add or subtract 1.

```java
int count = 0;

count++; // ahora count vale 1
count--; // vuelve a 0
```

---

### 5.1. Pre-increment vs post-increment (very important)

- `count++` (post): first uses the value, then increments
- `++count` (pre): first increments, then uses the value

Guided example:

```java
int count = 5;

System.out.println(count++); // imprime 5, luego count pasa a 6
System.out.println(count);   // imprime 6
```

Now with pre-increment:

```java
int count = 5;

System.out.println(++count); // count pasa a 6 y luego imprime 6
System.out.println(count);   // imprime 6
```

> Recommendation for beginners: use `count++` on separate lines to avoid confusion.

---

## 6. Relational operators (comparisons)

Relational operators compare values and the result is always a `boolean`.

### 6.1. Relational operators

| Operator | Meaning | Example |
| -------- | ----------------- | -------- |
| `==` | Equal to | `a == b` |
| `!=` | Not equal to | `a != b` |
| `>` | Greater than | `a > b` |
| `<` | Less than | `a < b` |
| `>=` | Greater than or equal to | `a >= b` |
| `<=` | Less than or equal to | `a <= b` |

---

### 6.2. Guided example: comparing ages

```java
int age = 17;

boolean isAdult = age >= 18;
boolean isMinor = age < 18;

System.out.println(isAdult); // false
System.out.println(isMinor); // true
```

---

### 6.3. Comparisons with `double` (be careful)

Comparing decimals for exact equality can fail because of how they're represented internally, although in simple examples it usually works.

```java
double a = 0.1 + 0.2;
System.out.println(a); // puede mostrar 0.30000000000000004
```

For beginners, stick with this idea:

- For money, `BigDecimal` is usually used (you will see it much later)
- For basic exercises, `double` is fine, but be aware of this

---

## 7. Logical operators

Logical operators combine boolean values.

### 7.1. Main logical operators

| Operator | Name | Meaning |
| -------- | ------ | ---------------------- | --- | ---------------------------- |
| `&&` | AND | true if both are true |
| `        |        | ` | OR | true if at least one is true |
| `!` | NOT | inverts the boolean |

---

### 7.2. Example: AND (`&&`)

```java
int age = 20;
boolean hasId = true;

boolean canEnter = (age >= 18) && hasId;
System.out.println(canEnter); // true
```

---

### 7.3. Example: OR (`||`)

```java
boolean isVip = true;
boolean hasInvitation = false;

boolean canAccess = isVip || hasInvitation;
System.out.println(canAccess); // true
```

---

### 7.4. Example: NOT (`!`)

```java
boolean isBlocked = false;

boolean canLogin = !isBlocked;
System.out.println(canLogin); // true
```

---

## 8. Short-circuit evaluation in `&&` and `||`

This is important because it affects the behavior of the program.

- In `&&`, if the first condition is `false`, Java does not evaluate the second.
- In `||`, if the first condition is `true`, Java does not evaluate the second.

Example:

```java
int value = 0;

boolean result = (value != 0) && (10 / value > 1);
System.out.println(result); // false
```

There is no error here, because `value != 0` is `false` and Java does not evaluate `10 / value`.

Without short-circuit evaluation, this code would throw a division-by-zero error.

---

## 9. Operators with `String` (very important)

### 9.1. Concatenation with `+`

You can join text with variables using `+`.

```java
String name = "Alex";
int age = 25;

String message = "Name: " + name + ", Age: " + age;
System.out.println(message);
```

---

### 9.2. Common mistake: concatenation vs addition

Look at this:

```java
System.out.println("Result: " + 2 + 3);
```

Output:

```
Result: 23
```

Because it is interpreted as concatenation: `"Result: " + 2` and then `+ 3`.

If you want an actual sum, use parentheses:

```java
System.out.println("Result: " + (2 + 3));
```

Output:

```
Result: 5
```

---

### 9.3. Comparing `String` values: use `.equals(...)`
This is a classic Java mistake.

Incorrect:

```java
String role = "admin";

if (role == "admin") {
    System.out.println("Admin access");
}
```

Correct:

```java
String role = "admin";

if (role.equals("admin")) {
    System.out.println("Admin access");
}
```

Later you'll see why (objects vs references), but for now stick to the rule:

> To compare text in Java, use `.equals(...)`.

---

## 10. Operator precedence and parentheses

Java evaluates expressions following an order of precedence.

Quick rule of thumb:

1. Parentheses `( )`
2. Multiplication/Division/Modulo `* / %`
3. Addition/Subtraction `+ -`
4. Comparisons `> < >= <=`
5. Equality `== !=`
6. AND `&&`
7. OR `||`
8. Assignment `=`

---

### 10.1. Example: precedence in arithmetic

```java
int result = 5 + 2 * 3;
System.out.println(result); // 11
```

If you want to change the order:

```java
int result = (5 + 2) * 3;
System.out.println(result); // 21
```

---

### 10.2. Example: precedence in conditions

```java
boolean result = true || false && false;
System.out.println(result); // true
```

Because `&&` has higher precedence than `||`, it is evaluated like this:

- `false && false` -> `false`
- `true || false` -> `true`

If you wanted different logic:

```java
boolean result = (true || false) && false;
System.out.println(result); // false
```

---

## 11. Guided examples (for real practice)

### 11.1. Example 1: calculating the final price with a discount

We want:

- `basePrice` (double)
- `discountRate` (double)
- `finalPrice = basePrice - (basePrice * discountRate)`

```java
public class Main {
    public static void main(String[] args) {
        double basePrice = 120.0;
        double discountRate = 0.15;

        double discountAmount = basePrice * discountRate;
        double finalPrice = basePrice - discountAmount;

        System.out.println("Base price: " + basePrice);
        System.out.println("Discount: " + discountAmount);
        System.out.println("Final price: " + finalPrice);
    }
}
```

Key points:

- Separating the calculation into steps improves readability
- You avoid errors when chaining operations

---

### 11.2. Example 2: validating access with logical conditions

We want to allow access if:

- they're of legal age **and**
- they have a ticket **or** they're VIP

```java
public class Main {
    public static void main(String[] args) {
        int age = 19;
        boolean hasTicket = false;
        boolean isVip = true;

        boolean isAdult = age >= 18;
        boolean canEnter = isAdult && (hasTicket || isVip);

        System.out.println("Can enter: " + canEnter);
    }
}
```

Notice the parentheses:

- Without parentheses the condition can be interpreted differently
- Parentheses make the intention clear

---

### 11.3. Example 3: even or odd and multiples

```java
public class Main {
    public static void main(String[] args) {
        int number = 12;

        boolean isEven = (number % 2) == 0;
        boolean isMultipleOf3 = (number % 3) == 0;

        System.out.println("Is even: " + isEven);
        System.out.println("Is multiple of 3: " + isMultipleOf3);
    }
}
```

---

## 12. Common mistakes (and how to avoid them)

### 12.1. Using `=` instead of `==`

Incorrect (it doesn't compile in conditions):

```java
// if (age = 18) { ... } // error
```

Correct:

```java
if (age == 18) {
    System.out.println("Exactly 18");
}
```

---

### 12.2. Forgetting parentheses in concatenation

```java
System.out.println("Total: " + 2 + 3); // "Total: 23"
System.out.println("Total: " + (2 + 3)); // "Total: 5"
```

---

### 12.3. Dividing integers and expecting decimals

```java
int a = 7;
int b = 2;

double average = a / b; // 3.0 (incorrecto)
```

Solution:

```java
double average = (double) a / b; // 3.5
```

---

## 13. Things to keep in mind

- An operator is a symbol; an expression combines operators and values.
- Integer division is a typical source of errors.
- `&&` and `||` use short-circuit evaluation (which sometimes prevents errors).
- For `String`, concatenate with `+` and compare with `.equals(...)`.
- Use parentheses for clarity and to control precedence.

---

In the next topic you'll learn about **type conversion**, where you'll see how to go from `int` to `double`, from `String` to a number, and why some operations give unexpected results if you don't convert correctly.
