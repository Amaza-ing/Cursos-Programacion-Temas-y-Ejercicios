# Topic 28. Generics

## 1. Introduction

In previous topics you have worked with collections such as:

- `ArrayList`
- `HashMap`
- `Set`
- `TreeMap`

And you've probably already seen syntax like this:

```java
List<String> names = new ArrayList<>();
Map<String, Integer> ages = new HashMap<>();
Set<Double> prices = new HashSet<>();
```

That `<String>`, `<Integer>` or `<Double>` is part of a very important feature of Java:

- **Generics**

**generics** allow you to write classes, interfaces and methods that work with **parameterized types**, that is, with a type that is indicated later.

The great advantage is that they allow:

- reuse code
- work with types safely
- avoid many runtime errors
- write cleaner and more expressive APIs

In this topic you will learn:

- What are generics?
- Why they are useful
- What problem do they solve?
- How to use generics in collections
- How to create generic classes
- How to create generic methods
- What are wildcards (`?`, `? extends`, `? super`)
- What limitations do generics have in Java?
- Typical errors and good practices

---

## 2. The problem before generics

To understand why generics exist, you first have to look at the problem they solve.

Before using generics, a collection could store elements like `Object`.

Conceptual example:

```java
List values = new ArrayList();
values.add("Laura");
values.add(28);
values.add(true);
```

Here you can enter everything:

- `String`
- `Integer`
- `Boolean`

That seems flexible, but it has several problems:

- you lose type safety
- you need manual conversions (_casting_)
- it is easier to make mistakes

Example:

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List values = new ArrayList();

        values.add("Laura");
        values.add(28);

        String name = (String) values.get(0);
        String wrongValue = (String) values.get(1); // error en ejecución
    }
}
```

The problem is that Java allows that code to be compiled, but it fails at runtime with an exception.

Generics avoid precisely this type of situation.

---

## 3. What are generics

Generics allow types to be defined using a type parameter.

Example:

```java
List<String> names = new ArrayList<>();
```

Here `String` is the specific type that you have indicated.

That means:

- this list can only save `String`
- if you try to enter another type, Java will flag a compilation error

Example:

```java
List<String> names = new ArrayList<>();
names.add("Laura");
names.add("Alex");

// names.add(25); // error
```

This makes the code much more secure.

---

## 4. Main advantages of generics

The most important advantages are these:

### 4.1. Type Safety

You avoid mixing incorrect types in a structure.

### 4.2. Less casting

You don't need to constantly do manual conversions.

### 4.3. Clearer code

When you see this:

```java
List<String> names
```

You already know that there is only `String` there.

### 4.4. Reuse

You can create classes and methods that work with different types without duplicating code.

---

## 5. Generics in collections

Most early uses of generics appear in collections.

### 5.1. `List<String>`

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>();

        names.add("Laura");
        names.add("Alex");

        String firstName = names.get(0);
        System.out.println(firstName);
    }
}
```

Notice that `get(0)` already returns an `String`.  
There is no need to cast.

---

### 5.2. `List<Integer>`

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = new ArrayList<>();

        numbers.add(10);
        numbers.add(20);
        numbers.add(30);

        int value = numbers.get(1);
        System.out.println(value);
    }
}
```

Wrappers (`Integer`) are used here instead of `int`, because generics work with objects, not primitive types.

---

### 5.3. `Map<String, Integer>`

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);

        int age = ages.get("Laura");
        System.out.println(age);
    }
}
```

---

## 6. General syntax of type parameters

Type parameters are usually written between `< >`.

Simple example:

```java
ClassName<T>
```

You can see names like:

- `T` → Type
- `E` → Element
- `K` → Key
- `V` → Value

They are very common conventions in Java.

Examples:

```java
List<E>
Map<K, V>
Optional<T>
```

---

## 7. Create a generic class

Now we are going to take the important step: not only use generics, but create a generic class.

Imagine a class that holds a single value.

Without generics, you would have to make separate versions:

- `StringBox`
- `IntegerBox`
- `DoubleBox`

With generics, you can make a single class.

### 7.1. Basic example: `Box<T>`

```java
public class Box<T> {
    private T value;

    public Box(T value) {
        this.value = value;
    }

    public T getValue() {
        return value;
    }

    public void setValue(T value) {
        this.value = value;
    }
}
```

Here `T` represents “the type that will be decided when using the class”.

### 7.2. Class usage

```java
public class Main {
    public static void main(String[] args) {
        Box<String> nameBox = new Box<>("Laura");
        Box<Integer> ageBox = new Box<>(28);

        System.out.println(nameBox.getValue());
        System.out.println(ageBox.getValue());
    }
}
```

Now the same class serves different types.

---

## 8. What does `T` mean

