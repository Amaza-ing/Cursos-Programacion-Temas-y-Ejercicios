# Ejercicios - Tema 5: Condicionales (if y switch)

A continuación, encontrarás **10 ejercicios prácticos** sobre condicionales en Java: `if`, `else if`, `else` y `switch` (clásico y moderno).

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Comprobar si un número es positivo

Declara una variable `number` con valor `-3`.

Muestra por consola:

- `"Positive number"` si el número es mayor que 0
- `"Not positive"` en caso contrario

<details><summary>Mostrar Solución</summary>

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

## Ejercicio 2: Mayor, menor o igual a cero

Declara una variable `value` con valor `0`.

Usa `if`, `else if` y `else` para mostrar:

- `"Greater than zero"`
- `"Less than zero"`
- `"Equal to zero"`

<details><summary>Mostrar Solución</summary>

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

## Ejercicio 3: Acceso con edad y documento

Declara:

- `age` con valor `17`
- `hasId` con valor `true`

Muestra `"Access granted"` solo si es mayor o igual a 18 **y** tiene documento.

<details><summary>Mostrar Solución</summary>

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

## Ejercicio 4: Usuario bloqueado

Declara una variable `isBlocked` con valor `true`.

Si el usuario **no** está bloqueado, muestra `"User can log in"`.

<details><summary>Mostrar Solución</summary>

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

## Ejercicio 5: Clasificar una nota numérica

Declara una variable `score` con valor `74`.

Muestra:

- `"Excellent"` si es mayor o igual a 90
- `"Good"` si es mayor o igual a 70
- `"Fail"` en cualquier otro caso

<details><summary>Mostrar Solución</summary>

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

## Ejercicio 6: Comparar texto correctamente

Declara una variable `role` con valor `"admin"`.

Muestra `"Administrator access"` solo si el rol es `"admin"`.

<details><summary>Mostrar Solución</summary>

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

## Ejercicio 7: Switch clásico con opciones numéricas

Declara una variable `option` con valor `3`.

Usa `switch` para mostrar:

- `1` → `"Start"`
- `2` → `"Settings"`
- `3` → `"Exit"`
- Cualquier otro valor → `"Invalid option"`

<details><summary>Mostrar Solución</summary>

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

## Ejercicio 8: Switch moderno con texto

Declara una variable `day` con valor `"SUN"`.

Usa `switch` moderno para mostrar:

- `"Weekday"` si es `"MON"`, `"TUE"`, `"WED"`, `"THU"` o `"FRI"`
- `"Weekend"` si es `"SAT"` o `"SUN"`
- `"Unknown"` en otro caso

<details><summary>Mostrar Solución</summary>

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

## Ejercicio 9: Switch como expresión con `yield`

Declara una variable `points` con valor `85`.

Usa `switch` para asignar una letra:

- 90 o más → `"A"`
- 80 a 89 → `"B"`
- 70 a 79 → `"C"`
- Menos de 70 → `"D"`

<details><summary>Mostrar Solución</summary>

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

## Ejercicio 10: Elegir entre if y switch

Declara una variable `statusCode` con valor `404`.

Usa la estructura que consideres más adecuada para mostrar:

- `200` → `"OK"`
- `404` → `"Not Found"`
- `500` → `"Server Error"`
- Otro valor → `"Unknown status"`

<details><summary>Mostrar Solución</summary>

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
