# Exercises - Topic 21: Interfaces

Below you will find **10 practical exercises** to work with **interfaces, contracts, `implements`, `default` methods, `static` methods and polymorphism**.

Try to solve them before consulting the solution.

---

## Exercise 1: Create an `Notifiable` interface

Creates an `Notifiable` interface with an `sendNotification(String message)` method. Then create an `EmailNotifier` class that implements the interface.

<details><summary>Show solution</summary>

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

## Exercise 2: Interface as a reference type

Create an `ReadableItem` interface with `read()`. Create a class `BlogPost` and save it in a variable of type `ReadableItem`.

<details><summary>Show solution</summary>

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

## Exercise 3: Polymorphic list

Create an `Downloadable` interface with `download()`. Create `ImageResource` and `AudioResource`, save them in a list and loop through it.

<details><summary>Show solution</summary>

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

## Exercise 4: Implement multiple interfaces

Create `Startable` with `start()` and `Pausable` with `pause()`. Create an `VideoPlayer` class that implements both.

<details><summary>Show solution</summary>

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

## Exercise 5: `default` Method

Create an interface `Loggable` with `log(String message)` and a method `default logError(String message)` that uses `log`.

<details><summary>Show solution</summary>

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

## Exercise 6: Overriding an `default` method

Create an `Describable` interface with `describe()` by default. Create an `Game` class that overrides that method.

<details><summary>Show solution</summary>

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

## Exercise 7: `static` method in an interface

Create an `PasswordRules` interface with a static method `isLongEnough` that validates whether a password is at least 8 characters long.

<details><summary>Show solution</summary>

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

## Exercise 8: Interface that extends another interface

Create `BasicPrinter` with `print()` and `AdvancedPrinter extends BasicPrinter` with `scan()`. Implement both in `OfficePrinter`.

<details><summary>Show solution</summary>

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

## Exercise 9: Interface with constant

Creates an interface `UploadConfig` with a constant `MAX_FILE_SIZE = 10`. Prints its value from `main`.

<details><summary>Show solution</summary>

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

## Exercise 10: Method that receives an interface

Create an `Compressible` interface and an `VideoFile` class. Then create a method `compressFile(Compressible file)`.

<details><summary>Show solution</summary>

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
