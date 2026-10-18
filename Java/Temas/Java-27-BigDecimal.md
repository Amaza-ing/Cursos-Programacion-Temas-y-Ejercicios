# Topic 27. `BigDecimal`

## 1. Introduction

So far you have worked with numeric types such as:

- `int`
- `long`
- `float`
- `double`
- wrappers like `Integer` or `Double`

These types are very useful, but they have an important limitation:

> `double` and `float` do not always represent decimals with exact precision.

This can be a problem when you work with:

- prices
- money
- taxes
- discounts
- financial calculations
- percentages that need precision

For these cases, Java provides a very important class:

- `BigDecimal`

`BigDecimal` allows you to work with decimal numbers in a much more precise and controlled way.

In this topic you will learn:

- Why `double` can cause problems
- What `BigDecimal` is
- How to create `BigDecimal` values correctly
- How to add, subtract, multiply and divide
- How to round with `RoundingMode`
- What it means for `BigDecimal` to be immutable
- The differences between `equals` and `compareTo`
- Good practices for working with money and precise decimals

---

[![BigDecimal](https://img.youtube.com/vi/yfJO-5ZHZqM/0.jpg)](https://www.youtube.com/watch?v=yfJO-5ZHZqM&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. The problem with `double`

In Java, `double` is very convenient for working with decimals.

Example:

```java
double price = 19.99;
double tax = 4.21;

double total = price + tax;

System.out.println(total);
```

But in some cases unexpected results appear.

Classic example:

```java
public class Main {
    public static void main(String[] args) {
        double result = 0.1 + 0.2;

        System.out.println(result);
    }
}
```

You might expect:

```text
0.3
```

But you will often see something like:

```text
0.30000000000000004
```

This happens because many decimal numbers cannot be represented exactly in binary.

---

## 3. Why this matters

In some programs, this small error doesn't matter too much.

For example:

- approximate coordinates
- scientific calculations with a margin of error
- graphics
- simulations

But in other cases it does matter a lot.

Example:

```java
double price = 0.10;
double total = price + price + price;

System.out.println(total);
```

If you're working with money, you don't want inaccurate results.

That is what `BigDecimal` is for.

---

## 4. What is `BigDecimal`

`BigDecimal` is a Java class designed to represent decimal numbers with arbitrary precision.

It is in the package:

```java
java.math
```

That's why you usually need to import it:

```java
import java.math.BigDecimal;
```

With `BigDecimal`, you can do decimal calculations in a more controlled way.

Example:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.99");

        System.out.println(price);
    }
}
```

---

## 5. Creating a `BigDecimal`

There are several ways to create a `BigDecimal`, but not all of them are equally recommended.

---

## 6. Recommended way: use a `String`

The safest way to get exact decimal values is to use a `String`.

```java
BigDecimal price = new BigDecimal("19.99");
BigDecimal tax = new BigDecimal("4.21");
```

Why?

Because then Java receives exactly the decimal value you have written.

Example:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal value = new BigDecimal("0.1");

        System.out.println(value);
    }
}
```

Result:

```text
0.1
```

---

## 7. Avoid `new BigDecimal(double)`

This way can be dangerous:

```java
BigDecimal value = new BigDecimal(0.1);
```

Although it looks correct, it may produce an unexpected value because the `double` is already imprecise when it arrives.

Example:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal value = new BigDecimal(0.1);

        System.out.println(value);
    }
}
```

You might see something like:

```text
0.1000000000000000055511151231257827021181583404541015625
```

Therefore, for values you write directly, it is better to use:

```java
BigDecimal value = new BigDecimal("0.1");
```

---

## 8. Using `BigDecimal.valueOf`

Another widely used option is `BigDecimal.valueOf`.

```java
BigDecimal value = BigDecimal.valueOf(0.1);
```

This form is generally safer than `new BigDecimal(0.1)` because it internally uses a conversion based on the textual representation of the `double`.

Example:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal value = BigDecimal.valueOf(0.1);

        System.out.println(value);
    }
}
```

Result:

```text
0.1
```

### 8.1. Rule of thumb

For fixed decimal values, preferably use:

```java
new BigDecimal("19.99")
```

or:

```java
BigDecimal.valueOf(19.99)
```

Avoid:

```java
new BigDecimal(19.99)
```

---

## 9. Useful constants

`BigDecimal` includes some useful constants:

```java
BigDecimal.ZERO
BigDecimal.ONE
BigDecimal.TEN
```

Example:

```java
BigDecimal total = BigDecimal.ZERO;
```

This is better than writing:

```java
BigDecimal total = new BigDecimal("0");
```

---

## 10. Basic operations

With `BigDecimal` we do not use operators like `+`, `-`, `*` or `/`.

You cannot do this:

```java
// BigDecimal total = price + tax; // error
```

Instead, we use methods:

