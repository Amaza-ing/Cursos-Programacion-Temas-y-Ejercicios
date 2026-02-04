# Ejercicios - Tema 9: Métodos de `String`

A continuación encontrarás **10 ejercicios prácticos** para trabajar con los métodos más usados de `String` (`length`, `charAt`, `substring`, `equals`, `contains`, `indexOf`, `replace`, `strip/trim`, `split`, `String.format`, etc.).

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Longitud y primera letra

Declara una variable `text` con valor `"Programming"`.

- Imprime la longitud de la cadena
- Imprime el primer carácter

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String text = "Programming";

        System.out.println(text.length());
        System.out.println(text.charAt(0));
    }
}
```

</details>

---

## Ejercicio 2: Obtener las 3 primeras letras

Declara una variable `word` con valor `"IntelliJ"`.

Usa `substring` para obtener `"Int"` y muéstralo por consola.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String word = "IntelliJ";

        String result = word.substring(0, 3);
        System.out.println(result);
    }
}
```

</details>

---

## Ejercicio 3: Comparación sin distinguir mayúsculas

Declara una variable `input` con valor `"YeS"`.

Comprueba si el valor significa `"yes"` ignorando mayúsculas y minúsculas, e imprime el resultado.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String input = "YeS";

        boolean isYes = input.equalsIgnoreCase("yes");
        System.out.println(isYes);
    }
}
```

</details>

---

## Ejercicio 4: Eliminar espacios y validar

Declara una variable `rawName` con valor `"   Laura   "`.

- Elimina los espacios de los lados
- Comprueba si el resultado NO está vacío
- Imprime el nombre limpio

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String rawName = "   Laura   ";

        String cleanName = rawName.strip();

        if (!cleanName.isEmpty()) {
            System.out.println(cleanName);
        }
    }
}
```

</details>

---

## Ejercicio 5: Comprobar si un email contiene `@` y termina en `.com`

Declara una variable `email` con valor `"user@example.com"`.

Crea una variable `isValid` que sea `true` si:

- Contiene `@`
- Termina en `.com`

Imprime `isValid`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String email = "user@example.com";

        boolean isValid = email.contains("@") && email.endsWith(".com");
        System.out.println(isValid);
    }
}
```

</details>

---

## Ejercicio 6: Encontrar la posición de un carácter

Declara una variable `fileName` con valor `"report_2026.pdf"`.

Usa `indexOf` para encontrar la posición del primer guion bajo (`_`) e imprímela.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String fileName = "report_2026.pdf";

        int index = fileName.indexOf("_");
        System.out.println(index);
    }
}
```

</details>

---

## Ejercicio 7: Extraer la extensión de un archivo

Declara `fileName` con valor `"photo.backup.png"`.

Extrae la extensión usando `lastIndexOf` y `substring` e imprímela.

Salida esperada:

```
png
```

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String fileName = "photo.backup.png";

        int dotIndex = fileName.lastIndexOf(".");

        String extension = fileName.substring(dotIndex + 1);
        System.out.println(extension);
    }
}
```

</details>

---

## Ejercicio 8: Reemplazar texto

Declara una variable `sentence` con valor `"Java is hard"`.

Reemplaza `"hard"` por `"powerful"` e imprime el resultado.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String sentence = "Java is hard";

        String updated = sentence.replace("hard", "powerful");
        System.out.println(updated);
    }
}
```

</details>

---

## Ejercicio 9: Dividir una cadena CSV

Declara una variable `line` con valor `"Laura;28;Madrid"`.

- Divide la cadena por `;`
- Imprime cada parte en una línea distinta

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String line = "Laura;28;Madrid";

        String[] parts = line.split(";");

        System.out.println(parts[0]);
        System.out.println(parts[1]);
        System.out.println(parts[2]);
    }
}
```

</details>

---

## Ejercicio 10: Formatear un mensaje con `String.format`

Declara:

- `product` con valor `"Mouse"`
- `unitPrice` con valor `12.5`
- `quantity` con valor `3`

Calcula el total y muestra un texto formateado con dos decimales usando `String.format`, por ejemplo:

```
Product: Mouse | Total: 37.50
```

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String product = "Mouse";
        double unitPrice = 12.5;
        int quantity = 3;

        double total = unitPrice * quantity;

        String message = String.format("Product: %s | Total: %.2f", product, total);
        System.out.println(message);
    }
}
```

</details>

---
