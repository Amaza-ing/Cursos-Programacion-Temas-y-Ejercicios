# Ejercicios - Tema 21: Interfaces

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **interfaces, contratos, `implements`, métodos `default`, métodos `static` y polimorfismo**.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear una interfaz `Notifiable`

Crea una interfaz `Notifiable` con un método `sendNotification(String message)`. Después crea una clase `EmailNotifier` que implemente la interfaz.

<details><summary>Mostrar solución</summary>

```java
public interface Notifiable {
    void sendNotification(String message);
}

public class EmailNotifier implements Notifiable {
    @Override
    public void sendNotification(String message) {
        System.out.println("Email notification: " + message);
    }
}

public class Main {
    public static void main(String[] args) {
        Notifiable notifier = new EmailNotifier();
        notifier.sendNotification("Your order is ready");
    }
}
```

</details>

---

## Ejercicio 2: Interfaz como tipo de referencia

Crea una interfaz `ReadableItem` con `read()`. Crea una clase `BlogPost` y guárdala en una variable de tipo `ReadableItem`.

<details><summary>Mostrar solución</summary>

```java
public interface ReadableItem {
    void read();
}

public class BlogPost implements ReadableItem {
    @Override
    public void read() {
        System.out.println("Reading blog post...");
    }
}

public class Main {
    public static void main(String[] args) {
        ReadableItem item = new BlogPost();
        item.read();
    }
}
```

</details>

---

## Ejercicio 3: Lista polimórfica

Crea una interfaz `Downloadable` con `download()`. Crea `ImageResource` y `AudioResource`, guárdalos en una lista y recórrela.

<details><summary>Mostrar solución</summary>

```java
import java.util.ArrayList;
import java.util.List;

public interface Downloadable {
    void download();
}

public class ImageResource implements Downloadable {
    @Override
    public void download() {
        System.out.println("Downloading image...");
    }
}

public class AudioResource implements Downloadable {
    @Override
    public void download() {
        System.out.println("Downloading audio...");
    }
}

public class Main {
    public static void main(String[] args) {
        List<Downloadable> resources = new ArrayList<>();
        resources.add(new ImageResource());
        resources.add(new AudioResource());

        for (Downloadable resource : resources) {
            resource.download();
        }
    }
}
```

</details>

---

## Ejercicio 4: Implementar varias interfaces

Crea `Startable` con `start()` y `Pausable` con `pause()`. Crea una clase `VideoPlayer` que implemente ambas.

<details><summary>Mostrar solución</summary>

```java
public interface Startable {
    void start();
}

public interface Pausable {
    void pause();
}

public class VideoPlayer implements Startable, Pausable {
    @Override
    public void start() {
        System.out.println("Video started");
    }

    @Override
    public void pause() {
        System.out.println("Video paused");
    }
}
```

</details>

---

## Ejercicio 5: Método `default`

Crea una interfaz `Loggable` con `log(String message)` y un método `default logError(String message)` que use `log`.

<details><summary>Mostrar solución</summary>

```java
public interface Loggable {
    void log(String message);

    default void logError(String message) {
        log("ERROR: " + message);
    }
}

public class ConsoleLogger implements Loggable {
    @Override
    public void log(String message) {
        System.out.println(message);
    }
}
```

</details>

---

## Ejercicio 6: Sobrescribir un método `default`

Crea una interfaz `Describable` con `describe()` por defecto. Crea una clase `Game` que sobrescriba ese método.

<details><summary>Mostrar solución</summary>

```java
public interface Describable {
    default void describe() {
        System.out.println("Generic description");
    }
}

public class Game implements Describable {
    @Override
    public void describe() {
        System.out.println("Game description");
    }
}
```

</details>

---

## Ejercicio 7: Método `static` en una interfaz

Crea una interfaz `PasswordRules` con un método estático `isLongEnough` que valide si una contraseña tiene al menos 8 caracteres.

<details><summary>Mostrar solución</summary>

```java
public interface PasswordRules {
    static boolean isLongEnough(String password) {
        return password != null && password.length() >= 8;
    }
}

public class Main {
    public static void main(String[] args) {
        System.out.println(PasswordRules.isLongEnough("java"));
        System.out.println(PasswordRules.isLongEnough("java1234"));
    }
}
```

</details>

---

## Ejercicio 8: Interfaz que extiende otra interfaz

Crea `BasicPrinter` con `print()` y `AdvancedPrinter extends BasicPrinter` con `scan()`. Implementa ambas en `OfficePrinter`.

<details><summary>Mostrar solución</summary>

```java
public interface BasicPrinter {
    void print();
}

public interface AdvancedPrinter extends BasicPrinter {
    void scan();
}

public class OfficePrinter implements AdvancedPrinter {
    @Override
    public void print() {
        System.out.println("Printing document");
    }

    @Override
    public void scan() {
        System.out.println("Scanning document");
    }
}
```

</details>

---

## Ejercicio 9: Interfaz con constante

Crea una interfaz `UploadConfig` con una constante `MAX_FILE_SIZE = 10`. Imprime su valor desde `main`.

<details><summary>Mostrar solución</summary>

```java
public interface UploadConfig {
    int MAX_FILE_SIZE = 10;
}

public class Main {
    public static void main(String[] args) {
        System.out.println("Max file size: " + UploadConfig.MAX_FILE_SIZE + " MB");
    }
}
```

</details>

---

## Ejercicio 10: Método que recibe una interfaz

Crea una interfaz `Compressible` y una clase `VideoFile`. Después crea un método `compressFile(Compressible file)`.

<details><summary>Mostrar solución</summary>

```java
public interface Compressible {
    void compress();
}

public class VideoFile implements Compressible {
    @Override
    public void compress() {
        System.out.println("Compressing video...");
    }
}

public class Main {
    public static void main(String[] args) {
        compressFile(new VideoFile());
    }

    public static void compressFile(Compressible file) {
        file.compress();
    }
}
```

</details>

---
