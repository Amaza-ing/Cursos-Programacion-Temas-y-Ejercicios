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
- The country of a city from the city name

With a list, searching for a value by “name” can be awkward, because you usually access it by position (`0`, `1`, `2`...).

To solve this problem, Java has the **`Map`** structure, and one of its most used implementations is:

- `HashMap`

In this topic you will learn:

- What is an `Map`
- What is an `HashMap`
- How to save key-value pairs
- How to add, read, modify and delete elements
- How to tour an `HashMap`
- Very useful methods like `containsKey`, `getOrDefault`, `putIfAbsent`
- What happens with duplicate keys, `null` and the order
- Typical errors and good practices

---

[![Maps](https://img.youtube.com/vi/uC5sj53SYDo/0.jpg)](https://www.youtube.com/watch?v=uC5sj53SYDo&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is an `Map`

An `Map` is a structure that stores data in format:

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

> In an `Map`, you do not search by index, but by key.

---

## 3. What is an `HashMap`

`HashMap` is a Java class that implements the `Map` interface.

In practice, `HashMap` is one of the most common options when you need:

- Save key-value pairs
- Quick search by key
- Add and delete entries with ease

Think of an `HashMap` as a kind of “dictionary”:

- you give a key
- Java finds the associated value

---

## 4. Import required

`Map` and `HashMap` are in `java.util`, so you have to import them:

```java
import java.util.HashMap;
import java.util.Map;
```

---

## 5. `Map<K, V>`: generics

As with `List<T>`, the maps use generics.

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

- The key will be `String`
- The value will be `Integer`

That is to say:

- `"Laura"` → `28`
- `"Alex"` → `35`

---

## 6. Why do we use wrappers in `HashMap`?

Just as in collections, in an `Map` generic types must be **objects**, not primitive types.

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

## 7. Create an `HashMap`

Recommended way:

```java
Map<String, Integer> ages = new HashMap<>();
```

Why so:

- You declare with the interface (`Map`)
- You create with a concrete implementation (`HashMap`)

You could also do:

```java
HashMap<String, Integer> ages = new HashMap<>();
```

But it is usually recommended to program against the interface.

---

## 8. Basic operation: `put(key, value)`

To save an entry on the map, `put` is used.

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

Here you have saved three key-value pairs.

---

## 9. Read a value: `get(key)`

To retrieve a value associated with a key, `get` is used.

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

- you give a key
- Java returns the associated value

---

## 10. What if the key does not exist

If you call `get` with a key that is not in the map, the result will be `null`.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

System.out.println(ages.get("David")); // null
```

This is very important.

If the expected value is an object, `null` means:

- there is no such key
- or there is no value associated

With wrappers it can be delicate:

```java
Integer age = ages.get("David");
System.out.println(age); // null
```

But this would be dangerous:

```java
// int age = ages.get("David"); // puede dar NullPointerException por unboxing
```

---

## 11. Duplicate keys: value is overwritten

In an `Map`, the keys must be unique.

If you insert the same key twice, the previous value is replaced.

```java
Map<String, Integer> ages = new HashMap<>();

ages.put("Laura", 28);
ages.put("Laura", 29);

System.out.println(ages.get("Laura")); // 29
```

Key point:

- **No duplicate keys**
- The new insertion overwrites the previous value

---

## 12. Size and checks: `size()` e `isEmpty()`

### 12.1. `size()`

Returns how many entries there are in the map.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);

System.out.println(ages.size()); // 2
```

### 12.2. `isEmpty()`

Indicates if the map is empty.

```java
Map<String, Integer> ages = new HashMap<>();

if (ages.isEmpty()) {
    System.out.println("The map is empty");
}
```

---

## 13. Check if a key exists: `containsKey`

It is very common to want to check if a key exists before using it.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

System.out.println(ages.containsKey("Laura")); // true
System.out.println(ages.containsKey("David")); // false
```

This is usually clearer than depending on `get(...) == null`, especially when `null` could also be a valid value.

---

## 14. Check if a value exists: `containsValue`

You can also check if a value exists in any entry.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);

System.out.println(ages.containsValue(28)); // true
System.out.println(ages.containsValue(50)); // false
```

---

## 15. Delete entries: `remove`

### 15.1. Delete by key

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

## 16. Modify a value

Since `put` overwrites the value if the key already exists, it is also useful for modification.

```java
Map<String, Double> prices = new HashMap<>();

prices.put("Mouse", 19.99);
prices.put("Mouse", 17.99);

System.out.println(prices.get("Mouse")); // 17.99
```

---

## 17. Loop through an `HashMap`

Unlike lists and arrays, here you don't work by index.

You will typically navigate a map in three main ways:

- by keys
- by values
- for full entries (`key` + `value`)

---

## 18. Loop keys with `keySet()`

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

## 19. Loop through values with `values()`

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

## 20. Loop key and value with `entrySet()`

This is one of the most useful ways.

`entrySet()` returns the set of map entries.

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

This way is very common when you need to work with both parts at the same time.

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

This is very useful to avoid `null` in many cases.

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

Completely empty the map.

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

or in another case a different order.

### 25.1. Key idea

- Do not assume that the order will be the insertion order
- Do not use `HashMap` if you need a specific order

Later, when you study other implementations, you will see alternatives such as:

- `LinkedHashMap` → maintains insertion order
- `TreeMap` → sort by key

But in this topic we focus on `HashMap`.

---

## 26. `null` in `HashMap`

`HashMap` allows working with `null` in some cases.

### 26.1. Key `null`

A key `null` may exist:

```java
Map<String, String> data = new HashMap<>();
data.put(null, "No key");

System.out.println(data.get(null)); // No key
```

### 26.2. `null` Securities

You can also save `null` values:

```java
Map<String, String> users = new HashMap<>();
users.put("Laura", null);

System.out.println(users.get("Laura")); // null
```

### 26.3. Be careful with this

Although Java allows it, at the design level it can complicate your code:

- `null` can mean “the key does not exist”
- or “the key exists but the value is null”

That is why it is advisable to use it with care.

---

## 27. Guided Example 1: Student Notes

We are going to use a very clear case.

We want to save the grade of several students using their name as a key.

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

## 28. Guided Example 2: Update Stock

A very realistic case is to save stock by product.

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

## 29. Guided Example 3: Counting Reps

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

1. We looked at how many times it had already appeared
2. If it was not there, we use `0`
3. We save the new incremented value

This pattern is used a lot in real programming.

---

## 30. Guided Example 4: Traverse an Entire Map

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

## 31. Maps with objects as value

An `HashMap` can not only store numbers or text. You can also save items.

Example with an `User` class:

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

Map usage:

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

- the key is an `String` (`"u1"`, `"u2"`)
- the value is an `User` object

---

## 32. Maps with objects as key

You can also use objects as a key, but there is an important nuance here:

- the key must be able to be compared correctly
- this connects with the topic of `equals`

If you use objects as a key, you will usually have to define well:

- `equals`
- `hashCode`

As you are still in an initial phase of the course, the safest thing for now is to use simple types like:
- `String`
- `Integer`
- `Long`
- enums

Later, when you delve into collections and hashing, this part will make a lot more sense.

---

## 33. Mental difference between `ArrayList` and `HashMap`

It is important to be clear about the difference.

### 33.1. `ArrayList`

In a list:

- you keep items in order
- access by index

```java
List<String> names = new ArrayList<>();
names.add("Laura");
names.add("Alex");

System.out.println(names.get(0)); // Laura
```

### 33.2. `HashMap`

On a map:

- saves key-value pairs
- access by password

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

System.out.println(ages.get("Laura")); // 28
```

### 33.3. When to use each

Use `ArrayList` when:

- you care about the order
- you want to loop through elements as a sequence
- you access by position

Use `HashMap` when:

- you want to search by key
- you need to associate one data with another
- you are not interested in accessing by index

---

## 34. Typical mistakes when starting

### 34.1. Thinking that `get` throws an error if the key does not exist

It doesn't throw error by itself. Returns `null`.

```java
Map<String, Integer> ages = new HashMap<>();
System.out.println(ages.get("Unknown")); // null
```

The problem appears if you then do something that `null` does not support.

---

### 34.2. Assume that order is guaranteed

With `HashMap`, order is not guaranteed.

Don't write code that depends on printing or traversal order.

---

### 34.3. Confusing `containsKey` with `containsValue`

This checks key:

```java
ages.containsKey("Laura");
```

This checks value:

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

Just leave one:

```text
Laura -> 29
```

---

### 34.5. Forget that generics use objects

This is wrong:

```java
// Map<String, int> ages = new HashMap<>();
```

It must be:

```java
Map<String, Integer> ages = new HashMap<>();
```

---

## 35. Good initial practices

- Use `Map` as reference type and `HashMap` as implementation.
- Choose clear names for the variables:
  - `agesByName`
  - `stockByProduct`
  - `usersById`
- Use `getOrDefault` when it makes sense to avoid `null`.
- Use `containsKey` when you want to clearly check if a key exists.
- Do not depend on the order in `HashMap`.
- Use simple and stable keys when you are starting out.

---

## 36. Complete Example: Simple Product Management

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

## 37. To take into account

- `Map` represents a key-value structure.
- `HashMap` is a widely used implementation of `Map`.
- Keys must be unique.
- `put` adds or replaces.
- `get` retrieves one value per key.
- `containsKey` and `containsValue` are used for checks.
- `entrySet()` is very useful for looping key and value at the same time.
- `HashMap` does not guarantee order.
- `getOrDefault` and `putIfAbsent` are very practical methods.
- Generics use objects (`Integer`, `Double`, etc.), not primitives.

---

## 38. Final summary

`HashMap` is one of the most useful structures in Java when you need to relate data.

It allows you to work with a very powerful idea:

- instead of searching by position
- you search for a meaningful key

That makes many problems easier to model.

Typical examples:

- name → age
- product → price
- userId → user
- word → number of repetitions

Mastering `HashMap` will help you a lot in real projects, because maps constantly appear in applications, APIs, configurations, counts, caches and data structures of all kinds.

---

In the next topic we will continue with other very common Java collections, such as `Set`, `LinkedHashMap`, `TreeMap` or iterators, to expand your mastery of the collection library.