`T` is not a special reserved word.  
It's just a letter chosen by convention.

You could write:

```java
public class Box<ValueType> {
    private ValueType value;

    public Box(ValueType value) {
        this.value = value;
    }

    public ValueType getValue() {
        return value;
    }
}
```

This works, but normally in Java short letters are used because they are a very widespread convention.

The most common are:

- `T` → generic type
- `E` → item
- `K` → key
- `V` → value
- `R` → result

---

## 9. Generic class with two parameters

A class can have more than one type parameter.

Example:

```java
public class Pair<K, V> {
    private K key;
    private V value;

    public Pair(K key, V value) {
        this.key = key;
        this.value = value;
    }

    public K getKey() {
        return key;
    }

    public V getValue() {
        return value;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Pair<String, Integer> userAge = new Pair<>("Laura", 28);

        System.out.println(userAge.getKey());
        System.out.println(userAge.getValue());
    }
}
```

---

## 10. Generic methods

Not only classes can be generic. Also the methods.

A generic method defines its own type parameter.

### 10.1. Example: print any value

```java
public class Printer {
    public static <T> void printValue(T value) {
        System.out.println(value);
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Printer.printValue("Laura");
        Printer.printValue(28);
        Printer.printValue(true);
    }
}
```

Here the method works with different types without the need to overload it several times.

---

## 11. Syntax of a generic method

The general syntax is this:

```java
public static <T> ReturnType methodName(T param) {
    ...
}
```

Example:

```java
public static <T> T getFirst(T first, T second) {
    return first;
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        String value1 = getFirst("A", "B");
        Integer value2 = getFirst(10, 20);

        System.out.println(value1);
        System.out.println(value2);
    }

    public static <T> T getFirst(T first, T second) {
        return first;
    }
}
```

---

## 12. Useful example: swapping two values in an array

```java
public class ArrayUtils {
    public static <T> void swap(T[] array, int firstIndex, int secondIndex) {
        T temp = array[firstIndex];
        array[firstIndex] = array[secondIndex];
        array[secondIndex] = temp;
    }
}
```

Usage:

```java
import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        String[] names = {"Laura", "Alex", "Maria"};

        ArrayUtils.swap(names, 0, 2);

        System.out.println(Arrays.toString(names));
    }
}
```

This method works for any type of array of objects:

- `String[]`
- `Integer[]`
- `Double[]`

---

## 13. Restrictions: generics do not accept primitive types

This is very important.

This is not valid:

```java
// Box<int> numberBox = new Box<>(10); // NO
```

The correct way is:

```java
Box<Integer> numberBox = new Box<>(10);
```

The same goes for collections:

```java
List<Integer> numbers = new ArrayList<>();
```

It cannot be `List<int>`.

You must use wrappers:

- `Integer`
- `Double`
- `Boolean`
- `Character`
- etc.

---

## 14. Type inference and diamond operator `<>`

Since Java 7, when the type is already clear on the left, you can use the diamond operator.

Example:

```java
List<String> names = new ArrayList<>();
```

Instead of writing:

```java
List<String> names = new ArrayList<String>();
```

Java can infer the type.

Same here:

```java
Box<String> nameBox = new Box<>("Laura");
```

This makes the code cleaner.

---

## 15. `Object` is not the same as generic

Sometimes someone thinks:

> “If everything inherits from `Object`, why do I need generics?”

The difference is enormous.

### 15.1. With `Object`

```java
public class Box {
    private Object value;

    public Box(Object value) {
        this.value = value;
    }

    public Object getValue() {
        return value;
    }
}
```

Usage:

```java
Box box = new Box("Laura");
String name = (String) box.getValue();
```

You need casting.

### 15.2. With generics

```java
public class Box<T> {
    private T value;

    public Box(T value) {
        this.value = value;
    }

    public T getValue() {
        return value;
    }
}
```

Usage:

```java
Box<String> box = new Box<>("Laura");
String name = box.getValue();
```

Now you don't need casting and the compiler protects your code better.

---

## 16. Wildcards: `?`

Now we are going to see a very important part: the wildcards.
The `?` symbol means:

- “some kind”
- “an unknown guy”

Example:

```java
List<?> values
```

This means:

- a list of some kind
- we don't know which one exactly

It can be:

- `List<String>`
- `List<Integer>`
- `List<Double>`

---

## 17. When to use `List<?>`

It is useful when you just need to read or generally work with a collection regardless of the specific type.

Example:

```java
import java.util.List;

public class Main {
    public static void printList(List<?> values) {
        for (Object value : values) {
            System.out.println(value);
        }
    }
}
```

