# Tema 19. Packages: organizar la estructura del proyecto

## 1. Introducción

A medida que tus proyectos Java crecen, empiezas a tener muchas clases:

- `User`, `Product`, `Order`, `BankAccount`…
- Clases “utilidad” como `Calculator`, `StringUtils`…
- Clases de entrada como `Main`
- Más adelante: controladores, servicios, repositorios, etc.

Si todas las clases están en el mismo sitio, el proyecto se vuelve difícil de mantener:

- Cuesta encontrar archivos
- Aparecen nombres duplicados
- Se mezclan responsabilidades
- Pierdes claridad al navegar el código

Para evitar esto, Java tiene **packages** (paquetes), que sirven para:

- Organizar clases en “carpetas lógicas”
- Evitar colisiones de nombres (dos clases pueden llamarse igual en paquetes distintos)
- Controlar visibilidad mediante el modificador _package-private_ (sin modificador)
- Mantener una estructura profesional y escalable

En este tema aprenderás:

- Qué es un package y cómo se escribe
- Cómo organizar un proyecto en IntelliJ
- Convenciones de nombres de paquetes
- Cómo funciona `import`
- Cómo evitar el _default package_
- Visibilidad: `public`, `private`, `protected` y _package-private_
- Ejemplos completos con estructura real de carpetas

---

## 2. Qué es un package

Un **package** es un “espacio de nombres” que agrupa clases relacionadas.

En código, se declara con la palabra `package` al inicio del archivo:

```java
package com.mycompany.app;
```

Reglas importantes:

- Debe ser **la primera línea real** del archivo (antes de `import` y antes de la clase)
- El nombre del paquete debe coincidir con la ruta de carpetas dentro de `src`

Ejemplo:

Si tu archivo está en:

```
src/com/mycompany/app/Main.java
```

Entonces arriba debe poner:

```java
package com.mycompany.app;
```

---

## 3. Convenciones de nombres de paquetes (muy importante)

En Java, la convención estándar para paquetes es:

- **todo en minúsculas**
- usando dominio invertido (para evitar colisiones)
- separando niveles con `.`

Ejemplos típicos:

- `com.companyname.projectname`
- `com.amazaing.javacurso`
- `org.example.myapp`

Por qué dominio invertido:

- Dos personas podrían crear un paquete llamado `utils`
- Pero es muy improbable que dos proyectos compartan exactamente `com.amazaing.utils`

---

## 4. Estructura de proyecto recomendada

Una estructura típica (simple y muy común) podría ser:

```
src/
  com/amazaing/java25/
    Main.java
    model/
      User.java
      Product.java
      Order.java
    service/
      UserService.java
    utils/
      Calculator.java
      StringUtils.java
```

Idea:

- `model`: clases de datos (entidades)
- `service`: lógica de negocio
- `utils`: funciones de apoyo (si tiene sentido)

---

## 5. Crear packages en IntelliJ (paso a paso)

### 5.1. Crear un package

1. Abre el panel **Project**
2. Ve a `src`
3. Clic derecho → **New** → **Package**
4. Escribe el nombre, por ejemplo:

```
com.amazaing.java25.model
```

IntelliJ creará automáticamente las carpetas.

### 5.2. Crear una clase dentro de un package

1. Clic derecho sobre el package (`model`)
2. **New** → **Java Class**
3. Escribe el nombre, por ejemplo: `User`

IntelliJ añadirá automáticamente la línea `package ...;` en el archivo.

---

## 6. Ejemplo 1: `Main` en un package principal y `User` en `model`

### 6.1. Estructura

```
src/
  com/amazaing/java25/
    Main.java
    model/
      User.java
```

### 6.2. `User.java`

Ruta:

```
src/com/amazaing/java25/model/User.java
```

Contenido:

```java
package com.amazaing.java25.model;

public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Age: " + age);
    }
}
```

### 6.3. `Main.java`

Ruta:

```
src/com/amazaing/java25/Main.java
```

Contenido:

```java
package com.amazaing.java25;

import com.amazaing.java25.model.User;

public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", 28);
        user.printInfo();
    }
}
```

Fíjate en:

- `Main` y `User` están en paquetes distintos
- Por eso necesitamos `import com.amazaing.java25.model.User;`

---

## 7. `import`: cómo funciona

Cuando usas una clase de otro package, tienes dos opciones:

1. Usar `import`
2. Usar el nombre completo (_fully qualified name_)

### 7.1. Usar `import` (lo normal)

```java
import com.amazaing.java25.model.User;
```

Luego puedes escribir:

```java
User user = new User("Laura", 28);
```

### 7.2. Usar nombre completo (no recomendado para escribir siempre)

```java
com.amazaing.java25.model.User user =
        new com.amazaing.java25.model.User("Laura", 28);
```

Se usa poco porque ensucia el código, pero es útil para entender qué está pasando.

---

## 8. Importar múltiples clases del mismo package

Si tienes varias clases en `model`:

- `User`
- `Product`
- `Order`

