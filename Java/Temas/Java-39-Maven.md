# Tema 39. Maven

## 1. Introducción

Hasta ahora has creado programas Java usando archivos `.java`, clases, paquetes y distintas APIs del lenguaje.

Pero cuando un proyecto empieza a crecer, aparecen nuevas necesidades:

- organizar mejor el código
- compilar el proyecto fácilmente
- ejecutar tests
- añadir librerías externas
- generar un `.jar`
- compartir el proyecto con otras personas
- evitar configurar todo manualmente
- mantener una estructura estándar

Para eso existen herramientas de construcción de proyectos.

Una de las más usadas en Java es:

- **Maven**

Maven ayuda a gestionar proyectos Java de forma estandarizada.

En este tema aprenderás:

- Qué es Maven
- Para qué sirve
- Qué es un archivo `pom.xml`
- Qué son `groupId`, `artifactId` y `version`
- Cuál es la estructura típica de un proyecto Maven
- Cómo añadir dependencias
- Qué es Maven Central
- Qué es el ciclo de vida de Maven
- Comandos básicos como `mvn compile`, `mvn test` y `mvn package`
- Qué son los plugins
- Cómo configurar Java 25 en Maven
- Qué es Maven Wrapper
- Buenas prácticas y errores típicos

---

## 2. Qué problema resuelve Maven

Imagina que estás haciendo un proyecto Java y necesitas:

- compilar muchas clases
- usar una librería externa
- ejecutar pruebas
- generar un archivo `.jar`
- compartir el proyecto con otro ordenador

Sin Maven, podrías tener que:

- descargar librerías manualmente
- configurar rutas manualmente
- compilar con comandos largos
- explicar a otra persona cómo montar el proyecto
- repetir configuraciones en cada equipo

Maven simplifica todo esto.

Con Maven, gran parte de la configuración vive en un archivo:

```text
pom.xml
```

Y puedes ejecutar comandos como:

```bash
mvn compile
mvn test
mvn package
```

---

## 3. Qué es Maven

Maven es una herramienta de gestión y construcción de proyectos.

Sirve para:

- compilar código
- ejecutar tests
- gestionar dependencias
- empaquetar aplicaciones
- definir información del proyecto
- aplicar una estructura estándar
- automatizar tareas repetitivas

Maven no sustituye a Java.  
Maven ayuda a trabajar mejor con proyectos Java.

---

## 4. Qué es el `pom.xml`

El archivo principal de Maven se llama:

```text
pom.xml
```

POM significa:

```text
Project Object Model
```

Este archivo describe el proyecto.

En él puedes indicar:

- nombre del proyecto
- versión
- dependencias
- plugins
- versión de Java
- configuración de compilación
- información del empaquetado

Ejemplo básico:

```xml
<project>
    ...
</project>
```

---

## 5. Estructura típica de un proyecto Maven

Un proyecto Maven suele tener esta estructura:

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

La estructura más importante es:

```text
src/main/java
src/test/java
```

---

## 6. `src/main/java`

Aquí va el código principal de la aplicación.

Ejemplo:

```text
src/main/java/com/amazaing/app/Main.java
```

Clase:

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

Aquí van los tests del proyecto.

Ejemplo:

```text
src/test/java/com/amazaing/app/MainTest.java
```

Los tests no forman parte del código principal de producción, pero sirven para comprobar que el proyecto funciona correctamente.

---

## 8. Ventaja de la estructura estándar

Maven espera esta estructura por defecto.

Eso significa que no tienes que explicarle dónde están tus clases principales si sigues la convención.

Maven ya sabe que:

```text
src/main/java
```

contiene el código principal.

Y que:

```text
src/test/java
```

contiene los tests.

Esto se conoce como:

> convention over configuration

Es decir:

> seguir convenciones reduce la configuración necesaria

---

## 9. Primer `pom.xml` básico

Un `pom.xml` básico puede ser así:

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

Este archivo define un proyecto Maven mínimo.

---

## 10. `modelVersion`

