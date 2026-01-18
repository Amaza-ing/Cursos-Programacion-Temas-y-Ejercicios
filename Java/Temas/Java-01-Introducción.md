# Tema 1. Qué es Java y primer programa con IntelliJ

## 1. ¿Qué es Java y para qué se usa?

Java es un **lenguaje de programación orientado a objetos**, de propósito general, diseñado para ser **portable**, **seguro** y **robusto**. Fue creado con la idea de que un mismo programa pudiera ejecutarse en distintos sistemas sin necesidad de modificar el código.

Esta característica se resume en la famosa frase:

> _Write once, run anywhere_

Java se utiliza en una gran variedad de contextos:

- Aplicaciones de escritorio
- Aplicaciones web (backend)
- Aplicaciones empresariales
- Aplicaciones móviles (Android)
- Sistemas embebidos

Es uno de los lenguajes más utilizados en el ámbito profesional y muy habitual en entornos académicos.

---

## 2. Cómo funciona Java: JVM, JDK y JRE

Java no se ejecuta directamente sobre el sistema operativo como otros lenguajes. Su funcionamiento se basa en varias capas.

### 2.1. Código fuente y bytecode

1. El programador escribe código Java (`.java`).
2. El compilador de Java transforma ese código en **bytecode** (`.class`).
3. El bytecode se ejecuta en la **Java Virtual Machine (JVM)**.

Gracias a esto, el mismo bytecode puede ejecutarse en distintos sistemas.

---

### 2.2. JVM (Java Virtual Machine)

La JVM es una **máquina virtual** que interpreta el bytecode y lo ejecuta.

- Existe una JVM para cada sistema operativo.
- El programador no interactúa directamente con ella.
- Garantiza la portabilidad del código Java.

---

### 2.3. JDK (Java Development Kit)

El JDK es el kit de desarrollo de Java. Incluye:

- Compilador (`javac`)
- JVM
- Librerías estándar
- Herramientas de desarrollo

Para programar en Java **siempre necesitas el JDK**.

---

## 3. IntelliJ IDEA y Java 25

IntelliJ IDEA es uno de los entornos de desarrollo más utilizados para programar en Java.

Ventajas principales:

- Autocompletado inteligente
- Detección de errores en tiempo real
- Integración directa con el JDK
- Muy usado en el ámbito profesional

En este curso trabajaremos con **Java 25** usando IntelliJ IDEA.

---

## 4. Crear el primer proyecto en IntelliJ

1. Abrir IntelliJ IDEA.
2. Seleccionar **New Project**.
3. Elegir **Java** como tipo de proyecto.
4. Seleccionar el **JDK 25**.
5. Elegir un nombre para el proyecto.
6. Finalizar.

IntelliJ creará automáticamente la estructura básica del proyecto.

---

## 5. Estructura básica de un proyecto Java

Un proyecto Java sencillo suele tener esta estructura:

```
project-name/
│── src/
│   └── Main.java
```

- `src` contiene el código fuente.
- `Main.java` es el punto de entrada del programa.

---

## 6. Primer programa en Java

### 6.1. La clase `Main`

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, Java!");
    }
}
```

Vamos a entender este código paso a paso.

---

### 6.2. Explicación del código

- `public class Main`: define una clase llamada `Main`.
- `public static void main(String[] args)`: método principal.
- `System.out.println`: muestra texto por consola.
- `"Hello, Java!"`: texto que se imprime.

El método `main` es el **punto de inicio** de cualquier programa Java.

---

## 7. Ejecutar el programa

Para ejecutar el programa en IntelliJ:

- Haz clic en el botón **Run**.
- O usa el atajo de teclado correspondiente.

En la consola aparecerá:

```
Hello, Java!
```

Esto confirma que el programa se ha ejecutado correctamente.

---

## 8. A tener en cuenta

- Java es un lenguaje compilado e interpretado.
- Todo el código vive dentro de **clases**.
- El método `main` es obligatorio para comenzar.
- IntelliJ facilita enormemente el trabajo desde el primer momento.

---

En el próximo tema comenzaremos a trabajar con **variables y tipos de datos**, la base para empezar a escribir programas útiles en Java.
