# Tema 32. Date/Time API

## 1. Introducción

Trabajar con fechas y horas es una necesidad muy común en programación.

Por ejemplo:

- guardar la fecha de registro de un usuario
- calcular la edad de una persona
- mostrar la hora actual
- comprobar si una tarea está vencida
- calcular cuántos días faltan para un evento
- registrar la fecha y hora de una compra
- trabajar con zonas horarias

Java incluye una API moderna para trabajar con fechas y horas de forma clara y segura:

- **Date/Time API**

Esta API está principalmente en el paquete:

```java
java.time
```

En este tema aprenderás:

- Por qué no se recomienda usar las clases antiguas `Date` y `Calendar` para código nuevo
- Qué es `LocalDate`
- Qué es `LocalTime`
- Qué es `LocalDateTime`
- Cómo crear fechas y horas
- Cómo sumar y restar días, meses, años, horas o minutos
- Cómo comparar fechas
- Cómo trabajar con `Period` y `Duration`
- Cómo formatear y parsear fechas
- Qué son `ZonedDateTime` y `ZoneId`
- Errores típicos y buenas prácticas

---

## 2. Antes de `java.time`: `Date` y `Calendar`

Durante muchos años, Java usó clases como:

```java
java.util.Date
java.util.Calendar
```

Estas clases todavía existen, pero para código nuevo se recomienda usar la API moderna:

```java
java.time
```

¿Por qué?

Porque `java.time` es:

- más clara
- más segura
- más fácil de leer
- más precisa en su diseño
- inmutable
- mejor preparada para zonas horarias

En este curso nos centraremos en `java.time`.

---

## 3. Paquete principal: `java.time`

Las clases más importantes que veremos son:

- `LocalDate`
- `LocalTime`
- `LocalDateTime`
- `Period`
- `Duration`
- `DateTimeFormatter`
- `ZoneId`
- `ZonedDateTime`
- `Instant`

Cada una se usa para un caso diferente.

No necesitas memorizarlo todo de golpe.  
Lo importante es entender qué representa cada clase.

---

## 4. `LocalDate`: solo fecha

`LocalDate` representa una fecha sin hora.

Ejemplos:

- `2026-06-21`
- `2025-12-31`
- `1995-04-10`

No incluye:

- hora
- minutos
- segundos
- zona horaria

Importación:

```java
import java.time.LocalDate;
```

Ejemplo:

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate today = LocalDate.now();

        System.out.println(today);
    }
}
```

---

## 5. Crear una fecha concreta con `LocalDate.of`

Puedes crear una fecha específica con `of`.

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate birthDate = LocalDate.of(1995, 4, 10);

        System.out.println(birthDate);
    }
}
```

El orden es:

```java
LocalDate.of(year, month, day)
```

Ejemplo:

```java
LocalDate date = LocalDate.of(2026, 6, 21);
```

---

## 6. Obtener partes de una fecha

Puedes obtener año, mes o día.

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate date = LocalDate.of(2026, 6, 21);

        System.out.println(date.getYear());
        System.out.println(date.getMonth());
        System.out.println(date.getMonthValue());
        System.out.println(date.getDayOfMonth());
        System.out.println(date.getDayOfWeek());
    }
}
```

Diferencia importante:

- `getMonth()` devuelve el enum del mes (`JUNE`)
- `getMonthValue()` devuelve el número del mes (`6`)

---

## 7. Sumar y restar fechas

`LocalDate` permite sumar o restar días, semanas, meses y años.

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate date = LocalDate.of(2026, 6, 21);

        LocalDate nextWeek = date.plusWeeks(1);
        LocalDate nextMonth = date.plusMonths(1);
        LocalDate previousDay = date.minusDays(1);
        LocalDate previousYear = date.minusYears(1);

        System.out.println(nextWeek);
        System.out.println(nextMonth);
        System.out.println(previousDay);
        System.out.println(previousYear);
    }
}
```

---

## 8. Las fechas son inmutables

Las clases principales de `java.time` son inmutables.

Eso significa que no cambian su valor original.  
Cuando haces una operación, se devuelve un nuevo objeto.

Ejemplo incorrecto:

```java
LocalDate date = LocalDate.of(2026, 6, 21);

date.plusDays(1);

System.out.println(date); // sigue siendo 2026-06-21
```

Versión correcta:

```java
LocalDate date = LocalDate.of(2026, 6, 21);

date = date.plusDays(1);

System.out.println(date); // 2026-06-22
```