Esta línea aparece casi siempre:

```xml
<modelVersion>4.0.0</modelVersion>
```

Indica la versión del modelo POM que usa Maven.

Para la mayoría de proyectos Maven actuales, verás:

```xml
4.0.0
```

No suele ser algo que tengas que modificar.

---

## 11. `groupId`

`groupId` identifica normalmente la organización, empresa, autor o dominio del proyecto.

Ejemplos:

```xml
<groupId>com.amazaing</groupId>
```

```xml
<groupId>org.example</groupId>
```

```xml
<groupId>com.company</groupId>
```

Suele seguir un formato parecido al de los paquetes Java.

---

## 12. `artifactId`

`artifactId` identifica el nombre del proyecto o artefacto.

Ejemplo:

```xml
<artifactId>maven-demo</artifactId>
```

Otros ejemplos:

```xml
<artifactId>user-service</artifactId>
<artifactId>inventory-app</artifactId>
<artifactId>java-course-project</artifactId>
```

---

## 13. `version`

`version` indica la versión del proyecto.

Ejemplo:

```xml
<version>1.0.0</version>
```

También puedes ver versiones como:

```xml
<version>1.0-SNAPSHOT</version>
```

La palabra `SNAPSHOT` suele indicar que es una versión en desarrollo.

---

## 14. Coordenadas Maven

La combinación de:

```xml
<groupId>...</groupId>
<artifactId>...</artifactId>
<version>...</version>
```

forma las coordenadas Maven del proyecto.

Ejemplo:

```xml
<groupId>com.amazaing</groupId>
<artifactId>maven-demo</artifactId>
<version>1.0.0</version>
```

Estas coordenadas identifican de forma única un artefacto.

---

## 15. Qué es un artefacto

Un artefacto es el resultado generado por un proyecto Maven.

Normalmente puede ser:

- un `.jar`
- un `.war`
- otro tipo de paquete

Para un proyecto Java básico, lo más común es generar un `.jar`.

---

## 16. `packaging`

Puedes indicar el tipo de empaquetado.

```xml
<packaging>jar</packaging>
```

Ejemplo:

```xml
<project>
    ...
    <packaging>jar</packaging>
</project>
```

Si no lo pones, Maven suele asumir `jar` por defecto.

---

## 17. Configurar Java 25

Para indicar que quieres compilar usando Java 25, puedes usar propiedades en el `pom.xml`.

```xml
<properties>
    <maven.compiler.release>25</maven.compiler.release>
</properties>
```

Ejemplo dentro del POM:

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

Esto indica a Maven que el proyecto debe compilarse para Java 25.

---

## 18. Comprobar Maven instalado

Para comprobar si Maven está instalado, puedes abrir una terminal y escribir:

```bash
mvn -v
```

o:

```bash
mvn --version
```

Esto muestra información como:

- versión de Maven
- versión de Java usada por Maven
- sistema operativo
- ruta de Java

Ejemplo conceptual:

```text
Apache Maven ...
Java version: 25
```

---

## 19. Comandos básicos de Maven

Los comandos más importantes para empezar son:

```bash
mvn compile
mvn test
mvn package
mvn clean
mvn install
```

Cada uno ejecuta una fase del ciclo de vida de Maven.

---

## 20. `mvn compile`

Compila el código principal del proyecto.

```bash
mvn compile
```

Maven busca el código en:

```text
src/main/java
```

y genera archivos compilados en:

```text
target/classes
```

---

## 21. `target`

Cuando ejecutas Maven, se crea una carpeta llamada:

```text
target
```

Dentro se guardan archivos generados.

Ejemplos:

```text
target/classes
target/test-classes
target/maven-demo-1.0.0.jar
```

La carpeta `target` normalmente no se sube a Git.

---

## 22. `mvn test`

Ejecuta los tests del proyecto.

```bash
mvn test
```

Maven:

1. compila el código principal
2. compila el código de test
3. ejecuta los tests

El código de test está normalmente en:

```text
src/test/java
```

---

## 23. `mvn package`

