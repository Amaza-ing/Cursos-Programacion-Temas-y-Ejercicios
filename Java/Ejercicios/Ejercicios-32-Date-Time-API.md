# Exercises - Topic 32: Date/Time API

Below you will find **10 practical exercises** to work with the **Date/Time API**: `LocalDate`, `LocalTime`, `LocalDateTime`, `DateTimeFormatter`, `Period`, `Duration`, comparing dates and operations with days, months and years.

Try to solve them before looking at the solution.

---

## Exercise 1: Show the current date

Use `LocalDate.now()` to get the current date and print it to the console.

<details><summary>Show solution</summary>

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

## Exercise 2: Create a specific date

Create a date with:

- year: `2026`
- month: `7`
- day: `15`

Use `LocalDate.of` and print the result.

<details><summary>Show solution</summary>

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

## Exercise 3: Add days to a date

Create a variable `LocalDate startDate` with the value `2026-06-01`.

Add 10 days using `plusDays` and print the end date.

<details><summary>Show solution</summary>

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

## Exercise 4: Subtract months

Create a date `LocalDate paymentDate = LocalDate.of(2026, 12, 5)`.

Subtract 2 months using `minusMonths` and print the result.

<details><summary>Show solution</summary>

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

## Exercise 5: Format a date

Create a date `LocalDate date = LocalDate.of(2026, 9, 30)`.

Format the date with the pattern:

```text
dd/MM/yyyy
```

and print the result.

<details><summary>Show solution</summary>

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

## Exercise 6: Parse text into a date

Declare:

```java
String text = "25/12/2026";
```

Convert that text to `LocalDate` using `DateTimeFormatter` with the pattern `dd/MM/yyyy`.

<details><summary>Show solution</summary>

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

## Exercise 7: Calculate age with `Period`

Create a date of birth:

```java
LocalDate birthDate = LocalDate.of(2000, 3, 20);
```

Calculate the age in years using `Period.between`.

<details><summary>Show solution</summary>

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

## Exercise 8: Compare dates

Create two dates:

```java
LocalDate deadline = LocalDate.of(2026, 8, 1);
LocalDate currentDate = LocalDate.of(2026, 8, 10);
```

Check whether `currentDate` is later than `deadline` using `isAfter`.

If it is, print `"Expired"`.

<details><summary>Show solution</summary>

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

## Exercise 9: Duration between two times

Create two times:

```java
LocalTime start = LocalTime.of(9, 30);
LocalTime end = LocalTime.of(11, 15);
```

Calculate the duration between the two using `Duration.between` and print the total minutes.

<details><summary>Show solution</summary>

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

## Exercise 10: Create a method to check whether a due date has passed

Create a method:

```java
public static boolean isExpired(LocalDate dueDate)
```

It should return `true` if `dueDate` is earlier than the current date.

Test the method from `main` with a past date and a future date.

<details><summary>Show solution</summary>

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