- `add`
- `subtract`
- `multiply`
- `divide`

---

## 11. Adding with `add`

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.99");
        BigDecimal tax = new BigDecimal("4.21");

        BigDecimal total = price.add(tax);

        System.out.println(total);
    }
}
```

Result:

```text
24.20
```

---

## 12. Subtracting with `subtract`

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.99");
        BigDecimal discount = new BigDecimal("5.00");

        BigDecimal finalPrice = price.subtract(discount);

        System.out.println(finalPrice);
    }
}
```

Result:

```text
14.99
```

---

## 13. Multiplying with `multiply`

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal unitPrice = new BigDecimal("12.50");
        BigDecimal quantity = new BigDecimal("3");

        BigDecimal total = unitPrice.multiply(quantity);

        System.out.println(total);
    }
}
```

Result:

```text
37.50
```

---

## 14. Dividing with `divide`

Dividing with `BigDecimal` requires more care.

Simple example:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal total = new BigDecimal("10");
        BigDecimal parts = new BigDecimal("2");

        BigDecimal result = total.divide(parts);

        System.out.println(result);
    }
}
```

Result:

```text
5
```

But some divisions do not have an exact result.

Example:

```java
BigDecimal result = new BigDecimal("10").divide(new BigDecimal("3"));
```

This may throw an exception:

```text
ArithmeticException
```

Why?

Because `10 / 3` gives a never-ending decimal:

```text
3.333333333...
```

Java needs to know how to round.

---

## 15. Dividing with scale and rounding

To divide safely, we usually specify:

- the scale
- the rounding mode

The scale indicates how many decimal places we want.

Example:

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal total = new BigDecimal("10");
        BigDecimal parts = new BigDecimal("3");

        BigDecimal result = total.divide(parts, 2, RoundingMode.HALF_UP);

        System.out.println(result);
    }
}
```

Result:

```text
3.33
```

Here:

- `2` indicates two decimal places
- `RoundingMode.HALF_UP` indicates the rounding criterion

---

## 16. What is `RoundingMode`

`RoundingMode` is a Java enum that defines how a number is rounded.

It is in:

```java
java.math.RoundingMode
```

Import:

```java
import java.math.RoundingMode;
```

Some common modes are:

- `HALF_UP`
- `HALF_DOWN`
- `HALF_EVEN`
- `UP`
- `DOWN`
- `CEILING`
- `FLOOR`

To start with, the most intuitive one is usually:

```java
RoundingMode.HALF_UP
```

which is similar to the usual rounding we learn at school.

---

## 17. `setScale`

`setScale` lets you adjust the number of decimal places.

Example:

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.999");

        BigDecimal roundedPrice = price.setScale(2, RoundingMode.HALF_UP);

        System.out.println(roundedPrice);
    }
}
```

Result:

```text
20.00
```

---

## 18. `BigDecimal` is immutable

This is very important.

A `BigDecimal` object does not change after it is created.

When you perform an operation, Java returns a new `BigDecimal`.

Incorrect example:

```java
BigDecimal price = new BigDecimal("10.00");

price.add(new BigDecimal("5.00"));

System.out.println(price); // 10.00
```

The addition does not modify `price`.

The right thing to do is to store the result:

```java
BigDecimal price = new BigDecimal("10.00");

price = price.add(new BigDecimal("5.00"));

System.out.println(price); // 15.00
```

---

## 19. Example of immutability step by step

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal total = BigDecimal.ZERO;

        total.add(new BigDecimal("10.00"));
        total.add(new BigDecimal("5.00"));

        System.out.println(total);
    }
}
```

Result:

```text
0
```

Why?

Because you are not storing the results.

Correct version:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal total = BigDecimal.ZERO;

        total = total.add(new BigDecimal("10.00"));
        total = total.add(new BigDecimal("5.00"));

        System.out.println(total);
    }
}
```

Result:

```text
15.00
```

---

## 20. Comparing `BigDecimal` values

With `BigDecimal`, there are two important ways to compare values:

- `equals`
- `compareTo`

And they don't mean exactly the same thing.

---

## 21. `equals`

`equals` compares both value and scale.

Example:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal a = new BigDecimal("10.0");
        BigDecimal b = new BigDecimal("10.00");

        System.out.println(a.equals(b));
    }
}
```

Result:

```text
false
```

Why?

Because:
- `10.0` has scale 1
- `10.00` has scale 2

Although they represent the same number, `equals` takes the scale into account.

---

## 22. `compareTo`

`compareTo` compares the numeric value.

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal a = new BigDecimal("10.0");
        BigDecimal b = new BigDecimal("10.00");

        System.out.println(a.compareTo(b));
    }
}
```

Result:

```text
0
```

A result of `0` means they are numerically equal.

Rule of thumb:

- to compare numeric values, use `compareTo`
- to check exact equality including the scale, use `equals`

