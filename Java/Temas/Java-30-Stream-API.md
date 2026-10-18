# Topic 30. Stream API

## 1. Introduction

In the previous topic you learned what **lambdas** and **functional interfaces** are, and you saw how they allow you to write more compact and expressive code.

Now we are going to study one of the most important tools of modern Java:

- **Stream API**

`Stream API` allows you to work with collections and sequences of data in a more declarative way.

Instead of saying step by step:

- scroll through this list
- check this condition
- transform these values
- save this result

You can express the intention more clearly:

- filter these elements
- transform these values
- order them
- collect them in a list

This makes many operations on data:

- more readable
- more compact
- easier to chain
- more expressive

In this topic you will learn:

- What is an `Stream`
- How to create streams
- Intermediate and terminal operations
- Methods like `filter`, `map`, `sorted`, `distinct`, `limit`
- How to convert the result into lists or other structures
- What is `forEach`
- Methods like `count`, `anyMatch`, `allMatch`, `findFirst`
- Reductions with `reduce`
- What relationship does `Stream API` have with lambdas?
- Typical errors and good practices

---

## 2. What is an `Stream`

An `Stream` is a sequence of elements on which you can apply operations such as:

- filter
- transform
- sort
- limit
- count
- collect results

It is very important to understand this:

> An `Stream` is not a collection.

A list stores data.  
A stream represents a way to **process** data.

For example, if you have a list:

```java
List<String> names = List.of("Laura", "Alex", "Maria");
```

you can create a stream from it:

```java
names.stream()
```

and then chain operations.

---

## 3. Imperative vs declarative processing

To understand `Stream API` well, it is useful to compare two styles.

### 3.1. imperative style

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo");
        List<String> result = new ArrayList<>();

        for (String name : names) {
            if (name.length() >= 5) {
                result.add(name.toUpperCase());
            }
        }

        System.out.println(result);
    }
}
```

Here you show step by step how to do it.

### 3.2. Declarative style with streams

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo");

        List<String> result = names.stream()
                .filter(name -> name.length() >= 5)
                .map(name -> name.toUpperCase())
                .toList();

        System.out.println(result);
    }
}
```

Here you express the intention:

- filters
- transform
- convert it to list

That is the great value of `Stream API`.

---

## 4. How to create a stream

The most common way is from a collection.

### 4.1. From a list

```java
List<String> names = List.of("Laura", "Alex", "Maria");

names.stream();
```

### 4.2. From an array

```java
import java.util.Arrays;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        String[] names = {"Laura", "Alex", "Maria"};

        Stream<String> stream = Arrays.stream(names);
    }
}
```

### 4.3. With `Stream.of`

```java
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        Stream<String> stream = Stream.of("Laura", "Alex", "Maria");
    }
}
```

---

## 5. Intermediate and terminal operations

In `Stream API` there are two types of operations:

- **intermediate**
- **terminals**

### 5.1. Intermediate

They return another stream and allow you to continue chaining operations.

Examples:

- `filter`
- `map`
- `sorted`
- `distinct`
- `limit`
- `skip`

### 5.2. Terminals

They close the processing and produce a final result.

Examples:

- `toList`
- `forEach`
- `count`
- `findFirst`
- `reduce`
- `collect`

### 5.3. Key idea

A stream is usually constructed like this:

- origin
- several intermediate operations
- a terminal operation

Example:

```java
names.stream()
        .filter(name -> name.length() > 4)
        .map(name -> name.toUpperCase())
        .toList();
```

---

## 6. `filter`

`filter` is used to keep only the elements that meet a condition.

Receive an `Predicate<T>`.

Example:
```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo");

        List<String> longNames = names.stream()
                .filter(name -> name.length() >= 5)
                .toList();

        System.out.println(longNames);
    }
}
```

Only names with length greater than or equal to 5 are passed here.

---

## 7. `map`

`map` is used to transform each element into another value.

Receive an `Function<T, R>`.

