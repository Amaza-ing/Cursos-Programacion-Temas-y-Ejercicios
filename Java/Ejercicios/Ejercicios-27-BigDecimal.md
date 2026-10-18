# Exercises - Topic 27: BigDecimal

Below you will find **10 practical exercises** to work with **`BigDecimal`, operations, rounding, immutability and `compareTo`**.

Try to solve them before looking at the solution.

---

## Exercise 1: Create values

Create two `BigDecimal` values from a `String`.

<details><summary>Show solution</summary>

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal first = new BigDecimal("12.50");
        BigDecimal second = new BigDecimal("7.25");
        System.out.println(first);
        System.out.println(second);
    }
}
```

</details>

---

## Exercise 2: Add

Add up three prices.

<details><summary>Show solution</summary>

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal total = BigDecimal.ZERO;
        total = total.add(new BigDecimal("14.99"));
        total = total.add(new BigDecimal("1.50"));
        total = total.add(new BigDecimal("4.25"));
        System.out.println(total);
    }
}
```

</details>

---

## Exercise 3: Subtract

Subtract a discount.

<details><summary>Show solution</summary>

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("80.00");
        BigDecimal discount = new BigDecimal("15.00");
        System.out.println(price.subtract(discount));
    }
}
```

</details>

---

## Exercise 4: Multiply

Multiply a price by a quantity.

<details><summary>Show solution</summary>

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal unitPrice = new BigDecimal("6.75");
        BigDecimal quantity = new BigDecimal("4");
        System.out.println(unitPrice.multiply(quantity));
    }
}
```

</details>

---

## Exercise 5: Divide

Divide with a scale and rounding.

<details><summary>Show solution</summary>

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal result = new BigDecimal("52.00")
                .divide(new BigDecimal("3"), 2, RoundingMode.HALF_UP);
        System.out.println(result);
    }
}
```

</details>

---

## Exercise 6: Round

Use `setScale`.

<details><summary>Show solution</summary>

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.995");
        System.out.println(price.setScale(2, RoundingMode.HALF_UP));
    }
}
```

</details>

---

## Exercise 7: Immutability

Store the result after each operation.

<details><summary>Show solution</summary>

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal total = BigDecimal.ZERO;
        total = total.add(new BigDecimal("10.00"));
        total = total.add(new BigDecimal("25.50"));
        System.out.println(total);
    }
}
```

</details>

---

## Exercise 8: Compare

Compare `10.0` and `10.00` with `compareTo`.

<details><summary>Show solution</summary>

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal a = new BigDecimal("10.0");
        BigDecimal b = new BigDecimal("10.00");
        System.out.println(a.compareTo(b) == 0);
    }
}
```

</details>

---

## Exercise 9: Validate a price

Assign zero if the price is negative.

<details><summary>Show solution</summary>

```java
import java.math.BigDecimal;

public class Product {
    private BigDecimal price;

    public void setPrice(BigDecimal price) {
        if (price == null || price.compareTo(BigDecimal.ZERO) < 0) {
            this.price = BigDecimal.ZERO;
            return;
        }
        this.price = price;
    }
}
```

</details>

---

## Exercise 10: Calculate tax

Calculate a 21% tax.

<details><summary>Show solution</summary>

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal base = new BigDecimal("120.00");
        BigDecimal rate = new BigDecimal("0.21");
        BigDecimal tax = base.multiply(rate).setScale(2, RoundingMode.HALF_UP);
        System.out.println(tax);
    }
}
```

</details>

---
