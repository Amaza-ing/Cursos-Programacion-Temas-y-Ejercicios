# Topic 33. `Files` and `Path`

## 1. Introduction

In many programs you need to work with files and folders.

For example:

- reading a text file
- saving information to a file
- creating a folder
- checking whether a file exists
- copying a file
- moving or renaming a file
- deleting files
- listing the contents of a folder

Java has several ways of working with files, but in modern code it is recommended to use mainly:

- `Path`
- `Files`

These classes are part of the modern Java input/output API, known as **NIO.2**.

In this topic you will learn:

- What `Path` is
- What `Files` is
- How to create paths
- How to check whether files or folders exist
- How to read text files
- How to write files
- How to add content to a file
- How to create folders
- How to copy, move and delete files
- How to list the contents of a folder
- How to handle exceptions with `IOException`
- Good practices when working with files

---

## 2. Files and paths

Before writing code, it is worth telling two concepts apart.

### 2.1. File

A file is an element that contains information.

Examples:

```text
notes.txt
users.csv
config.json
image.png
```

### 2.2. Path

A path indicates where a file or folder is.

Example on Windows:

```text
C:\Users\Laura\Documents\notes.txt
```

Example on macOS or Linux:

```text
/home/laura/documents/notes.txt
```

In modern Java, paths are represented with the `Path` class.

---

## 3. What is `Path`

`Path` represents a file system path.

It can point to:

- a file
- a folder
- a path that does not exist yet

Import:

```java
import java.nio.file.Path;
```

Example:

```java
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("notes.txt");

        System.out.println(path);
    }
}
```

Here `path` represents the `notes.txt` file in the current project folder.

---

## 4. What is `Files`

`Files` is a utility class with static methods for working with files and folders.

Import:

```java
import java.nio.file.Files;
```

Examples of operations:

```java
Files.exists(path);
Files.readString(path);
Files.writeString(path, "Hello");
Files.createDirectory(path);
Files.deleteIfExists(path);
```

Key idea:

- `Path` represents the path
- `Files` performs operations on that path

---

## 5. Creating paths with `Path.of`

The modern, simple way to create paths is to use `Path.of`.

```java
Path path = Path.of("notes.txt");
```

You can also create paths from several parts:

```java
Path path = Path.of("data", "notes.txt");
```

This represents:

```text
data/notes.txt
```

or on Windows:

```text
data\notes.txt
```

Java adapts the separator depending on the operating system.

---

## 6. Avoid writing separators by hand

You can write this:

```java
Path path = Path.of("data/notes.txt");
```

But it is usually better to write the path in parts:

```java
Path path = Path.of("data", "notes.txt");
```

This way the code is more portable between operating systems.

---

## 7. Relative and absolute paths

### 7.1. Relative path

A relative path depends on the folder from which the program is run.

```java
Path path = Path.of("notes.txt");
```

This points to `notes.txt` in the current folder.

### 7.2. Absolute path

An absolute path starts from the root of the file system.

Example on Windows:

```java
Path path = Path.of("C:", "Users", "Laura", "Documents", "notes.txt");
```

Example on macOS or Linux:

```java
Path path = Path.of("/home/laura/documents/notes.txt");
```

In learning projects, we will usually start with relative paths.

---

## 8. Getting information about a path

`Path` has useful methods for analyzing a path.

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

Approximate result:

```text
Path: data/notes.txt
File name: notes.txt
Parent: data
Absolute path: ...
```

---
## 9. Checking whether a file exists

To check whether a path exists, we use `Files.exists`.

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

## 10. Checking whether it is a file or a folder

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

- `isRegularFile` checks whether it is a regular file
- `isDirectory` checks whether it is a folder

---

## 11. Creating a file

You can create an empty file with `Files.createFile`.

This method may throw `IOException`, so you must handle it.

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

If the file already exists, an exception may occur.

---

## 12. Creating a folder

To create a folder, we use `Files.createDirectory`.

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

## 13. Creating nested folders with `createDirectories`

If you want to create several folders at once, use `createDirectories`.

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

Important difference:

- `createDirectory` creates a single folder
- `createDirectories` creates the whole structure needed

---

## 14. Writing text to a file with `writeString`

An easy way to write text is to use `Files.writeString`.

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

If the file does not exist, it is created.  
If the file exists, its contents are replaced.

---

## 15. Reading text from a file with `readString`

To read the entire contents of a text file, you can use `Files.readString`.

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

## 16. Guided example: writing and reading a file

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

This example:

1. creates or overwrites `message.txt`
2. writes text
3. reads the content
4. prints it

---

## 17. Writing several lines

You can write a list of lines with `Files.write`.

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

Each item in the list is written as one line.

---

## 18. Reading all the lines with `readAllLines`

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

## 19. Appending content to a file

By default, `writeString` replaces the content.

If you want to add content at the end, you can use `StandardOpenOption.APPEND`.

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

Here:

- `CREATE` creates the file if it does not exist
- `APPEND` adds the text at the end

---

## 20. Copying a file

To copy files, we use `Files.copy`.

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

If the destination file already exists, an exception may occur.

---

## 21. Copying and replacing if it already exists

To replace the destination, use `StandardCopyOption.REPLACE_EXISTING`.

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

## 22. Moving or renaming a file

To move or rename, use `Files.move`.

### 22.1. Renaming

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

### 22.2. Moving to another folder

```java
Path source = Path.of("renamed-notes.txt");
Path target = Path.of("data", "renamed-notes.txt");
```

---

## 23. Deleting a file

