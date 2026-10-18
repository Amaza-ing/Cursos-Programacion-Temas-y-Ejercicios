# Topic 32. Date/Time API

## 1. Introduction

Working with dates and times is a very common need in programming.

For example:

- storing a user's registration date
- calculating a person's age
- showing the current time
- checking whether a task is overdue
- calculating how many days are left until an event
- recording the date and time of a purchase
- working with time zones

Java includes a modern API for working with dates and times in a clear and safe way:

- **Date/Time API**

This API is mainly in the package:

```java
java.time
```

In this topic you will learn:

- Why using the old `Date` and `Calendar` classes is not recommended for new code
- What `LocalDate` is
- What `LocalTime` is
- What `LocalDateTime` is
- How to create dates and times
- How to add and subtract days, months, years, hours or minutes
- How to compare dates
- How to work with `Period` and `Duration`
- How to format and parse dates
- What `ZonedDateTime` and `ZoneId` are
- Typical mistakes and good practices

---

## 2. Before `java.time`: `Date` and `Calendar`

For many years, Java used classes like:

```java
java.util.Date
java.util.Calendar
```

These classes still exist, but for new code it is recommended to use the modern API:

```java
java.time
```

Why?

Because `java.time` is:

- clearer
- safer
- easier to read
- more precise in its design
- immutable
- better prepared for time zones

In this course we will focus on `java.time`.

---

## 3. Main package: `java.time`

The most important classes we will see are:

- `LocalDate`
- `LocalTime`
- `LocalDateTime`
- `Period`
- `Duration`
- `DateTimeFormatter`
- `ZoneId`
- `ZonedDateTime`
- `Instant`

Each one is used for a different case.

You don't need to memorize everything at once.  
The important thing is to understand what each class represents.

---

## 4. `LocalDate`: date only

`LocalDate` represents a date without a time.

Examples:

- `2026-06-21`
- `2025-12-31`
- `1995-04-10`

It does not include:

- hours
- minutes
- seconds
- time zone

Import:

```java
import java.time.LocalDate;
```

Example:

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

## 5. Creating a specific date with `LocalDate.of`

You can create a specific date with `of`.

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate birthDate = LocalDate.of(1995, 4, 10);

        System.out.println(birthDate);
    }
}
```

The order is:

```java
LocalDate.of(year, month, day)
```

Example:

```java
LocalDate date = LocalDate.of(2026, 6, 21);
```

---

## 6. Getting the parts of a date

You can get the year, the month or the day.

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

Important difference:

- `getMonth()` returns the enum of the month (`JUNE`)
- `getMonthValue()` returns the month number (`6`)

---

## 7. Adding to and subtracting from dates

`LocalDate` lets you add or subtract days, weeks, months and years.

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

## 8. Dates are immutable

The main classes of `java.time` are immutable.

That means their original value never changes.  
When you perform an operation, a new object is returned.

Incorrect example:

```java
LocalDate date = LocalDate.of(2026, 6, 21);

date.plusDays(1);

System.out.println(date); // sigue siendo 2026-06-21
```

Correct version:

```java
LocalDate date = LocalDate.of(2026, 6, 21);

date = date.plusDays(1);

System.out.println(date); // 2026-06-22
```

---

## 9. Comparing dates

You can compare dates with methods like:

- `isBefore`
- `isAfter`
- `isEqual`

Example:

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

## 10. Guided example: checking whether a task is overdue

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

## 11. `LocalTime`: time only

`LocalTime` represents a time without a date.

Examples:

- `10:30`
- `18:45:20`
- `09:15:00`

It does not include:

- day
- month
- year
- time zone

Import:

```java
import java.time.LocalTime;
```

Example:

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

## 12. Creating a specific time with `LocalTime.of`

```java
import java.time.LocalTime;

public class Main {
    public static void main(String[] args) {
        LocalTime startTime = LocalTime.of(9, 30);

        System.out.println(startTime);
    }
}
```

You can also include seconds:

```java
LocalTime time = LocalTime.of(9, 30, 15);
```

---

## 13. Getting the parts of a time

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

## 14. Adding and subtracting time

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

## 15. `LocalDateTime`: date and time

`LocalDateTime` combines:

- date
- time

Example:

```text
2026-06-21T10:30
```

It does not include a time zone.

Import:

```java
import java.time.LocalDateTime;
```

Example:

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

## 16. Creating a `LocalDateTime`

```java
import java.time.LocalDateTime;