---

## 9. Comparar fechas

Puedes comparar fechas con métodos como:

- `isBefore`
- `isAfter`
- `isEqual`

Ejemplo:

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate today = LocalDate.now();
        LocalDate deadline = LocalDate.of(2026, 12, 31);

        System.out.println(today.isBefore(deadline));
        System.out.println(today.isAfter(deadline));
        System.out.println(today.isEqual(deadline));
    }
}
```

---

## 10. Ejemplo guiado: comprobar si una tarea está vencida

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate today = LocalDate.now();
        LocalDate dueDate = LocalDate.of(2026, 1, 10);

        if (dueDate.isBefore(today)) {
            System.out.println("Task is overdue");
        } else {
            System.out.println("Task is still active");
        }
    }
}
```

---

## 11. `LocalTime`: solo hora

`LocalTime` representa una hora sin fecha.

Ejemplos:

- `10:30`
- `18:45:20`
- `09:15:00`

No incluye:

- día
- mes
- año
- zona horaria

Importación:

```java
import java.time.LocalTime;
```

Ejemplo:

```java
import java.time.LocalTime;

public class Main {
    public static void main(String[] args) {
        LocalTime currentTime = LocalTime.now();

        System.out.println(currentTime);
    }
}
```

---

## 12. Crear una hora concreta con `LocalTime.of`

```java
import java.time.LocalTime;

public class Main {
    public static void main(String[] args) {
        LocalTime startTime = LocalTime.of(9, 30);

        System.out.println(startTime);
    }
}
```

También puedes incluir segundos:

```java
LocalTime time = LocalTime.of(9, 30, 15);
```

---

## 13. Obtener partes de una hora

```java
import java.time.LocalTime;

public class Main {
    public static void main(String[] args) {
        LocalTime time = LocalTime.of(14, 45, 30);

        System.out.println(time.getHour());
        System.out.println(time.getMinute());
        System.out.println(time.getSecond());
    }
}
```

---

## 14. Sumar y restar tiempo

```java
import java.time.LocalTime;

public class Main {
    public static void main(String[] args) {
        LocalTime time = LocalTime.of(10, 30);

        LocalTime later = time.plusHours(2);
        LocalTime earlier = time.minusMinutes(15);

        System.out.println(later);
        System.out.println(earlier);
    }
}
```

---

## 15. `LocalDateTime`: fecha y hora

`LocalDateTime` combina:

- fecha
- hora

Ejemplo:

```text
2026-06-21T10:30
```

No incluye zona horaria.

Importación:

```java
import java.time.LocalDateTime;
```

Ejemplo:

```java
import java.time.LocalDateTime;

public class Main {
    public static void main(String[] args) {
        LocalDateTime now = LocalDateTime.now();

        System.out.println(now);
    }
}
```

---

## 16. Crear un `LocalDateTime`

```java
import java.time.LocalDateTime;

public class Main {
    public static void main(String[] args) {
        LocalDateTime appointment = LocalDateTime.of(2026, 6, 21, 16, 30);

        System.out.println(appointment);
    }
}
```

Orden:

```java
LocalDateTime.of(year, month, day, hour, minute)
```

---

## 17. Combinar `LocalDate` y `LocalTime`

Puedes crear un `LocalDateTime` combinando fecha y hora.

```java
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class Main {
    public static void main(String[] args) {
        LocalDate date = LocalDate.of(2026, 6, 21);
        LocalTime time = LocalTime.of(16, 30);

        LocalDateTime dateTime = LocalDateTime.of(date, time);

        System.out.println(dateTime);
    }
}
```

---

## 18. Separar fecha y hora desde `LocalDateTime`

```java
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class Main {
    public static void main(String[] args) {
        LocalDateTime dateTime = LocalDateTime.of(2026, 6, 21, 16, 30);

        LocalDate date = dateTime.toLocalDate();
        LocalTime time = dateTime.toLocalTime();

        System.out.println(date);
        System.out.println(time);
    }
}
```

---

## 19. Sumar y restar con `LocalDateTime`

```java
import java.time.LocalDateTime;

public class Main {
    public static void main(String[] args) {
        LocalDateTime dateTime = LocalDateTime.of(2026, 6, 21, 16, 30);

        LocalDateTime nextDay = dateTime.plusDays(1);
        LocalDateTime twoHoursBefore = dateTime.minusHours(2);

        System.out.println(nextDay);
        System.out.println(twoHoursBefore);
    }
}
```