Genera el paquete final del proyecto.

```bash
mvn package
```

Para un proyecto `jar`, genera algo como:

```text
target/maven-demo-1.0.0.jar
```

Antes de empaquetar, Maven también ejecuta fases anteriores como compilar y testear.

---

## 24. `mvn clean`

Elimina la carpeta `target`.

```bash
mvn clean
```

Es útil cuando quieres limpiar los archivos generados y empezar desde cero.

Muy común:

```bash
mvn clean package
```

Este comando:

1. limpia el proyecto
2. compila
3. ejecuta tests
4. genera el paquete

---

## 25. `mvn install`

Instala el artefacto en tu repositorio local de Maven.

```bash
mvn install
```

El repositorio local suele estar en una carpeta como:

```text
.m2/repository
```

Esto permite que otros proyectos de tu ordenador puedan usar ese artefacto como dependencia.

---

## 26. Ciclo de vida de Maven

Maven tiene ciclos de vida.

El más importante para empezar es el ciclo de vida por defecto.

Algunas fases comunes son:

```text
validate
compile
test
package
verify
install
deploy
```

Cuando ejecutas una fase, Maven ejecuta también las fases anteriores necesarias.

Por ejemplo:

```bash
mvn package
```

ejecuta antes:

- `validate`
- `compile`
- `test`

---

## 27. Diferencia entre fase y comando

Cuando escribes:

```bash
mvn package
```

`package` es una fase.

Cuando escribes:

```bash
mvn clean package
```

estás ejecutando:

- fase `clean`
- fase `package`

Maven se encarga de ejecutar todo lo necesario.

---

## 28. Qué son las dependencias

Una dependencia es una librería externa que tu proyecto necesita.

Por ejemplo:

- JUnit para tests
- Gson o Jackson para JSON
- MySQL Connector para conectar con MySQL
- Lombok para reducir código repetitivo
- Spring para aplicaciones web

En Maven, las dependencias se declaran en el `pom.xml`.

---

## 29. Añadir una dependencia

Las dependencias se colocan dentro de:

```xml
<dependencies>
    ...
</dependencies>
```

Ejemplo:

```xml
<dependencies>
    <dependency>
        <groupId>org.example</groupId>
        <artifactId>example-library</artifactId>
        <version>1.0.0</version>
    </dependency>
</dependencies>
```

Cada dependencia también tiene coordenadas Maven.

---

## 30. Maven Central

Maven descarga dependencias desde repositorios.

El repositorio público más conocido es:

```text
Maven Central
```

Cuando añades una dependencia, Maven puede descargarla automáticamente desde Maven Central y guardarla en tu repositorio local.

Eso evita tener que descargar `.jar` manualmente.

---

## 31. Ejemplo con JUnit

JUnit es una librería muy usada para hacer tests.

Ejemplo de dependencia:

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

Fíjate en:

```xml
<scope>test</scope>
```

Esto significa que la dependencia se usa para tests, no para el código principal.

---

## 32. Qué es `scope`

El `scope` indica cuándo se usa una dependencia.

Scopes comunes:

- `compile`
- `test`
- `provided`
- `runtime`

### 32.1. `compile`

Es el scope por defecto.

La dependencia se usa al compilar y ejecutar.

### 32.2. `test`

La dependencia solo se usa en tests.

```xml
<scope>test</scope>
```

### 32.3. `provided`

La dependencia se necesita para compilar, pero el entorno de ejecución la proporciona.

### 32.4. `runtime`

No se necesita para compilar, pero sí para ejecutar.

---

## 33. Ejemplo completo de POM con JUnit

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

## 34. Crear una clase principal

Ruta:

```text
src/main/java/com/amazaing/app/Calculator.java
```

Código:

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

## 35. Crear un test con JUnit

Ruta:

```text
src/test/java/com/amazaing/app/CalculatorTest.java
```

Código:

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

Ejecutar:

```bash
mvn test
```

---

## 36. Dependencias transitivas

Una dependencia puede necesitar otras dependencias.

