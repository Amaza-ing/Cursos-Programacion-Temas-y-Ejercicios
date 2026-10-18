# Topic 39. Maven

## 1. Introduction

So far you have created Java programs using `.java` files, classes, packages and various language APIs.

But when a project starts to grow, new needs come up:

- organizing the code better
- compiling the project easily
- running tests
- adding external libraries
- generating a `.jar`
- sharing the project with other people
- not having to configure everything manually
- keeping a standard structure

That's what build tools are for.

One of the most widely used in Java is:

- **Maven**

Maven helps manage Java projects in a standardized way.

In this topic you will learn:

- What Maven is
- What it's for
- What a `pom.xml` file is
- What `groupId`, `artifactId` and `version` are
- What the typical structure of a Maven project looks like
- How to add dependencies
- What Maven Central is
- What the Maven lifecycle is
- Basic commands like `mvn compile`, `mvn test` and `mvn package`
- What plugins are
- How to configure Java 25 in Maven
- What Maven Wrapper is
- Best practices and common mistakes

---

## 2. What problem does Maven solve?

Imagine you're working on a Java project and you need to:

- compile many classes
- use an external library
- run tests
- generate a `.jar` file
- move the project to another computer

Without Maven, you might have to:

- download libraries manually
- configure paths manually
- compile with long commands
- explain to another person how to set up the project
- repeat configurations on each computer

Maven simplifies all this.

With Maven, much of the configuration lives in one file:

```text
pom.xml
```

And you can run commands like:

```bash
mvn compile
mvn test
mvn package
```

---

## 3. What is Maven?

Maven is a project management and build tool.

It's used to:

- compile code
- run tests
- manage dependencies
- package applications
- define project information
- apply a standard structure
- automate repetitive tasks

Maven is not a substitute for Java.  
Maven helps you work better with Java projects.

---

## 4. What is the `pom.xml`?

The main Maven file is called:

```text
pom.xml
```

POM stands for:

```text
Project Object Model
```

This file describes the project.

In it you can specify:

- project name
- version
- dependencies
- plugins
- Java version
- build configuration
- packaging information

Basic example:

```xml
<project>
    ...
</project>
```

---

## 5. Typical structure of a Maven project

A Maven project usually has this structure:

```text
my-project
├── pom.xml
└── src
    ├── main
    │   └── java
    │       └── com
    │           └── amazaing
    │               └── app
    │                   └── Main.java
    └── test
        └── java
            └── com
                └── amazaing
                    └── app
                        └── MainTest.java
```

The most important part of the structure is:

```text
src/main/java
src/test/java
```

---

## 6. `src/main/java`

This is where the application's main code goes.

Example:

```text
src/main/java/com/amazaing/app/Main.java
```

Class:

```java
package com.amazaing.app;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello Maven");
    }
}
```

---

## 7. `src/test/java`

This is where the project's tests go.

Example:

```text
src/test/java/com/amazaing/app/MainTest.java
```

The tests are not part of the main production code, but they are used to check that the project works correctly.

---

## 8. The advantage of a standard structure

Maven expects this structure by default.

That means you don't have to tell it where your main classes are if you follow the convention.

Maven already knows that:
```text
src/main/java
```

contains the main code.

And that:

```text
src/test/java
```

contains the tests.

This is known as:

> convention over configuration

In other words:

> following conventions reduces the configuration needed

---

## 9. A first basic `pom.xml`

A basic `pom.xml` can look like this:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.amazaing</groupId>
    <artifactId>maven-demo</artifactId>
    <version>1.0.0</version>