Usage:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex");
        List<Integer> numbers = List.of(10, 20, 30);

        printList(names);
        printList(numbers);
    }

    public static void printList(List<?> values) {
        for (Object value : values) {
            System.out.println(value);
        }
    }
}
```

Here `printList` is used for lists of any type.

---

## 18. `? extends T`

This wildcard is used when you want to accept a type or any of its subtypes.

Example:

```java
List<? extends Number>
```

This can accept:

- `List<Integer>`
- `List<Double>`
- `List<Long>`

because all those types inherit from `Number`.

### 18.1. Example: adding numbers

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> integers = List.of(10, 20, 30);
        List<Double> doubles = List.of(1.5, 2.5, 3.0);

        System.out.println(sumNumbers(integers));
        System.out.println(sumNumbers(doubles));
    }

    public static double sumNumbers(List<? extends Number> numbers) {
        double sum = 0;

        for (Number number : numbers) {
            sum += number.doubleValue();
        }

        return sum;
    }
}
```

Here the method accepts different numerical lists.

---

## 19. Mind idea of `extends`

When you see this:

```java
<? extends Number>
```

read it like this:

- “some type that is `Number` or inherits from `Number`”

It is very useful for **reading** data from a structure.

---

## 20. `? super T`

This wildcard is used when you want to accept a type or any of its supertypes.

Example:

```java
List<? super Integer>
```

This can accept:

- `List<Integer>`
- `List<Number>`
- `List<Object>`

### 20.1. Conceptual example

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Number> numbers = new ArrayList<>();
        addNumbers(numbers);

        System.out.println(numbers);
    }

    public static void addNumbers(List<? super Integer> values) {
        values.add(10);
        values.add(20);
        values.add(30);
    }
}
```

Here you can add `Integer` because the list accepts `Integer` or a supertype of it.

---

## 21. Very useful rule of thumb: PECS

There is a famous rule to remember `extends` and `super`:

- **Producer Extends**
- **Consumer Super**

Idea:

- if a structure **produces** data to read → `extends`
- if a structure **consumes** data to write → `super`

It is not necessary to memorize it perfectly yet, but you do need to understand the general idea.

---

## 22. Example comparing `extends` and `super`

### 22.1. Read numbers with `extends`

```java
public static double sumNumbers(List<? extends Number> numbers)
```

This signature is good for reading numbers.

### 22.2. Writing integers with `super`

```java
public static void addNumbers(List<? super Integer> values)
```

This signature is good for adding integers.

---

## 23. Generic classes with limits

You can also limit which types are valid in a generic.

Example:

```java
public class NumericBox<T extends Number> {
    private T value;

    public NumericBox(T value) {
        this.value = value;
    }

    public double doubleValue() {
        return value.doubleValue();
    }
}
```

Here `T` must be `Number` or a subtype.

Valid use:

```java
NumericBox<Integer> intBox = new NumericBox<>(10);
NumericBox<Double> doubleBox = new NumericBox<>(5.5);
```

Invalid use:

```java
// NumericBox<String> textBox = new NumericBox<>("Hello"); // error
```

---

## 24. Complete example: `NumericBox<T extends Number>`

```java
public class NumericBox<T extends Number> {
    private T value;

    public NumericBox(T value) {
        this.value = value;
    }

    public T getValue() {
        return value;
    }

    public double square() {
        double number = value.doubleValue();
        return number * number;
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        NumericBox<Integer> intBox = new NumericBox<>(4);
        NumericBox<Double> doubleBox = new NumericBox<>(2.5);

        System.out.println(intBox.square());
        System.out.println(doubleBox.square());
    }
}
```

---

## 25. Generics and inheritance

This part is usually quite confusing when starting out.

Even though `Integer` inherits from `Number`, that does **not** mean that:

```java
List<Integer>
```

be subtype of:

```java
List<Number>
```

This is incorrect:

```java
// List<Number> numbers = new ArrayList<Integer>(); // NO
```

And this surprises at first.

The reason is that if that were allowed, you could break type safety.

That's why wildcards exist (`? extends Number`).

---

## 26. Example to understand why `List<Integer>` is not `List<Number>`

Imagine if this were valid:

```java
List<Number> numbers = new ArrayList<Integer>();
numbers.add(3.14);
```

Then you would be putting an `Double` into a list that was actually `Integer`.

That would completely break type safety.

That's why Java doesn't allow it.

---

## 27. Type erasure
Generics in Java work using a technique called:

- **type erasure**

That means that at compile time, Java uses generic information to check types, but at run time that information is not preserved the same as in other languages.

At an initial level, the important thing is to understand two ideas:

- generics help especially in compilation
- have certain limitations due to how they are implemented

It is not necessary to go much deeper for now, but you do need to know the concept.

---

## 28. Typical limitations of generics

### 28.1. You cannot create generic type arrays directly

This is not allowed:

```java
// T[] values = new T[10]; // NO
```

### 28.2. You can't use primitive types

This neither:

```java
// Box<int> box = new Box<>(10); // NO
```

### 28.3. You can't use `instanceof` with the particular parameterized type like that

For example, this is not used like this:

```java
// if (value instanceof T) { ... } // NO
```

### 28.4. You cannot create objects of the generic type with `new T()`

This neither:

```java
// T value = new T(); // NO
```

These limitations are a consequence of _type erasure_.

---

## 29. Raw types: why avoid them

A **raw type** is using a generic class without indicating the type.

Example:

```java
List values = new ArrayList();
```

This compiles in many cases, but it is bad practice because you lose all the advantages of generics.

The correct thing is:

```java
List<String> values = new ArrayList<>();
```

Avoid raw types except in very specific or legacy contexts.

---

## 30. Guided Example: Generic class to store two values of the same type

```java
public class DoubleBox<T> {
    private T firstValue;
    private T secondValue;

