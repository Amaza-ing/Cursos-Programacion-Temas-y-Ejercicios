# Tema 33. `Files` y `Path`

## 1. Introducción

En muchos programas necesitas trabajar con archivos y carpetas.

Por ejemplo:

- leer un archivo de texto
- guardar información en un archivo
- crear una carpeta
- comprobar si un archivo existe
- copiar un archivo
- mover o renombrar un archivo
- borrar archivos
- listar el contenido de una carpeta

Java tiene varias formas de trabajar con archivos, pero en código moderno se recomienda usar principalmente:

- `Path`
- `Files`

Estas clases forman parte de la API moderna de entrada/salida de Java, conocida como **NIO.2**.

En este tema aprenderás:

- Qué es `Path`
- Qué es `Files`
- Cómo crear rutas
- Cómo comprobar si existen archivos o carpetas
- Cómo leer archivos de texto
- Cómo escribir archivos
- Cómo añadir contenido a un archivo
- Cómo crear carpetas
- Cómo copiar, mover y borrar archivos
- Cómo listar una carpeta
- Cómo manejar excepciones con `IOException`
- Buenas prácticas al trabajar con archivos

---

## 2. Archivos y rutas

Antes de escribir código, conviene diferenciar dos conceptos.

### 2.1. Archivo

Un archivo es un elemento que contiene información.

Ejemplos:

```text
notes.txt
users.csv
config.json
image.png
```

### 2.2. Ruta

Una ruta indica dónde está un archivo o una carpeta.

Ejemplo en Windows:

```text
C:\Users\Laura\Documents\notes.txt
```

Ejemplo en macOS o Linux:

```text
/home/laura/documents/notes.txt
```

En Java moderno, las rutas se representan con la clase `Path`.

---

## 3. Qué es `Path`

`Path` representa una ruta del sistema de archivos.

Puede apuntar a:

- un archivo
- una carpeta
- una ruta que todavía no existe

Importación:

```java
import java.nio.file.Path;
```

Ejemplo:

```java
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("notes.txt");

        System.out.println(path);
    }
}
```

Aquí `path` representa el archivo `notes.txt` en la carpeta actual del proyecto.

---

## 4. Qué es `Files`

`Files` es una clase de utilidad con métodos estáticos para trabajar con archivos y carpetas.

Importación:

```java
import java.nio.file.Files;
```

Ejemplos de operaciones:

```java
Files.exists(path);
Files.readString(path);
Files.writeString(path, "Hello");
Files.createDirectory(path);
Files.deleteIfExists(path);
```

Idea clave:

- `Path` representa la ruta
- `Files` realiza operaciones sobre esa ruta

---

## 5. Crear rutas con `Path.of`

La forma moderna y sencilla de crear rutas es usar `Path.of`.

```java
Path path = Path.of("notes.txt");
```

También puedes crear rutas por partes:

```java
Path path = Path.of("data", "notes.txt");
```

Esto representa:

```text
data/notes.txt
```

o en Windows:

```text
data\notes.txt
```

Java adapta el separador según el sistema operativo.

---

## 6. Evitar escribir separadores manualmente

Puedes escribir esto:

```java
Path path = Path.of("data/notes.txt");
```

Pero suele ser más recomendable escribir la ruta por partes:

```java
Path path = Path.of("data", "notes.txt");
```

Así el código es más portable entre sistemas operativos.

---

## 7. Rutas relativas y absolutas

### 7.1. Ruta relativa

Una ruta relativa depende de la carpeta desde la que se ejecuta el programa.

```java
Path path = Path.of("notes.txt");
```

Esto apunta a `notes.txt` en la carpeta actual.

### 7.2. Ruta absoluta

Una ruta absoluta empieza desde la raíz del sistema.

Ejemplo en Windows:

```java
Path path = Path.of("C:", "Users", "Laura", "Documents", "notes.txt");
```

Ejemplo en macOS o Linux:

```java
Path path = Path.of("/home/laura/documents/notes.txt");
```

En proyectos de aprendizaje, normalmente empezaremos con rutas relativas.

---

## 8. Obtener información de una ruta

`Path` tiene métodos útiles para analizar una ruta.