Maven puede descargarlas automáticamente.

Ejemplo conceptual:

```text
Tu proyecto
    depende de Library A
        Library A depende de Library B
            Library B depende de Library C
```

Maven resuelve esa cadena de dependencias.

Eso se llama:

- dependencias transitivas

---

## 37. Ver árbol de dependencias

Puedes ver las dependencias del proyecto con:

```bash
mvn dependency:tree
```

Esto muestra:

- dependencias directas
- dependencias transitivas
- posibles conflictos

Es muy útil para entender qué librerías está usando tu proyecto.

---

## 38. Qué son los plugins de Maven

Los plugins permiten a Maven realizar tareas.

Por ejemplo:

- compilar
- ejecutar tests
- empaquetar
- generar documentación
- crear un `.jar` ejecutable
- copiar recursos

Maven funciona en gran parte mediante plugins.

---

## 39. Maven Compiler Plugin

Uno de los plugins más importantes es el plugin de compilación.

Puedes configurarlo así:

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

También puedes usar la propiedad:

```xml
<properties>
    <maven.compiler.release>25</maven.compiler.release>
</properties>
```

Para proyectos iniciales, la propiedad suele ser suficiente.

---

## 40. Crear un `.jar`

Con:

```bash
mvn package
```

Maven genera un `.jar` en:

```text
target
```

Ejemplo:

```text
target/maven-demo-1.0.0.jar
```

Pero para que un `.jar` sea ejecutable con:

```bash
java -jar archivo.jar
```

necesita saber cuál es la clase principal.

---

## 41. Configurar clase principal en el `.jar`

Puedes configurar el plugin de empaquetado para indicar la clase principal.

Ejemplo:

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

Ahora el `.jar` puede saber qué clase ejecutar.

---

## 42. Ejemplo de `Main.java`

Ruta:

```text
src/main/java/com/amazaing/app/Main.java
```

Código:

```java
package com.amazaing.app;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from Maven");
    }
}
```

---

## 43. Ejecutar el `.jar`

Después de:

```bash
mvn clean package
```

puedes ejecutar el `.jar`:

```bash
java -jar target/maven-demo-1.0.0.jar
```

Si todo está bien configurado, verás:

```text
Hello from Maven
```

---

## 44. Resources

Maven tiene una carpeta especial para recursos.

```text
src/main/resources
```

Aquí puedes poner archivos como:

- `.properties`
- `.json`
- `.xml`
- plantillas
- textos
- configuraciones

Ejemplo:

```text
src/main/resources/config.properties
```

Al empaquetar el proyecto, Maven incluye esos recursos.

---

## 45. Leer un recurso

Supongamos que tienes:

```text
src/main/resources/message.txt
```

Contenido:

```text
Hello from resources
```

Puedes leerlo así:

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

Maven Wrapper permite ejecutar Maven aunque la persona no tenga Maven instalado globalmente.

En vez de:

```bash
mvn package
```

puedes usar:

```bash
./mvnw package
```

En Windows:

```bash
mvnw.cmd package
```

Esto ayuda a que todos usen una versión concreta de Maven para el proyecto.

---

## 47. Archivos de Maven Wrapper

Cuando un proyecto usa Maven Wrapper, suelen aparecer archivos como:

```text
mvnw
mvnw.cmd
.mvn/wrapper/maven-wrapper.properties
```

Estos archivos sí suelen subirse al repositorio.

Así otra persona puede clonar el proyecto y ejecutar:

```bash
./mvnw test
```

sin instalar Maven manualmente.

---

## 48. Crear un proyecto Maven desde un IDE

Muchos IDEs permiten crear proyectos Maven automáticamente.

Por ejemplo:

- IntelliJ IDEA
- Eclipse
- NetBeans
- Visual Studio Code con extensiones Java

Normalmente eliges:

```text
New Project -> Maven
```

Y el IDE crea:

- `pom.xml`
- `src/main/java`
- `src/test/java`

---

## 49. Crear un proyecto Maven desde terminal

