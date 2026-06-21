# Curso Completo de Java desde Cero

![Java](https://img.shields.io/badge/Java-25-007396?style=for-the-badge&logo=openjdk&logoColor=white)
![Maven](https://img.shields.io/badge/Maven-Proyectos%20Java-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)
![Markdown](https://img.shields.io/badge/Formato-Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white)
![Nivel](https://img.shields.io/badge/Nivel-Desde%20cero-2E8B57?style=for-the-badge)
![Idioma](https://img.shields.io/badge/Idioma-Espa%C3%B1ol-1F6FEB?style=for-the-badge)

Repositorio del **Curso Completo de Java desde Cero**, creado para aprender Java de forma progresiva, práctica y estructurada.

El curso empieza por los fundamentos del lenguaje y avanza hasta conceptos modernos del ecosistema Java, como `Stream API`, `Optional`, `records`, `sealed classes`, concurrencia básica, anotaciones, módulos y Maven.

---

## Descripción general

Este repositorio está pensado para estudiantes que quieren aprender Java paso a paso, sin asumir conocimientos previos.

Cada tema incluye explicaciones claras, ejemplos prácticos y una progresión pensada para construir una base sólida antes de pasar a conceptos más avanzados.

El objetivo del curso es que puedas:

- Entender la sintaxis esencial de Java.
- Escribir programas simples desde cero.
- Trabajar con clases, objetos y estructuras de datos.
- Aplicar Programación Orientada a Objetos.
- Usar herramientas modernas del lenguaje.
- Organizar proyectos de forma profesional.
- Prepararte para continuar con tecnologías como JDBC, Spring Boot o APIs REST.

---

## Contenidos principales

A lo largo del curso trabajarás con:

- Fundamentos de Java: variables, operadores, condicionales, bucles y métodos.
- Tipos de datos, conversión de tipos, wrappers y cadenas de texto.
- Arrays, `ArrayList`, maps y otras colecciones.
- Programación Orientada a Objetos: clases, objetos, encapsulación, herencia y polimorfismo.
- Interfaces, clases abstractas, enums y excepciones.
- `BigDecimal`, genéricos, lambdas y programación funcional.
- `Stream API`, `Optional` y Date/Time API.
- Trabajo con archivos usando `Files` y `Path`.
- Java moderno: records, sealed classes, anotaciones y módulos.
- Concurrencia básica.
- Gestión de proyectos con Maven.

---

## Estructura del repositorio

El contenido se organiza principalmente en dos carpetas:

```text
.
├── Temas
│   ├── Java-01-Empezar-con-Java.md
│   ├── Java-02-Variables.md
│   └── ...
├── Ejercicios
│   ├── Ejercicios-01.md
│   ├── Ejercicios-02.md
│   └── ...
└── README.md
```

- `Temas`: contiene las explicaciones teóricas y ejemplos guiados.
- `Ejercicios`: contiene ejercicios prácticos con soluciones.
- `README.md`: guía general del curso y tabla de contenidos.

---

## Temario completo

| Nº  | Tema                        | Archivo                                                                                | Descripción                                         |
| --- | --------------------------- | -------------------------------------------------------------------------------------- | --------------------------------------------------- |
| 01  | Empezar con Java            | [Java-01-Empezar-con-Java.md](Temas/Java-01-Empezar-con-Java.md)                       | Instalación, configuración y primer programa.       |
| 02  | Variables                   | [Java-02-Variables.md](Temas/Java-02-Variables.md)                                     | Declaración de variables y tipos básicos.           |
| 03  | Operadores                  | [Java-03-Operadores.md](Temas/Java-03-Operadores.md)                                   | Operadores aritméticos, relacionales y lógicos.     |
| 04  | Conversión de Tipos         | [Java-04-Conversión-de-Tipos.md](Temas/Java-04-Conversión-de-Tipos.md)                 | Conversiones automáticas y manuales.                |
| 05  | Condicionales               | [Java-05-Condicionales.md](Temas/Java-05-Condicionales.md)                             | Estructuras `if`, `else if` y `else`.               |
| 06  | Bucles                      | [Java-06-Bucles.md](Temas/Java-06-Bucles.md)                                           | Repetición con `for`, `while` y `do while`.         |
| 07  | Break y Continue            | [Java-07-Break-y-Continue.md](Temas/Java-07-Break-y-Continue.md)                       | Control del flujo dentro de bucles.                 |
| 08  | Métodos                     | [Java-08-Métodos.md](Temas/Java-08-Métodos.md)                                         | Métodos, parámetros y valores de retorno.           |
| 09  | Métodos de los String       | [Java-09-Métodos-de-los-String.md](Temas/Java-09-Métodos-de-los-String.md)             | Operaciones habituales con cadenas de texto.        |
| 10  | Wrappers                    | [Java-10-Wrappers.md](Temas/Java-10-Wrappers.md)                                       | Clases envoltorio, autoboxing y unboxing.           |
| 11  | Sobrecarga de Métodos       | [Java-11-Sobrecarga-de-Métodos.md](Temas/Java-11-Sobrecarga-de-Métodos.md)             | Métodos con el mismo nombre y distintas firmas.     |
| 12  | Arrays                      | [Java-12-Arrays.md](Temas/Java-12-Arrays.md)                                           | Creación, acceso y recorrido de arrays.             |
| 13  | ArrayList                   | [Java-13-ArrayList.md](Temas/Java-13-ArrayList.md)                                     | Listas dinámicas y operaciones principales.         |
| 14  | Clases y Objetos            | [Java-14-Clases-y-Objetos.md](Temas/Java-14-Clases-y-Objetos.md)                       | Introducción a la Programación Orientada a Objetos. |
| 15  | Encapsulación               | [Java-15-Encapsulación.md](Temas/Java-15-Encapsulación.md)                             | Atributos privados, getters, setters y validación.  |
| 16  | Sobrecarga de Constructores | [Java-16-Sobrecarga-de-Constructores.md](Temas/Java-16-Sobrecarga-de-Constructores.md) | Múltiples constructores y `this(...)`.              |
| 17  | Métodos Estáticos           | [Java-17-Métodos-Estáticos.md](Temas/Java-17-Métodos-Estáticos.md)                     | Métodos `static`, constantes y utilidades.          |
| 18  | Herencia y Polimorfismo     | [Java-18-Herencia-y-Polimorfismo.md](Temas/Java-18-Herencia-y-Polimorfismo.md)         | `extends`, `super`, sobrescritura y polimorfismo.   |
| 19  | Packages                    | [Java-19-Packages.md](Temas/Java-19-Packages.md)                                       | Organización del código e imports.                  |
| 20  | Clases Abstractas           | [Java-20-Clases-Abstractas.md](Temas/Java-20-Clases-Abstractas.md)                     | Clases base y métodos abstractos.                   |
| 21  | Interfaces                  | [Java-21-Interfaces.md](Temas/Java-21-Interfaces.md)                                   | Contratos, implementación y diseño flexible.        |
| 22  | Equals                      | [Java-22-Equals.md](Temas/Java-22-Equals.md)                                           | Comparación de objetos con `equals`.                |
| 23  | Excepciones                 | [Java-23-Excepciones.md](Temas/Java-23-Excepciones.md)                                 | Manejo de errores y excepciones propias.            |
| 24  | Enums                       | [Java-24-Enums.md](Temas/Java-24-Enums.md)                                             | Conjuntos cerrados de valores.                      |
| 25  | Maps                        | [Java-25-Maps.md](Temas/Java-25-Maps.md)                                               | Estructuras clave-valor y búsquedas eficientes.     |
| 26  | Otras Colecciones           | [Java-26-Otras-Colecciones.md](Temas/Java-26-Otras-Colecciones.md)                     | Sets, queues y colecciones adicionales.             |
| 27  | BigDecimal                  | [Java-27-BigDecimal.md](Temas/Java-27-BigDecimal.md)                                   | Cálculos decimales precisos.                        |
| 28  | Genéricos                   | [Java-28-Genéricos.md](Temas/Java-28-Genéricos.md)                                     | Clases, métodos e interfaces genéricas.             |
| 29  | Expresiones Lambda          | [Java-29-Expresiones-Lambda.md](Temas/Java-29-Expresiones-Lambda.md)                   | Lambdas e interfaces funcionales.                   |
| 30  | Stream API                  | [Java-30-Stream-API.md](Temas/Java-30-Stream-API.md)                                   | Procesamiento declarativo de colecciones.           |
| 31  | Optional                    | [Java-31-Optional.md](Temas/Java-31-Optional.md)                                       | Gestión segura de valores ausentes.                 |
| 32  | Date-Time API               | [Java-32-Date-Time-API.md](Temas/Java-32-Date-Time-API.md)                             | Fechas, horas, periodos y formateo.                 |
| 33  | Files & Path                | [Java-33-Files-&-Path.md](Temas/Java-33-Files-&-Path.md)                               | Lectura, escritura y gestión de archivos.           |
| 34  | Records                     | [Java-34-Records.md](Temas/Java-34-Records.md)                                         | Datos inmutables y código más conciso.              |
| 35  | Sealed Classes              | [Java-35-Sealed-Classes.md](Temas/Java-35-Sealed-Classes.md)                           | Jerarquías controladas con `sealed` y `permits`.    |
| 36  | Concurrencia Básica         | [Java-36-Concurrencia-Básica.md](Temas/Java-36-Concurrencia-Básica.md)                 | Hilos, tareas, executors y resultados futuros.      |
| 37  | Anotaciones                 | [Java-37-Anotaciones.md](Temas/Java-37-Anotaciones.md)                                 | Anotaciones integradas y personalizadas.            |
| 38  | Módulos y Java Moderno      | [Java-38-Módulos-y-Java-Moderno.md](Temas/Java-38-Módulos-y-Java-Moderno.md)           | Sistema de módulos y características modernas.      |
| 39  | Maven                       | [Java-39-Maven.md](Temas/Java-39-Maven.md)                                             | Gestión de proyectos, dependencias y empaquetado.   |
| 40  | Proyecto Final              | [Java-40-Proyecto-Final.md](Temas/Java-40-Proyecto-Final.md)                           | Aplicación Completa con los conceptos aprendidos.   |

---

## Ejercicios

Los ejercicios están diseñados para practicar los contenidos de cada tema con ejemplos distintos a los de la teoría.

Cada archivo de ejercicios incluye:

- 10 ejercicios prácticos.
- Enunciados progresivos.
- Soluciones ocultas en bloques desplegables.
- Código preparado para copiar, probar y modificar.
- Casos pensados para reforzar los conceptos principales del tema.

Carpeta de ejercicios:

[Ejercicios](Ejercicios)

---

## Curso en vídeo

El curso también puede seguirse en YouTube con explicaciones paso a paso.

**Curso Completo de Java desde Cero**

[![Curso de Java desde Cero](https://img.youtube.com/vi/8qjZQZAvwBQ/0.jpg)](https://www.youtube.com/watch?v=8qjZQZAvwBQ&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD&index=1)

---

## Requisitos

Para seguir el curso necesitas:

- JDK instalado.
- Un editor o IDE compatible con Java.
- Terminal o consola básica.
- Conocimientos previos: ninguno.

Recomendaciones:

- IntelliJ IDEA, Eclipse, NetBeans o Visual Studio Code.
- Java 25 para los temas más modernos.
- Maven para el bloque final del curso.

---

## Ruta de aprendizaje recomendada

Para aprovechar mejor el curso:

1. Completa primero los fundamentos: temas 1 al 13.
2. Dedica tiempo a Programación Orientada a Objetos: temas 14 al 24.
3. Practica colecciones, genéricos y programación funcional: temas 25 al 31.
4. Avanza hacia APIs modernas: temas 32 al 36.
5. Termina con herramientas profesionales: temas 37 al 39.

La clave no es avanzar rápido, sino escribir código, equivocarse, corregir y volver a intentarlo.

---

## Próximos pasos

Después de completar este curso, puedes continuar con:

- JUnit y testing.
- JDBC y conexión con bases de datos.
- MySQL desde Java.
- Spring Boot.
- APIs REST.
- Persistencia con JPA e Hibernate.
- Arquitectura por capas.
- Patrones de diseño.
- Desarrollo backend profesional.

---

## Autor

Curso creado por **Adrián Maza**.

- YouTube: [AMaza-ing](https://www.youtube.com/@AMaza-Ing)
- LinkedIn: [Adrián Maza](https://www.linkedin.com/in/adrian-maza-vazquez/)
- Web: [AMazaing](https://www.amaza-ing.com/)
- GitHub: [AMaza-ing](https://github.com/Amaza-ing)

---

## Nota final

Este curso está diseñado para aprender Java de forma gradual, práctica y sólida.

Si estás empezando, no intentes memorizarlo todo. Escribe código, prueba los ejemplos, rompe cosas y vuelve a construirlas. Esa es la forma más efectiva de aprender a programar.
