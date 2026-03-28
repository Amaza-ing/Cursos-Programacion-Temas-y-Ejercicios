# Tema 24. `enum` en Java

## 1. Introducción

A medida que programas en Java, hay situaciones en las que una variable no puede tomar cualquier valor, sino solo un conjunto **limitado y conocido** de opciones.

Ejemplos típicos:

- Los días de la semana
- El estado de un pedido
- El nivel de dificultad de un juego
- El rol de un usuario
- El tamaño de una camiseta
- Las estaciones del año
- Los colores permitidos en una configuración

Una mala solución sería usar `String`:

```java
String status = "SHIPPED";
```

Esto funciona, pero tiene varios problemas:

- puedes escribir mal el valor (`"SHIPED"`, `"shipped"`, `"Shipped"`)
- no hay control real del conjunto permitido
- el código es menos seguro y menos claro
- los cambios futuros son más difíciles de mantener

Para resolver esto, Java ofrece los **enum**.

Un `enum` permite definir un conjunto fijo de constantes con nombre.

En este tema aprenderás:

- qué es un `enum`
- cuándo usarlo y por qué es mejor que usar `String` o números mágicos
- cómo declarar y usar un `enum`
- cómo usar `enum` con `switch`
- cómo añadir atributos, constructores y métodos a un `enum`
- métodos útiles como `values()`, `valueOf()` y `name()`
- buenas prácticas y errores típicos

---

## 2. Qué es un `enum`

`enum` viene de **enumeration**, es decir, enumeración.

Un `enum` es un tipo especial de Java que representa un conjunto fijo de constantes.

Ejemplo simple:

```java
public enum OrderStatus {
    CREATED,
    PAID,
    SHIPPED,
    DELIVERED
}
```

Aquí `OrderStatus` solo puede tomar uno de estos cuatro valores.

---

## 3. Cuándo usar un `enum`

Usa un `enum` cuando:

- existe un conjunto fijo y conocido de valores
- quieres dar significado claro a esos valores
- quieres evitar errores con `String` o números sueltos
- quieres que el compilador ayude a detectar usos incorrectos

Ejemplos claros:

- `DayOfWeek`
- `OrderStatus`
- `Difficulty`
- `Role`
- `TrafficLight`

No suele tener sentido usar `enum` cuando los valores:

- son completamente libres
- cambian dinámicamente según datos externos
- no forman un conjunto fijo

---

## 4. Primer ejemplo básico

### 4.1. Declaración

```java
public enum Difficulty {
    EASY,
    MEDIUM,
    HARD
}
```

### 4.2. Uso en una variable

```java
public class Main {
    public static void main(String[] args) {
        Difficulty difficulty = Difficulty.MEDIUM;

        System.out.println(difficulty);
    }
}
```

Salida:

```java
MEDIUM
```

---

## 5. Comparar valores de un `enum`

Los `enum` se suelen comparar con `==`.

Esto es diferente a lo que ocurría con `String`, donde normalmente debías usar `equals`.

Ejemplo:

```java
Difficulty difficulty = Difficulty.HARD;

if (difficulty == Difficulty.HARD) {
    System.out.println("High difficulty");
}
```

¿Por qué `==` funciona bien aquí?

Porque cada constante de un `enum` es única dentro del programa.

---

## 6. `enum` en lugar de `String`

Veamos una comparación clara.

### 6.1. Usando `String` (peor opción)

```java
String status = "PAID";

if (status.equals("PAID")) {
    System.out.println("Order is paid");
}
```

Problemas:

- si escribes `"paid"` en minúsculas, falla
- si escribes `"PADI"` por error, compila igual
- no hay control fuerte del conjunto permitido

### 6.2. Usando `enum` (mejor opción)

```java
public enum OrderStatus {
    CREATED,
    PAID,
    SHIPPED,
    DELIVERED
}
```

```java
OrderStatus status = OrderStatus.PAID;

if (status == OrderStatus.PAID) {
    System.out.println("Order is paid");
}
```

Ventajas:

- el compilador valida los valores
- el código es más legible
- evitas errores de escritura
- puedes usar `switch` de forma muy limpia

---

## 7. `switch` con `enum`

Una de las mejores combinaciones con `enum` es `switch`.

Ejemplo:

```java
public enum TrafficLight {
    RED,
    YELLOW,
    GREEN
}
```

```java
public class Main {
    public static void main(String[] args) {
        TrafficLight light = TrafficLight.YELLOW;

        switch (light) {
            case RED:
                System.out.println("Stop");
                break;
            case YELLOW:
                System.out.println("Be careful");
                break;
            case GREEN:
                System.out.println("Go");
                break;
        }
    }
}
```

También puedes usar `switch` moderno:

