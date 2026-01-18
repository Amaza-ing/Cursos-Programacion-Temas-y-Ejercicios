# Tema 5. Condicionales (if y switch)

## 1. Introducción

Hasta ahora has aprendido a:

- Guardar información con **variables**
- Operar con valores usando **operadores**
- Convertir tipos cuando es necesario

El siguiente paso es que el programa pueda **tomar decisiones**.

En programación, tomar decisiones significa:

- Evaluar una condición (algo que es `true` o `false`)
- Ejecutar un bloque de código u otro según el resultado

En Java, los condicionales principales son:

- `if`, `else if`, `else`
- `switch` (incluyendo el **switch moderno**)

En este tema aprenderás a usarlos con claridad y con ejemplos guiados.

---

## 2. Condicional `if`

### 2.1. ¿Qué hace un `if`?

Un `if` ejecuta un bloque de código **solo si una condición es verdadera**.

Sintaxis básica:

```java
if (condition) {
    // code to run if condition is true
}
```

- `condition` debe ser una expresión que devuelva un `boolean` (`true` o `false`).
- El bloque va entre llaves `{}`.

---

### 2.2. Ejemplo 1: comprobar si una persona es mayor de edad

```java
int age = 20;

if (age >= 18) {
    System.out.println("You are an adult.");
}
```

Si `age` es 20, la condición `age >= 18` es `true`, por lo tanto se ejecuta el mensaje.

---

### 2.3. Ejemplo 2: condición falsa (no pasa nada)

```java
int age = 15;

if (age >= 18) {
    System.out.println("You are an adult.");
}
```

Aquí la condición es `false`, así que el bloque **no se ejecuta**.

---

## 3. `if` con `else`

### 3.1. ¿Qué hace `else`?

`else` define qué hacer **si la condición del `if` es falsa**.

```java
if (condition) {
    // if true
} else {
    // if false
}
```

---

### 3.2. Ejemplo: mayor de edad o menor de edad

```java
int age = 15;

if (age >= 18) {
    System.out.println("You are an adult.");
} else {
    System.out.println("You are a minor.");
}
```

Con `age = 15`, imprime:

```
You are a minor.
```

---

## 4. `if` con `else if` (varias condiciones)

### 4.1. ¿Cuándo usar `else if`?

Cuando necesitas evaluar **más de dos casos**.

```java
if (condition1) {
    // case 1
} else if (condition2) {
    // case 2
} else {
    // default case
}
```

Java evalúa de arriba hacia abajo y se queda con el **primer caso que sea true**.

---

### 4.2. Ejemplo: clasificar una nota

```java
int score = 82;

if (score >= 90) {
    System.out.println("Grade: A");
} else if (score >= 80) {
    System.out.println("Grade: B");
} else if (score >= 70) {
    System.out.println("Grade: C");
} else {
    System.out.println("Grade: D");
}
```

Si `score = 82`, imprime:

```
Grade: B
```

---

### 4.3. Error típico: orden incorrecto

Este ejemplo está mal:

```java
int score = 82;

if (score >= 70) {
    System.out.println("Grade: C");
} else if (score >= 80) {
    System.out.println("Grade: B");
}
```

Con `82`, el primer `if` ya es `true`, así que nunca llega a `score >= 80`.

**Regla práctica:** coloca primero las condiciones **más restrictivas** o “más altas”.

---

## 5. Condiciones compuestas (AND, OR, NOT)

Aquí es donde los operadores lógicos son muy útiles.

### 5.1. AND (`&&`)

Ambas condiciones deben ser verdaderas.

```java
int age = 20;
boolean hasId = true;

if (age >= 18 && hasId) {
    System.out.println("Access granted.");
} else {
    System.out.println("Access denied.");
}
```

---

### 5.2. OR (`||`)

Con que una condición sea verdadera, basta.

```java
boolean isVip = true;
boolean hasInvitation = false;

if (isVip || hasInvitation) {
    System.out.println("Welcome!");
} else {
    System.out.println("No access.");
}
```

---

### 5.3. NOT (`!`)

Niega un valor booleano.

```java
boolean isBlocked = false;

if (!isBlocked) {
    System.out.println("You can log in.");
}
```

---

## 6. Buenas prácticas con `if`

### 6.1. Evita condiciones difíciles de leer

Mal (difícil de entender):

```java
if (age >= 18 && (country.equals("ES") || country.equals("FR")) && !isBlocked) {
    System.out.println("OK");
}
```

Mejor (variables intermedias):

```java
boolean isAdult = age >= 18;
boolean isAllowedCountry = country.equals("ES") || country.equals("FR");
boolean canAccess = isAdult && isAllowedCountry && !isBlocked;

if (canAccess) {
    System.out.println("OK");
}
```

Esto es más largo, pero mucho más legible.

---

### 6.2. Comparaciones con `String` (muy importante)

En Java, para comparar `String` debes usar `.equals(...)`, no `==`.

Incorrecto:

```java
String role = "admin";

if (role == "admin") {
    System.out.println("Admin access");
}
```

Correcto:

```java
String role = "admin";

if (role.equals("admin")) {
    System.out.println("Admin access");
}
```

---

## 7. Condicional `switch`

### 7.1. ¿Qué es `switch`?

`switch` se usa cuando quieres comparar **un mismo valor** contra múltiples casos.

Ejemplo típico: menús, opciones, días de la semana, tipos, estados, etc.

---

## 8. `switch` clásico (con `case` y `break`)

Sintaxis:

```java
switch (value) {
    case option1:
        // code
        break;
    case option2:
        // code
        break;
    default:
        // code if none match
}
```

`break` es crucial para evitar que el programa “siga” con los siguientes casos.

---

### 8.1. Ejemplo: menú simple

```java
int option = 2;

switch (option) {
    case 1:
        System.out.println("You selected: Play");
        break;
    case 2:
        System.out.println("You selected: Settings");
        break;
    case 3:
        System.out.println("You selected: Exit");
        break;
    default:
        System.out.println("Invalid option");
}
```

---

### 8.2. Error típico: olvidar `break`

```java
int option = 2;

switch (option) {
    case 1:
        System.out.println("Play");
    case 2:
        System.out.println("Settings");
    case 3:
        System.out.println("Exit");
}
```

Con `option = 2`, imprimirá:

```
Settings
Exit
```

Porque al no haber `break`, entra en `case 2` y continúa.

---

## 9. Switch moderno (recomendado en Java moderno)

Java moderno permite escribir `switch` de forma más segura y compacta.

Características:

- Usa `->` en lugar de `:`
- No necesita `break`
- Permite retornar valores fácilmente
- Evita errores de “fall-through”

---

### 9.1. Ejemplo: switch moderno (expresión)

```java
int option = 2;

String message = switch (option) {
    case 1 -> "You selected: Play";
    case 2 -> "You selected: Settings";
    case 3 -> "You selected: Exit";
    default -> "Invalid option";
};

System.out.println(message);
```

Aquí `switch` devuelve un `String`, como si fuera una expresión.

---

### 9.2. Ejemplo: múltiples valores por caso

```java
String day = "SAT";

String type = switch (day) {
    case "MON", "TUE", "WED", "THU", "FRI" -> "Weekday";
    case "SAT", "SUN" -> "Weekend";
    default -> "Unknown";
};

System.out.println(type);
```

---

### 9.3. Ejemplo: bloque con `yield`

Cuando necesitas más de una línea en un caso, puedes usar un bloque `{}` y `yield`.

```java
int score = 85;

String grade = switch (score / 10) {
    case 10, 9 -> "A";
    case 8 -> {
        System.out.println("Good job!");
        yield "B";
    }
    case 7 -> "C";
    default -> "D";
};

System.out.println(grade);
```

---

## 10. ¿Cuándo usar `if` y cuándo usar `switch`?

### 10.1. Usa `if` cuando

- La condición es una comparación compleja (`&&`, `||`, rangos, etc.)
- Necesitas evaluar expresiones como “entre 0 y 10”
- Tienes condiciones que no dependen de un único valor

Ejemplo típico para `if`:

```java
if (age >= 18 && hasId) {
    System.out.println("Access granted");
}
```

---

### 10.2. Usa `switch` cuando

- Comparas un valor con varias opciones posibles
- Es un menú o una selección clara
- Los casos son discretos (1, 2, 3 o "A", "B", "C")

Ejemplo típico para `switch`:

```java
switch (option) {
    case 1 -> System.out.println("Play");
    case 2 -> System.out.println("Settings");
    default -> System.out.println("Invalid option");
}
```

---

## 11. Ejemplos guiados (para entenderlo de verdad)

### 11.1. Ejemplo 1: validar una contraseña simple con `if`

Queremos comprobar:

- Que la contraseña tenga al menos 8 caracteres
- Que no esté bloqueado el usuario

```java
public class Main {
    public static void main(String[] args) {
        String password = "mySecret1";
        boolean isBlocked = false;

        boolean isLongEnough = password.length() >= 8;

        if (isLongEnough && !isBlocked) {
            System.out.println("Password accepted");
        } else {
            System.out.println("Password rejected");
        }
    }
}
```

Puntos clave:

- `password.length()` devuelve el número de caracteres
- `isLongEnough` hace la condición más legible
- `!isBlocked` significa “no está bloqueado”

---

### 11.2. Ejemplo 2: sistema de niveles con `else if`

Queremos clasificar un nivel según puntos:

- 0 a 99: Beginner
- 100 a 199: Intermediate
- 200 o más: Advanced

```java
public class Main {
    public static void main(String[] args) {
        int points = 165;

        if (points < 100) {
            System.out.println("Level: Beginner");
        } else if (points < 200) {
            System.out.println("Level: Intermediate");
        } else {
            System.out.println("Level: Advanced");
        }
    }
}
```

Puntos clave:

- No hace falta escribir `points >= 100` en el segundo caso
- Si llega al `else if`, ya sabemos que `points >= 100`

---

### 11.3. Ejemplo 3: seleccionar una acción con switch moderno

```java
public class Main {
    public static void main(String[] args) {
        int option = 3;

        String action = switch (option) {
            case 1 -> "Creating new file";
            case 2 -> "Opening settings";
            case 3 -> "Exiting";
            default -> "Unknown option";
        };

        System.out.println(action);
    }
}
```

Puntos clave:

- `switch` devuelve un valor
- No hay `break`
- El código es más limpio

---

## 12. A tener en cuenta

- `if` se usa para decisiones basadas en condiciones.
- `else` cubre el caso contrario.
- `else if` permite múltiples caminos, pero el orden importa.
- `switch` es ideal cuando comparas un solo valor con varias opciones.
- El **switch moderno** evita errores y suele ser más legible.

---

En el próximo tema aprenderemos a repetir acciones con **bucles** (`while` y `for`), donde los condicionales serán clave para controlar cuándo parar o continuar.
