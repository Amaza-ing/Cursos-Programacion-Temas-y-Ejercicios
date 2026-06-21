# Ejercicios - Tema 24: Enums

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **`enum`, `switch`, `values`, `valueOf`, atributos y métodos propios**.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear un enum

Crea `Level` con `BEGINNER`, `INTERMEDIATE`, `ADVANCED`.

<details><summary>Mostrar solución</summary>

```java
public enum Level {
    BEGINNER,
    INTERMEDIATE,
    ADVANCED
}
```

</details>

---

## Ejercicio 2: Comparar con `==`

Comprueba si `SubscriptionType` es `PRO`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 3: Switch con enum

Usa `switch` con `Weather`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 4: Recorrer `values()`

Recorre todos los valores de `Language`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 5: Usar `valueOf`

Convierte el texto `LARGE` a `Size`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 6: Enum con atributo

Crea `ShippingMethod` con precio.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 7: Enum con método

Crea `AccountRole` con `canPublish()`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 8: Sobrescribir `toString`

Crea `TicketStatus` con textos legibles.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 9: Enum como parámetro

Crea `hasSupport(UserPlan plan)`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 10: Enum en clase

Crea `Task` con un atributo `TaskPriority`.

<details><summary>Mostrar solución</summary>

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