---

## 23. Typical comparisons with `compareTo`

`compareTo` returns:

- a negative number if the first is smaller
- `0` if they are equal
- a positive number if the first is greater

Example:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.99");
        BigDecimal limit = new BigDecimal("20.00");

        if (price.compareTo(limit) < 0) {
            System.out.println("Price is lower than limit");
        }

        if (price.compareTo(limit) == 0) {
            System.out.println("Price is equal to limit");
        }

        if (price.compareTo(limit) > 0) {
            System.out.println("Price is greater than limit");
        }
    }
}
```

---

## 24. Checking whether a value is zero

Doing this is not recommended:

```java
price.equals(BigDecimal.ZERO)
```

because it might fail if the scale is different.

Better:

```java
price.compareTo(BigDecimal.ZERO) == 0
```

Example:

```java
BigDecimal value = new BigDecimal("0.00");

System.out.println(value.equals(BigDecimal.ZERO)); // false
System.out.println(value.compareTo(BigDecimal.ZERO) == 0); // true
```

---

## 25. Guided example: calculating a cart total

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal mousePrice = new BigDecimal("19.99");
        BigDecimal keyboardPrice = new BigDecimal("49.99");
        BigDecimal cablePrice = new BigDecimal("5.50");

        BigDecimal total = BigDecimal.ZERO;

        total = total.add(mousePrice);
        total = total.add(keyboardPrice);
        total = total.add(cablePrice);

        System.out.println("Total: " + total);
    }
}
```

---

## 26. Guided example: price by quantity

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal unitPrice = new BigDecimal("12.50");
        BigDecimal quantity = new BigDecimal("4");

        BigDecimal total = unitPrice.multiply(quantity);

        System.out.println("Total: " + total);
    }
}
```

---

## 27. Guided example: applying a discount

We are going to apply a 20% discount.

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("100.00");
        BigDecimal discountRate = new BigDecimal("0.20");

        BigDecimal discount = price.multiply(discountRate);
        BigDecimal finalPrice = price.subtract(discount);

        finalPrice = finalPrice.setScale(2, RoundingMode.HALF_UP);

        System.out.println("Discount: " + discount);
        System.out.println("Final price: " + finalPrice);
    }
}
```

---

## 28. Guided example: calculating VAT

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal basePrice = new BigDecimal("80.00");
        BigDecimal taxRate = new BigDecimal("0.21");

        BigDecimal tax = basePrice.multiply(taxRate);
        BigDecimal total = basePrice.add(tax);

        tax = tax.setScale(2, RoundingMode.HALF_UP);
        total = total.setScale(2, RoundingMode.HALF_UP);

        System.out.println("Tax: " + tax);
        System.out.println("Total: " + total);
    }
}
```

---

## 29. Guided example: splitting a bill

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal bill = new BigDecimal("47.50");
        BigDecimal people = new BigDecimal("3");

        BigDecimal eachPersonPays = bill.divide(people, 2, RoundingMode.HALF_UP);

        System.out.println("Each person pays: " + eachPersonPays);
    }
}
```

---

## 30. Creating a `Product` class with `BigDecimal`

When working with prices, it is better to use `BigDecimal` than `double`.

### 30.1. `Product.java`

```java
import java.math.BigDecimal;

public class Product {
    private String name;
    private BigDecimal price;

    public Product(String name, BigDecimal price) {
        setName(name);
        setPrice(price);
    }

    public String getName() {
        return name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            this.name = "Unknown";
            return;
        }

        this.name = name;
    }

    public void setPrice(BigDecimal price) {
        if (price == null || price.compareTo(BigDecimal.ZERO) < 0) {
            this.price = BigDecimal.ZERO;
            return;
        }

        this.price = price;
    }

    public void printInfo() {
        System.out.println("Product: " + name + " | Price: " + price);
    }
}
```

### 30.2. `Main.java`

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        Product mouse = new Product("Mouse", new BigDecimal("19.99"));
        Product keyboard = new Product("Keyboard", new BigDecimal("49.99"));

        mouse.printInfo();
        keyboard.printInfo();
    }
}
```

---

## 31. Complete example: cart with products

### 31.1. `Product.java`

```java
import java.math.BigDecimal;

public class Product {
    private String name;
    private BigDecimal price;

    public Product(String name, BigDecimal price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public BigDecimal getPrice() {
        return price;
    }
}
```

### 31.2. `Main.java`

```java
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Product> products = new ArrayList<>();

        products.add(new Product("Mouse", new BigDecimal("19.99")));
        products.add(new Product("Keyboard", new BigDecimal("49.99")));
        products.add(new Product("Cable", new BigDecimal("5.50")));

        BigDecimal total = BigDecimal.ZERO;

        for (Product product : products) {
            total = total.add(product.getPrice());
        }