</project>
```

This file defines a minimal Maven project.

---

## 10. `modelVersion`

This line almost always appears:

```xml
<modelVersion>4.0.0</modelVersion>
```

It indicates the version of the POM model that Maven uses.

For most current Maven projects, you will see:

```xml
4.0.0
```

It's not usually something you have to modify.

---

## 11. `groupId`

`groupId` typically identifies the organization, company, author, or domain of the project.

Examples:

```xml
<groupId>com.amazaing</groupId>
```

```xml
<groupId>org.example</groupId>
```

```xml
<groupId>com.company</groupId>
```

It usually follows a format similar to that of Java packages.

---

## 12. `artifactId`

`artifactId` identifies the name of the project or artifact.

Example:

```xml
<artifactId>maven-demo</artifactId>
```

Other examples:

```xml
<artifactId>user-service</artifactId>
<artifactId>inventory-app</artifactId>
<artifactId>java-course-project</artifactId>
```

---

## 13. `version`

`version` indicates the project version.

Example:

```xml
<version>1.0.0</version>
```

You may also see versions like:

```xml
<version>1.0-SNAPSHOT</version>
```

The word `SNAPSHOT` usually indicates that it is a development version.

---

## 14. Maven coordinates

The combination of:

```xml
<groupId>...</groupId>
<artifactId>...</artifactId>
<version>...</version>
```

forms the Maven coordinates of the project.

Example:

```xml
<groupId>com.amazaing</groupId>
<artifactId>maven-demo</artifactId>
<version>1.0.0</version>
```

These coordinates uniquely identify an artifact.

---

## 15. What is an artifact?

An artifact is the output generated by a Maven project.

It's usually one of these:

- a `.jar`
- a `.war`
- another type of package

For a basic Java project, the most common thing is to generate a `.jar`.

---

## 16. `packaging`

You can specify the packaging type.

```xml
<packaging>jar</packaging>
```

Example:

```xml
<project>
    ...
    <packaging>jar</packaging>
</project>
```

If you don't set it, Maven usually assumes `jar` by default.

---

## 17. Configuring Java 25

To specify that you want to compile with Java 25, you can use properties in the `pom.xml`.

```xml
<properties>
    <maven.compiler.release>25</maven.compiler.release>
</properties>
```

Example inside the POM:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.amazaing</groupId>
    <artifactId>maven-demo</artifactId>
    <version>1.0.0</version>

    <properties>
        <maven.compiler.release>25</maven.compiler.release>
    </properties>

</project>
```

This tells Maven that the project should be compiled for Java 25.

---

## 18. Checking that Maven is installed

To check if Maven is installed, you can open a terminal and type:

```bash
mvn -v
```

or:

```bash
mvn --version
```

This displays information such as:

- Maven version
- Java version used by Maven
- operating system
- Java path

Conceptual example:

```text
Apache Maven ...
Java version: 25
```

---

## 19. Basic Maven commands

The most important commands to get started are:

```bash
mvn compile
mvn test
mvn package
mvn clean
mvn install
```

Each one runs a phase of the Maven lifecycle.

---

## 20. `mvn compile`

Compiles the project's main code.

```bash
mvn compile
```

Maven looks for the code in:

```text
src/main/java
```

and generates compiled files in:

```text
target/classes
```

---

## 21. `target`

When you run Maven, it creates a folder called:

```text
target
```

Generated files are stored inside it.

Examples:

```text
target/classes
target/test-classes
target/maven-demo-1.0.0.jar
```

The `target` folder is not normally committed to Git.

---

## 22. `mvn test`

Runs the project's tests.

```bash
mvn test
```

Maven:

1. compiles the main code
2. compiles the test code
3. runs the tests

The test code is normally in:

```text
src/test/java
```

---
## 23. `mvn package`

Generates the project's final package.

```bash
mvn package
```

For a `jar` project, it generates something like:

```text
target/maven-demo-1.0.0.jar
```

Before packaging, Maven also runs earlier phases such as compiling and testing.

---

## 24. `mvn clean`

Deletes the `target` folder.

```bash
mvn clean
```

It is useful when you want to clean up the generated files and start from scratch.

Very common:

```bash
mvn clean package
```

This command:

1. cleans the project
2. compiles
3. runs the tests
4. generates the package

---

## 25. `mvn install`

Installs the artifact in your local Maven repository.

```bash
mvn install
```

The local repository is usually in a folder like:

