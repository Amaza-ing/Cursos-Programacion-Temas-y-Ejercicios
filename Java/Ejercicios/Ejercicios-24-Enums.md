# Exercises - Topic 24: Enums

Below you will find **10 practical exercises** to work with **`enum`, `switch`, `values`, `valueOf`, attributes and custom methods**.

Try to solve them before looking at the solution.

---

## Exercise 1: Create an enum

Create `Level` with `BEGINNER`, `INTERMEDIATE`, `ADVANCED`.

<details><summary>Show solution</summary>

```java
public enum Level {
    BEGINNER,
    INTERMEDIATE,
    ADVANCED
}
```

</details>

---

## Exercise 2: Compare with `==`

Check if `SubscriptionType` is `PRO`.

<details><summary>Show solution</summary>

```java
public enum SubscriptionType { FREE, PLUS, PRO }

public class Main {
    public static void main(String[] args) {
        SubscriptionType type = SubscriptionType.PRO;
        System.out.println(type == SubscriptionType.PRO);
    }
}
```

</details>

---

## Exercise 3: Switch with an enum

Use `switch` with `Weather`.

<details><summary>Show solution</summary>

```java
public enum Weather { SUNNY, RAINY, CLOUDY }

public class Main {
    public static void main(String[] args) {
        Weather weather = Weather.RAINY;
        String message = switch (weather) {
            case SUNNY -> "Wear sunglasses";
            case RAINY -> "Take an umbrella";
            case CLOUDY -> "Light jacket recommended";
        };
        System.out.println(message);
    }
}
```

</details>

---

## Exercise 4: Loop through `values()`

Loop through all the values of `Language`.

<details><summary>Show solution</summary>

```java
public enum Language { JAVA, PYTHON, JAVASCRIPT }

public class Main {
    public static void main(String[] args) {
        for (Language language : Language.values()) {
            System.out.println(language);
        }
    }
}
```

</details>

---

## Exercise 5: Use `valueOf`

Convert the text `LARGE` to `Size`.

<details><summary>Show solution</summary>

```java
public enum Size { SMALL, MEDIUM, LARGE }

public class Main {
    public static void main(String[] args) {
        Size size = Size.valueOf("LARGE");
        System.out.println(size);
    }
}
```

</details>

---

## Exercise 6: Enum with an attribute

Create `ShippingMethod` with a price.

<details><summary>Show solution</summary>

```java
public enum ShippingMethod {
    STANDARD(5.99), EXPRESS(12.99), PICKUP(0.00);

    private double price;

    ShippingMethod(double price) {
        this.price = price;
    }

    public double getPrice() {
        return price;
    }
}
```

</details>

---

## Exercise 7: Enum with a method

Create `AccountRole` with `canPublish()`.

<details><summary>Show solution</summary>

```java
public enum AccountRole {
    ADMIN, EDITOR, VIEWER;

    public boolean canPublish() {
        return this == ADMIN || this == EDITOR;
    }
}
```

</details>

---

## Exercise 8: Override `toString`

Create `TicketStatus` with readable texts.

<details><summary>Show solution</summary>

```java
public enum TicketStatus {
    OPEN, IN_REVIEW, CLOSED;

    @Override
    public String toString() {
        return switch (this) {
            case OPEN -> "Open";
            case IN_REVIEW -> "In review";
            case CLOSED -> "Closed";
        };
    }
}
```

</details>

---

## Exercise 9: Enum as a parameter

Create `hasSupport(UserPlan plan)`.

<details><summary>Show solution</summary>

```java
public enum UserPlan { BASIC, STANDARD, PREMIUM }

public class Main {
    public static boolean hasSupport(UserPlan plan) {
        return plan == UserPlan.STANDARD || plan == UserPlan.PREMIUM;
    }
}
```

</details>

---

## Exercise 10: Enum in a class

Create `Task` with a `TaskPriority` attribute.

<details><summary>Show solution</summary>

```java
public enum TaskPriority { LOW, MEDIUM, HIGH }

public class Task {
    private String title;
    private TaskPriority priority;

    public Task(String title, TaskPriority priority) {
        this.title = title;
        this.priority = priority;
    }
}
```

</details>

---