Puedes importarlas una por una:

```java
import com.amazaing.java25.model.User;
import com.amazaing.java25.model.Product;
import com.amazaing.java25.model.Order;
```

O usar comodín (no suele recomendarse en proyectos profesionales grandes, pero en aprendizaje es válido):

```java
import com.amazaing.java25.model.*;
```

---

## 9. El _default package_ y por qué evitarlo

Si creas una clase directamente en `src` sin package, estará en el **default package** (sin `package ...;`).

Esto funciona en proyectos muy pequeños, pero es mala práctica porque:

- No puedes organizar tu proyecto bien
- Puede dar problemas con herramientas y tests
- Es difícil de mantener
- En proyectos reales casi nunca se usa

**Recomendación:** usa packages desde el primer día.

---

## 10. Visibilidad y packages: _package-private_

Además de `public`, `private`, `protected`, existe un “modificador” que no se escribe:

- **sin modificador** → _package-private_

Significa:

> Accesible solo desde clases del mismo package.

Ejemplo:

```java
package com.amazaing.java25.model;

class InternalHelper {
    void doWork() {
        System.out.println("Working...");
    }
}
```

- `InternalHelper` no es `public`
- Solo se puede usar desde `com.amazaing.java25.model`

---

## 11. Ejemplo 2: `package-private` en acción

### 11.1. `InternalHelper.java` (package-private)

```java
package com.amazaing.java25.model;

class InternalHelper {
    void log(String message) {
        System.out.println("LOG: " + message);
    }
}
```

### 11.2. `User.java` (mismo package)

```java
package com.amazaing.java25.model;

public class User {
    private String name;

    public User(String name) {
        this.name = name;
    }

    public void printInfo() {
        InternalHelper helper = new InternalHelper();
        helper.log("Printing user: " + name);
        System.out.println("Name: " + name);
    }
}
```

Esto funciona porque están en el mismo package.

### 11.3. Intento desde `Main` (otro package)

```java
package com.amazaing.java25;

import com.amazaing.java25.model.InternalHelper; // NO compila
```

No compila, porque `InternalHelper` no es visible fuera del package.

---

## 12. `protected` y paquetes (idea clave)

`protected` permite acceso:

- dentro del mismo package
- y desde subclases (aunque estén en otro package)

Esto es relevante cuando trabajas con herencia.  
Como norma general para este curso:

- Mantén atributos `private`
- Expón getters/setters o métodos

---

## 13. `static import` (opcional, pero útil)

A veces quieres usar métodos estáticos sin escribir el nombre de la clase.

En vez de:

```java
double root = Math.sqrt(25);
```

Puedes hacer:

```java
import static java.lang.Math.sqrt;

double root = sqrt(25);
```

### 13.1. Ejemplo completo

```java
import static java.lang.Math.sqrt;
import static java.lang.Math.PI;

public class Main {
    public static void main(String[] args) {
        double r = 3.0;
        double area = PI * r * r;

        System.out.println(area);
        System.out.println(sqrt(81));
    }
}
```

---

## 14. Mover clases entre packages en IntelliJ (sin romper nada)

Pasos:

1. Clic derecho en la clase (o package)
2. **Refactor** → **Move**
3. Selecciona el nuevo package
4. IntelliJ actualiza automáticamente:
   - la línea `package ...;`
   - los `import ...;` donde se use esa clase

---

## 15. Errores típicos al trabajar con packages

### 15.1. El nombre del package no coincide con la carpeta

Si el archivo está en `src/es/app/model/User.java` pero arriba pone:

```java
package es.other.model;
```

Entonces tendrás errores.  
La ruta y el package deben coincidir.

### 15.2. Olvidar el `import`

Si estás usando una clase de otro package y no importas, Java no la reconoce (salvo que uses el nombre completo).

### 15.3. Confundir paquetes con carpetas “cualesquiera”

En Java, no es solo “una carpeta bonita”:

- la carpeta representa el paquete
- y el paquete define cómo se encuentra la clase

---

## 16. Buenas prácticas

- Usa packages desde el principio (evita el default package).
- Sigue la convención del dominio invertido (`com.amazaing...`).
- Separa por responsabilidad: `model`, `service`, `utils`, etc.
- Usa `package-private` para cosas internas cuando tenga sentido.
- No abuses de `import *` en proyectos grandes.
- Usa IntelliJ para mover/renombrar con refactor y evitar errores.

---

## 17. A tener en cuenta

- Un package organiza clases y evita colisiones de nombres.
- `package ...;` debe ir al inicio y coincidir con la ruta del archivo.
- `import` te permite usar clases de otros paquetes de forma limpia.
- El _default package_ es una mala práctica en proyectos serios.
- _package-private_ (sin modificador) limita el acceso al mismo package.
- IntelliJ puede refactorizar y actualizar imports automáticamente.

---

En el siguiente tema seguiremos avanzando con conceptos más avanzadas de Programación Orientada a Objetos en Java con **Clases Abstractas y Métodos Abstractos**.