```text
.m2/repository
```

This allows other projects on your computer to use that artifact as a dependency.

---

## 26. The Maven lifecycle

Maven has lifecycles.

The most important one to start with is the default lifecycle.

Some common phases are:

```text
validate
compile
test
package
verify
install
deploy
```

When you run a phase, Maven also runs the earlier phases it needs.

For example:

```bash
mvn package
```

first runs:

- `validate`
- `compile`
- `test`

---

## 27. The difference between a phase and a command

When you write:

```bash
mvn package
```

`package` is a phase.

When you write:

```bash
mvn clean package
```

you are running:

- the `clean` phase
- the `package` phase

Maven takes care of running everything that's needed.

---

## 28. What are dependencies?

A dependency is an external library that your project needs.

For example:

- JUnit for tests
- Gson or Jackson for JSON
- MySQL Connector to connect with MySQL
- Lombok to reduce repetitive code
- Spring for web applications

In Maven, dependencies are declared in the `pom.xml`.

---

## 29. Adding a dependency

Dependencies go inside:

```xml
<dependencies>
    ...
</dependencies>
```

Example:

```xml
<dependencies>
    <dependency>
        <groupId>org.example</groupId>
        <artifactId>example-library</artifactId>
        <version>1.0.0</version>
    </dependency>
</dependencies>
```

Each dependency also has Maven coordinates.

---

## 30. Maven Central

Maven downloads dependencies from repositories.

The best-known public repository is:

```text
Maven Central
```

When you add a dependency, Maven can automatically download it from Maven Central and save it to your local repository.

That saves you from downloading `.jar` files manually.

---

## 31. Example with JUnit

JUnit is a library widely used for testing.

Dependency example:

```xml
<dependencies>
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter</artifactId>
        <version>5.10.2</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

Notice:

```xml
<scope>test</scope>
```

This means that the dependency is used for tests, not for the main code.

---

## 32. What is `scope`?

The `scope` indicates when a dependency is used.

Common scopes:

- `compile`
- `test`
- `provided`
- `runtime`

### 32.1. `compile`

It is the default scope.

The dependency is used when compiling and running.

### 32.2. `test`

The dependency is only used in tests.

```xml
<scope>test</scope>
```

### 32.3. `provided`

The dependency is required to compile, but it is provided by the runtime environment.

### 32.4. `runtime`

It is not needed to compile, but it is needed to run.

---

## 33. Complete POM example with JUnit

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.amazaing</groupId>
    <artifactId>maven-demo</artifactId>
    <version>1.0.0</version>

    <properties>
        <maven.compiler.release>25</maven.compiler.release>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <version>5.10.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

</project>
```

---

## 34. Creating a main class

Path:

```text
src/main/java/com/amazaing/app/Calculator.java
```

Code:

```java
package com.amazaing.app;

public class Calculator {
    public int add(int a, int b) {
        return a + b;
    }

    public int subtract(int a, int b) {
        return a - b;
    }
}
```

---

## 35. Creating a test with JUnit

Path:
```text
src/test/java/com/amazaing/app/CalculatorTest.java
```

Code:

```java
package com.amazaing.app;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class CalculatorTest {
    @Test
    void shouldAddTwoNumbers() {
        Calculator calculator = new Calculator();

        int result = calculator.add(10, 20);

        assertEquals(30, result);
    }
}
```

Run:

```bash
mvn test
```

---

## 36. Transitive dependencies

A dependency may require other dependencies.

Maven can download them automatically.

Conceptual example:

```text
Tu proyecto
    depende de Library A
        Library A depende de Library B
            Library B depende de Library C
```

Maven resolves that chain of dependencies.

That's called:

- transitive dependencies

---

## 37. Viewing the dependency tree

You can see the project dependencies with:

```bash
mvn dependency:tree
```

This shows:

- direct dependencies
- transitive dependencies
- possible conflicts

It is very useful for understanding which libraries your project is using.

---

## 38. What are Maven plugins?

