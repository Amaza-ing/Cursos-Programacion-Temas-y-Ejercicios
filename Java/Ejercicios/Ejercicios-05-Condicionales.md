# Exercises - Topic 5: Conditionals (if and switch)

Below you will find **10 practical exercises** on conditionals in Java: `if`, `else if`, `else` and `switch` (classic and modern).

Try to solve them before consulting the solution.

---

## Exercise 1: Check if a number is positive

Declares a variable `number` with value `-3`.

Sample per console:

- `"Positive number"` if the number is greater than 0
- `"Not positive"` otherwise

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int number = -3;

        if (number > 0) {
            System.out.println("Positive number");
        } else {
            System.out.println("Not positive");
        }
    }
}
```

</details>

---

## Exercise 2: Greater than, less than or equal to zero

Declare a variable `value` with value `0`.

Use `if`, `else if` and `else` to display:

- `"Greater than zero"`
- `"Less than zero"`
- `"Equal to zero"`

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int value = 0;

        if (value > 0) {
            System.out.println("Greater than zero");
        } else if (value < 0) {
            System.out.println("Less than zero");
        } else {
            System.out.println("Equal to zero");
        }
    }
}
```

</details>

---

## Exercise 3: Access with age and document

Declares:

- `age` with `17` value
- `hasId` with `true` value

Displays `"Access granted"` only if it is greater than or equal to 18 **and** it has a document.

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int age = 17;
        boolean hasId = true;

        if (age >= 18 && hasId) {
            System.out.println("Access granted");
        } else {
            System.out.println("Access denied");
        }
    }
}
```

</details>

---

## Exercise 4: Blocked user

Declare a variable `isBlocked` with value `true`.

If the user is **not** blocked, it displays `"User can log in"`.

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        boolean isBlocked = true;

        if (!isBlocked) {
            System.out.println("User can log in");
        }
    }
}
```

</details>

---

## Exercise 5: Classify a numerical note

Declares a variable `score` with value `74`.

Sample:

- `"Excellent"` if greater than or equal to 90
- `"Good"` if greater than or equal to 70
- `"Fail"` in any other case

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int score = 74;

        if (score >= 90) {
            System.out.println("Excellent");
        } else if (score >= 70) {
            System.out.println("Good");
        } else {
            System.out.println("Fail");
        }
    }
}
```

</details>

---

## Exercise 6: Compare text correctly

Declares a variable `role` with value `"admin"`.

Displays `"Administrator access"` only if the role is `"admin"`.

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String role = "admin";

        if (role.equals("admin")) {
            System.out.println("Administrator access");
        }
    }
}
```

</details>

---

## Exercise 7: Classic switch with numerical options

Declares a variable `option` with value `3`.

Use `switch` to display:

- `1` → `"Start"`
- `2` → `"Settings"`
- `3` → `"Exit"`
- Any other value → `"Invalid option"`

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int option = 3;

        switch (option) {
            case 1:
                System.out.println("Start");
                break;
            case 2:
                System.out.println("Settings");
                break;
            case 3:
                System.out.println("Exit");
                break;
            default:
                System.out.println("Invalid option");
        }
    }
}
```

</details>

---

## Exercise 8: Modern switch with text

Declare a variable `day` with value `"SUN"`.

Use modern `switch` to display:

- `"Weekday"` if it is `"MON"`, `"TUE"`, `"WED"`, `"THU"` or `"FRI"`
- `"Weekend"` if it is `"SAT"` or `"SUN"`
- `"Unknown"` otherwise

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String day = "SUN";

        String result = switch (day) {
            case "MON", "TUE", "WED", "THU", "FRI" -> "Weekday";
            case "SAT", "SUN" -> "Weekend";
            default -> "Unknown";
        };

        System.out.println(result);
    }
}
```

</details>

---

## Exercise 9: Switch as an expression with `yield`

Declares a variable `points` with value `85`.

Use `switch` to assign a letter:

- 90 or more → `"A"`
- 80 to 89 → `"B"`
- 70 to 79 → `"C"`
- Less than 70 → `"D"`
<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int points = 85;

        String grade = switch (points / 10) {
            case 10, 9 -> "A";
            case 8 -> "B";
            case 7 -> "C";
            default -> {
                yield "D";
            }
        };

        System.out.println(grade);
    }
}
```

</details>

---

## Exercise 10: Choose between if and switch

Declares a variable `statusCode` with value `404`.

Use the structure that you consider most appropriate to show:

- `200` → `"OK"`
- `404` → `"Not Found"`
- `500` → `"Server Error"`
- Other value → `"Unknown status"`

<details><summary>Show Solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        int statusCode = 404;

        String message = switch (statusCode) {
            case 200 -> "OK";
            case 404 -> "Not Found";
            case 500 -> "Server Error";
            default -> "Unknown status";
        };

        System.out.println(message);
    }
}
```

</details>

---