Example:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        List<String> upperNames = names.stream()
                .map(name -> name.toUpperCase())
                .toList();

        System.out.println(upperNames);
    }
}
```

Each original `String` is transformed into its uppercase version.

---

## 8. Chain `filter` and `map`

This is very common in `Stream API`.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo");

        List<String> result = names.stream()
                .filter(name -> name.length() >= 5)
                .map(name -> name.toUpperCase())
                .toList();

        System.out.println(result);
    }
}
```

Process:

1. part of the original list
2. filter out long names
3. transforms them to uppercase letters
4. create a new list

---

## 9. `forEach`

`forEach` is a terminal operation that executes an action for each item.

Receive an `Consumer<T>`.

Example:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        names.stream()
                .forEach(name -> System.out.println(name));
    }
}
```

You can also use a method reference:

```java
names.stream()
        .forEach(System.out::println);
```

---

## 10. `toList`

`toList()` converts the stream result into a list.

Example:

```java
List<String> result = names.stream()
        .filter(name -> name.startsWith("A"))
        .toList();
```

It is a very convenient way to end a chain of operations.

---

## 11. `count`

`count` returns how many elements there are after processing.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo");

        long count = names.stream()
                .filter(name -> name.length() >= 5)
                .count();

        System.out.println(count);
    }
}
```

Here you count how many names have at least 5 characters.

---

## 12. `sorted`

`sorted` sorts the elements.

### 12.1. natural order

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Maria", "Alex", "Laura");

        List<String> sortedNames = names.stream()
                .sorted()
                .toList();

        System.out.println(sortedNames);
    }
}
```

### 12.2. With comparator

```java
import java.util.Comparator;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Maria", "Alex", "Laura");

        List<String> sortedByLength = names.stream()
                .sorted(Comparator.comparingInt(name -> name.length()))
                .toList();

        System.out.println(sortedByLength);
    }
}
```

---

## 13. `distinct`

`distinct` removes duplicates.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Laura", "Maria", "Alex");

        List<String> uniqueNames = names.stream()
                .distinct()
                .toList();

        System.out.println(uniqueNames);
    }
}
```

It is very useful when you want to clean replays.

---

## 14. `limit` and `skip`

### 14.1. `limit`

It keeps the first `n` elements.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "John", "Emma");

        List<String> firstThree = names.stream()
                .limit(3)
                .toList();

        System.out.println(firstThree);
    }
}
```

### 14.2. `skip`

Skip the first `n` elements.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "John", "Emma");

        List<String> afterTwo = names.stream()
                .skip(2)
                .toList();

        System.out.println(afterTwo);
    }
}
```

---

## 15. `findFirst`

`findFirst` returns the first element, if it exists.

The result is an `Optional<T>`.

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        Optional<String> result = names.stream()
                .filter(name -> name.startsWith("A"))
                .findFirst();

        System.out.println(result);
    }
}
```

If you want to act on the value:

```java
result.ifPresent(System.out::println);
```

---

## 16. `anyMatch`, `allMatch` and `noneMatch`

These methods are used to check conditions.

### 16.1. `anyMatch`

Returns `true` if at least one element meets the condition.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        boolean hasShortName = names.stream()
                .anyMatch(name -> name.length() < 4);

        System.out.println(hasShortName);
    }
}
```

### 16.2. `allMatch`

Returns `true` if everyone meets the condition.

```java
boolean allLongEnough = names.stream()
        .allMatch(name -> name.length() >= 3);
```

### 16.3. `noneMatch`

Returns `true` if none meet the condition.

```java
boolean noneStartsWithZ = names.stream()
        .noneMatch(name -> name.startsWith("Z"));
```

---

## 17. `reduce`

`reduce` is used to combine all elements into a single result.

