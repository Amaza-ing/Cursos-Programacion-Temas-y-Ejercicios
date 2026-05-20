# Tema 04 — Instalación y configuración de GitHub Copilot en VS Code y JetBrains

## 1. Objetivos del tema

En este tema aprenderás a preparar el entorno de trabajo para utilizar **GitHub Copilot** en un proyecto real de desarrollo.

Al finalizar este tema deberías ser capaz de:

- Entender qué necesitas para usar GitHub Copilot.
- Instalar GitHub Copilot en **Visual Studio Code**.
- Instalar GitHub Copilot en **JetBrains**.
- Iniciar sesión con tu cuenta de GitHub.
- Comprobar si Copilot está funcionando correctamente.
- Activar y desactivar sugerencias automáticas.
- Identificar la diferencia entre las sugerencias inline y Copilot Chat.
- Aplicar una configuración básica segura y cómoda para trabajar.

> En este tema no se busca todavía dominar los prompts ni Copilot Chat. El objetivo es dejar el entorno preparado para los temas siguientes.

---

## 2. Qué es GitHub Copilot dentro del entorno de desarrollo

**GitHub Copilot** es un asistente de programación basado en inteligencia artificial que se integra dentro del editor o IDE.

Puede ayudarte a:

- Completar líneas de código.
- Generar funciones.
- Sugerir fragmentos de código.
- Explicar código existente.
- Proponer refactorizaciones.
- Ayudar a escribir tests.
- Resolver dudas técnicas desde el propio editor.
- Detectar errores o posibles mejoras.

La idea principal es que Copilot actúa como un **asistente de desarrollo**, no como un sustituto del programador.

Tú sigues siendo responsable de:

- Entender el código.
- Revisar lo que se genera.
- Probar que funciona.
- Comprobar que cumple los requisitos.
- Mantener la calidad y seguridad del proyecto.

---

## 3. Requisitos previos

Antes de instalar GitHub Copilot, conviene comprobar que tienes lo siguiente:

### 3.1. Cuenta de GitHub

Necesitas una cuenta de GitHub.

Si no tienes una, puedes crearla desde:

```text
https://github.com/
```

### 3.2. Acceso a GitHub Copilot

GitHub Copilot requiere acceso mediante una suscripción, licencia educativa, licencia de empresa o activación dentro de una organización.

Dependiendo del contexto del curso, puede ocurrir una de estas situaciones:

- Tienes una suscripción individual.
- Tu empresa o centro de formación te ha asignado una licencia.
- Usas una cuenta educativa con acceso a Copilot.
- El profesor proporciona instrucciones concretas para acceder durante la formación.

### 3.3. Editor o IDE compatible

En este curso trabajaremos principalmente con:

- **Visual Studio Code**.
- **JetBrains IDEs**, como IntelliJ IDEA, WebStorm, PyCharm o PhpStorm.

También existen integraciones para otros entornos, pero no serán el foco principal de este tema.

### 3.4. Git instalado

Aunque GitHub Copilot puede usarse para escribir código sin Git, en un curso de desarrollo profesional es recomendable tener Git instalado.

Para comprobarlo, abre una terminal y ejecuta:

```bash
git --version
```

Si aparece una versión, Git está instalado correctamente.

Ejemplo:

```bash
git version 2.45.0
```

---

## 4. Instalación de GitHub Copilot en Visual Studio Code

Visual Studio Code es uno de los entornos más cómodos para comenzar con GitHub Copilot.

### 4.1. Paso 1: Abrir Visual Studio Code

Abre Visual Studio Code desde tu ordenador.

Si todavía no lo tienes instalado, puedes descargarlo desde:

```text
https://code.visualstudio.com/
```

---

### 4.2. Paso 2: Abrir el panel de extensiones

En la barra lateral izquierda, haz clic en el icono de **Extensions**.

También puedes abrirlo con el atajo:

```text
Ctrl + Shift + X
```

En macOS:

```text
Cmd + Shift + X
```

---

### 4.3. Paso 3: Buscar GitHub Copilot

En el buscador de extensiones, escribe:

```text
GitHub Copilot
```

Deberías encontrar extensiones relacionadas con:

- GitHub Copilot.
- GitHub Copilot Chat.

En versiones recientes de Visual Studio Code, la experiencia de Copilot puede estar integrada o agruparse dentro de las extensiones oficiales de GitHub.

---

### 4.4. Paso 4: Instalar la extensión

Haz clic en **Install**.

Es importante instalar la extensión oficial de GitHub.

Comprueba que el publicador sea:

```text
GitHub
```

---

### 4.5. Paso 5: Iniciar sesión con GitHub

