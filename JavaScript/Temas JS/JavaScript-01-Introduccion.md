# **Tema 1: Introducción a JavaScript**

## **1. ¿Qué es JavaScript?**

JavaScript es un lenguaje de programación interpretado, orientado a objetos y basado en prototipos. Es uno de los lenguajes esenciales del desarrollo web, junto con HTML y CSS, permitiendo crear páginas web dinámicas e interactivas.

### **Características clave de JavaScript:**

- **Lenguaje interpretado:** No requiere compilación previa.
- **Multiplataforma:** Funciona en la mayoría de los navegadores web modernos.
- **Orientado a objetos:** Utiliza objetos y prototipos para estructurar el código.
- **Basado en eventos:** Permite responder a acciones del usuario, como clics y teclas.
- **Manipulación del DOM:** Puede acceder y modificar el contenido y estructura de las páginas web.

---

## **2. Historia y evolución de JavaScript**

- **1995:** JavaScript fue creado por Brendan Eich en Netscape.
- **1997:** Se estandarizó bajo el nombre de ECMAScript.
- **ECMAScript 6 (2015):** Introdujo características modernas como `let`, `const`, clases y funciones flecha.
- **Actualidad:** JavaScript sigue evolucionando con nuevas versiones anuales de ECMAScript.

---

## **3. Instalación y configuración del entorno**

Para comenzar a programar en JavaScript no es necesario instalar herramientas complejas. Solo se necesita:

### **Requisitos básicos:**

1. **Navegador web:** Chrome, Firefox, Edge o Safari.
2. **Editor de código:** Visual Studio Code, Sublime Text o cualquier otro editor.

### **Instalación de Node.js (opcional)**

Si deseas ejecutar código JavaScript fuera del navegador:

1. Descarga e instala Node.js desde [nodejs.org](https://nodejs.org/).
2. Verifica la instalación ejecutando en la terminal:

```sh
node -v
npm -v
```

---

## **4. Escribiendo tu primer programa en JavaScript**

Vamos a crear un programa simple que muestre un mensaje en la consola.

### **Opción 1: Usando el navegador**

1. Abre tu navegador web.
2. Haz clic derecho en cualquier parte de la página y selecciona "Inspeccionar" o "Inspeccionar elemento".
3. Ve a la pestaña **Consola**.
4. Escribe el siguiente código y presiona **Enter**:

```js
console.log("¡Hola, mundo!");
```

Deberías ver el mensaje "¡Hola, mundo!" en la consola.

### **Opción 2: Usando un archivo HTML**

1. Crea un archivo llamado `index.html` y escribe lo siguiente:

```html
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <title>Mi primer programa</title>
  </head>
  <body>
    <h1>¡Hola, mundo!</h1>
    <script>
      console.log("¡Hola desde el archivo HTML!");
    </script>
  </body>
</html>
```

2. Abre el archivo en tu navegador (En VSCode puedes instalar la extensión `Live Server` y después abajo a la derecha darle al botón `Go Live`)
3. Ve a la consola del navegador para ver el mensaje.

### **Opción 3: Usando un archivo JS**

Crea un nuevo fichero que tenga extensión `.js`. Ejemplo: `main.js`

Modifica el fichero html para que vincule el fichero JavaScript usando de nuevo la etiqueta `<script src="main.js">` añadiendo en el atributo `src` la ruta al fichero `main.js`.

```html
<head>
  <script src="main.js"></script>
</head>
```

> Nota: Esta es la manera recomendada de trabajar con JavaScript

---

## **5. Sintaxis básica de JavaScript**

### **5.1. Variables**

Las variables son datos, es decir información, que se almacenan bajo un nombre concreto.

En JavaScript puedes declarar variables usando `var`, `let` o `const`:

```js
let name = "Sara";
const pi = 3.1416;
var oldVariable = "Usado antes de ES6";
```

- **`let`**: Se usa para declarar variables que pueden cambiar.
- **`const`**: Declara constantes que no pueden ser reasignadas.
- **`var`**: Obsoleto, evita su uso.

### **5.2. Tipos de datos**

- **String:** Cadenas de texto. Van entre comillas. Ejemplo: `"Hola"`.
- **Number:** Números. Ejemplo: `42`, `3.14`.
- **Boolean:** Valores lógicos. Ejemplo: `true`, `false`.
- **Array:** Listas de elementos. Van entre corchete. Ejemplo: `[1, 2, 3]`.
- **Object:** Colección de pares clave-valor. Van entre llaves. Ejemplo:

```js
const user = {
  name: "Sara",
  age: 25,
};
```

### **5.3. Operadores básicos**

Se pueden realizar operaciones básicas matemáticas y lógicas fácilmente usando operadores.

- **Aritméticos:** `+`, `-`, `*`, `/`, `%`
- **Asignación:** `=`, `+=`, `-=`, `*=`
- **Comparación:** `==`, `===`, `!=`, `!==`, `>`, `<`
- **Lógicos:** `&&`, `||`, `!`

```js
let num1 = 5;
let num2 = 3;

const result = num1 + num2; // result = 8
```

Si se "suman" dos strings el resultado será una concatenación.

```js
let str1 = "Hola";
let str2 = "Qué tal?";

const result = str1 + ", " + str2; // result = Hola, Qué tal?
```

El operador módulo `%` calcula el resto de la división entera. Esto puede ser útil por ejemplo para verificar si un número es par (Si el resto de la división entre 2 es 0 será par, si es 1 será impar).

```js
let num1 = 7;
let num2 = 2;

const result = num1 % num2; // result = 1
```

### **5.4. Estructuras de control**

En los siguientes temas profundizaremos en estos conceptos. Pero en esencia, cuando escribimos nuestro código podemos decidir si se ejecuta una linea u otra, o ninguna en absoluto mediante una estructura de control de flujo condicional. También podemos decidir repetir bloques de código tantas veces como queramos mediante el uso de bucles.

- **Condicionales:**

```js
let age = 18;
if (age >= 18) {
  console.log("Eres mayor de edad");
} else {
  console.log("Eres menor de edad");
}
```

- **Bucles:**

```js
for (let i = 0; i < 5; i++) {
  console.log("Número: " + i);
}

// Resultado por consola:
// Número 0
// Número 1
// Número 2
// Número 3
// Número 4
```

---

## **6. Consola y depuración**

### **6.1. Métodos básicos de `console`**

- `console.log()`: Muestra mensajes generales.
- `console.warn()`: Muestra advertencias.
- `console.error()`: Muestra errores.
- `console.table()`: Muestra datos en formato de tabla.

Ejemplo:

```js
console.table([
  { name: "Sara", age: 25 },
  { name: "Luis", age: 30 },
]);
```

### **6.2. Uso de Breakpoints**

En las herramientas del desarrollador del navegador, puedes establecer **breakpoints** para pausar la ejecución y examinar el estado del programa.

1. Abre la pestaña **Sources**.
2. Encuentra tu archivo JavaScript.
3. Haz clic en el número de línea donde quieres pausar.
4. Refresca la página y observa cómo se detiene en el breakpoint.

---

## **7. Buenas prácticas en JavaScript**

- Usa `let` y `const` en lugar de `var`.
- Nombra variables y funciones de forma descriptiva (en inglés, usando camelCase).
- Usa `===` en lugar de `==` para comparaciones estrictas.
- Comenta el código cuando sea necesario.

---

## **8. Conclusión**

En este tema, exploramos los fundamentos de JavaScript, su historia, configuración básica y conceptos esenciales. Con este conocimiento, ya puedes comenzar a escribir tus propios programas sencillos.

En el próximo tema, profundizaremos en los **condicionales** en JavaScript.