```java
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("data", "notes.txt");

        System.out.println("Path: " + path);
        System.out.println("File name: " + path.getFileName());
        System.out.println("Parent: " + path.getParent());
        System.out.println("Absolute path: " + path.toAbsolutePath());
    }
}
```

Resultado aproximado:

```text
Path: data/notes.txt
File name: notes.txt
Parent: data
Absolute path: ...
```

---

## 9. Comprobar si un archivo existe

Para comprobar si una ruta existe, usamos `Files.exists`.

```java
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("notes.txt");

        if (Files.exists(path)) {
            System.out.println("File exists");
        } else {
            System.out.println("File does not exist");
        }
    }
}
```

---

## 10. Comprobar si es archivo o carpeta

```java
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("data");

        System.out.println(Files.isRegularFile(path));
        System.out.println(Files.isDirectory(path));
    }
}
```

- `isRegularFile` comprueba si es un archivo normal
- `isDirectory` comprueba si es una carpeta

---

## 11. Crear un archivo

Puedes crear un archivo vacío con `Files.createFile`.

Este método puede lanzar `IOException`, así que debes manejarla.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("notes.txt");

        try {
            Files.createFile(path);
            System.out.println("File created");
        } catch (IOException e) {
            System.out.println("Could not create file");
            System.out.println(e.getMessage());
        }
    }
}
```

Si el archivo ya existe, puede producirse una excepción.

---

## 12. Crear una carpeta

Para crear una carpeta usamos `Files.createDirectory`.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path folder = Path.of("data");

        try {
            Files.createDirectory(folder);
            System.out.println("Folder created");
        } catch (IOException e) {
            System.out.println("Could not create folder");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 13. Crear carpetas anidadas con `createDirectories`

Si quieres crear varias carpetas a la vez, usa `createDirectories`.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path folder = Path.of("data", "users", "2026");

        try {
            Files.createDirectories(folder);
            System.out.println("Folders created");
        } catch (IOException e) {
            System.out.println("Could not create folders");
            System.out.println(e.getMessage());
        }
    }
}
```

Diferencia importante:

- `createDirectory` crea una sola carpeta
- `createDirectories` crea toda la estructura necesaria

---

## 14. Escribir texto en un archivo con `writeString`

Una forma sencilla de escribir texto es usar `Files.writeString`.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("notes.txt");

        try {
            Files.writeString(path, "Learning Java Files and Path");
            System.out.println("File written");
        } catch (IOException e) {
            System.out.println("Could not write file");
            System.out.println(e.getMessage());
        }
    }
}
```

Si el archivo no existe, se crea.  
Si el archivo existe, se reemplaza su contenido.

---

## 15. Leer texto de un archivo con `readString`

Para leer todo el contenido de un archivo de texto, puedes usar `Files.readString`.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("notes.txt");

        try {
            String content = Files.readString(path);
            System.out.println(content);
        } catch (IOException e) {
            System.out.println("Could not read file");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 16. Ejemplo guiado: escribir y leer un archivo

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("message.txt");

        try {
            Files.writeString(path, "Hello from Java");

            String content = Files.readString(path);

            System.out.println(content);
        } catch (IOException e) {
            System.out.println("File error");
            System.out.println(e.getMessage());
        }
    }
}
```

Este ejemplo:

1. crea o sobrescribe `message.txt`
2. escribe texto
3. lee el contenido
4. lo imprime

---

## 17. Escribir varias líneas

Puedes escribir una lista de líneas con `Files.write`.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("tasks.txt");

        List<String> tasks = List.of(
                "Study Java",
                "Practice Files",
                "Review exceptions"
        );

        try {
            Files.write(path, tasks);
            System.out.println("Tasks saved");
        } catch (IOException e) {
            System.out.println("Could not save tasks");
            System.out.println(e.getMessage());
        }
    }
}
```

Cada elemento de la lista se escribe como una línea.

---

## 18. Leer todas las líneas con `readAllLines`

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("tasks.txt");

        try {
            List<String> lines = Files.readAllLines(path);

            for (String line : lines) {
                System.out.println(line);
            }
        } catch (IOException e) {
            System.out.println("Could not read lines");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 19. Añadir contenido a un archivo

Por defecto, `writeString` reemplaza el contenido.

Si quieres añadir contenido al final, puedes usar `StandardOpenOption.APPEND`.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("log.txt");

        try {
            Files.writeString(
                    path,
                    "New log entry\n",
                    StandardOpenOption.CREATE,
                    StandardOpenOption.APPEND
            );

            System.out.println("Log updated");
        } catch (IOException e) {
            System.out.println("Could not update log");
            System.out.println(e.getMessage());
        }
    }
}
```