---

## 20. `Period`: diferencia entre fechas

`Period` representa una cantidad de tiempo basada en fechas:

- años
- meses
- días

Se usa normalmente con `LocalDate`.

Ejemplo:

```java
import java.time.LocalDate;
import java.time.Period;

public class Main {
    public static void main(String[] args) {
        LocalDate birthDate = LocalDate.of(1995, 4, 10);
        LocalDate today = LocalDate.now();

        Period age = Period.between(birthDate, today);

        System.out.println(age.getYears());
        System.out.println(age.getMonths());
        System.out.println(age.getDays());
    }
}
```

---

## 21. Ejemplo guiado: calcular edad

```java
import java.time.LocalDate;
import java.time.Period;

public class Main {
    public static void main(String[] args) {
        LocalDate birthDate = LocalDate.of(1995, 4, 10);
        LocalDate today = LocalDate.now();

        int age = Period.between(birthDate, today).getYears();

        System.out.println("Age: " + age);
    }
}
```

---

## 22. `Duration`: diferencia entre horas

`Duration` representa una cantidad de tiempo basada en segundos y nanosegundos.

Se usa normalmente con:

- `LocalTime`
- `LocalDateTime`
- `Instant`

Ejemplo:

```java
import java.time.Duration;
import java.time.LocalTime;

public class Main {
    public static void main(String[] args) {
        LocalTime start = LocalTime.of(9, 0);
        LocalTime end = LocalTime.of(11, 30);

        Duration duration = Duration.between(start, end);

        System.out.println(duration.toHours());
        System.out.println(duration.toMinutes());
    }
}
```

---

## 23. Ejemplo guiado: calcular duración de una clase

```java
import java.time.Duration;
import java.time.LocalTime;

public class Main {
    public static void main(String[] args) {
        LocalTime classStart = LocalTime.of(10, 15);
        LocalTime classEnd = LocalTime.of(12, 0);

        Duration duration = Duration.between(classStart, classEnd);

        System.out.println("Minutes: " + duration.toMinutes());
    }
}
```

---

## 24. Diferencia entre `Period` y `Duration`

### 24.1. `Period`

Usa fechas:

```java
Period.between(startDate, endDate)
```

Trabaja con:

- años
- meses
- días

### 24.2. `Duration`

Usa tiempos:

```java
Duration.between(startTime, endTime)
```

Trabaja con:

- horas
- minutos
- segundos
- nanosegundos

### 24.3. Regla práctica

- Diferencia entre fechas → `Period`
- Diferencia entre horas o instantes → `Duration`

---

## 25. Formatear fechas con `DateTimeFormatter`

Por defecto, `LocalDate` se imprime en formato ISO:

```text
2026-06-21
```

Pero muchas veces quieres mostrarlo de otra forma:

```text
21/06/2026
```

Para eso usamos `DateTimeFormatter`.

Importación:

```java
import java.time.format.DateTimeFormatter;
```

Ejemplo:

```java
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Main {
    public static void main(String[] args) {
        LocalDate date = LocalDate.of(2026, 6, 21);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        String formattedDate = date.format(formatter);

        System.out.println(formattedDate);
    }
}
```

---

## 26. Patrones habituales de formato

Algunos patrones comunes son:

```text
dd/MM/yyyy      -> 21/06/2026
yyyy-MM-dd      -> 2026-06-21
dd-MM-yyyy      -> 21-06-2026
HH:mm           -> 16:30
dd/MM/yyyy HH:mm -> 21/06/2026 16:30
```

Ejemplo:

```java
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
```

---

## 27. Parsear texto a fecha

Parsear significa convertir un texto en una fecha.