```java
String message = switch (light) {
    case RED -> "Stop";
    case YELLOW -> "Be careful";
    case GREEN -> "Go";
};
```

---

## 8. Métodos útiles de los `enum`

Todos los `enum` tienen algunos métodos útiles incorporados.

### 8.1. `values()`

Devuelve un array con todos los valores del `enum`.

Ejemplo:

```java
public enum Day {
    MONDAY,
    TUESDAY,
    WEDNESDAY
}
```

```java
public class Main {
    public static void main(String[] args) {
        for (Day day : Day.values()) {
            System.out.println(day);
        }
    }
}
```

Salida:

```java
MONDAY
TUESDAY
WEDNESDAY
```

### 8.2. `name()`

Devuelve el nombre exacto de la constante como `String`.

```java
Day day = Day.MONDAY;
System.out.println(day.name()); // MONDAY
```

### 8.3. `ordinal()`

Devuelve la posición de la constante según el orden en que fue declarada.

```java
System.out.println(Day.MONDAY.ordinal());   // 0
System.out.println(Day.TUESDAY.ordinal());  // 1
```

**Importante:** no conviene basar lógica importante en `ordinal()`, porque si cambias el orden del `enum`, cambian esos números.

### 8.4. `valueOf(...)`

Convierte un `String` al valor del `enum`.

```java
Day day = Day.valueOf("MONDAY");
System.out.println(day);
```

Pero cuidado: el texto debe coincidir exactamente o lanzará excepción.

```java
// Day.valueOf("monday"); // IllegalArgumentException
```

---

## 9. Recorrer todos los valores de un `enum`

Esto es muy útil para menús, validaciones, depuración o mostrar opciones al usuario.

Ejemplo:

```java
public enum Role {
    ADMIN,
    EDITOR,
    USER,
    GUEST
}
```

```java
public class Main {
    public static void main(String[] args) {
        for (Role role : Role.values()) {
            System.out.println(role);
        }
    }
}
```

---

## 10. `enum` con atributos, constructor y métodos

Aquí es donde mucha gente descubre que un `enum` en Java es bastante potente.

Un `enum` puede tener:

- atributos
- constructor
- métodos
- lógica propia

### 10.1. Ejemplo: niveles de prioridad

```java
public enum Priority {
    LOW(1),
    MEDIUM(2),
    HIGH(3);

    private int level;

    Priority(int level) {
        this.level = level;
    }

    public int getLevel() {
        return level;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Priority priority = Priority.HIGH;

        System.out.println(priority);
        System.out.println(priority.getLevel());
    }
}
```

### 10.2. Importante sobre el constructor del `enum`

El constructor del `enum`:

- no se llama con `new`
- lo usa Java internamente para crear cada constante
- suele ser `private` implícitamente

No puedes hacer esto:

```java
// Priority p = new Priority(4); // error
```

---

## 11. Ejemplo: `Planet` con datos asociados

```java
public enum Planet {
    MERCURY(57.9),
    VENUS(108.2),
    EARTH(149.6),
    MARS(227.9);

    private double distanceFromSun;

    Planet(double distanceFromSun) {
        this.distanceFromSun = distanceFromSun;
    }

    public double getDistanceFromSun() {
        return distanceFromSun;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        for (Planet planet : Planet.values()) {
            System.out.println(
                    planet + " -> " + planet.getDistanceFromSun() + " million km"
            );
        }
    }
}
```

Esto demuestra que un `enum` no es solo una lista de palabras; puede encapsular datos y comportamiento.

---

## 12. `enum` con métodos propios

Puedes añadir lógica directamente al `enum`.

Ejemplo:

```java
public enum AccessLevel {
    GUEST,
    USER,
    ADMIN;

    public boolean canEdit() {
        return this == USER || this == ADMIN;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        AccessLevel access = AccessLevel.USER;

        System.out.println(access.canEdit());
    }
}
```

Esto mejora la cohesión: la lógica asociada al concepto vive dentro del propio `enum`.

---

## 13. Sobrescribir `toString()` en un `enum`

Por defecto, un `enum` imprime el nombre exacto de la constante.

Ejemplo:

```java
System.out.println(Priority.HIGH); // HIGH
```

Pero puedes sobrescribir `toString()` para una salida más legible.

```java
public enum Size {
    SMALL,
    MEDIUM,
    LARGE;

    @Override
    public String toString() {
        return switch (this) {
            case SMALL -> "Small";
            case MEDIUM -> "Medium";
            case LARGE -> "Large";
        };
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(Size.SMALL); // Small
    }
}
```

---

## 14. Ejemplo completo: estado de pedido con comportamiento

### 14.1. `OrderStatus.java`