public class Main {
    public static void main(String[] args) {
        LocalDateTime appointment = LocalDateTime.of(2026, 6, 21, 16, 30);

        System.out.println(appointment);
    }
}
```

Order:

```java
LocalDateTime.of(year, month, day, hour, minute)
```

---

## 17. Combining `LocalDate` and `LocalTime`

You can create a `LocalDateTime` by combining a date and a time.

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

## 18. Splitting a `LocalDateTime` into date and time

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

## 19. Adding and subtracting with `LocalDateTime`

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

## 20. `Period`: difference between dates

`Period` represents a date-based amount of time:

- years
- months
- days

It is normally used with `LocalDate`.

Example:

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

## 21. Guided example: calculating an age

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

## 22. `Duration`: difference between times

`Duration` represents an amount of time based on seconds and nanoseconds.

It is normally used with:

- `LocalTime`
- `LocalDateTime`
- `Instant`

Example:

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

## 23. Guided example: calculating the length of a class

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

## 24. Difference between `Period` and `Duration`

### 24.1. `Period`

It uses dates:

```java
Period.between(startDate, endDate)
```

It works with:

- years
- months
- days

### 24.2. `Duration`

It uses times:

```java
Duration.between(startTime, endTime)
```

It works with:

- hours
- minutes
- seconds
- nanoseconds

### 24.3. Rule of thumb

- Difference between dates → `Period`
- Difference between times or instants → `Duration`

---

## 25. Formatting dates with `DateTimeFormatter`

By default, `LocalDate` is printed in ISO format:

```text
2026-06-21
```

But you will often want to show it in another way:

```text
21/06/2026
```

For that we use `DateTimeFormatter`.

Import:

```java
import java.time.format.DateTimeFormatter;
```

Example:

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

## 26. Common formatting patterns

Some common patterns are:

```text
dd/MM/yyyy      -> 21/06/2026
yyyy-MM-dd      -> 2026-06-21
dd-MM-yyyy      -> 21-06-2026
HH:mm           -> 16:30
dd/MM/yyyy HH:mm -> 21/06/2026 16:30
```

Example:

```java
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
```

---

## 27. Parsing text into a date

Parsing means converting text into a date.

Example:

```java
import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        LocalDate date = LocalDate.parse("2026-06-21");

        System.out.println(date);
    }
}
```

This works because the text is in ISO format (`yyyy-MM-dd`).

---

## 28. Parsing with a custom format

If the text is in another format, you must specify a `DateTimeFormatter`.

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

Result:

```text
2026-06-21
```

---

## 29. Parsing a date and time

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

## 30. `ZoneId`: time zones

So far we have seen classes without a time zone:

- `LocalDate`
- `LocalTime`
- `LocalDateTime`

But sometimes you need to work with real time zones.

For that you can use:

- `ZoneId`
- `ZonedDateTime`

Time zone example:

```java
ZoneId madridZone = ZoneId.of("Europe/Madrid");
```

---

## 31. `ZonedDateTime`: date, time and time zone

`ZonedDateTime` represents a date and time with a time zone.

Example:

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

This includes:

- date
- time
- time zone
- the corresponding UTC offset

---

## 32. Seeing the time in another time zone

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

The important idea:

- it is the same real moment
- represented in two different time zones

---

## 33. `Instant`: an exact moment

`Instant` represents an exact point in time in UTC.

It is very useful for:

- logs
- timestamps
- events
- internal storage of exact moments

Example:

```java
import java.time.Instant;

public class Main {
    public static void main(String[] args) {
        Instant now = Instant.now();

        System.out.println(now);
    }
}
```

`Instant` is not mainly intended to be shown to the end user, but to represent an exact moment.

---

## 34. Converting between `Instant` and `ZonedDateTime`

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

## 35. Complete example: an event with a date and time

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

## 36. Complete example: a task with a due date

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

## 37. Guided example: calculating the days left until a date

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

`ChronoUnit.DAYS.between` is very useful when you want a direct difference in days.

---

## 38. `Month` as an enum

Java also has an enum called `Month`.

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

This can make the code more readable.

---

## 39. Invalid dates

Java validates dates.

This is not valid:

```java
// LocalDate date = LocalDate.of(2026, 2, 30); // error
```

February does not have a 30th day, so Java throws an exception.

This helps avoid impossible dates.

---

## 40. Common beginner mistakes

### 40.1. Using `Date` and `Calendar` in new code when there is no need

For modern code, it is usually better to use `java.time`.

### 40.2. Confusing `LocalDateTime` with a universal date

`LocalDateTime` does not have a time zone.  
It does not represent a global instant in itself.

### 40.3. Forgetting that dates are immutable

This does not change the original date:

```java
date.plusDays(1);
```

You must store the result:

```java
date = date.plusDays(1);
```

### 40.4. Using incorrect patterns in `DateTimeFormatter`

For example:

- `MM` means month
- `mm` means minutes

They are not the same:

```java
DateTimeFormatter.ofPattern("dd/MM/yyyy");
DateTimeFormatter.ofPattern("HH:mm");
```

### 40.5. Ignoring time zones when they matter

If you work with users from different countries or global events, you need to think about time zones.

---

## 41. Good practices

- Use `LocalDate` for dates without a time.
- Use `LocalTime` for times without a date.
- Use `LocalDateTime` for a date and time without a time zone.
- Use `ZonedDateTime` if the time zone matters.
- Use `Instant` for exact moments and internal records.
- Use `Period` for differences between dates.
- Use `Duration` for differences between times or instants.
- Use `DateTimeFormatter` to display or read dates in specific formats.
- Remember that `java.time` classes are immutable.
- Avoid `Date` and `Calendar` in new code unless you have to work with old APIs.

---

## 42. Things to keep in mind

- `java.time` is the modern date and time API in Java.
- `LocalDate` represents a date only.
- `LocalTime` represents a time only.
- `LocalDateTime` represents a date and time without a time zone.
- `ZonedDateTime` includes a time zone.
- `Instant` represents an exact moment in UTC.
- `Period` measures differences between dates.
- `Duration` measures differences between times.
- `DateTimeFormatter` is used for formatting and parsing.
- Dates and times are immutable.

---

## 43. Final summary

Java's modern Date/Time API lets you work with dates and times much more clearly than the old classes.

The key is choosing the right class:

- `LocalDate` if you only need a date
- `LocalTime` if you only need a time
- `LocalDateTime` if you need a date and time without a time zone
- `ZonedDateTime` if the time zone matters
- `Instant` if you need an exact moment

You have also seen how to:

- add and subtract dates
- compare dates
- calculate periods and durations
- format dates
- parse text into a date

Mastering this API is very important because dates appear constantly in real applications.

---

In the next topic we will keep moving forward with modern Java and see how to work with files and paths using **Files** and **Path**.