Después de instalar la extensión, Visual Studio Code puede pedirte iniciar sesión.

Haz clic en:

```text
Sign in to GitHub
```

Se abrirá una ventana del navegador.

Sigue los pasos:

1. Inicia sesión con tu cuenta de GitHub.
2. Autoriza Visual Studio Code.
3. Vuelve al editor.
4. Comprueba que Copilot aparece como activo.

---

### 4.6. Paso 6: Comprobar el estado de Copilot

En Visual Studio Code suele aparecer un icono de Copilot en la zona inferior o superior del editor, dependiendo de la versión.

Desde ese icono puedes comprobar si Copilot está:

- Activado.
- Desactivado.
- Esperando inicio de sesión.
- Sin acceso por licencia.
- Bloqueado por la organización.

Si Copilot no funciona, revisa:

- Que has iniciado sesión con la cuenta correcta.
- Que tu cuenta tiene acceso a Copilot.
- Que la extensión está instalada y habilitada.
- Que no hay restricciones de red o proxy.
- Que Visual Studio Code está actualizado.

---

## 5. Primera prueba en Visual Studio Code

Para comprobar que Copilot funciona, crea una carpeta de prueba.

Por ejemplo:

```text
copilot-demo
```

Dentro de esa carpeta, crea un archivo llamado:

```text
main.js
```

Escribe el siguiente comentario:

```javascript
// Create a function that receives an array of numbers and returns the average
```

Espera unos segundos.

Copilot debería sugerir una posible función.

Una sugerencia posible sería:

```javascript
function calculateAverage(numbers) {
  if (numbers.length === 0) {
    return 0;
  }

  const sum = numbers.reduce((total, number) => total + number, 0);
  return sum / numbers.length;
}
```

> El código exacto puede variar. Copilot no siempre genera la misma respuesta.

---

## 6. Cómo aceptar, rechazar o cambiar sugerencias

Cuando Copilot muestra una sugerencia, normalmente aparece en gris claro dentro del editor.

### Aceptar una sugerencia

En Visual Studio Code, normalmente puedes aceptar la sugerencia con:

```text
Tab
```

### Rechazar una sugerencia

Puedes seguir escribiendo o pulsar:

```text
Esc
```

### Ver otra sugerencia

Según la configuración del editor, puedes moverte entre sugerencias con atajos de teclado.

También puedes abrir el panel de comandos:

```text
Ctrl + Shift + P
```

En macOS:

```text
Cmd + Shift + P
```

Y buscar comandos relacionados con Copilot.

---

## 7. Activar y desactivar Copilot en VS Code

Hay momentos en los que puede interesarte desactivar Copilot temporalmente.

Por ejemplo:

- Cuando estás haciendo una prueba sin ayuda.
- Cuando estás trabajando con información sensible.
- Cuando las sugerencias te distraen.
- Cuando quieres escribir manualmente una solución.

### Desde el icono de Copilot

1. Haz clic en el icono de Copilot.
2. Selecciona la opción para activar o desactivar Copilot.
3. Elige si quieres desactivarlo globalmente o solo para un lenguaje concreto.

### Desde configuración

También puedes abrir la configuración de VS Code y buscar:

```text
Copilot
```

Desde ahí puedes modificar opciones relacionadas con:

- Sugerencias inline.
- Activación por lenguajes.
- Comportamiento de Chat.
- Accesos directos.

---

## 8. Activar o desactivar Copilot por lenguaje

A veces no quieres que Copilot funcione en todos los lenguajes.

Por ejemplo, puedes querer usarlo en JavaScript, Java o Python, pero desactivarlo en Markdown, JSON o archivos de configuración sensibles.

En VS Code puedes acceder a la configuración de Copilot y modificar los lenguajes permitidos.

Un ejemplo de configuración podría ser:

```json
{
  "github.copilot.enable": {
    "*": true,
    "markdown": false,
    "plaintext": false
  }
}
```

Este ejemplo indica:

- Copilot está activado por defecto.
- Copilot está desactivado en Markdown.
- Copilot está desactivado en texto plano.

> La configuración exacta puede variar según la versión de la extensión y del editor.

---

## 9. Instalación de GitHub Copilot en JetBrains

GitHub Copilot también puede instalarse en IDEs de JetBrains.

Algunos ejemplos son:

- IntelliJ IDEA.
- WebStorm.
- PyCharm.
- PhpStorm.
- RubyMine.
- GoLand.

---

### 9.1. Paso 1: Abrir el IDE

Abre tu IDE de JetBrains.

Por ejemplo:

```text
IntelliJ IDEA
```

---

