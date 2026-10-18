# Topic 25. `Map` and `HashMap`

## 1. Introduction

Until now you have worked with structures such as:

- Arrays
- `ArrayList`
- Classes and objects
- Enums

With them you can store a lot of data, but sometimes a different need arises:

> I want to save a value and retrieve it using a key.

For example:

- The age of a person based on their name
- The price of a product based on its code
- A student's grade based on their identifier
- The stock quantity based on the product name
- The country of a city based on the city's name

With a list, searching for a value by “name” can be awkward, because you usually access it by position (`0`, `1`, `2`...).

To solve this problem, Java has the **`Map`** structure, and one of its most widely used implementations is:

- `HashMap`

In this topic you will learn:

- What a `Map` is
- What a `HashMap` is
- How to store key-value pairs
- How to add, read, modify and delete elements
- How to iterate over a `HashMap`
- Very useful methods like `containsKey`, `getOrDefault`, `putIfAbsent`
- What happens with duplicate keys, `null` and ordering
- Typical mistakes and good practices

---

[![Maps](https://img.youtube.com/vi/uC5sj53SYDo/0.jpg)](https://www.youtube.com/watch?v=uC5sj53SYDo&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is a `Map`

A `Map` is a structure that stores data in this format:

- **key** → **value**

Conceptual example:

```text
"Laura"  ->  28
"Alex"   ->  35
"Maria"  ->  31
```

Here:

- The key can be the name
- The value can be the age

The important idea is this:

> In a `Map`, you do not search by index, but by key.

---

## 3. What is a `HashMap`

`HashMap` is a Java class that implements the `Map` interface.

In practice, `HashMap` is one of the most common options when you need:

- To store key-value pairs
- Fast lookups by key
- To add and delete entries easily

Think of a `HashMap` as a kind of “dictionary”:

- you give it a key
- Java finds the associated value

---

## 4. Required imports

`Map` and `HashMap` are in `java.util`, so you have to import them:

```java
import java.util.HashMap;
import java.util.Map;
```

---

## 5. `Map<K, V>`: generics

As with `List<T>`, maps use generics.

The general form is:

```java
Map<K, V>
```

Where:

- `K` = key type (_key_)
- `V` = value type (_value_)

Example:

```java
Map<String, Integer> ages = new HashMap<>();
```

Here you are saying:

- The key will be a `String`
- The value will be an `Integer`

In other words:

- `"Laura"` → `28`
- `"Alex"` → `35`

---

## 6. Why do we use wrappers in `HashMap`?

Just as with collections, in a `Map` the generic types must be **objects**, not primitive types.

This does not exist:

```java
// Map<String, int> ages = new HashMap<>(); // NO
```

The correct way is:

```java
Map<String, Integer> ages = new HashMap<>();
Map<String, Double> prices = new HashMap<>();
Map<Integer, Boolean> answers = new HashMap<>();
```

That's why the **wrappers** appear again here:

- `Integer`
- `Double`
- `Boolean`
- etc.

---

## 7. Creating a `HashMap`

Recommended way:

```java
Map<String, Integer> ages = new HashMap<>();
```

Why this way:

- You declare it with the interface (`Map`)
- You create it with a concrete implementation (`HashMap`)

You could also do:

```java
HashMap<String, Integer> ages = new HashMap<>();
```

But it is usually recommended to program against the interface.

---

## 8. Basic operation: `put(key, value)`

To store an entry in the map, you use `put`.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);
        ages.put("Maria", 31);

        System.out.println(ages);
    }
}
```

Here you have stored three key-value pairs.

---

## 9. Reading a value: `get(key)`

To retrieve the value associated with a key, you use `get`.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);

        System.out.println(ages.get("Laura")); // 28
        System.out.println(ages.get("Alex"));  // 35
    }
}
```

The idea is:

- you give it a key
- Java returns the associated value

---

## 10. What happens if the key does not exist

If you call `get` with a key that is not in the map, the result will be `null`.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

System.out.println(ages.get("David")); // null
```

This is very important.

If the expected value is an object, `null` means:

- there is no such key
- or there is no associated value

With wrappers this can be tricky:

```java
Integer age = ages.get("David");
System.out.println(age); // null
```

But this would be dangerous:

```java
// int age = ages.get("David"); // puede dar NullPointerException por unboxing
```

---

## 11. Duplicate keys: the value is overwritten

In a `Map`, keys must be unique.

If you insert the same key twice, the previous value is replaced.

```java
Map<String, Integer> ages = new HashMap<>();

