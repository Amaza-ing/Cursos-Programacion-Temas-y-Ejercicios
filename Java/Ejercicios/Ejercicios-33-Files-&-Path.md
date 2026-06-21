# Ejercicios - Tema 33: Files y Path

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **Files y Path**: creación de rutas, escritura y lectura de archivos, carpetas, añadir contenido, copiar, borrar, listar archivos y trabajar con líneas.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear una ruta con `Path.of`

Crea una ruta que apunte al archivo:

```text
data/notes.txt
```

Usa `Path.of` e imprime:

- la ruta
- la ruta absoluta

<details><summary>Mostrar solución</summary>

```java
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("data", "notes.txt");

        System.out.println(path);
        System.out.println(path.toAbsolutePath());
    }
}
```

</details>

---

## Ejercicio 2: Escribir texto en un archivo

Crea la carpeta `data` si no existe.

Después escribe el texto `"Learning Java files"` en:

```text
data/message.txt
```

Usa `Files.createDirectories` y `Files.writeString`.

<details><summary>Mostrar solución</summary>

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path folder = Path.of("data");
        Path file = folder.resolve("message.txt");

        try {
            Files.createDirectories(folder);
            Files.writeString(file, "Learning Java files");
        } catch (IOException e) {
            System.out.println("Could not write file");
        }
    }
}
```

</details>

---

## Ejercicio 3: Leer texto de un archivo

Usando el archivo del ejercicio anterior, lee el contenido de:

```text
data/message.txt
```

e imprímelo por consola.

<details><summary>Mostrar solución</summary>

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path file = Path.of("data", "message.txt");

        try {
            String content = Files.readString(file);
            System.out.println(content);
        } catch (IOException e) {
            System.out.println("Could not read file");
        }
    }
}
```

</details>

---

## Ejercicio 4: Escribir varias líneas

Crea una lista con estas líneas:

- `"First line"`
- `"Second line"`
- `"Third line"`

Escríbelas en:

```text
data/lines.txt
```

Usa `Files.write`.

<details><summary>Mostrar solución</summary>

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Path folder = Path.of("data");
        Path file = folder.resolve("lines.txt");

        List<String> lines = List.of("First line", "Second line", "Third line");

        try {
            Files.createDirectories(folder);
            Files.write(file, lines);
        } catch (IOException e) {
            System.out.println("Could not write lines");
        }
    }
}
```

</details>

---

## Ejercicio 5: Leer todas las líneas y filtrarlas

Lee el archivo:

```text
data/lines.txt
```

Usa `Files.readAllLines` y muestra solo las líneas que contengan la palabra `"Second"`.

<details><summary>Mostrar solución</summary>

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Path file = Path.of("data", "lines.txt");

        try {
            List<String> lines = Files.readAllLines(file);

            lines.stream()
                    .filter(line -> line.contains("Second"))
                    .forEach(System.out::println);
        } catch (IOException e) {
            System.out.println("Could not read lines");
        }
    }
}
```

</details>

---

## Ejercicio 6: Añadir contenido al final de un archivo

Añade la línea `"New entry"` al archivo:

```text
data/log.txt
```

Si el archivo no existe, debe crearse.

Usa `StandardOpenOption.CREATE` y `StandardOpenOption.APPEND`.

<details><summary>Mostrar solución</summary>

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Path folder = Path.of("data");
        Path file = folder.resolve("log.txt");

        try {
            Files.createDirectories(folder);
            Files.write(
                    file,
                    List.of("New entry"),
                    StandardOpenOption.CREATE,
                    StandardOpenOption.APPEND
            );
        } catch (IOException e) {
            System.out.println("Could not append content");
        }
    }
}
```

</details>

---

## Ejercicio 7: Copiar un archivo

Crea una copia de:

```text
data/message.txt
```

en:

```text
data/message-copy.txt
```

Usa `Files.copy` y `StandardCopyOption.REPLACE_EXISTING`.

<details><summary>Mostrar solución</summary>

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;

public class Main {
    public static void main(String[] args) {
        Path source = Path.of("data", "message.txt");
        Path target = Path.of("data", "message-copy.txt");

        try {
            Files.copy(source, target, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            System.out.println("Could not copy file");
        }
    }
}
```

</details>

---

## Ejercicio 8: Borrar un archivo si existe

Borra el archivo:

```text
data/message-copy.txt
```

Usa `Files.deleteIfExists` e imprime si se ha borrado o no.

<details><summary>Mostrar solución</summary>

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path file = Path.of("data", "message-copy.txt");

        try {
            boolean deleted = Files.deleteIfExists(file);
            System.out.println("Deleted: " + deleted);
        } catch (IOException e) {
            System.out.println("Could not delete file");
        }
    }
}
```

</details>

---

## Ejercicio 9: Listar archivos de una carpeta

Lista todos los elementos de la carpeta:

```text
data
```

Usa `Files.list`.

<details><summary>Mostrar solución</summary>

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        Path folder = Path.of("data");

        try (Stream<Path> paths = Files.list(folder)) {
            paths.forEach(System.out::println);
        } catch (IOException e) {
            System.out.println("Could not list folder");
        }
    }
}
```

</details>

---

## Ejercicio 10: Contar líneas de un archivo grande

Usa `Files.lines` para contar cuántas líneas tiene:

```text
data/lines.txt
```

Recuerda usar `try-with-resources`.

<details><summary>Mostrar solución</summary>

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        Path file = Path.of("data", "lines.txt");

        try (Stream<String> lines = Files.lines(file)) {
            long count = lines.count();
            System.out.println(count);
        } catch (IOException e) {
            System.out.println("Could not count lines");
        }
    }
}
```

</details>

---