### 9.2. Paso 2: Abrir configuración de plugins

En Windows o Linux:

```text
File > Settings > Plugins
```

En macOS:

```text
IntelliJ IDEA > Settings > Plugins
```

---

### 9.3. Paso 3: Buscar GitHub Copilot

En la pestaña de Marketplace, busca:

```text
GitHub Copilot
```

Comprueba que el plugin corresponde a GitHub.

---

### 9.4. Paso 4: Instalar el plugin

Haz clic en:

```text
Install
```

Después de instalarlo, puede que el IDE te pida reiniciar.

Si aparece ese mensaje, reinicia el IDE.

---

### 9.5. Paso 5: Iniciar sesión

Después de reiniciar, el IDE puede pedirte iniciar sesión en GitHub.

Sigue estos pasos:

1. Haz clic en la opción de iniciar sesión.
2. Se abrirá el navegador.
3. Accede con tu cuenta de GitHub.
4. Autoriza el plugin.
5. Vuelve al IDE.

---

### 9.6. Paso 6: Comprobar funcionamiento

Crea un archivo de prueba.

Por ejemplo:

```text
Main.java
```

Escribe este comentario:

```java
// Create a method that receives a list of integers and returns the highest value
```

Copilot debería sugerir una posible implementación.

Ejemplo:

```java
public static int getHighestValue(List<Integer> numbers) {
    if (numbers == null || numbers.isEmpty()) {
        throw new IllegalArgumentException("The list cannot be null or empty");
    }

    int max = numbers.get(0);

    for (int number : numbers) {
        if (number > max) {
            max = number;
        }
    }

    return max;
}
```

---

## 10. Diferencia entre sugerencias inline y Copilot Chat

GitHub Copilot puede ayudarte de dos formas principales dentro del editor.

### 10.1. Sugerencias inline

Son sugerencias que aparecen mientras escribes código.

Sirven para:

- Completar una línea.
- Generar una función.
- Continuar un patrón.
- Rellenar código repetitivo.
- Sugerir una implementación.

Ejemplo:

```javascript
function formatPrice(price) {
```

Copilot puede sugerir el resto de la función.

---

### 10.2. Copilot Chat

Copilot Chat permite escribir preguntas o instrucciones en lenguaje natural.

Sirve para:

- Preguntar qué hace un archivo.
- Pedir que explique una función.
- Solicitar una refactorización.
- Pedir tests.
- Analizar errores.
- Generar documentación.
- Comparar alternativas.

Ejemplo de prompt:

```text
Explain what this function does and suggest how to make it easier to read.
```

---

## 11. Cuándo usar sugerencias inline y cuándo usar Chat

Usa **sugerencias inline** cuando:

- Ya sabes lo que quieres escribir.
- Estás completando código repetitivo.
- Quieres acelerar una implementación sencilla.
- El contexto cercano del archivo es suficiente.

Usa **Copilot Chat** cuando:

- Necesitas explicar una duda.
- Quieres analizar un error.
- Necesitas comparar alternativas.
- Quieres modificar varias partes del código.
- Necesitas una explicación antes de aceptar el código.
- Quieres generar tests o documentación con instrucciones concretas.

---

## 12. Configuración recomendada para clase

Para este curso, se recomienda trabajar con la siguiente configuración inicial:

### En VS Code

- Tener instalada la extensión oficial de GitHub Copilot.
- Tener Copilot Chat disponible.
- Tener Git instalado.
- Tener un proyecto de prueba abierto como carpeta.
- Tener activadas las sugerencias inline.
- Tener visible el panel de Chat.

### En JetBrains

- Tener instalado el plugin oficial de GitHub Copilot.
- Haber iniciado sesión con GitHub.
- Haber probado una sugerencia inline.
- Tener abierto un proyecto de prueba.
- Tener localizadas las opciones de Copilot en Settings.

---

## 13. Proyecto de ejemplo para las pruebas del curso

Durante los temas siguientes puedes usar un proyecto sencillo.

Crea una carpeta llamada:

```text
copilot-course-demo
```

Dentro, crea esta estructura:

```text
copilot-course-demo/
├── README.md
├── src/
│   ├── calculator.js
│   ├── users.js
│   └── validators.js
└── tests/
    └── calculator.test.js
```

No hace falta que el proyecto sea complejo.

La idea es tener archivos suficientes para probar:

- Generación de funciones.
- Refactorización.
- Documentación.
- Tests.
- Explicación de código.
- Detección de errores.

---

## 14. Archivo inicial de ejemplo

En el archivo:

```text
src/calculator.js
```

puedes escribir:

```javascript
function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

function multiply(a, b) {
  return a * b;
}

function divide(a, b) {
  return a / b;
}

module.exports = {
  add,
  subtract,
  multiply,
  divide,
};
```

Este código nos permitirá pedir a Copilot que:

- Añada validaciones.
- Documente funciones.
- Genere tests.
- Detecte errores.
- Proponga mejoras.

---

## 15. Errores habituales al configurar Copilot

### Error 1: No aparece ninguna sugerencia

Posibles causas:

- No has iniciado sesión.
- La extensión no está instalada.
- Copilot está desactivado.
- Tu cuenta no tiene acceso a Copilot.
- El archivo está vacío o no tiene suficiente contexto.
- Hay problemas de conexión.

Solución recomendada:

1. Comprueba el estado de Copilot en el editor.
2. Revisa que la cuenta de GitHub sea la correcta.
3. Cierra y vuelve a abrir el editor.
4. Actualiza la extensión.
5. Prueba en un archivo sencillo.

---

### Error 2: Copilot genera código que no encaja con el proyecto

Posibles causas:

- El proyecto no tiene una estructura clara.
- El prompt es demasiado ambiguo.
- El archivo no contiene suficiente contexto.
- El código existente no sigue patrones consistentes.

Solución recomendada:

- Añade nombres de funciones claros.
- Escribe comentarios específicos.
- Abre archivos relacionados.
- Usa Copilot Chat para dar más contexto.
- Revisa y adapta siempre el resultado.

---

### Error 3: Copilot sugiere código incorrecto

Esto puede ocurrir.

Copilot no garantiza que el código sea correcto.

Solución recomendada:

- Lee el código antes de aceptarlo.
- Ejecuta el proyecto.
- Añade tests.
- Comprueba casos límite.
- No aceptes código que no entiendes.

---

### Error 4: Copilot no responde en Chat

Posibles causas:

- No tienes acceso a Copilot Chat.
- Hay un problema de sesión.
- El IDE no está actualizado.
- Hay restricciones de red.

Solución recomendada:

- Cierra sesión y vuelve a iniciarla.
- Actualiza el IDE.
- Actualiza la extensión.
- Comprueba la documentación oficial.
- Revisa si tu organización ha limitado alguna función.

---

## 16. Buenas prácticas de configuración

Para trabajar mejor con Copilot:

- Mantén el editor actualizado.
- Usa la extensión oficial.
- Inicia sesión con la cuenta correcta.
- Trabaja con proyectos bien organizados.
- Usa nombres claros para archivos, funciones y variables.
- No pegues datos sensibles en prompts.
- Revisa siempre el código generado.
- Desactiva Copilot en archivos sensibles si es necesario.
- Usa Chat para tareas complejas y sugerencias inline para tareas pequeñas.

---

## 17. Checklist final del tema

Antes de pasar al siguiente tema, comprueba que puedes responder afirmativamente a estas preguntas:

- ¿Tengo una cuenta de GitHub activa?
- ¿Tengo acceso a GitHub Copilot?
- ¿He instalado Copilot en VS Code o JetBrains?
- ¿He iniciado sesión correctamente?
- ¿He probado una sugerencia inline?
- ¿Sé aceptar o rechazar una sugerencia?
- ¿Sé abrir Copilot Chat?
- ¿Sé activar o desactivar Copilot si lo necesito?
- ¿Entiendo que el código generado debe revisarse?

---

## 18. Resumen

En este tema has preparado tu entorno para trabajar con GitHub Copilot.

Has visto:

- Qué necesitas para usar Copilot.
- Cómo instalarlo en VS Code.
- Cómo instalarlo en JetBrains.
- Cómo comprobar que funciona.
- Qué son las sugerencias inline.
- Qué es Copilot Chat.
- Cuándo usar cada modalidad.
- Qué errores de configuración pueden aparecer.
- Qué buenas prácticas aplicar desde el principio.

A partir del siguiente tema empezaremos a trabajar con una de las partes más importantes del curso: **cómo escribir buenos prompts para programar con Copilot**.

---

## 19. Documentación oficial recomendada

- GitHub Copilot documentation: `https://docs.github.com/copilot`
- Installing the GitHub Copilot extension: `https://docs.github.com/copilot/managing-copilot/configure-personal-settings/installing-the-github-copilot-extension-in-your-environment`
- Getting code suggestions in your IDE: `https://docs.github.com/copilot/using-github-copilot/getting-code-suggestions-in-your-ide-with-github-copilot`
- Troubleshooting GitHub Copilot: `https://docs.github.com/copilot/troubleshooting-github-copilot/troubleshooting-common-issues-with-github-copilot`
