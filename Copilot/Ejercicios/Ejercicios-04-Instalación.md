# Ejercicios - Tema 04: Instalación y configuración de GitHub Copilot

A continuación, encontrarás ejercicios prácticos sobre instalación, configuración y primeros pasos con GitHub Copilot en un entorno de desarrollo.

## Ejercicio 1: Comprobar los requisitos antes de instalar GitHub Copilot

Antes de instalar GitHub Copilot, indica qué elementos deberías comprobar para asegurarte de que puedes utilizarlo correctamente en tu equipo.

Debes incluir, al menos, aspectos relacionados con la cuenta, el editor de código, la extensión y la conexión.

<details>
<summary>Mostrar solución</summary>

Antes de instalar GitHub Copilot, debería comprobar lo siguiente:

1. Tener una cuenta de GitHub activa.
2. Tener acceso a una suscripción de GitHub Copilot, ya sea individual, educativa, de empresa o proporcionada por una organización.
3. Tener instalado un editor compatible, como Visual Studio Code o un IDE de JetBrains.
4. Tener conexión a Internet, ya que Copilot necesita comunicarse con los servicios de GitHub.
5. Comprobar que el editor está actualizado.
6. Instalar la extensión oficial de GitHub Copilot.
7. Iniciar sesión en GitHub desde el editor.
8. Aceptar los permisos necesarios para vincular el editor con la cuenta de GitHub.
9. Revisar si la organización tiene políticas específicas que limiten o configuren el uso de Copilot.

</details>

## Ejercicio 2: Instalación de GitHub Copilot en Visual Studio Code

Ordena los pasos que seguirías para instalar y activar GitHub Copilot en Visual Studio Code.

Pasos desordenados:

- Buscar la extensión de GitHub Copilot.
- Abrir Visual Studio Code.
- Iniciar sesión con la cuenta de GitHub.
- Abrir el panel de extensiones.
- Instalar la extensión oficial.
- Comprobar que aparecen sugerencias al escribir código.

<details>
<summary>Mostrar solución</summary>

El orden correcto sería:

1. Abrir Visual Studio Code.
2. Abrir el panel de extensiones.
3. Buscar la extensión de GitHub Copilot.
4. Instalar la extensión oficial.
5. Iniciar sesión con la cuenta de GitHub.
6. Comprobar que aparecen sugerencias al escribir código.

Una vez hecho esto, se puede crear un archivo de prueba, por ejemplo `app.js`, y escribir un comentario como este:

```javascript
// Crear una función que reciba un array de precios y devuelva el total
```

Si Copilot está activo, debería proponer una posible implementación.

</details>

## Ejercicio 3: Instalación de GitHub Copilot en JetBrains

Explica qué pasos seguirías para instalar GitHub Copilot en un IDE de JetBrains, como IntelliJ IDEA, WebStorm o PyCharm.

<details>
<summary>Mostrar solución</summary>

Los pasos serían:

1. Abrir el IDE de JetBrains.
2. Entrar en `Settings` o `Preferences`.
3. Ir al apartado `Plugins`.
4. Buscar `GitHub Copilot` en el marketplace de plugins.
5. Instalar el plugin oficial.
6. Reiniciar el IDE si se solicita.
7. Iniciar sesión con la cuenta de GitHub.
8. Autorizar la conexión entre GitHub y el IDE.
9. Abrir un archivo de código y comprobar que Copilot ofrece sugerencias.

Para comprobarlo, se puede crear un archivo como `ProductService.java` y escribir:

```java
// Crear un método que calcule el precio final aplicando un descuento
```

Si Copilot está correctamente activado, debería sugerir una implementación relacionada con ese comentario.

</details>

## Ejercicio 4: Diferenciar sugerencias inline y Copilot Chat

Lee las siguientes situaciones e indica si sería más adecuado usar sugerencias inline o Copilot Chat.

1. Estás escribiendo una función sencilla y quieres que Copilot complete el código.
2. Tienes un error en una clase y quieres que Copilot te explique qué puede estar pasando.
3. Quieres generar rápidamente una condición dentro de un bucle.
4. Quieres que Copilot compare dos posibles formas de resolver un problema.
5. Quieres pedir una explicación general de un archivo completo.

<details>
<summary>Mostrar solución</summary>

1. **Sugerencias inline**. Son adecuadas para completar código mientras se escribe.
2. **Copilot Chat**. Permite explicar errores y razonar sobre el contexto.
3. **Sugerencias inline**. Es una ayuda rápida dentro del flujo de escritura.
4. **Copilot Chat**. Es mejor para comparar alternativas y pedir razonamiento.
5. **Copilot Chat**. Puede analizar y explicar código de forma conversacional.

Las sugerencias inline son útiles cuando ya se sabe qué se quiere escribir y solo se necesita ayuda para completarlo. Copilot Chat es más adecuado cuando se necesita explicación, análisis, comparación o una respuesta más elaborada.

</details>

## Ejercicio 5: Configurar Copilot para trabajar con más control

Imagina que un alumno instala GitHub Copilot y empieza a aceptar todas las sugerencias automáticamente sin revisarlas. Escribe una pequeña lista de recomendaciones para usar Copilot de forma más controlada.

<details>
<summary>Mostrar solución</summary>

Recomendaciones:

1. Leer siempre el código generado antes de aceptarlo.
2. Comprobar que la sugerencia encaja con el objetivo del archivo.
3. No aceptar código que no se entiende.
4. Probar el código después de incorporarlo.
5. Revisar nombres de variables, funciones y clases.
6. Comprobar que no se han introducido dependencias innecesarias.
7. Verificar que el código no expone datos sensibles.
8. Pedir a Copilot una explicación si la sugerencia no está clara.
9. Usar Copilot como ayuda, no como sustituto de la revisión humana.

Una forma correcta de trabajar sería aceptar solo las partes útiles de una sugerencia y modificar manualmente lo que no encaje con el proyecto.

</details>

## Ejercicio 6: Primer archivo de prueba con GitHub Copilot

Crea un archivo llamado `cart.js` y escribe un comentario inicial que ayude a Copilot a generar una función para calcular el total de un carrito. El carrito tendrá productos con nombre, precio y cantidad.

Después, indica qué código podría generar Copilot y cómo lo revisarías.

<details>
<summary>Mostrar solución</summary>

Un comentario adecuado podría ser:

```javascript
// Crear una función que reciba un array de productos y calcule el total del carrito.
// Cada producto tiene name, price y quantity.
// La función debe devolver el total como número.
```

Copilot podría generar algo parecido a esto:

```javascript
function calculateCartTotal(products) {
  return products.reduce((total, product) => {
    return total + product.price * product.quantity;
  }, 0);
}
```

La revisión debería comprobar:

1. Que la función recibe el parámetro correcto.
2. Que usa nombres claros en inglés.
3. Que multiplica correctamente `price` por `quantity`.
4. Que devuelve un número.
5. Que no modifica el array original.
6. Que funciona con un array vacío.

Se podría probar con este ejemplo:

```javascript
const products = [
  { name: "Keyboard", price: 30, quantity: 2 },
  { name: "Mouse", price: 15, quantity: 1 },
];

console.log(calculateCartTotal(products)); // 75
```

</details>