        System.out.println("Total: " + total);
    }
}
```

---

## 32. `BigDecimal` and `Stream API`: a preview

You will see `Stream API` later on, but here you can see what adding up prices with streams would look like.

```java
import java.math.BigDecimal;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<BigDecimal> prices = List.of(
                new BigDecimal("19.99"),
                new BigDecimal("49.99"),
                new BigDecimal("5.50")
        );

        BigDecimal total = prices.stream()
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        System.out.println(total);
    }
}
```

You don't need to master this syntax yet, but it's helpful to see that `BigDecimal` works very well with modern collections.

---

## 33. Formatting the output

`BigDecimal` represents the value, but sometimes you want to display it with formatting.

For example, with two decimal places:

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.9");

        BigDecimal formattedPrice = price.setScale(2, RoundingMode.HALF_UP);

        System.out.println(formattedPrice);
    }
}
```

Result:

```text
19.90
```

For real user interfaces, invoices or applications that handle currencies, you could later use formatting tools like `NumberFormat`.

---

## 34. Using `MathContext`

`MathContext` lets you control the precision of some operations.

Example:

```java
import java.math.BigDecimal;
import java.math.MathContext;

public class Main {
    public static void main(String[] args) {
        BigDecimal a = new BigDecimal("10");
        BigDecimal b = new BigDecimal("3");

        BigDecimal result = a.divide(b, new MathContext(4));

        System.out.println(result);
    }
}
```

Approximate result:

```text
3.333
```

At this early stage, for money calculations it is usually more common to control the decimal places with:

```java
setScale(2, RoundingMode.HALF_UP)
```

or to divide with scale and rounding.

---

## 35. When to use `BigDecimal`

Use `BigDecimal` when working with:

- money
- prices
- taxes
- interest
- discounts
- percentages where precision matters
- financial calculations

Example:

```java
BigDecimal price = new BigDecimal("19.99");
```

---

## 36. When `double` can be enough

`double` is still useful in many cases.

You can use `double` when working with:

- approximate measurements
- graphics
- approximate physical calculations
- positions
- percentages where a small error is not relevant
- simulations

Example:

```java
double distance = 12.75;
double average = 8.43;
```

It is not about `double` being “bad”, but about using each type in the right situation.

---
## 37. Common beginner mistakes

### 37.1. Creating a `BigDecimal` from a `double`

Avoid:

```java
BigDecimal value = new BigDecimal(0.1);
```

Better:

```java
BigDecimal value = new BigDecimal("0.1");
```

or:

```java
BigDecimal value = BigDecimal.valueOf(0.1);
```

### 37.2. Using arithmetic operators

You cannot do this:

```java
// BigDecimal total = price + tax;
```

Use:

```java
BigDecimal total = price.add(tax);
```

### 37.3. Forgetting that `BigDecimal` is immutable

This does not change the original value:

```java
total.add(price);
```

You must do:

```java
total = total.add(price);
```

### 37.4. Dividing without rounding when the result is non-terminating

This may fail:

```java
// BigDecimal result = new BigDecimal("10").divide(new BigDecimal("3"));
```

Better:

```java
BigDecimal result = new BigDecimal("10")
        .divide(new BigDecimal("3"), 2, RoundingMode.HALF_UP);
```

### 37.5. Using `equals` to compare numeric values

This may surprise you:

```java
new BigDecimal("10.0").equals(new BigDecimal("10.00")); // false
```

For numeric comparisons, use:

```java
a.compareTo(b) == 0
```

---

## 38. Good practices

- Use `BigDecimal` for money and exact decimal calculations.
- Create decimal values with `String` or `BigDecimal.valueOf`.
- Avoid `new BigDecimal(double)`.
- Remember to store the result of each operation.
- Use `compareTo` to compare numeric values.
- Define the scale and rounding clearly.
- For prices, it usually makes sense to work with 2 decimal places.
- Use constants like `BigDecimal.ZERO`, `BigDecimal.ONE` and `BigDecimal.TEN`.

---

## 39. Things to keep in mind

- `double` can have decimal precision errors.
- `BigDecimal` allows more accurate decimal calculations.
- You don't use operators such as `+` or `*`, but methods.
- `BigDecimal` is immutable.
- For non-exact divisions, you need to specify the rounding.
- `equals` takes the scale into account.
- `compareTo` compares the numeric value.
- It is the usual option for prices, money and taxes.

---

## 40. Final summary

`BigDecimal` is an essential class when you need decimal precision.

Although its syntax is somewhat longer than using `double`, it offers much more control and avoids dangerous errors in sensitive calculations.

The main idea is:

- use `double` for approximate calculations
- use `BigDecimal` for exact or financial calculations

If you work with prices, taxes, discounts or amounts, `BigDecimal` will almost always be the best option.

---

In the next topic we will keep expanding your command of modern Java with generic types.