Ejemplo:

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate date = LocalDate.parse("2026-06-21");

        System.out.println(date);
    }
}
```

Esto funciona porque el texto está en formato ISO (`yyyy-MM-dd`).

---

## 28. Parsear con formato personalizado

Si el texto está en otro formato, debes indicar un `DateTimeFormatter`.

```java
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Main {
    public static void main(String[] args) {
        String text = "21/06/2026";

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        LocalDate date = LocalDate.parse(text, formatter);

        System.out.println(date);
    }
}
```

Resultado:

```text
2026-06-21
```

---

## 29. Parsear fecha y hora

```java
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Main {
    public static void main(String[] args) {
        String text = "21/06/2026 16:30";

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

        LocalDateTime dateTime = LocalDateTime.parse(text, formatter);

        System.out.println(dateTime);
    }
}
```

---

## 30. `ZoneId`: zonas horarias

Hasta ahora hemos visto clases sin zona horaria:

- `LocalDate`
- `LocalTime`
- `LocalDateTime`

Pero a veces necesitas trabajar con zonas horarias reales.

Para eso puedes usar:

- `ZoneId`
- `ZonedDateTime`

Ejemplo de zona horaria:

```java
ZoneId madridZone = ZoneId.of("Europe/Madrid");
```

---

## 31. `ZonedDateTime`: fecha, hora y zona horaria

`ZonedDateTime` representa una fecha y hora con zona horaria.

Ejemplo:

```java
import java.time.ZoneId;
import java.time.ZonedDateTime;

public class Main {
    public static void main(String[] args) {
        ZoneId madridZone = ZoneId.of("Europe/Madrid");

        ZonedDateTime nowInMadrid = ZonedDateTime.now(madridZone);

        System.out.println(nowInMadrid);
    }
}
```

Esto incluye:

- fecha
- hora
- zona horaria
- desplazamiento UTC correspondiente

---

## 32. Ver hora en otra zona horaria

```java
import java.time.ZoneId;
import java.time.ZonedDateTime;

public class Main {
    public static void main(String[] args) {
        ZonedDateTime madridTime = ZonedDateTime.now(ZoneId.of("Europe/Madrid"));
        ZonedDateTime newYorkTime = madridTime.withZoneSameInstant(ZoneId.of("America/New_York"));

        System.out.println("Madrid: " + madridTime);
        System.out.println("New York: " + newYorkTime);
    }
}
```

La idea importante:

- es el mismo instante real
- representado en dos zonas horarias diferentes

---

## 33. `Instant`: un momento exacto

`Instant` representa un punto exacto en el tiempo en UTC.

Es muy útil para:

- logs
- marcas temporales
- eventos
- almacenamiento interno de momentos exactos

Ejemplo:

```java
import java.time.Instant;

public class Main {
    public static void main(String[] args) {
        Instant now = Instant.now();

        System.out.println(now);
    }
}
```

`Instant` no está pensado principalmente para mostrar al usuario final, sino para representar un momento exacto.

---

## 34. Convertir entre `Instant` y `ZonedDateTime`

```java
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;

public class Main {
    public static void main(String[] args) {
        Instant instant = Instant.now();

        ZonedDateTime madridDateTime = instant.atZone(ZoneId.of("Europe/Madrid"));

        System.out.println(madridDateTime);
    }
}
```

---

## 35. Ejemplo completo: evento con fecha y hora

### 35.1. `Event.java`

```java
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Event {
    private String title;
    private LocalDateTime dateTime;

    public Event(String title, LocalDateTime dateTime) {
        setTitle(title);
        this.dateTime = dateTime;
    }

    public String getTitle() {
        return title;
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public void setTitle(String title) {
        if (title == null || title.isBlank()) {
            this.title = "Untitled";
            return;
        }

        this.title = title;
    }

    public boolean isPast() {
        return dateTime.isBefore(LocalDateTime.now());
    }

    public String getFormattedDateTime() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return dateTime.format(formatter);
    }

    public void printInfo() {
        System.out.println("Event: " + title);
        System.out.println("Date: " + getFormattedDateTime());
        System.out.println("Past: " + isPast());
    }
}
```

### 35.2. `Main.java`

```java
import java.time.LocalDateTime;

public class Main {
    public static void main(String[] args) {
        Event event = new Event(
                "Java class",
                LocalDateTime.of(2026, 6, 21, 18, 30)
        );

        event.printInfo();
    }
}
```

---

## 36. Ejemplo completo: tarea con fecha límite

### 36.1. `Task.java`

```java
import java.time.LocalDate;

public class Task {
    private String title;
    private LocalDate dueDate;
    private boolean completed;

    public Task(String title, LocalDate dueDate) {
        this.title = title;
        this.dueDate = dueDate;
        this.completed = false;
    }