```java
public enum OrderStatus {
    CREATED("Order created"),
    PAID("Order paid"),
    SHIPPED("Order shipped"),
    DELIVERED("Order delivered");

    private String description;

    OrderStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public boolean isFinalStatus() {
        return this == DELIVERED;
    }
}
```

### 14.2. Uso en una clase `Order`

```java
public class Order {
    private String id;
    private OrderStatus status;

    public Order(String id) {
        this.id = id;
        this.status = OrderStatus.CREATED;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        if (status == null) {
            return;
        }

        this.status = status;
    }

    public void printInfo() {
        System.out.println(
                "Order: " + id +
                " | Status: " + status +
                " | Description: " + status.getDescription()
        );
    }
}
```

### 14.3. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        Order order = new Order("ORD-100");

        order.printInfo();

        order.setStatus(OrderStatus.PAID);
        order.printInfo();

        order.setStatus(OrderStatus.SHIPPED);
        order.printInfo();

        order.setStatus(OrderStatus.DELIVERED);
        order.printInfo();

        System.out.println(order.getStatus().isFinalStatus());
    }
}
```

---

## 15. `enum` en métodos y parámetros

Es muy común usar un `enum` como parámetro de un método.

Ejemplo:

```java
public enum Role {
    ADMIN,
    USER,
    GUEST
}
```

```java
public class SecurityService {
    public static boolean canDelete(Role role) {
        return role == Role.ADMIN;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(SecurityService.canDelete(Role.ADMIN));
        System.out.println(SecurityService.canDelete(Role.USER));
    }
}
```

Esto hace que el método sea mucho más seguro y expresivo.

---

## 16. `enum` en listas y colecciones

Los `enum` funcionan perfectamente con colecciones.

Ejemplo:

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Priority> priorities = new ArrayList<>();
        priorities.add(Priority.LOW);
        priorities.add(Priority.HIGH);
        priorities.add(Priority.MEDIUM);

        for (Priority priority : priorities) {
            System.out.println(priority + " -> " + priority.getLevel());
        }
    }
}
```

---

## 17. `EnumSet` (introducción)

Java tiene una colección especial para trabajar con enums: `EnumSet`.

Es muy eficiente y está pensada específicamente para ellos.

Ejemplo simple:

```java
import java.util.EnumSet;

public class Main {
    public static void main(String[] args) {
        EnumSet<WeekendDay> weekend = EnumSet.of(WeekendDay.SATURDAY, WeekendDay.SUNDAY);

        System.out.println(weekend);
    }
}
```

```java
public enum WeekendDay {
    SATURDAY,
    SUNDAY
}
```

No necesitas dominar `EnumSet` ahora, pero conviene saber que existe.

---

## 18. Errores típicos al empezar

### 18.1. Usar `String` cuando el conjunto de valores es fijo

Si los valores están controlados y son limitados, un `enum` suele ser mejor.

### 18.2. Pensar que un `enum` es solo una lista de constantes

Puede tener atributos, constructor, métodos y lógica.

### 18.3. Usar `ordinal()` como parte importante de la lógica

Es peligroso, porque cambiar el orden del `enum` cambia los ordinales.

### 18.4. Usar `valueOf(...)` con texto no validado

Si el texto no coincide exactamente, lanza excepción.

Ejemplo:

```java
// Day.valueOf("monday"); // error
```

### 18.5. Intentar crear constantes dinámicas

Un `enum` representa un conjunto fijo. No puedes añadir nuevos valores en tiempo de ejecución.

---

## 19. Buenas prácticas

- Usa `enum` cuando tengas un conjunto fijo y conocido de valores.
- Usa nombres claros y en mayúsculas para las constantes (`PENDING`, `PAID`, `DONE`).
- Evita usar `ordinal()` para lógica importante.
- Añade atributos y métodos al `enum` cuando aporte claridad.
- Si una lógica pertenece al concepto representado por el `enum`, plantéate ponerla dentro del propio `enum`.

---

## 20. A tener en cuenta

- Un `enum` define un conjunto fijo de constantes.
- Es mucho más seguro que usar `String` o números mágicos.
- Puedes compararlo con `==`.
- Puedes usarlo con `switch`.
- Tiene métodos útiles como `values()`, `name()`, `valueOf()` y `ordinal()`.
- Puede tener atributos, constructores y métodos propios.
- Se usa muchísimo en Java real.

---

## 21. Resumen final

- **`enum`** sirve para representar opciones limitadas y conocidas.
- **Mejora seguridad y legibilidad** frente a `String`.
- **Se compara con `==`**.
- **Funciona muy bien con `switch`**.
- **Puede tener datos y comportamiento**, no es solo una lista de constantes.
- **Es ideal** para estados, roles, niveles, tipos y configuraciones cerradas.

---

En el siguiente tema seguiremos avanzando trabajando otras colecciones de datos como los `HashMaps`.
