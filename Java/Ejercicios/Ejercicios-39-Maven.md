# Exercises - Topic 39: Maven

Below you will find **10 practical exercises** to work with **Maven**: project structure, `pom.xml`, Maven coordinates, Java version, dependencies, scopes, commands, plugins, resources, `.gitignore` and Maven Wrapper.

Try to solve them before consulting the solution.

---

## Exercise 1: Identify Maven coordinates

Write the Maven coordinates for a project with this data:

- group: `com.amazaing`
- project name: `library-app`
- version: `1.0.0`

You must write the corresponding XML elements.

<details><summary>Show solution</summary>

```xml
<groupId>com.amazaing</groupId>
<artifactId>library-app</artifactId>
<version>1.0.0</version>
```

</details>

---

## Exercise 2: Create a minimum `pom.xml`

Create a minimal `pom.xml` for a project called:

```text
maven-practice
```

With:

- `groupId`: `com.amazaing`
- `artifactId`: `maven-practice`
- `version`: `1.0.0`

<details><summary>Show solution</summary>

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.amazaing</groupId>
    <artifactId>maven-practice</artifactId>
    <version>1.0.0</version>

</project>
```

</details>

---

## Exercise 3: Configure Java 25

Add to `pom.xml` the necessary configuration to compile with Java 25 using properties.

<details><summary>Show solution</summary>

```xml
<properties>
    <maven.compiler.release>25</maven.compiler.release>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>
```

</details>

---

## Exercise 4: Write the standard structure

Write the basic folder structure of a Maven project with:

- main code
- tests
- file `pom.xml`

<details><summary>Show solution</summary>

```text
my-project
├── pom.xml
└── src
    ├── main
    │   └── java
    └── test
        └── java
```

</details>

---

## Exercise 5: Add JUnit dependency

Adds a JUnit Jupiter dependency to `pom.xml`.

Must have scope `test`.

<details><summary>Show solution</summary>

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

</details>

---

## Exercise 6: Basic commands

Write the Maven command for each action:

1. Compile the project
2. Run tests
3. Create the final package
4. Clean and create the package from scratch

<details><summary>Show solution</summary>

```bash
mvn compile
```

```bash
mvn test
```

```bash
mvn package
```

```bash
mvn clean package
```

</details>

---

## Exercise 7: Configure `.jar` main class

Add to `pom.xml` a configuration of `maven-jar-plugin` so that the main class is:

```text
com.amazaing.app.Main
```

<details><summary>Show solution</summary>

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

</details>

---

## Exercise 8: Create an `.gitignore` for Maven

Write a basic `.gitignore` for a Maven project that ignores:

- `target` folder
- `.iml` files
- `.idea` folder

<details><summary>Show solution</summary>

```gitignore
target/
*.iml
.idea/
```

</details>

---

## Exercise 9: Use resources

Indicates where you would place a file called:

```text
config.properties
```

so that Maven treats it as a project resource.

Then write the full path.

<details><summary>Show solution</summary>

```text
src/main/resources/config.properties
```

</details>

---

## Exercise 10: Maven Wrapper

Write the equivalent commands with Maven Wrapper to:

1. Run tests on macOS/Linux
2. Run tests on Windows
3. Create the package on macOS/Linux
4. Create the package on Windows

<details><summary>Show solution</summary>

```bash
./mvnw test
```

```bash
mvnw.cmd test
```

```bash
./mvnw package
```

```bash
mvnw.cmd package
```

</details>

---
