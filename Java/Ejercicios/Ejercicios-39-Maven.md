# Ejercicios - Tema 39: Maven

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **Maven**: estructura de proyecto, `pom.xml`, coordenadas Maven, versión de Java, dependencias, scopes, comandos, plugins, resources, `.gitignore` y Maven Wrapper.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Identificar coordenadas Maven

Escribe las coordenadas Maven para un proyecto con estos datos:

- grupo: `com.amazaing`
- nombre del proyecto: `library-app`
- versión: `1.0.0`

Debes escribir los elementos XML correspondientes.

<details><summary>Mostrar solución</summary>

```xml
<groupId>com.amazaing</groupId>
<artifactId>library-app</artifactId>
<version>1.0.0</version>
```

</details>

---

## Ejercicio 2: Crear un `pom.xml` mínimo

Crea un `pom.xml` mínimo para un proyecto llamado:

```text
maven-practice
```

Con:

- `groupId`: `com.amazaing`
- `artifactId`: `maven-practice`
- `version`: `1.0.0`

<details><summary>Mostrar solución</summary>

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

## Ejercicio 3: Configurar Java 25

Añade al `pom.xml` la configuración necesaria para compilar con Java 25 usando propiedades.

<details><summary>Mostrar solución</summary>

```xml
<properties>
    <maven.compiler.release>25</maven.compiler.release>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>
```

</details>

---

## Ejercicio 4: Escribir la estructura estándar

Escribe la estructura básica de carpetas de un proyecto Maven con:

- código principal
- tests
- archivo `pom.xml`

<details><summary>Mostrar solución</summary>

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

## Ejercicio 5: Añadir dependencia de JUnit

Añade una dependencia de JUnit Jupiter al `pom.xml`.

Debe tener scope `test`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 6: Comandos básicos

Escribe el comando Maven para cada acción:

1. Compilar el proyecto
2. Ejecutar tests
3. Crear el paquete final
4. Limpiar y crear el paquete desde cero

<details><summary>Mostrar solución</summary>

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

## Ejercicio 7: Configurar clase principal del `.jar`

Añade al `pom.xml` una configuración del `maven-jar-plugin` para que la clase principal sea:

```text
com.amazaing.app.Main
```

<details><summary>Mostrar solución</summary>

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

## Ejercicio 8: Crear un `.gitignore` para Maven

Escribe un `.gitignore` básico para un proyecto Maven que ignore:

- carpeta `target`
- archivos `.iml`
- carpeta `.idea`

<details><summary>Mostrar solución</summary>

```gitignore
target/
*.iml
.idea/
```

</details>

---

## Ejercicio 9: Usar resources

Indica dónde colocarías un archivo llamado:

```text
config.properties
```

para que Maven lo trate como recurso del proyecto.

Después escribe la ruta completa.

<details><summary>Mostrar solución</summary>

```text
src/main/resources/config.properties
```

</details>

---

## Ejercicio 10: Maven Wrapper

Escribe los comandos equivalentes con Maven Wrapper para:

1. Ejecutar tests en macOS/Linux
2. Ejecutar tests en Windows
3. Crear el paquete en macOS/Linux
4. Crear el paquete en Windows

<details><summary>Mostrar solución</summary>

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