También puedes crear un proyecto Maven desde terminal usando un archetype.

Ejemplo:

```bash
mvn archetype:generate
```

Un archetype es una plantilla de proyecto.

Para un curso inicial, muchas veces es más cómodo crear la estructura manualmente o desde el IDE.

---

## 50. Importar un proyecto Maven

Si descargas o clonas un proyecto Maven, normalmente basta con abrir la carpeta donde está el `pom.xml`.

El IDE detecta que es un proyecto Maven y descarga las dependencias.

Si no lo hace automáticamente, suele haber una opción como:

```text
Reload Maven Project
```

o:

```text
Update Project
```

---

## 51. Actualizar dependencias

Cuando modificas el `pom.xml`, el IDE puede necesitar recargar Maven.

Ejemplos de acciones:

- Reload Maven
- Reimport Maven project
- Update project
- Sync project

En terminal, puedes ejecutar:

```bash
mvn clean compile
```

para comprobar que todo se descarga y compila correctamente.

---

## 52. Repositorio local `.m2`

Maven guarda las dependencias descargadas en tu repositorio local.

Suele estar en:

```text
~/.m2/repository
```

En Windows, puede estar en una ruta como:

```text
C:\Users\YourUser\.m2\repository
```

Esto permite que Maven no descargue la misma dependencia una y otra vez.

---

## 53. `.gitignore` en un proyecto Maven

Normalmente no debes subir la carpeta `target` a Git.

Ejemplo de `.gitignore`:

```gitignore
target/
.idea/
*.iml
```

Si usas Maven Wrapper, normalmente sí se suben:

```text
mvnw
mvnw.cmd
.mvn/wrapper/
```

---

## 54. Ejemplo completo de proyecto Maven

Estructura:

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

## 55. `pom.xml` completo de ejemplo

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

## 59. Comandos para probar el proyecto

Compilar:

```bash
mvn compile
```

Ejecutar tests:

```bash
mvn test
```

Crear `.jar`:

```bash
mvn package
```

Limpiar y crear paquete:

```bash
mvn clean package
```

Ejecutar el `.jar`:

```bash
java -jar target/maven-demo-1.0.0.jar
```

---

## 60. Maven y proyectos con módulos Java

Maven puede usarse también con el sistema de módulos de Java.

En ese caso puedes tener un archivo:

```text
module-info.java
```

Ejemplo:

```java
module com.amazaing.app {
}
```

Y Maven puede compilarlo siempre que la estructura y configuración sean correctas.

Para empezar, no hace falta mezclar módulos y Maven en todos los proyectos, pero es importante saber que pueden trabajar juntos.

---

## 61. Maven y Java moderno

Maven encaja muy bien con Java moderno porque permite gestionar proyectos que usan:

- records
- sealed classes
- streams
- virtual threads
- módulos
- tests
- librerías externas
- frameworks

La configuración de Java en el POM ayuda a que el proyecto sea más reproducible.

Ejemplo:

```xml
<properties>
    <maven.compiler.release>25</maven.compiler.release>
</properties>
```

Así cualquier persona que abra el proyecto sabe para qué versión de Java está preparado.

---

## 62. Maven vs Gradle

Otra herramienta muy conocida en Java es Gradle.

### 62.1. Maven

- usa principalmente XML
- tiene una estructura muy estándar
- es muy usado en proyectos Java empresariales
- es fácil de reconocer
- tiene mucha documentación y ejemplos

### 62.2. Gradle

- suele usar Groovy o Kotlin
- es más flexible
- se usa mucho en Android
- puede ser más compacto
- puede ser más complejo al principio

Para aprender Java, Maven es una muy buena primera herramienta porque su estructura es clara y muy estándar.

---

## 63. Cuándo usar Maven

Usa Maven cuando quieras:

- crear un proyecto Java bien organizado
- añadir dependencias externas
- ejecutar tests fácilmente
- generar un `.jar`
- compartir el proyecto
- seguir una estructura estándar
- trabajar con frameworks como Spring

---