ages.put("Laura", 28);
ages.put("Laura", 29);

System.out.println(ages.get("Laura")); // 29
```

Key point:

- **There are no duplicate keys**
- The new insertion overwrites the previous value

---

## 12. Size and checks: `size()` and `isEmpty()`

### 12.1. `size()`

Returns how many entries there are in the map.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);

System.out.println(ages.size()); // 2
```

### 12.2. `isEmpty()`

Tells you whether the map is empty.

```java
Map<String, Integer> ages = new HashMap<>();

if (ages.isEmpty()) {
    System.out.println("The map is empty");
}
```

---

## 13. Checking whether a key exists: `containsKey`

You will very often want to check whether a key exists before using it.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

System.out.println(ages.containsKey("Laura")); // true
System.out.println(ages.containsKey("David")); // false
```

This is usually clearer than relying on `get(...) == null`, especially when `null` could also be a valid value.

---

## 14. Checking whether a value exists: `containsValue`

You can also check whether a value exists in any entry.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);

System.out.println(ages.containsValue(28)); // true
System.out.println(ages.containsValue(50)); // false
```

---

## 15. Deleting entries: `remove`

### 15.1. Deleting by key

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);

ages.remove("Laura");

System.out.println(ages); // {Alex=35}
```

### 15.2. `remove` returns the deleted value

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

Integer removedAge = ages.remove("Laura");
System.out.println(removedAge); // 28
```

If the key does not exist, it returns `null`.

---

## 16. Modifying a value

Since `put` overwrites the value if the key already exists, it is also useful for modifying values.

```java
Map<String, Double> prices = new HashMap<>();

prices.put("Mouse", 19.99);
prices.put("Mouse", 17.99);

System.out.println(prices.get("Mouse")); // 17.99
```

---

## 17. Iterating over a `HashMap`

Unlike lists and arrays, here you don't work by index.

You will typically iterate over a map in three main ways:

- by keys
- by values
- by full entries (`key` + `value`)

---

## 18. Iterating over keys with `keySet()`

`keySet()` returns a set with all the keys in the map.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);
        ages.put("Maria", 31);

        for (String name : ages.keySet()) {
            System.out.println(name);
        }
    }
}
```

This prints the keys.

---

## 19. Iterating over values with `values()`

`values()` returns a collection with all the values.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);
        ages.put("Maria", 31);

        for (Integer age : ages.values()) {
            System.out.println(age);
        }
    }
}
```

This prints the values.

---

## 20. Iterating over keys and values with `entrySet()`

This is one of the most useful ways.

`entrySet()` returns the set of entries in the map.

Each entry has:

- a key
- a value

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);
        ages.put("Maria", 31);

        for (Map.Entry<String, Integer> entry : ages.entrySet()) {
            System.out.println("Key: " + entry.getKey() + " | Value: " + entry.getValue());
        }
    }
}
```

This approach is very common when you need to work with both parts at the same time.

---

## 21. `getOrDefault(key, defaultValue)`

This method returns:

- the actual value if the key exists
- a default value if it does not exist

Example:

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

int lauraAge = ages.getOrDefault("Laura", 0);
int davidAge = ages.getOrDefault("David", 0);

System.out.println(lauraAge); // 28
System.out.println(davidAge); // 0
```

This is very useful for avoiding `null` in many cases.

---

## 22. `putIfAbsent(key, value)`
This method inserts an entry **only if the key does not already exist**.

```java
Map<String, String> countries = new HashMap<>();

countries.put("Madrid", "Spain");
countries.putIfAbsent("Madrid", "Portugal");

System.out.println(countries.get("Madrid")); // Spain
```

The second insertion doesn't change anything because `"Madrid"` was already in the map.

---

## 23. `replace(key, value)`

`replace` changes a value only if the key already exists.

```java
Map<String, Double> prices = new HashMap<>();

prices.put("Keyboard", 49.99);
prices.replace("Keyboard", 44.99);

System.out.println(prices.get("Keyboard")); // 44.99
```

If the key does not exist, nothing is added.

---

## 24. `clear()`

Empties the map completely.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);

ages.clear();

System.out.println(ages.size());    // 0
System.out.println(ages.isEmpty()); // true
```

---

## 25. Order in `HashMap`

A very important point:

> `HashMap` **does not guarantee the order** of its elements.

Example:

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);
ages.put("Maria", 31);

System.out.println(ages);
```