Plugins allow Maven to perform tasks.

For example:

- compiling
- running tests
- packaging
- generating documentation
- creating an executable `.jar`
- copying resources

Maven is largely powered by plugins.

---

## 39. Maven Compiler Plugin

One of the most important plugins is the compiler plugin.

You can configure it like this:

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <configuration>
                <release>25</release>
            </configuration>
        </plugin>
    </plugins>
</build>
```

You can also use the property:

```xml
<properties>
    <maven.compiler.release>25</maven.compiler.release>
</properties>
```

For beginner projects, the property is usually enough.

---

## 40. Creating a `.jar`

With:

```bash
mvn package
```

Maven generates a `.jar` in:

```text
target
```

Example:

```text
target/maven-demo-1.0.0.jar
```

But for a `.jar` to be executable with:

```bash
java -jar archivo.jar
```

it needs to know which class is the main class.

---

## 41. Configuring the main class in the `.jar`

You can configure the packaging plugin to specify the main class.

Example:

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-jar-plugin</artifactId>
            <configuration>
                <archive>
                    <manifest>
                        <mainClass>com.amazaing.app.Main</mainClass>
                    </manifest>
                </archive>
            </configuration>
        </plugin>
    </plugins>
</build>
```

Now the `.jar` knows which class to run.

---

## 42. `Main.java` example

Path:

```text
src/main/java/com/amazaing/app/Main.java
```

Code:

```java
package com.amazaing.app;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from Maven");
    }
}
```

---

## 43. Running the `.jar`

After:

```bash
mvn clean package
```

you can run the `.jar`:

```bash
java -jar target/maven-demo-1.0.0.jar
```

If everything is configured correctly, you will see:

```text
Hello from Maven
```

---

## 44. Resources

Maven has a special folder for resources.

```text
src/main/resources
```

Here you can put files like:

- `.properties`
- `.json`
- `.xml`
- templates
- text files
- configuration files

Example:

```text
src/main/resources/config.properties
```

When packaging the project, Maven includes those resources.

---

## 45. Reading a resource

Suppose you have:

```text
src/main/resources/message.txt
```

Content:

```text
Hello from resources
```

You can read it like this:

```java
package com.amazaing.app;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;

public class Main {
    public static void main(String[] args) throws Exception {
        InputStream inputStream = Main.class.getResourceAsStream("/message.txt");

        if (inputStream == null) {
            System.out.println("Resource not found");
            return;
        }

        String content = new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);

        System.out.println(content);
    }
}
```

---

## 46. Maven Wrapper

Maven Wrapper lets you run Maven even if Maven isn't installed globally.

Instead of:

```bash
mvn package
```

you can use:

```bash
./mvnw package
```

On Windows:

```bash
mvnw.cmd package
```

This helps everyone use a specific version of Maven for the project.

---

## 47. Maven Wrapper files

When a project uses Maven Wrapper, you'll usually see files like:

```text
mvnw
mvnw.cmd
.mvn/wrapper/maven-wrapper.properties
```

These files, on the other hand, are usually committed to the repository.

So another person can clone the project and run:

```bash
./mvnw test
```

without installing Maven manually.

---

## 48. Creating a Maven project from an IDE

Many IDEs allow you to create Maven projects automatically.

For example:

- IntelliJ IDEA
- Eclipse
- NetBeans
- Visual Studio Code with Java extensions

Normally you choose:

```text
New Project -> Maven
```

And the IDE creates:

- `pom.xml`
- `src/main/java`
- `src/test/java`

---

## 49. Creating a Maven project from the terminal
You can also create a Maven project from the terminal using an archetype.

Example:

```bash
mvn archetype:generate
```

An archetype is a project template.

In an introductory course, it's often easier to create the structure manually or from the IDE.

---

## 50. Importing a Maven project

If you download or clone a Maven project, opening the folder that contains the `pom.xml` is usually enough.

The IDE detects that it is a Maven project and downloads the dependencies.

If it doesn't do this automatically, there is usually an option like:

