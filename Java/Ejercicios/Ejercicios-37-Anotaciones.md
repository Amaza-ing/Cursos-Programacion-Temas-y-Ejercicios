# Ejercicios - Tema 37: Módulos y Java Moderno

A continuación encontrarás **10 ejercicios prácticos** sobre **módulos y Java moderno**: `module-info.java`, `requires`, `exports`, `opens`, estructura modular, compact source files, `switch` moderno, text blocks, `var` y pattern matching.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear un módulo vacío

Crea un archivo `module-info.java` para un módulo llamado:

```text
com.amazaing.notes
```

No exportes ningún paquete todavía.

<details><summary>Mostrar solución</summary>

```java
module com.amazaing.notes {
}
```

</details>

---

## Ejercicio 2: Exportar un paquete

Modifica el módulo `com.amazaing.notes` para exportar el paquete:

```text
com.amazaing.notes.api
```

<details><summary>Mostrar solución</summary>

```java
module com.amazaing.notes {
    exports com.amazaing.notes.api;
}
```

</details>

---

## Ejercicio 3: Requerir otro módulo

Crea un `module-info.java` para un módulo llamado:

```text
com.amazaing.app
```

Debe requerir el módulo:

```text
com.amazaing.notes
```

<details><summary>Mostrar solución</summary>

```java
module com.amazaing.app {
    requires com.amazaing.notes;
}
```

</details>

---

## Ejercicio 4: Usar `requires java.sql`

Crea un `module-info.java` para un módulo llamado:

```text
com.amazaing.database
```

Debe declarar que necesita `java.sql`.

<details><summary>Mostrar solución</summary>

```java
module com.amazaing.database {
    requires java.sql;
}
```

</details>

---

## Ejercicio 5: Abrir un paquete con `opens`

Crea un `module-info.java` para un módulo llamado:

```text
com.amazaing.users
```

Debe abrir el paquete:

```text
com.amazaing.users.model
```

para permitir reflexión.

<details><summary>Mostrar solución</summary>

```java
module com.amazaing.users {
    opens com.amazaing.users.model;
}
```

</details>

---

## Ejercicio 6: Escribir una estructura modular

Escribe la estructura de carpetas para un módulo llamado:

```text
com.amazaing.shop
```

Con una clase principal:

```text
com.amazaing.shop.Main
```

No necesitas crear código completo, solo la estructura.

<details><summary>Mostrar solución</summary>

```text
src
└── com.amazaing.shop
    ├── module-info.java
    └── com
        └── amazaing
            └── shop
                └── Main.java
```

</details>

---

## Ejercicio 7: Compact source file

Escribe un programa sencillo usando la forma compacta de Java moderno para imprimir:

```text
Hello modern Java
```

No uses `public class Main`.

<details><summary>Mostrar solución</summary>

```java
void main() {
    System.out.println("Hello modern Java");
}
```

</details>

---

## Ejercicio 8: `switch` moderno

Declara una variable:

```java
String role = "admin";
```

Usa un `switch` moderno para asignar a una variable `message`:

- `"Full access"` si el rol es `"admin"`
- `"Limited access"` si el rol es `"user"`
- `"No access"` en cualquier otro caso

Imprime el mensaje.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String role = "admin";

        String message = switch (role) {
            case "admin" -> "Full access";
            case "user" -> "Limited access";
            default -> "No access";
        };

        System.out.println(message);
    }
}
```

</details>

---

## Ejercicio 9: Pattern matching con `instanceof`

Declara una variable:

```java
Object value = "Java";
```

Usa pattern matching con `instanceof` para comprobar si es `String` e imprimir su longitud.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        Object value = "Java";

        if (value instanceof String text) {
            System.out.println(text.length());
        }
    }
}
```

</details>

---

## Ejercicio 10: Text block para JSON

Crea un `String json` usando text block con este contenido:

```json
{
  "name": "Laura",
  "active": true
}
```

Imprime el texto.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String json = """
                {
                  "name": "Laura",
                  "active": true
                }
                """;

        System.out.println(json);
    }
}
```

</details>

---
