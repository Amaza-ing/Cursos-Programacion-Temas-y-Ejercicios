# Exercises - Topic 30: Stream API

Below you will find **10 practical exercises** to work with **Stream API**: `filter`, `map`, `sorted`, `distinct`, `count`, `reduce`, `findFirst`, `anyMatch`, `allMatch` and final conversion with `toList`.

Try to solve them before consulting the solution.

---

## Exercise 1: Filter long words

Create an `List<String> words` list with these values:

- `"java"`
- `"stream"`
- `"api"`
- `"programming"`
- `"code"`

Use `stream()` to only keep words that are **more than 4 characters**.  
Save the result in a new list and print it.

<details><summary>Show solution</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> words = List.of("java", "stream", "api", "programming", "code");

        List<String> longWords = words.stream()
                .filter(word -> word.length() > 4)
                .toList();

        System.out.println(longWords);
    }
}
```

</details>

---

## Exercise 2: Convert names to uppercase

Create an `List<String> names` list with:

- `"laura"`
- `"alex"`
- `"maria"`
- `"david"`

Use `map` to create a new list with all names in uppercase.

<details><summary>Show solution</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("laura", "alex", "maria", "david");

        List<String> upperNames = names.stream()
                .map(name -> name.toUpperCase())
                .toList();

        System.out.println(upperNames);
    }
}
```

</details>

---

## Exercise 3: Filter even numbers

Create an `List<Integer> numbers` list with:

`3`, `8`, `12`, `5`, `7`, `20`.

Use `filter` to get only the even numbers and print the resulting list.

<details><summary>Show solution</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(3, 8, 12, 5, 7, 20);

        List<Integer> evenNumbers = numbers.stream()
                .filter(number -> number % 2 == 0)
                .toList();

        System.out.println(evenNumbers);
    }
}
```

</details>

---

## Exercise 4: Sort prices from lowest to highest

Create an `List<Double> prices` list with:

`19.99`, `5.50`, `120.0`, `49.99`.

Use `sorted` to create a list ordered from smallest to largest.

<details><summary>Show solution</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Double> prices = List.of(19.99, 5.50, 120.0, 49.99);

        List<Double> sortedPrices = prices.stream()
                .sorted()
                .toList();

        System.out.println(sortedPrices);
    }
}
```

</details>

---

## Exercise 5: Delete repeated tags

Create an `List<String> tags` list with:

- `"java"`
- `"backend"`
- `"java"`
- `"maven"`
- `"backend"`

Use `distinct` to remove duplicates and print the resulting list.

<details><summary>Show solution</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> tags = List.of("java", "backend", "java", "maven", "backend");

        List<String> uniqueTags = tags.stream()
                .distinct()
                .toList();

        System.out.println(uniqueTags);
    }
}
```

</details>

---

## Exercise 6: Count expensive products

Create a class `Product` with:

- `name`
- `price`

In `main`, create a list with multiple products.  
Use `stream()` and `count()` to count how many products have a price higher than `50`.

<details><summary>Show solution</summary>

```java
import java.util.List;

public class Product {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public double getPrice() {
        return price;
    }
}
```

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Product> products = List.of(
                new Product("Mouse", 19.99),
                new Product("Keyboard", 49.99),
                new Product("Monitor", 199.99),
                new Product("Desk", 120.0)
        );

        long expensiveCount = products.stream()
                .filter(product -> product.getPrice() > 50)
                .count();

        System.out.println(expensiveCount);
    }
}
```

</details>

---

## Exercise 7: Add numbers with `reduce`

Create an `List<Integer> expenses` list with:

`10`, `25`, `15`, `40`.

Use `reduce` to calculate the total sum and print the result.

<details><summary>Show solution</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> expenses = List.of(10, 25, 15, 40);

        int total = expenses.stream()
                .reduce(0, (currentTotal, expense) -> currentTotal + expense);

        System.out.println(total);
    }
}
```

</details>

---

## Exercise 8: Find the first name that starts with a letter

Create an `List<String> names` list with:

- `"Carlos"`
- `"Ana"`
- `"Carmen"`
- `"Luis"`

Use `stream()`, `filter`, and `findFirst` to find the first name that starts with `"C"`.  
If it exists, print it.
<details><summary>Show solution</summary>

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Carlos", "Ana", "Carmen", "Luis");

        Optional<String> firstName = names.stream()
                .filter(name -> name.startsWith("C"))
                .findFirst();

        firstName.ifPresent(System.out::println);
    }
}
```

</details>

---

## Exercise 9: Check if there are any adult users

Create a class `User` with:

- `name`
- `age`

In `main`, create a list of users.  
Use `anyMatch` to check if there is at least one user with an age greater than or equal to `18`.

<details><summary>Show solution</summary>

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public int getAge() {
        return age;
    }
}
```

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<User> users = List.of(
                new User("Laura", 22),
                new User("Alex", 16),
                new User("Maria", 30)
        );

        boolean hasAdult = users.stream()
                .anyMatch(user -> user.getAge() >= 18);

        System.out.println(hasAdult);
    }
}
```

</details>

---

## Exercise 10: Filter, transform and sort

Create an `List<String> emails` list with:

- `"LAURA@EXAMPLE.COM"`
- `"test@gmail.com"`
- `"ADMIN@EXAMPLE.COM"`
- `"hello@yahoo.com"`

Use the Stream API to:

1. Keep only emails that end in `"@example.com"`, ignoring upper/lower case.
2. Convert them to lowercase.
3. Sort them alphabetically.
4. Print the final list.

<details><summary>Show solution</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> emails = List.of(
                "LAURA@EXAMPLE.COM",
                "test@gmail.com",
                "ADMIN@EXAMPLE.COM",
                "hello@yahoo.com"
        );

        List<String> exampleEmails = emails.stream()
                .map(email -> email.toLowerCase())
                .filter(email -> email.endsWith("@example.com"))
                .sorted()
                .toList();

        System.out.println(exampleEmails);
    }
}
```

</details>

---