You might see something like:

```text
{Alex=35, Laura=28, Maria=31}
```

or, in another case, a different order.

### 25.1. Key idea

- Do not assume that the order will be the insertion order
- Do not use `HashMap` if you need a specific order

Later, when you study other implementations, you will see alternatives such as:

- `LinkedHashMap` → keeps the insertion order
- `TreeMap` → sorts by key

But in this topic we focus on `HashMap`.

---

## 26. `null` in `HashMap`

`HashMap` lets you work with `null` in some cases.

### 26.1. `null` key

A `null` key can exist:

```java
Map<String, String> data = new HashMap<>();
data.put(null, "No key");

System.out.println(data.get(null)); // No key
```

### 26.2. `null` values

You can also store `null` values:

```java
Map<String, String> users = new HashMap<>();
users.put("Laura", null);

System.out.println(users.get("Laura")); // null
```

### 26.3. Be careful with this

Although Java allows it, from a design point of view it can complicate your code:

- `null` can mean “the key does not exist”
- or “the key exists but the value is null”

That is why it is advisable to use it with care.

---

## 27. Guided example 1: student grades

We are going to use a very clear case.

We want to store the grades of several students using their names as keys.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> grades = new HashMap<>();

        grades.put("Laura", 8.5);
        grades.put("Alex", 6.0);
        grades.put("Maria", 9.2);

        System.out.println("Laura: " + grades.get("Laura"));
        System.out.println("Alex: " + grades.get("Alex"));
        System.out.println("Maria: " + grades.get("Maria"));
    }
}
```

The great advantage here is that you don't need to search by position.

You search directly by name.

---

## 28. Guided example 2: updating stock

A very realistic case is storing the stock of each product.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> stock = new HashMap<>();

        stock.put("Mouse", 10);
        stock.put("Keyboard", 5);
        stock.put("Monitor", 3);

        stock.put("Mouse", 12); // actualiza el valor

        System.out.println("Mouse stock: " + stock.get("Mouse"));
        System.out.println("Keyboard stock: " + stock.get("Keyboard"));
        System.out.println("Monitor stock: " + stock.get("Monitor"));
    }
}
```

---

## 29. Guided example 3: counting repetitions

This example is very important because it shows a very typical use of `HashMap`.

We want to count how many times each word appears.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        String[] words = {"java", "code", "java", "map", "code", "java"};

        Map<String, Integer> counts = new HashMap<>();

        for (String word : words) {
            int currentCount = counts.getOrDefault(word, 0);
            counts.put(word, currentCount + 1);
        }

        System.out.println(counts);
    }
}
```

Expected result:

```text
{java=3, code=2, map=1}
```

### 29.1. What is happening here

For each word:

1. We check how many times it has already appeared
2. If it is not there yet, we use `0`
3. We store the new, incremented value

This pattern is used a lot in real programming.

---

## 30. Guided example 4: iterating over a whole map

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> prices = new HashMap<>();

        prices.put("Mouse", 19.99);
        prices.put("Keyboard", 49.99);
        prices.put("Monitor", 199.99);

        for (Map.Entry<String, Double> entry : prices.entrySet()) {
            String productName = entry.getKey();
            double productPrice = entry.getValue();

            System.out.println("Product: " + productName + " | Price: " + productPrice);
        }
    }
}
```

---

## 31. Maps with objects as values

A `HashMap` can store more than just numbers or text. You can also store objects.

Example with a `User` class:

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Age: " + age);
    }
}
```

Using it in a map:

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, User> usersById = new HashMap<>();

        usersById.put("u1", new User("Laura", 28));
        usersById.put("u2", new User("Alex", 35));

        User user = usersById.get("u1");

        if (user != null) {
            user.printInfo();
        }
    }
}
```

Here:

- the key is a `String` (`"u1"`, `"u2"`)
- the value is a `User` object

---

## 32. Maps with objects as keys

You can also use objects as keys, but there is an important nuance here:

- the key must be comparable correctly
- this ties in with the topic on `equals`

If you use objects as keys, you will usually have to define these properly:

- `equals`
- `hashCode`

As you are still at an early stage of the course, the safest thing for now is to use simple types as keys, such as:
- `String`
- `Integer`
- `Long`
- enums

Later, when you go deeper into collections and hashing, this part will make a lot more sense.

---

## 33. The conceptual difference between `ArrayList` and `HashMap`

It is important to be clear about the difference.

### 33.1. `ArrayList`