    public DoubleBox(T firstValue, T secondValue) {
        this.firstValue = firstValue;
        this.secondValue = secondValue;
    }

    public T getFirstValue() {
        return firstValue;
    }

    public T getSecondValue() {
        return secondValue;
    }

    public void printValues() {
        System.out.println("First: " + firstValue);
        System.out.println("Second: " + secondValue);
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        DoubleBox<String> names = new DoubleBox<>("Laura", "Alex");
        DoubleBox<Integer> numbers = new DoubleBox<>(10, 20);

        names.printValues();
        numbers.printValues();
    }
}
```

---

## 31. Guided example: generic method to compare equality

```java
public class CompareUtils {
    public static <T> boolean areEqual(T firstValue, T secondValue) {
        if (firstValue == null) {
            return secondValue == null;
        }

        return firstValue.equals(secondValue);
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(CompareUtils.areEqual("Java", "Java"));
        System.out.println(CompareUtils.areEqual(10, 20));
        System.out.println(CompareUtils.areEqual(true, true));
    }
}
```

---

## 32. Guided Example: Print Any Collection

```java
import java.util.List;

public class CollectionPrinter {
    public static void printItems(List<?> items) {
        for (Object item : items) {
            System.out.println(item);
        }
    }
}
```

Usage:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex");
        List<Integer> numbers = List.of(10, 20, 30);

        CollectionPrinter.printItems(names);
        CollectionPrinter.printItems(numbers);
    }
}
```

---

## 33. When to use generics

Use generics whenever you want:

- create reusable structures for various types
- work with collections securely
- avoid manual casting
- clearly express what type a class or method handles

Clear examples:

- `List<String>`
- `Map<String, Integer>`
- `Optional<User>`
- `Comparator<Product>`

---

## 34. Typical mistakes when starting

### 34.1. Thinking that generics accept primitives

Not:

```java
// List<int> numbers = new ArrayList<>(); // error
```

It must be:

```java
List<Integer> numbers = new ArrayList<>();
```

### 34.2. Thinking that `List<Integer>` is a subtype of `List<Number>`

It is not.

### 34.3. Use raw types for convenience

This makes the code less secure:

```java
List values = new ArrayList();
```

### 34.4. Confusing `Object` with generic

It's not the same.  
With `Object` you lose type safety and need casting.

### 34.5. Wanting to write and read the same with `extends` and `super`

Each one has a different purpose:

- `extends` → read
- `super` → write

---

## 35. Good practices

- Use generics whenever you work with collections.
- Avoid raw types.
- Use clear names in generic classes when necessary, but respect the usual conventions (`T`, `E`, `K`, `V`).
- Use limits (`extends`) when a type must belong to a specific hierarchy.
- Use wildcards when a method must accept related type families.
- Don't complicate the API if you don't have to: sometimes a specific type is better than an excessive generic signature.

---
## 36. To take into account

- Generics allow working with parameterized types.
- They improve type safety and avoid many errors.
- They are used a lot in collections.
- You can create generic classes and generic methods.
- `?` represents an unknown type.
- `? extends T` is used to read from a type hierarchy.
- `? super T` is used to write to a type hierarchy.
- Generics do not accept primitive types.
- In Java there are limitations due to the _type erasure_.

---

## 37. Final summary

Generics are one of the most important Java tools because they allow you to write code:

- safer
- more reusable
- clearer
- more professional

At first you will see them mainly in collections like `List<String>` or `Map<String, Integer>`, but their usefulness goes much further.

Thanks to generics you can create classes and methods that work with many types without losing control or clarity.

Mastering this part will help you greatly to understand better:

- collections
- comparators
- streams
-optional
- Modern Java APIs in general

---

In the next topic we will continue advancing with modern Java and we will see **lambda expressions** and **functional interfaces**, which are closely related to generics and are constantly used together with `Stream API`.