You can delete a file with `Files.delete`.

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

If the file does not exist, it may throw an exception.

---

## 24. Deleting if it exists: `deleteIfExists`

A more convenient option is `deleteIfExists`.

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

## 25. Listing the files in a folder

To list the contents of a folder, you can use `Files.list`.

This method returns a `Stream<Path>`, so it is important to close it with `try-with-resources`.

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

## 26. Listing only files

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

## 27. Walking through folders with `walk`

`Files.walk` lets you go through a folder and all its subfolders.

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

This is useful for searching for files within a folder structure.

---

## 28. Searching for files by extension

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

Some operations open resources that must be closed.

For example:

```java
Files.list(folder)
Files.walk(folder)
```

That is why this structure is used:

```java
try (Stream<Path> paths = Files.list(folder)) {
    // use paths
}
```

When the block ends, Java automatically closes the resource.

---

## 30. Reading large files line by line

`Files.readAllLines` loads all the lines into memory.

For small files that is fine, but if the file is large it may not be a good idea.

An alternative is `Files.lines`, which returns a stream of lines.

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

## 31. Guided example: counting the lines in a file

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

## 32. Guided example: saving a list of users

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

## 33. Guided example: loading users from a file

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

## 34. Complete example: a simple task manager

This example saves tasks to a text file and then reads them.

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

## 35. `resolve`: building paths from another path

`resolve` lets you create a path from another one.

```java
Path folder = Path.of("data");
Path file = folder.resolve("notes.txt");
```

This produces:

```text
data/notes.txt
```

Example:

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

## 36. `normalize`: cleaning up a path

Sometimes a path may contain redundant parts such as `..` or `.`.

```java
Path path = Path.of("data", "users", "..", "notes.txt");

System.out.println(path);
System.out.println(path.normalize());
```

Approximate result:

```text
data/users/../notes.txt
data/notes.txt
```

`normalize` does not access the file system.  
It only cleans up the path at a logical level.

---

## 37. `toAbsolutePath`

To convert a relative path into an absolute one:

```java
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path path = Path.of("notes.txt");

        System.out.println(path.toAbsolutePath());
    }
}
```

This is very useful for debugging and finding out where Java is actually looking for the file.

---

## 38. Character encoding

When you work with text, encoding comes into play.

A common encoding is:

```java
UTF-8
```

You can specify it explicitly.

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

In many cases Java will use a default encoding, but for real projects it is usually a good idea to be explicit.

---

## 39. `File` vs `Path`

It used to be very common to use:

```java
java.io.File
```

In modern Java, these are usually preferred:

```java
java.nio.file.Path
java.nio.file.Files
```

### 39.1. `File`

It represents files and folders with an older API.

### 39.2. `Path`

It represents paths in a modern way and works very well with `Files`.

Rule of thumb:

- new code → use `Path` and `Files`
- older APIs → may still use `File`

---

## 40. Converting between `File` and `Path`

Sometimes you may need to convert between the two.

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

Many file operations can fail.

For example:

- the file does not exist
- you don't have permission
- the folder does not exist
- the file is locked
- there is a read or write error

That's why many `Files` methods throw `IOException`.

Example:

```java
try {
    String content = Files.readString(Path.of("notes.txt"));
    System.out.println(content);
} catch (IOException e) {
    System.out.println("Could not read file");
}
```

---

## 42. Common beginner mistakes

### 42.1. Not knowing where the file is created

If you use a relative path:

```java
Path path = Path.of("notes.txt");
```

the file is created in the folder from which the program is run.

To debug it:

```java
System.out.println(path.toAbsolutePath());
```

### 42.2. Forgetting to handle `IOException`

Many operations require `try-catch`.

### 42.3. Writing slashes by hand in a non-portable way

Better:

```java
Path path = Path.of("data", "notes.txt");
```

than:

```java
Path path = Path.of("data\\notes.txt");
```

### 42.4. Reading entire large files into memory

For large files, consider `Files.lines`.

### 42.5. Not closing file streams

Use `try-with-resources` with `Files.list`, `Files.walk` and `Files.lines`.

---

## 43. Good practices

- Use `Path` to represent paths.
- Use `Files` to operate on files and folders.
- Use `Path.of("folder", "file.txt")` for portable paths.
- Use `createDirectories` if you need to create nested folders.
- Use `deleteIfExists` if you don't want an error when the file doesn't exist.
- Use `try-with-resources` with file streams.
- Use `toAbsolutePath` to debug paths.
- Handle `IOException` correctly.
- For text, consider using `StandardCharsets.UTF_8`.

---

## 44. Things to keep in mind

- `Path` represents a path.
- `Files` lets you read, write, copy, move and delete.
- `Files.writeString` writes text.
- `Files.readString` reads text.
- `Files.write` can write several lines.
- `Files.readAllLines` reads all the lines.
- `Files.list` lists the contents of a folder.
- `Files.walk` goes through subfolders.
- Many operations can throw `IOException`.
- Relative paths depend on the folder the program runs from.

---

## 45. Final summary

`Files` and `Path` are essential tools for working with files in modern Java.

The main idea is simple:

```java
Path path = Path.of("notes.txt");
Files.writeString(path, "Hello");
```

`Path` says where the file is.  
`Files` performs the operation.

With these classes you can:

- create files
- create folders
- write text
- read text
- list folders
- copy files
- move files
- delete files

Mastering this part is very important because a great many applications need to save information to or read it from the file system.

---

In the next topic we will keep moving forward with modern Java and look at **Records**, a compact way to create classes designed mainly to store data.
