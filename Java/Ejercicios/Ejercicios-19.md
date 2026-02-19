# Ejercicios - Tema 19: Packages

A continuación encontrarás **10 ejercicios prácticos** sobre **packages**: crear estructura de carpetas, declaración `package`, uso de `import`, evitar _default package_, `package-private`, y un primer contacto con `static import`.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear un package principal y un `Main`

Crea un proyecto con este package principal:

```
app
```

Dentro, crea `Main.java` con:

- `package app;`
- Un `main` que imprima `Hello packages`.

<details><summary>Mostrar solución</summary>

```java
package app;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello packages");
    }
}
```

</details>

---

## Ejercicio 2: Crear `model` y una clase `User`

Crea el package:

```
app.model
```

Dentro, crea `User.java` con:

- `private String name`
- Constructor `User(String name)`
- Método `printInfo()` que imprima `User: name`

<details><summary>Mostrar solución</summary>

```java
package app.model;

public class User {
    private String name;

    public User(String name) {
        this.name = name;
    }

    public void printInfo() {
        System.out.println("User: " + name);
    }
}
```

</details>

---

## Ejercicio 3: Importar `User` desde `Main`

Usando lo del ejercicio 2, en `Main.java` (package `app`) crea un `User` e imprime su info.

Debes usar `import`.

<details><summary>Mostrar solución</summary>

```java
package app;

import app.model.User;

public class Main {
    public static void main(String[] args) {
        User user = new User("Laura");
        user.printInfo();
    }
}
```

</details>

---

## Ejercicio 4: Usar nombre completo sin `import`

Repite el ejercicio 3, pero esta vez **no** uses `import`.  
Crea el `User` usando el nombre completo de la clase (_fully qualified name_).

<details><summary>Mostrar solución</summary>

```java
package app;

public class Main {
    public static void main(String[] args) {
        app.model.User user = new app.model.User("Laura");
        user.printInfo();
    }
}
```

</details>

---

## Ejercicio 5: Dos clases con el mismo nombre en packages distintos

Crea dos clases llamadas `Logger` en:

- `app.utils.Logger`
- `app.service.Logger`

Cada una debe tener un método `log(String message)` que imprima:

- `UTILS: message`
- `SERVICE: message`

En `Main`, crea una instancia de cada `Logger`.  
Para evitar confusión, importa una y usa el nombre completo para la otra.

<details><summary>Mostrar solución</summary>

```java
package app.utils;

public class Logger {
    public void log(String message) {
        System.out.println("UTILS: " + message);
    }
}
```

```java
package app.service;

public class Logger {
    public void log(String message) {
        System.out.println("SERVICE: " + message);
    }
}
```

```java
package app;

import app.utils.Logger;

public class Main {
    public static void main(String[] args) {
        Logger utilsLogger = new Logger();
        utilsLogger.log("Hello");

        app.service.Logger serviceLogger = new app.service.Logger();
        serviceLogger.log("Hi");
    }
}
```

</details>

---

## Ejercicio 6: Clase `package-private` (sin modificador)

Crea una clase `InternalValidator` en `app.model` sin `public` (package-private).

Debe tener un método `isValidName(String name)` que devuelva `true` si:

- no es `null`
- no es blanca (`isBlank()`)

Luego, en `User` (mismo package `app.model`), crea un método `setName(String name)` que use `InternalValidator`.

<details><summary>Mostrar solución</summary>

```java
package app.model;

class InternalValidator {
    boolean isValidName(String name) {
        return name != null && !name.isBlank();
    }
}
```

```java
package app.model;

public class User {
    private String name;

    public User(String name) {
        setName(name);
    }

    public void setName(String name) {
        InternalValidator validator = new InternalValidator();

        if (!validator.isValidName(name)) {
            this.name = "Unknown";
            return;
        }

        this.name = name;
    }

    public void printInfo() {
        System.out.println("User: " + name);
    }
}
```

</details>

---

## Ejercicio 7: Probar que `package-private` no es accesible desde otro package

Con el ejercicio 6 hecho, en `Main` (package `app`) intenta crear `InternalValidator`.  
Debe fallar (no compila). Deja el código comentado.

<details><summary>Mostrar solución</summary>

```java
package app;

import app.model.User;

public class Main {
    public static void main(String[] args) {
        User user = new User("Laura");
        user.printInfo();

        // app.model.InternalValidator v = new app.model.InternalValidator(); // no compila
    }
}
```

</details>

---

## Ejercicio 8: Reorganizar estructura con `Refactor > Move` (teórico-práctico)

Imagina que tienes una clase `Order` en `app.model`, pero quieres moverla a:

```
app.domain
```

Escribe los cambios que deben ocurrir en el archivo `Order.java`:

1. Línea `package ...;` correcta
2. Imports que cambian en las clases que usan `Order`

No necesitas ejecutar nada: solo escribe el ejemplo de cómo quedaría.

<details><summary>Mostrar solución</summary>

```java
// Antes (en app.model)
package app.model;

public class Order {
}
```

```java
// Después (movida a app.domain)
package app.domain;

public class Order {
}
```

```java
// En una clase que antes tenía:
import app.model.Order;

// ahora debería tener:
import app.domain.Order;
```

</details>

---

## Ejercicio 9: `import *` vs imports explícitos

Crea tres clases en `app.model`:

- `User`
- `Product`
- `Order`

En `Main`, escribe dos versiones:

1. Import explícito de las tres clases
2. Import con comodín `import app.model.*;`

No necesitas instanciar nada, solo mostrar cómo serían los imports.

<details><summary>Mostrar solución</summary>

```java
// Versión 1: imports explícitos
import app.model.User;
import app.model.Product;
import app.model.Order;
```

```java
// Versión 2: comodín
import app.model.*;
```

</details>

---

## Ejercicio 10: `static import` con `Math`

En `Main`, calcula:

- Área de un círculo de radio `r = 3` con `PI`
- Raíz cuadrada de `81` con `sqrt`

Usa `static import` para poder escribir `PI` y `sqrt(...)` sin `Math.`.

<details><summary>Mostrar solución</summary>

```java
package app;

import static java.lang.Math.PI;
import static java.lang.Math.sqrt;

public class Main {
    public static void main(String[] args) {
        double r = 3;
        double area = PI * r * r;

        System.out.println(area);
        System.out.println(sqrt(81));
    }
}
```

</details>

---