Aquí:

- `CREATE` crea el archivo si no existe
- `APPEND` añade el texto al final

---

## 20. Copiar un archivo

Para copiar archivos usamos `Files.copy`.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path source = Path.of("notes.txt");
        Path target = Path.of("notes-copy.txt");

        try {
            Files.copy(source, target);
            System.out.println("File copied");
        } catch (IOException e) {
            System.out.println("Could not copy file");
            System.out.println(e.getMessage());
        }
    }
}
```

Si el archivo destino ya existe, puede producirse una excepción.

---

## 21. Copiar reemplazando si ya existe

Para reemplazar el destino, usa `StandardCopyOption.REPLACE_EXISTING`.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;

public class Main {
    public static void main(String[] args) {
        Path source = Path.of("notes.txt");
        Path target = Path.of("backup", "notes.txt");

        try {
            Files.createDirectories(target.getParent());

            Files.copy(source, target, StandardCopyOption.REPLACE_EXISTING);

            System.out.println("File copied");
        } catch (IOException e) {
            System.out.println("Could not copy file");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 22. Mover o renombrar un archivo

Para mover o renombrar, usa `Files.move`.

### 22.1. Renombrar

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path oldPath = Path.of("notes.txt");
        Path newPath = Path.of("renamed-notes.txt");

        try {
            Files.move(oldPath, newPath);
            System.out.println("File renamed");
        } catch (IOException e) {
            System.out.println("Could not rename file");
            System.out.println(e.getMessage());
        }
    }
}
```

### 22.2. Mover a otra carpeta

```java
Path source = Path.of("renamed-notes.txt");
Path target = Path.of("data", "renamed-notes.txt");
```

---

## 23. Borrar un archivo

Puedes borrar un archivo con `Files.delete`.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("old-notes.txt");

        try {
            Files.delete(path);
            System.out.println("File deleted");
        } catch (IOException e) {
            System.out.println("Could not delete file");
            System.out.println(e.getMessage());
        }
    }
}
```

Si el archivo no existe, puede lanzar una excepción.

---

## 24. Borrar si existe: `deleteIfExists`

Una opción más cómoda es `deleteIfExists`.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("old-notes.txt");

        try {
            boolean deleted = Files.deleteIfExists(path);

            if (deleted) {
                System.out.println("File deleted");
            } else {
                System.out.println("File did not exist");
            }
        } catch (IOException e) {
            System.out.println("Could not delete file");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 25. Listar archivos de una carpeta

Para listar el contenido de una carpeta puedes usar `Files.list`.

Este método devuelve un `Stream<Path>`, por eso es importante cerrarlo con `try-with-resources`.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        Path folder = Path.of("data");

        try (Stream<Path> paths = Files.list(folder)) {
            paths.forEach(path -> System.out.println(path));
        } catch (IOException e) {
            System.out.println("Could not list folder");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 26. Listar solo archivos

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        Path folder = Path.of("data");

        try (Stream<Path> paths = Files.list(folder)) {
            paths
                    .filter(path -> Files.isRegularFile(path))
                    .forEach(path -> System.out.println(path.getFileName()));
        } catch (IOException e) {
            System.out.println("Could not list files");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 27. Recorrer carpetas con `walk`

`Files.walk` permite recorrer una carpeta y sus subcarpetas.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        Path folder = Path.of("data");

        try (Stream<Path> paths = Files.walk(folder)) {
            paths.forEach(path -> System.out.println(path));
        } catch (IOException e) {
            System.out.println("Could not walk folder");
            System.out.println(e.getMessage());
        }
    }
}
```

Esto es útil para buscar archivos dentro de una estructura de carpetas.

---

