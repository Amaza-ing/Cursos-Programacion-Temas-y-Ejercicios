# Ejercicios - Tema 32: Date/Time API

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **Date/Time API**: `LocalDate`, `LocalTime`, `LocalDateTime`, `DateTimeFormatter`, `Period`, `Duration`, comparación de fechas y operaciones con días, meses y años.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Mostrar la fecha actual

Usa `LocalDate.now()` para obtener la fecha actual e imprímela por consola.

<details><summary>Mostrar solución</summary>

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate today = LocalDate.now();

        System.out.println(today);
    }
}
```

</details>

---

## Ejercicio 2: Crear una fecha concreta

Crea una fecha con:

- año: `2026`
- mes: `7`
- día: `15`

Usa `LocalDate.of` e imprime el resultado.

<details><summary>Mostrar solución</summary>

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate date = LocalDate.of(2026, 7, 15);

        System.out.println(date);
    }
}
```

</details>

---

## Ejercicio 3: Sumar días a una fecha

Crea una variable `LocalDate startDate` con el valor `2026-06-01`.

Suma 10 días usando `plusDays` e imprime la fecha final.

<details><summary>Mostrar solución</summary>

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate startDate = LocalDate.of(2026, 6, 1);

        LocalDate endDate = startDate.plusDays(10);

        System.out.println(endDate);
    }
}
```

</details>

---

## Ejercicio 4: Restar meses

Crea una fecha `LocalDate paymentDate = LocalDate.of(2026, 12, 5)`.

Resta 2 meses usando `minusMonths` e imprime el resultado.

<details><summary>Mostrar solución</summary>

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate paymentDate = LocalDate.of(2026, 12, 5);

        LocalDate previousDate = paymentDate.minusMonths(2);

        System.out.println(previousDate);
    }
}
```

</details>

---

## Ejercicio 5: Formatear una fecha

Crea una fecha `LocalDate date = LocalDate.of(2026, 9, 30)`.

Formatea la fecha con el patrón:

```text
dd/MM/yyyy
```

e imprime el resultado.

<details><summary>Mostrar solución</summary>

```java
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Main {
    public static void main(String[] args) {
        LocalDate date = LocalDate.of(2026, 9, 30);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        String formattedDate = date.format(formatter);

        System.out.println(formattedDate);
    }
}
```

</details>

---

## Ejercicio 6: Parsear texto a fecha

Declara:

```java
String text = "25/12/2026";
```

Convierte ese texto a `LocalDate` usando `DateTimeFormatter` con patrón `dd/MM/yyyy`.

<details><summary>Mostrar solución</summary>

```java
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Main {
    public static void main(String[] args) {
        String text = "25/12/2026";

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        LocalDate date = LocalDate.parse(text, formatter);

        System.out.println(date);
    }
}
```

</details>

---

## Ejercicio 7: Calcular edad con `Period`

Crea una fecha de nacimiento:

```java
LocalDate birthDate = LocalDate.of(2000, 3, 20);
```

Calcula la edad en años usando `Period.between`.

<details><summary>Mostrar solución</summary>

```java
import java.time.LocalDate;
import java.time.Period;

public class Main {
    public static void main(String[] args) {
        LocalDate birthDate = LocalDate.of(2000, 3, 20);
        LocalDate today = LocalDate.now();

        Period age = Period.between(birthDate, today);

        System.out.println(age.getYears());
    }
}
```

</details>

---

## Ejercicio 8: Comparar fechas

Crea dos fechas:

```java
LocalDate deadline = LocalDate.of(2026, 8, 1);
LocalDate currentDate = LocalDate.of(2026, 8, 10);
```

Comprueba si `currentDate` es posterior a `deadline` usando `isAfter`.

Si lo es, imprime `"Expired"`.

<details><summary>Mostrar solución</summary>

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate deadline = LocalDate.of(2026, 8, 1);
        LocalDate currentDate = LocalDate.of(2026, 8, 10);

        if (currentDate.isAfter(deadline)) {
            System.out.println("Expired");
        }
    }
}
```

</details>

---

## Ejercicio 9: Duración entre dos horas

Crea dos horas:

```java
LocalTime start = LocalTime.of(9, 30);
LocalTime end = LocalTime.of(11, 15);
```

Calcula la duración entre ambas usando `Duration.between` e imprime los minutos totales.

<details><summary>Mostrar solución</summary>

```java
import java.time.Duration;
import java.time.LocalTime;

public class Main {
    public static void main(String[] args) {
        LocalTime start = LocalTime.of(9, 30);
        LocalTime end = LocalTime.of(11, 15);

        Duration duration = Duration.between(start, end);

        System.out.println(duration.toMinutes());
    }
}
```

</details>

---

## Ejercicio 10: Crear un método para comprobar vencimiento

Crea un método:

```java
public static boolean isExpired(LocalDate dueDate)
```

Debe devolver `true` si `dueDate` es anterior a la fecha actual.

Prueba el método desde `main` con una fecha pasada y una fecha futura.

<details><summary>Mostrar solución</summary>

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate pastDate = LocalDate.now().minusDays(3);
        LocalDate futureDate = LocalDate.now().plusDays(3);

        System.out.println(isExpired(pastDate));
        System.out.println(isExpired(futureDate));
    }

    public static boolean isExpired(LocalDate dueDate) {
        return dueDate.isBefore(LocalDate.now());
    }
}
```

</details>

---