## 64. Cuándo puede no hacer falta Maven

Puede que no necesites Maven si:

- estás haciendo un ejemplo de una sola clase
- estás aprendiendo una sintaxis muy básica
- no tienes dependencias externas
- no necesitas tests ni empaquetado
- quieres hacer pruebas rápidas

Pero en cuanto el proyecto crece un poco, Maven empieza a ser muy útil.

---

## 65. Errores típicos al empezar

### 65.1. Poner las clases fuera de `src/main/java`

Maven espera el código principal en:

```text
src/main/java
```

### 65.2. Poner tests fuera de `src/test/java`

Maven espera los tests en:

```text
src/test/java
```

### 65.3. Modificar el `pom.xml` y no recargar Maven

Si añades una dependencia y el IDE no la reconoce, recarga el proyecto Maven.

### 65.4. Olvidar cerrar etiquetas XML

El `pom.xml` es XML, así que todas las etiquetas deben estar correctamente cerradas.

Ejemplo incorrecto:

```xml
<groupId>com.amazaing</groupId
```

Ejemplo correcto:

```xml
<groupId>com.amazaing</groupId>
```

### 65.5. Confundir `groupId` y `artifactId`

- `groupId` identifica organización o grupo
- `artifactId` identifica el proyecto o artefacto

### 65.6. Subir `target` a Git

La carpeta `target` contiene archivos generados.  
Normalmente debe ignorarse.

### 65.7. Usar una versión de Java distinta

Si tu `pom.xml` indica Java 25, asegúrate de que Maven está usando un JDK compatible.

Comprueba con:

```bash
mvn -v
```

---

## 66. Buenas prácticas

- Sigue la estructura estándar de Maven.
- Mantén el `pom.xml` ordenado.
- Usa nombres claros para `groupId` y `artifactId`.
- Configura la versión de Java con `maven.compiler.release`.
- No subas la carpeta `target` al repositorio.
- Usa Maven Wrapper si quieres facilitar la ejecución del proyecto en otros equipos.
- Declara las dependencias en el `pom.xml`, no descargues `.jar` manualmente.
- Usa `scope test` para dependencias de testing.
- Ejecuta `mvn clean package` para comprobar que el proyecto compila desde cero.
- Revisa `mvn dependency:tree` si tienes conflictos de dependencias.

---

## 67. A tener en cuenta

- Maven es una herramienta para construir y gestionar proyectos Java.
- El archivo principal es `pom.xml`.
- Maven usa una estructura estándar.
- El código principal va en `src/main/java`.
- Los tests van en `src/test/java`.
- Las dependencias se declaran en `<dependencies>`.
- Maven descarga dependencias automáticamente.
- `mvn compile` compila.
- `mvn test` ejecuta tests.
- `mvn package` genera el paquete.
- `mvn clean` limpia archivos generados.
- `mvn install` instala el artefacto en el repositorio local.
- La carpeta `target` contiene los archivos generados.
- Maven Wrapper permite ejecutar Maven sin instalación global.

---

## 68. Resumen final

Maven es una herramienta fundamental en el ecosistema Java.

Permite organizar proyectos, gestionar dependencias, compilar, ejecutar tests y generar paquetes de forma estándar.

La pieza central de Maven es:

```text
pom.xml
```

En este archivo defines información como:

```xml
<groupId>com.amazaing</groupId>
<artifactId>maven-demo</artifactId>
<version>1.0.0</version>
```

También puedes añadir dependencias:

```xml
<dependencies>
    ...
</dependencies>
```

Y configurar Java:

```xml
<properties>
    <maven.compiler.release>25</maven.compiler.release>
</properties>
```

Los comandos más importantes son:

```bash
mvn compile
mvn test
mvn package
mvn clean package
```

Aprender Maven te prepara para trabajar con proyectos Java reales, librerías externas, tests y frameworks modernos.

---

En el siguiente tema terminaremos el curso con un **Proyecto Final**, donde podrás unir muchos de los conceptos aprendidos en una aplicación práctica.
