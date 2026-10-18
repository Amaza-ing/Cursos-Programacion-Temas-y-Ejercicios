# Exercises - Topic 33: Files and Path

Below you will find **10 practical exercises** to work with **Files and Path**: creating paths, writing and reading files, folders, adding content, copying, deleting, listing files and working with lines.

Try to solve them before looking at the solution.

---

## Exercise 1: Create a path with `Path.of`

Create a path that points to the file:

```text
data/notes.txt
```

Use `Path.of` and print:

- the path
- the absolute path

<details><summary>Show solution</summary>

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

## Exercise 2: Write text to a file

Create the `data` folder if it does not exist.

Then write the text `"Learning Java files"` to:

```text
data/message.txt
```

Use `Files.createDirectories` and `Files.writeString`.

<details><summary>Show solution</summary>

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

## Exercise 3: Read text from a file

Using the file from the previous exercise, read the contents of:

```text
data/message.txt
```

and print it to the console.

<details><summary>Show solution</summary>

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

## Exercise 4: Write multiple lines

Create a list with these lines:

- `"First line"`
- `"Second line"`
- `"Third line"`

Write them to:

```text
data/lines.txt
```

Use `Files.write`.

<details><summary>Show solution</summary>

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

## Exercise 5: Read all the lines and filter them

Read the file:

```text
data/lines.txt
```

Use `Files.readAllLines` and display only the lines that contain the word `"Second"`.

<details><summary>Show solution</summary>

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

## Exercise 6: Add content to the end of a file

Add the line `"New entry"` to the file:

```text
data/log.txt
```

If the file does not exist, it must be created.

Use `StandardOpenOption.CREATE` and `StandardOpenOption.APPEND`.

<details><summary>Show solution</summary>

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

## Exercise 7: Copy a file

Create a copy of:

```text
data/message.txt
```

to:

```text
data/message-copy.txt
```

Use `Files.copy` and `StandardCopyOption.REPLACE_EXISTING`.

<details><summary>Show solution</summary>

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

## Exercise 8: Delete a file if it exists

Delete the file:

```text
data/message-copy.txt
```

Use `Files.deleteIfExists` and print whether it was deleted or not.

<details><summary>Show solution</summary>

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

## Exercise 9: List files in a folder

List all items in the folder:

```text
data
```

Use `Files.list`.

<details><summary>Show solution</summary>

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

## Exercise 10: Count the lines of a large file

Use `Files.lines` to count how many lines this file has:

```text
data/lines.txt
```

Remember to use `try-with-resources`.

<details><summary>Show solution</summary>

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