    public String getTitle() {
        return title;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void complete() {
        this.completed = true;
    }

    public boolean isOverdue() {
        return !completed && dueDate.isBefore(LocalDate.now());
    }

    public void printInfo() {
        System.out.println("Task: " + title);
        System.out.println("Due date: " + dueDate);
        System.out.println("Completed: " + completed);
        System.out.println("Overdue: " + isOverdue());
    }
}
```

### 36.2. `Main.java`

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        Task task = new Task("Study Date/Time API", LocalDate.of(2026, 6, 30));

        task.printInfo();
    }
}
```

---

## 37. Ejemplo guiado: calcular días hasta una fecha

```java
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class Main {
    public static void main(String[] args) {
        LocalDate today = LocalDate.now();
        LocalDate examDate = LocalDate.of(2026, 7, 15);

        long days = ChronoUnit.DAYS.between(today, examDate);

        System.out.println("Days until exam: " + days);
    }
}
```

`ChronoUnit.DAYS.between` es muy útil cuando quieres una diferencia directa en días.

---

## 38. `Month` como enum

Java también tiene un enum llamado `Month`.

```java
import java.time.LocalDate;
import java.time.Month;

public class Main {
    public static void main(String[] args) {
        LocalDate date = LocalDate.of(2026, Month.JUNE, 21);

        System.out.println(date);
    }
}
```

Esto puede hacer que el código sea más legible.

---

## 39. Fechas inválidas

Java valida las fechas.

Esto no es válido:

```java
// LocalDate date = LocalDate.of(2026, 2, 30); // error
```

Febrero no tiene día 30, así que Java lanza una excepción.

Esto ayuda a evitar fechas imposibles.

---

## 40. Errores típicos al empezar

### 40.1. Usar `Date` y `Calendar` en código nuevo sin necesidad

Para código moderno, normalmente es mejor usar `java.time`.

### 40.2. Confundir `LocalDateTime` con una fecha universal

`LocalDateTime` no tiene zona horaria.  
No representa por sí mismo un instante global.

### 40.3. Olvidar que las fechas son inmutables

Esto no modifica la fecha original:

```java
date.plusDays(1);
```

Debes guardar el resultado:

```java
date = date.plusDays(1);
```

### 40.4. Usar patrones incorrectos en `DateTimeFormatter`

Por ejemplo:

- `MM` significa mes
- `mm` significa minutos

No es lo mismo:

```java
DateTimeFormatter.ofPattern("dd/MM/yyyy");
DateTimeFormatter.ofPattern("HH:mm");
```

### 40.5. Ignorar zonas horarias cuando importan

Si trabajas con usuarios de distintos países o eventos globales, debes pensar en zonas horarias.

---

## 41. Buenas prácticas

- Usa `LocalDate` para fechas sin hora.
- Usa `LocalTime` para horas sin fecha.
- Usa `LocalDateTime` para fecha y hora sin zona horaria.
- Usa `ZonedDateTime` si la zona horaria importa.
- Usa `Instant` para momentos exactos y registros internos.
- Usa `Period` para diferencias entre fechas.
- Usa `Duration` para diferencias entre horas o instantes.
- Usa `DateTimeFormatter` para mostrar o leer fechas con formatos concretos.
- Recuerda que las clases de `java.time` son inmutables.
- Evita `Date` y `Calendar` en código nuevo salvo que tengas que trabajar con APIs antiguas.

---

## 42. A tener en cuenta

- `java.time` es la API moderna de fechas y horas en Java.
- `LocalDate` representa solo fecha.
- `LocalTime` representa solo hora.
- `LocalDateTime` representa fecha y hora sin zona horaria.
- `ZonedDateTime` incluye zona horaria.
- `Instant` representa un momento exacto en UTC.
- `Period` mide diferencias entre fechas.
- `Duration` mide diferencias entre tiempos.
- `DateTimeFormatter` sirve para formatear y parsear.
- Las fechas y horas son inmutables.

---

## 43. Resumen final

La Date/Time API moderna de Java permite trabajar con fechas y horas de forma mucho más clara que las clases antiguas.

La clave está en elegir la clase correcta:

- `LocalDate` si solo necesitas una fecha
- `LocalTime` si solo necesitas una hora
- `LocalDateTime` si necesitas fecha y hora sin zona horaria
- `ZonedDateTime` si la zona horaria importa
- `Instant` si necesitas un momento exacto

También has visto cómo:

- sumar y restar fechas
- comparar fechas
- calcular periodos y duraciones
- formatear fechas
- parsear texto a fecha

Dominar esta API es muy importante porque las fechas aparecen constantemente en aplicaciones reales.

---

En el siguiente tema seguiremos avanzando con Java moderno y veremos cómo trabajar con archivos y rutas usando **Files** y **Path**.