Example: adding numbers.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(10, 20, 30, 40);

        int sum = numbers.stream()
                .reduce(0, (a, b) -> a + b);

        System.out.println(sum);
    }
}
```

Here:

- `0` is the initial value
- `(a, b) -> a + b` indicates how to combine values

---

## 18. Example with `reduce` to concatenate text

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> words = List.of("Java", "Stream", "API");

        String result = words.stream()
                .reduce("", (a, b) -> a + " " + b)
                .trim();

        System.out.println(result);
    }
}
```

---

## 19. `collect`

`collect` is a very important terminal operation that allows you to collect results in different ways.

Although `toList()` is very convenient, `collect` offers more options.

Example with `Collectors.toList()`:

```java
import java.util.List;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        List<String> result = names.stream()
                .map(name -> name.toUpperCase())
                .collect(Collectors.toList());

        System.out.println(result);
    }
}
```

---

## 20. `collect` with `joining`

You can also join chains.

```java
import java.util.List;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        String result = names.stream()
                .collect(Collectors.joining(", "));

        System.out.println(result);
    }
}
```

Result:

```text
Laura, Alex, Maria
```

---

## 21. `collect` with `toSet`

You can collect the result into a set.

```java
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Laura", "Maria");

        Set<String> uniqueNames = names.stream()
                .collect(Collectors.toSet());

        System.out.println(uniqueNames);
    }
}
```

---

## 22. Mental flow of a stream

A stream usually reads like this:

```java
source.stream()
        .intermediateOperation(...)
        .intermediateOperation(...)
        .terminalOperation(...)
```

For example:

```java
names.stream()
        .filter(name -> name.length() > 4)
        .map(name -> name.toUpperCase())
        .sorted()
        .toList();
```

Natural reading:

- take the list
- stick with long names
- convert them to uppercase
- order them
- convert them into list

---

## 23. Streams do not modify the original collection

This is very important.

Example:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        List<String> upperNames = names.stream()
                .map(name -> name.toUpperCase())
                .toList();

        System.out.println(names);
        System.out.println(upperNames);
    }
}
```

The original list remains the same.  
The stream produces a new result.

---

## 24. A stream is not reused

Once you execute a terminal operation, that stream can no longer be used.

Incorrect example:

```java
// Stream<String> stream = names.stream();
// stream.forEach(System.out::println);
// stream.count(); // error
```

If you need other processing, create a new stream.

---

## 25. Guided Example: Filter Even Numbers

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(1, 2, 3, 4, 5, 6);

        List<Integer> evenNumbers = numbers.stream()
                .filter(number -> number % 2 == 0)
                .toList();

        System.out.println(evenNumbers);
    }
}
```

---

## 26. Guided example: transforming names to uppercase

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        List<String> result = names.stream()
                .map(name -> name.toUpperCase())
                .toList();

        System.out.println(result);
    }
}
```

---

## 27. Guided Example: Filter and Sort

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo", "Emma");

        List<String> result = names.stream()
                .filter(name -> name.length() >= 4)
                .sorted()
                .toList();

        System.out.println(result);
    }
}
```

---

## 28. Guided Example: Counting Items That Meet a Condition

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo");

        long count = names.stream()
                .filter(name -> name.contains("a") || name.contains("A"))
                .count();

        System.out.println(count);
    }
}
```

---

## 29. Guided Example: Get the first number greater than 10

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(3, 7, 12, 20, 5);

        Optional<Integer> result = numbers.stream()
                .filter(number -> number > 10)
                .findFirst();

        result.ifPresent(System.out::println);
    }
}
```

---

## 30. Guided Example: Add with `reduce`

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(5, 10, 15);

        int total = numbers.stream()
                .reduce(0, (a, b) -> a + b);

        System.out.println(total);
    }
}
```

---

## 31. Guided Example: Remove Duplicates and Sort

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Laura", "Maria", "Alex");

        List<String> result = names.stream()
                .distinct()
                .sorted()
                .toList();

        System.out.println(result);
    }
}
```

---

## 32. Guided Example: Working with Objects