```text
Reload Maven Project
```

or:

```text
Update Project
```

---

## 51. Updating dependencies

When you modify the `pom.xml`, the IDE may need to reload Maven.

Example actions:

- Reload Maven
- Reimport Maven project
- Update project
- Sync project

In the terminal, you can run:

```bash
mvn clean compile
```

to check that everything downloads and compiles correctly.

---

## 52. The `.m2` local repository

Maven saves downloaded dependencies to your local repository.

It is usually in:

```text
~/.m2/repository
```

On Windows, it can be in a path like:

```text
C:\Users\YourUser\.m2\repository
```

This means Maven doesn't have to download the same dependency over and over again.

---

## 53. `.gitignore` in a Maven project

Normally you shouldn't commit the `target` folder to Git.

`.gitignore` example:

```gitignore
target/
.idea/
*.iml
```

If you use Maven Wrapper, you normally do commit:

```text
mvnw
mvnw.cmd
.mvn/wrapper/
```

---

## 54. Complete Maven project example

Structure:

```text
maven-demo
├── pom.xml
└── src
    ├── main
    │   └── java
    │       └── com
    │           └── amazaing
    │               └── app
    │                   ├── Main.java
    │                   └── Calculator.java
    └── test
        └── java
            └── com
                └── amazaing
                    └── app
                        └── CalculatorTest.java
```

---

## 55. Complete example `pom.xml`

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.amazaing</groupId>
    <artifactId>maven-demo</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>

    <properties>
        <maven.compiler.release>25</maven.compiler.release>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <version>5.10.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <configuration>
                    <archive>
                        <manifest>
                            <mainClass>com.amazaing.app.Main</mainClass>
                        </manifest>
                    </archive>
                </configuration>
            </plugin>
        </plugins>
    </build>

</project>
```

---

## 56. `Calculator.java`

```java
package com.amazaing.app;

public class Calculator {
    public int add(int a, int b) {
        return a + b;
    }

    public int subtract(int a, int b) {
        return a - b;
    }
}
```

---

## 57. `Main.java`

```java
package com.amazaing.app;

public class Main {
    public static void main(String[] args) {
        Calculator calculator = new Calculator();

        int result = calculator.add(10, 20);

        System.out.println("Result: " + result);
    }
}
```

---

## 58. `CalculatorTest.java`

```java
package com.amazaing.app;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class CalculatorTest {
    @Test
    void shouldAddTwoNumbers() {
        Calculator calculator = new Calculator();

        int result = calculator.add(10, 20);

        assertEquals(30, result);
    }

    @Test
    void shouldSubtractTwoNumbers() {
        Calculator calculator = new Calculator();

        int result = calculator.subtract(20, 10);

        assertEquals(10, result);
    }
}
```

---

## 59. Commands to try out the project

Compile:

```bash
mvn compile
```

Run tests:

```bash
mvn test
```

Create the `.jar`:

```bash
mvn package
```

Clean and create package:

```bash
mvn clean package
```

Run the `.jar`:

```bash
java -jar target/maven-demo-1.0.0.jar
```

---

## 60. Maven and projects with Java modules

Maven can also be used with the Java module system.

In that case you can have a file:

```text
module-info.java
```

Example:

```java
module com.amazaing.app {
}
```

And Maven can compile it as long as the structure and configuration are correct.

To begin with, there is no need to mix modules and Maven in every project, but it is important to know that they can work together.

---

## 61. Maven and modern Java

Maven works really well with modern Java because it lets you manage projects that use:

- records
- sealed classes
- streams
- virtual threads
- modules
- tests
- external libraries
- frameworks

Configuring Java in the POM helps make the project more reproducible.

Example:

```xml
<properties>
    <maven.compiler.release>25</maven.compiler.release>