## 28. Buscar archivos por extensión

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        Path folder = Path.of("data");

        try (Stream<Path> paths = Files.walk(folder)) {
            paths
                    .filter(path -> Files.isRegularFile(path))
                    .filter(path -> path.toString().endsWith(".txt"))
                    .forEach(path -> System.out.println(path));
        } catch (IOException e) {
            System.out.println("Could not search files");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 29. `try-with-resources`

Algunas operaciones abren recursos que deben cerrarse.

Por ejemplo:

```java
Files.list(folder)
Files.walk(folder)
```

Por eso se usa esta estructura:

```java
try (Stream<Path> paths = Files.list(folder)) {
    // use paths
}
```

Cuando termina el bloque, Java cierra el recurso automáticamente.

---

## 30. Leer archivos grandes línea a línea

`Files.readAllLines` carga todas las líneas en memoria.

Para archivos pequeños está bien, pero si el archivo es grande puede no ser buena idea.

Una alternativa es `Files.lines`, que devuelve un stream de líneas.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("large-file.txt");

        try (Stream<String> lines = Files.lines(path)) {
            lines.forEach(line -> System.out.println(line));
        } catch (IOException e) {
            System.out.println("Could not read file");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 31. Ejemplo guiado: contar líneas de un archivo

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("tasks.txt");

        try (Stream<String> lines = Files.lines(path)) {
            long count = lines.count();

            System.out.println("Total lines: " + count);
        } catch (IOException e) {
            System.out.println("Could not count lines");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 32. Ejemplo guiado: guardar una lista de usuarios

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("users.txt");

        List<String> users = List.of(
                "Laura",
                "Alex",
                "Maria"
        );

        try {
            Files.write(path, users);
            System.out.println("Users saved");
        } catch (IOException e) {
            System.out.println("Could not save users");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 33. Ejemplo guiado: cargar usuarios desde archivo

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("users.txt");

        try {
            List<String> users = Files.readAllLines(path);

            for (String user : users) {
                System.out.println("User: " + user);
            }
        } catch (IOException e) {
            System.out.println("Could not load users");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 34. Ejemplo completo: gestor simple de tareas

Este ejemplo guarda tareas en un archivo de texto y luego las lee.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Path folder = Path.of("data");
        Path file = folder.resolve("tasks.txt");

        try {
            Files.createDirectories(folder);

            Files.writeString(
                    file,
                    "Study Java\n",
                    StandardOpenOption.CREATE,
                    StandardOpenOption.APPEND
            );

            Files.writeString(
                    file,
                    "Practice Files and Path\n",
                    StandardOpenOption.CREATE,
                    StandardOpenOption.APPEND
            );

            List<String> tasks = Files.readAllLines(file);

            for (String task : tasks) {
                System.out.println("Task: " + task);
            }
        } catch (IOException e) {
            System.out.println("File error");
            System.out.println(e.getMessage());
        }
    }
}
```

---

## 35. `resolve`: construir rutas desde otra ruta

`resolve` permite crear una ruta a partir de otra.

```java
Path folder = Path.of("data");
Path file = folder.resolve("notes.txt");
```

Esto produce:

```text
data/notes.txt
```

Ejemplo:

```java
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path folder = Path.of("data");
        Path file = folder.resolve("notes.txt");

        System.out.println(file);
    }
}
```

---

## 36. `normalize`: limpiar una ruta

A veces una ruta puede contener partes redundantes como `..` o `.`.

```java
Path path = Path.of("data", "users", "..", "notes.txt");

System.out.println(path);
System.out.println(path.normalize());
```

Resultado aproximado:

```text
data/users/../notes.txt
data/notes.txt
```

`normalize` no accede al sistema de archivos.  
Solo limpia la ruta a nivel lógico.

---

## 37. `toAbsolutePath`

Para convertir una ruta relativa en absoluta:

```java
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("notes.txt");

        System.out.println(path.toAbsolutePath());
    }
}
```

Esto es muy útil para depurar y saber dónde está buscando realmente Java el archivo.

---

## 38. Codificación de caracteres

Cuando trabajas con texto, existe la codificación.

Una codificación habitual es:

```java
UTF-8
```

Puedes indicarla explícitamente.

```java
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("message.txt");

        try {
            Files.writeString(path, "Hola desde Java", StandardCharsets.UTF_8);

            String content = Files.readString(path, StandardCharsets.UTF_8);

            System.out.println(content);
        } catch (IOException e) {
            System.out.println("File error");
            System.out.println(e.getMessage());
        }
    }
}
```

En muchos casos Java usará una codificación por defecto, pero para proyectos reales suele ser buena idea ser explícito.

---

## 39. `File` vs `Path`

Antes era muy común usar:

```java
java.io.File
```

En Java moderno, suele preferirse:

```java
java.nio.file.Path
java.nio.file.Files
```

### 39.1. `File`

Representa archivos y carpetas con una API más antigua.

### 39.2. `Path`

Representa rutas de forma moderna y trabaja muy bien con `Files`.

Regla práctica:

- código nuevo → usa `Path` y `Files`
- APIs antiguas → puede que todavía usen `File`

---

## 40. Convertir entre `File` y `Path`

A veces puedes necesitar convertir entre ambos.

```java
import java.io.File;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("notes.txt");

        File file = path.toFile();

        Path pathAgain = file.toPath();

        System.out.println(file);
        System.out.println(pathAgain);
    }
}
```

---

## 41. `IOException`

Muchas operaciones con archivos pueden fallar.

Por ejemplo:

- el archivo no existe
- no tienes permisos
- la carpeta no existe
- el archivo está bloqueado
- hay un error de lectura o escritura

Por eso muchos métodos de `Files` lanzan `IOException`.

Ejemplo:

```java
try {
    String content = Files.readString(Path.of("notes.txt"));
    System.out.println(content);
} catch (IOException e) {
    System.out.println("Could not read file");
}
```

---

## 42. Errores típicos al empezar

### 42.1. No saber dónde se crea el archivo

Si usas una ruta relativa:

```java
Path path = Path.of("notes.txt");
```

el archivo se crea en la carpeta desde la que se ejecuta el programa.

Para depurar:

```java
System.out.println(path.toAbsolutePath());
```

### 42.2. Olvidar manejar `IOException`

Muchas operaciones requieren `try-catch`.

### 42.3. Usar barras manuales de forma poco portable

Mejor:

```java
Path path = Path.of("data", "notes.txt");
```

que:

```java
Path path = Path.of("data\\notes.txt");
```

### 42.4. Leer archivos grandes enteros en memoria

Para archivos grandes, considera `Files.lines`.

### 42.5. No cerrar streams de archivos

Usa `try-with-resources` con `Files.list`, `Files.walk` y `Files.lines`.

---

## 43. Buenas prácticas

- Usa `Path` para representar rutas.
- Usa `Files` para operar sobre archivos y carpetas.
- Usa `Path.of("folder", "file.txt")` para rutas portables.
- Usa `createDirectories` si necesitas crear carpetas anidadas.
- Usa `deleteIfExists` si no quieres error cuando no existe.
- Usa `try-with-resources` con streams de archivos.
- Usa `toAbsolutePath` para depurar rutas.
- Maneja `IOException` correctamente.
- Para texto, considera usar `StandardCharsets.UTF_8`.

---

## 44. A tener en cuenta

- `Path` representa una ruta.
- `Files` permite leer, escribir, copiar, mover y borrar.
- `Files.writeString` escribe texto.
- `Files.readString` lee texto.
- `Files.write` puede escribir varias líneas.
- `Files.readAllLines` lee todas las líneas.
- `Files.list` lista una carpeta.
- `Files.walk` recorre subcarpetas.
- Muchas operaciones pueden lanzar `IOException`.
- Las rutas relativas dependen de la carpeta de ejecución.

---

## 45. Resumen final

`Files` y `Path` son herramientas fundamentales para trabajar con archivos en Java moderno.

La idea principal es sencilla:

```java
Path path = Path.of("notes.txt");
Files.writeString(path, "Hello");
```

`Path` dice dónde está el archivo.  
`Files` hace la operación.

Con estas clases puedes:

- crear archivos
- crear carpetas
- escribir texto
- leer texto
- listar carpetas
- copiar archivos
- mover archivos
- borrar archivos

Dominar esta parte es muy importante porque muchísimas aplicaciones necesitan guardar o leer información del sistema de archivos.

---

En el siguiente tema seguiremos avanzando con Java moderno y veremos **Records**, una forma compacta de crear clases pensadas principalmente para almacenar datos.