Streams are especially useful when working with objects.

### 32.1. `Product` class

```java
public class Product {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }
}
```

### 32.2. Use with stream

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Product> products = List.of(
                new Product("Mouse", 19.99),
                new Product("Keyboard", 49.99),
                new Product("Monitor", 199.99),
                new Product("Cable", 5.99)
        );

        List<String> expensiveProductNames = products.stream()
                .filter(product -> product.getPrice() > 20)
                .map(product -> product.getName())
                .toList();

        System.out.println(expensiveProductNames);
    }
}
```

Here:

- you filter expensive products
- you transform each product into its name
- you collect the result in a list

---

## 33. `map` does not modify, transforms

This is key:

- `filter` decides whether an item passes or not
- `map` transforms an element into another value

Example:

```java
List<Integer> lengths = names.stream()
        .map(name -> name.length())
        .toList();
```

Here you convert a list of `String` to a list of `Integer`.

---

## 34. `Stream API` and lazy (_lazy evaluation_)

Intermediate operations like `filter` or `map` are lazy.

That means they don't get the job done right away.  
The actual processing occurs when a terminal operation appears.

Example:

```java
names.stream()
        .filter(name -> name.length() > 3)
        .map(name -> name.toUpperCase());
```

Nothing useful happens here yet until you put something like:

```java
.toList()
```

or:

```java
.forEach(...)
```

At the initial level, the important thing is to remember:

- intermediate operations prepare processing
- the terminal operation executes it

---

## 35. When to use `Stream API`

Use streams when you need:

- filter collections
- transform data
- sort results
- count elements
- search values
- chain several processing operations

It is especially useful when the flow is clear and expressive.

---

## 36. When it is not advisable to abuse streams

Although they are very useful, not everything should be done with streams.

Avoid complicating the code if:

- the logic is very long
- you need a lot of hard to read conditions
- a simple `for` is clearer
- the team will better understand an imperative version

The idea is not to always use streams, but when they improve the code.

---

## 37. Typical mistakes when starting

### 37.1. Thinking that a stream modifies the original list

It does not modify it.  
Produces a new result.

### 37.2. Try to reuse a stream

A stream is only used once.

### 37.3. Confusing `filter` with `map`

- `filter` select
- `map` transforms

### 37.4. Forget terminal operation
Without terminal operation, processing is not completed.

### 37.5. Write stream strings that are difficult to read

If a chain starts to get too complex, you may want to split it or use another approach.

---

## 38. Good practices

- Use streams when they make the code clearer.
- Keep lambdas small and readable.
- Use `map` to transform and `filter` to select.
- Prefers clear names when an expression becomes difficult to understand.
- Don't force the use of streams in cases where a simple loop is more expressive.
- Remember that `toList()`, `count()`, `findFirst()` or `forEach()` close the stream.

---

## 39. To take into account

- An `Stream` is a processing sequence, not a collection.
- It is usually created from lists, arrays or other sources.
- There are intermediate and terminal operations.
- `filter` filters, `map` transforms, `sorted` sorts, `distinct` removes duplicates.
- `count`, `forEach`, `toList`, `findFirst` and `reduce` are very common terminal operations.
- Streams do not modify the original collection.
- A stream is not reused.
- `Stream API` relies heavily on lambdas and functional interfaces.

---

## 40. Final summary

`Stream API` is one of the most powerful tools in modern Java for working with data declaratively.

It allows you to chain operations such as:

- filter
- transform
- sort
- count
- collect results

in a clear and elegant way.

At first it may seem like a new syntax, but once you understand the difference between:

- origin
- intermediate operations
- terminal operation

everything starts to make a lot of sense.

Mastering `Stream API` will greatly help you write cleaner, more expressive code when working with:

- lists
- sets
- maps
- objects
- search results
- data transformations

---

In the next topic we will continue advancing with modern Java and see **Optional**, a very useful tool to represent the presence or absence of a value in a more secure way.