</properties>
```

This way anyone who opens the project knows which version of Java it's set up for.

---

## 62. Maven vs Gradle

Another well-known tool in Java is Gradle.

### 62.1. Maven

- mainly uses XML
- has a very standard structure
- is widely used in enterprise Java projects
- is easy to recognize
- has a lot of documentation and examples

### 62.2. Gradle

- usually uses Groovy or Kotlin
- is more flexible
- is used a lot on Android
- can be more compact
- can be more complex at first
When you're learning Java, Maven is a very good first tool because its structure is clear and very standard.

---

## 63. When to use Maven

Use Maven when you want to:

- create a well-organized Java project
- add external dependencies
- run tests easily
- generate a `.jar`
- share the project
- follow a standard structure
- work with frameworks like Spring

---

## 64. When Maven may not be needed

You may not need Maven if:

- you are writing a single-class example
- you are learning very basic syntax
- you have no external dependencies
- you don't need testing or packaging
- you want to try things out quickly

But as soon as the project grows a bit, Maven becomes very useful.

---

## 65. Common beginner mistakes

### 65.1. Putting classes outside `src/main/java`

Maven expects the main code in:

```text
src/main/java
```

### 65.2. Putting tests outside `src/test/java`

Maven expects the tests in:

```text
src/test/java
```

### 65.3. Changing the `pom.xml` without reloading Maven

If you add a dependency and the IDE does not recognize it, reload the Maven project.

### 65.4. Forgetting to close XML tags

The `pom.xml` is XML, so all tags must be properly closed.

Incorrect example:

```xml
<groupId>com.amazaing</groupId
```

Correct example:

```xml
<groupId>com.amazaing</groupId>
```

### 65.5. Confusing `groupId` and `artifactId`

- `groupId` identifies the organization or group
- `artifactId` identifies the project or artifact

### 65.6. Committing `target` to Git

The `target` folder contains generated files.  
Normally it should be ignored.

### 65.7. Using a different Java version

If your `pom.xml` specifies Java 25, make sure Maven is using a compatible JDK.

Check with:

```bash
mvn -v
```

---

## 66. Best practices

- Follow the standard Maven structure.
- Keep the `pom.xml` tidy.
- Use clear names for `groupId` and `artifactId`.
- Configure the Java version with `maven.compiler.release`.
- Don't commit the `target` folder to the repository.
- Use Maven Wrapper if you want to make it easier to run the project on other computers.
- Declare dependencies in the `pom.xml`; don't download `.jar` files manually.
- Use `scope test` for testing dependencies.
- Run `mvn clean package` to verify that the project compiles from scratch.
- Check `mvn dependency:tree` if you have dependency conflicts.

---

## 67. Things to keep in mind

- Maven is a tool for building and managing Java projects.
- The main file is `pom.xml`.
- Maven uses a standard structure.
- The main code goes in `src/main/java`.
- The tests go in `src/test/java`.
- Dependencies are declared in `<dependencies>`.
- Maven downloads dependencies automatically.
- `mvn compile` compiles.
- `mvn test` runs tests.
- `mvn package` generates the package.
- `mvn clean` cleans generated files.
- `mvn install` installs the artifact in the local repository.
- The `target` folder contains the generated files.
- Maven Wrapper allows you to run Maven without a global installation.

---

## 68. Final summary
Maven is a fundamental tool in the Java ecosystem.

It allows you to organize projects, manage dependencies, compile, run tests and generate packages in a standard way.

The centerpiece of Maven is:

```text
pom.xml
```

In this file you define information such as:

```xml
<groupId>com.amazaing</groupId>
<artifactId>maven-demo</artifactId>
<version>1.0.0</version>
```

You can also add dependencies:

```xml
<dependencies>
    ...
</dependencies>
```

And configure Java:

```xml
<properties>
    <maven.compiler.release>25</maven.compiler.release>
</properties>
```

The most important commands are:

```bash
mvn compile
mvn test
mvn package
mvn clean package
```

Learning Maven prepares you to work with real Java projects, external libraries, tests and modern frameworks.

---

In the next topic we'll wrap up the course with a **Final Project**, where you'll be able to bring together many of the concepts you've learned in a practical application.