In a list:

- you store items in order
- you access them by index

```java
List<String> names = new ArrayList<>();
names.add("Laura");
names.add("Alex");

System.out.println(names.get(0)); // Laura
```

### 33.2. `HashMap`

In a map:

- you store key-value pairs
- you access them by key

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

System.out.println(ages.get("Laura")); // 28
```

### 33.3. When to use each

Use `ArrayList` when:

- you care about the order
- you want to iterate over elements as a sequence
- you access them by position

Use `HashMap` when:

- you want to search by key
- you need to associate one piece of data with another
- you don't need to access by index

---

## 34. Common beginner mistakes

### 34.1. Thinking that `get` throws an error if the key does not exist

It doesn't throw an error by itself. It returns `null`.

```java
Map<String, Integer> ages = new HashMap<>();
System.out.println(ages.get("Unknown")); // null
```

The problem appears if you then do something that `null` does not support.

---

### 34.2. Assuming that the order is guaranteed

With `HashMap`, the order is not guaranteed.

Don't write code that depends on the printing or iteration order.

---

### 34.3. Confusing `containsKey` with `containsValue`

This checks a key:

```java
ages.containsKey("Laura");
```

This checks a value:

```java
ages.containsValue(28);
```

They are different things.

---

### 34.4. Thinking that a duplicate key creates a second entry

No.

This:

```java
ages.put("Laura", 28);
ages.put("Laura", 29);
```

does not create two entries.

Only one is left:

```text
Laura -> 29
```

---

### 34.5. Forgetting that generics use objects

This is wrong:

```java
// Map<String, int> ages = new HashMap<>();
```

It must be:

```java
Map<String, Integer> ages = new HashMap<>();
```

---

## 35. Good practices to start with

- Use `Map` as the reference type and `HashMap` as the implementation.
- Choose clear names for the variables:
  - `agesByName`
  - `stockByProduct`
  - `usersById`
- Use `getOrDefault` when it makes sense to avoid `null`.
- Use `containsKey` when you want to check clearly whether a key exists.
- Do not rely on the order of a `HashMap`.
- Use simple and stable keys when you are starting out.

---

## 36. Complete example: simple product management

This example brings together several operations in a realistic case.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> pricesByProduct = new HashMap<>();

        pricesByProduct.put("Mouse", 19.99);
        pricesByProduct.put("Keyboard", 49.99);
        pricesByProduct.put("Monitor", 199.99);

        System.out.println("Initial map: " + pricesByProduct);

        double mousePrice = pricesByProduct.getOrDefault("Mouse", 0.0);
        double laptopPrice = pricesByProduct.getOrDefault("Laptop", 0.0);

        System.out.println("Mouse price: " + mousePrice);
        System.out.println("Laptop price: " + laptopPrice);

        pricesByProduct.put("Mouse", 17.99);
        pricesByProduct.putIfAbsent("Laptop", 899.99);

        System.out.println("After updates: " + pricesByProduct);

        if (pricesByProduct.containsKey("Monitor")) {
            System.out.println("Monitor exists");
        }

        pricesByProduct.remove("Keyboard");

        for (Map.Entry<String, Double> entry : pricesByProduct.entrySet()) {
            System.out.println("Product: " + entry.getKey() + " | Price: " + entry.getValue());
        }
    }
}
```

---

## 37. Things to keep in mind

- `Map` represents a key-value structure.
- `HashMap` is a widely used implementation of `Map`.
- Keys must be unique.
- `put` adds or replaces.
- `get` retrieves a value by its key.
- `containsKey` and `containsValue` are used for checks.
- `entrySet()` is very useful for iterating over keys and values at the same time.
- `HashMap` does not guarantee order.
- `getOrDefault` and `putIfAbsent` are very practical methods.
- Generics use objects (`Integer`, `Double`, etc.), not primitives.

---

## 38. Final summary

`HashMap` is one of the most useful structures in Java when you need to relate data.

It allows you to work with a very powerful idea:

- instead of searching by position
- you search by a meaningful key

That makes many problems easier to model.

Typical examples:

- name → age
- product → price
- userId → user
- word → number of repetitions

Mastering `HashMap` will help you a lot in real projects, because maps constantly appear in applications, APIs, configurations, counts, caches and data structures of all kinds.

---

In the next topic we will continue with other very common Java collections, such as `Set`, `LinkedHashMap`, `TreeMap` or iterators, to broaden your mastery of the collections library.
