# Tema 08 — GitHub Copilot personalizado: proyectos, instrucciones personalizadas, agentes y CLI

## 1. Introducción

Hasta ahora hemos utilizado GitHub Copilot para tareas concretas: generar funciones, explicar código, documentar, refactorizar y crear tests.  
En este tema vamos a dar un paso más: usaremos Copilot como apoyo en flujos de trabajo más amplios.

GitHub Copilot puede ayudar en tareas como:

- analizar un proyecto completo;
- planificar una funcionalidad;
- generar estructura inicial de archivos;
- aplicar convenciones del proyecto;
- crear documentación de repositorio;
- preparar pull requests;
- sugerir mensajes de commit;
- utilizar instrucciones personalizadas;
- trabajar con agentes;
- usar Copilot desde la terminal.

El objetivo no es que Copilot “haga todo”, sino aprender a dirigirlo correctamente para que trabaje dentro de unos límites claros.

---

## 2. Objetivos del tema

Al finalizar este tema deberías ser capaz de:

- Usar Copilot para analizar la estructura de un proyecto.
- Pedir planes de implementación antes de generar código.
- Crear instrucciones personalizadas para un repositorio.
- Entender la diferencia entre Copilot Chat, Agent Mode, Copilot cloud agent y Copilot CLI.
- Usar Copilot en flujos de trabajo de GitHub.
- Pedir resúmenes de cambios, mensajes de commit y ayuda en pull requests.
- Aplicar buenas prácticas al trabajar con agentes.
- Evitar riesgos habituales al delegar tareas amplias en IA.

---

## 3. De autocompletado a flujo de trabajo completo

GitHub Copilot empezó siendo conocido sobre todo por sus sugerencias de código en el editor.  
Actualmente puede intervenir en más partes del proceso de desarrollo:

- escritura de código;
- explicación de código;
- documentación;
- testing;
- debugging;
- revisión;
- commits;
- pull requests;
- agentes;
- terminal;
- automatización.

Esto implica un cambio importante: Copilot ya no se usa solo para “completar líneas”, sino también para **ayudar a organizar el trabajo técnico**.

---

# Parte 1. Uso de Copilot en proyectos completos

## 4. Analizar la estructura de un proyecto

Antes de pedir a Copilot que modifique un proyecto, es conveniente pedirle que lo analice.

Prompt recomendado:

```text
Analiza la estructura de este proyecto.
Explícame:
- qué tipo de aplicación parece ser;
- qué carpetas principales existen;
- dónde está la lógica de negocio;
- dónde están las vistas o componentes;
- dónde se configuran las dependencias;
- cómo se ejecuta el proyecto;
- qué archivos debería revisar antes de hacer cambios.
No modifiques ningún archivo todavía.
```

Este prompt ayuda a que Copilot actúe primero como lector del proyecto, no como generador de código.

---

## 5. Pedir un plan antes de pedir código

Cuando una tarea es grande, no conviene pedir directamente la implementación.

Prompt poco recomendable:

```text
Añade autenticación a este proyecto.
```

Prompt mejor:

```text
Quiero añadir autenticación básica a este proyecto.
Antes de escribir código, analiza la estructura actual y propón un plan de implementación.
Incluye:
- archivos que habría que modificar;
- archivos nuevos que habría que crear;
- riesgos técnicos;
- decisiones que debería tomar antes de implementar.
No modifiques todavía el código.
```

La diferencia es importante.  
Primero se obtiene un plan, después se decide si ese plan es correcto.

---

## 6. Flujo recomendado para funcionalidades complejas

Para una funcionalidad compleja, sigue esta secuencia:

1. **Explicar el objetivo.**
2. **Pedir análisis del proyecto.**
3. **Pedir un plan de implementación.**
4. **Revisar el plan.**
5. **Dividir la implementación en pasos pequeños.**
6. **Aplicar cambios por partes.**
7. **Ejecutar tests o probar manualmente.**
8. **Pedir revisión de los cambios.**
9. **Documentar lo añadido.**

Ejemplo de prompt para el paso 5:

```text
Divide este plan en pasos pequeños.
Cada paso debe poder revisarse y probarse por separado.
No escribas todavía el código.
```

Ejemplo de prompt para el paso 6:

```text
Implementa únicamente el paso 1 del plan.
No modifiques archivos que no sean necesarios.
Explica qué has cambiado y cómo puedo probarlo.
```

---

# Parte 2. Generación de estructura de proyecto

## 7. Pedir una estructura inicial

Copilot puede ayudar a diseñar una estructura inicial de proyecto.  
Por ejemplo, para una API sencilla en Node.js:

```text
Propón una estructura de carpetas para una API REST sencilla con Node.js y Express.
La aplicación tendrá usuarios y productos.
Quiero una separación clara entre rutas, controladores, servicios y datos.
No escribas todavía el código, solo la estructura y una breve explicación de cada carpeta.
```

Una posible estructura sería:

```text
project/
├── src/
│   ├── controllers/
│   │   ├── userController.js
│   │   └── productController.js
│   ├── routes/
│   │   ├── userRoutes.js
│   │   └── productRoutes.js
│   ├── services/
│   │   ├── userService.js
│   │   └── productService.js
│   ├── data/
│   │   ├── users.js
│   │   └── products.js
│   └── app.js
├── tests/
├── package.json
└── README.md
```

Después se puede pedir la implementación paso a paso:

```text
Crea el archivo src/app.js con una configuración básica de Express.
No añadas base de datos.
Usa datos en memoria.
Incluye comentarios breves en español.
```

---

## 8. Mantener el control arquitectónico

Cuando Copilot genera una estructura, puede proponer más capas de las necesarias.  
Antes de aceptar, pregúntate:

- ¿La estructura es adecuada para el tamaño del proyecto?
- ¿Hay demasiadas carpetas?
- ¿Se han añadido dependencias innecesarias?
- ¿La arquitectura es comprensible para el equipo?
- ¿Se puede probar fácilmente?
- ¿Se parece al estilo de otros proyectos de la empresa o del curso?

Una estructura sencilla y clara suele ser mejor que una arquitectura excesivamente compleja.

---

# Parte 3. Instrucciones personalizadas de GitHub Copilot

## 9. Qué son las instrucciones personalizadas

Las instrucciones personalizadas sirven para dar a Copilot información persistente sobre cómo debe trabajar en un proyecto.

En lugar de repetir en cada prompt:

```text
Usa JavaScript moderno, comentarios en español, nombres de variables en inglés, no añadas dependencias y escribe tests con Jest.
```

podemos guardar estas preferencias en un archivo de instrucciones.

---

## 10. Archivo `.github/copilot-instructions.md`

Una forma habitual de añadir instrucciones al repositorio es crear el archivo:

```text
.github/copilot-instructions.md
```

Este archivo contiene indicaciones en lenguaje natural que Copilot puede usar como contexto cuando trabaja con el repositorio.

---

## 11. Guía paso a paso: crear instrucciones personalizadas

### Paso 1. Crear la carpeta `.github`

En la raíz del proyecto, crea la carpeta:

```text
.github
```

Si ya existe, no hace falta crearla de nuevo.

### Paso 2. Crear el archivo de instrucciones

Dentro de `.github`, crea este archivo:

```text
copilot-instructions.md
```

La ruta final será:

```text
.github/copilot-instructions.md
```

### Paso 3. Añadir instrucciones del proyecto

Ejemplo:

```md
# Instrucciones para GitHub Copilot

Este proyecto es una aplicación educativa creada para aprender desarrollo web.

## Estilo general

- Usa nombres de variables y funciones en inglés.
- Escribe comentarios y explicaciones en español.
- Prioriza código claro frente a código demasiado compacto.
- No añadas dependencias externas salvo que se solicite expresamente.
- Mantén las funciones pequeñas y fáciles de probar.

## JavaScript

- Usa sintaxis moderna de JavaScript.
- Usa `const` por defecto y `let` solo cuando sea necesario reasignar.
- Evita `var`.
- Usa `async/await` en lugar de cadenas largas de `.then()`.

## Testing

- Usa Jest para los tests unitarios.
- Los tests deben tener nombres descriptivos.
- Incluye casos normales, casos límite y casos de error.

## Documentación

- Cuando documentes código, evita comentarios obvios.
- Explica decisiones de negocio o partes que puedan resultar confusas.
- Los ejemplos deben ser sencillos y ejecutables.
```

### Paso 4. Guardar el archivo

Guarda los cambios.

### Paso 5. Probar las instrucciones

Abre Copilot Chat y pide:

```text
Resume las instrucciones personalizadas de este repositorio.
```

Después prueba un prompt:

```text
Genera una función para calcular el precio final de un producto con descuento e impuestos.
```

Comprueba si Copilot respeta:

- nombres en inglés;
- comentarios en español;
- estilo claro;
- ausencia de dependencias innecesarias.

---

## 12. Qué incluir en las instrucciones

Un buen archivo de instrucciones puede incluir:

- stack tecnológico;
- versión del lenguaje;
- estilo de código;
- convenciones de nombres;
- estructura de carpetas;
- comandos de instalación;
- comandos de test;
- normas de seguridad;
- qué dependencias se usan;
- qué dependencias no deben añadirse;
- estilo de documentación;
- criterios de revisión.

Ejemplo más completo:

```md
# Proyecto

Aplicación web con Node.js, Express y JavaScript.

# Comandos

- Instalar dependencias: `npm install`
- Ejecutar en desarrollo: `npm run dev`
- Ejecutar tests: `npm test`

# Convenciones

- Rutas en `src/routes`.
- Controladores en `src/controllers`.
- Servicios en `src/services`.
- Tests en `tests`.
- Nombres de funciones y variables en inglés.
- Comentarios explicativos en español.

# Restricciones

- No añadir nuevas dependencias sin justificarlo.
- No incluir claves API, tokens ni contraseñas.
- No cambiar la estructura del proyecto sin pedir confirmación.
- No mezclar lógica de negocio con rutas.
```

---

## 13. Instrucciones específicas por ruta

En algunos proyectos puede ser útil dar instrucciones específicas para ciertos tipos de archivo.

Ejemplo conceptual:

```text
.github/instructions/javascript.instructions.md
```

Contenido:

```md
---
applyTo: "**/*.js"
---

Para archivos JavaScript:

- Usa `const` por defecto.
- Evita `var`.
- Escribe funciones pequeñas.
- Prefiere código legible a soluciones demasiado compactas.
- Añade tests cuando modifiques lógica de negocio.
```

Otro ejemplo:

```text
.github/instructions/tests.instructions.md
```

Contenido:

```md
---
applyTo: "**/*.test.js,**/*.spec.js"
---

Para archivos de test:

- Usa Jest.
- Cada test debe verificar un comportamiento concreto.
- Los nombres de test deben explicar el resultado esperado.
- Incluye casos límite.
- Evita tests dependientes del orden de ejecución.
```

Estas instrucciones ayudan a que Copilot adapte mejor sus respuestas según el tipo de archivo.

---

## 14. Buenas prácticas con instrucciones personalizadas

- Escribe instrucciones claras y concretas.
- Evita instrucciones contradictorias.
- No escribas un documento enorme si no es necesario.
- Actualiza las instrucciones cuando cambie el proyecto.
- Incluye comandos reales del proyecto.
- Incluye restricciones explícitas.
- No guardes secretos ni información sensible.
- Revisa si Copilot está respetando las instrucciones.

---

# Parte 4. Copilot en GitHub: commits, pull requests y code review

## 15. Generar mensajes de commit

Copilot puede ayudar a generar mensajes de commit a partir de los cambios realizados.  
Aun así, el mensaje debe revisarse antes de confirmarlo.

Un buen mensaje de commit debe explicar:

- qué se ha cambiado;
- por qué se ha cambiado;
- si hay alguna consecuencia importante.

Ejemplos:

```text
Refactor product price calculation
```

```text
Add unit tests for discount validation
```

```text
Fix null profile handling in user name formatter
```

Puedes pedir a Copilot:

```text
Genera un mensaje de commit claro y breve para estos cambios.
Usa estilo imperativo.
No exageres el alcance del cambio.
```

---

## 16. Resúmenes de pull request

Cuando se abre una pull request, Copilot puede ayudar a resumir los cambios para que otras personas entiendan mejor qué se ha modificado.

Un buen resumen de PR debería incluir:

- objetivo del cambio;
- archivos principales modificados;
- decisiones relevantes;
- pruebas realizadas;
- riesgos o aspectos que conviene revisar.

Prompt útil:

```text
Genera un resumen para esta pull request.
Incluye:
- qué problema resuelve;
- cambios principales;
- cómo se ha probado;
- qué debería revisar con más atención la persona revisora.
```

---

## 17. Code review asistida

Copilot también puede ayudar en revisión de código.

Prompt recomendado:

```text
Revisa los cambios de esta pull request.
Busca:
- posibles bugs;
- problemas de seguridad;
- código difícil de mantener;
- tests ausentes;
- cambios que puedan romper compatibilidad.
Prioriza los problemas importantes y evita comentarios de estilo menores.
```

La revisión de Copilot debe tratarse como una revisión preliminar.  
La decisión final debe tomarla una persona.

---

# Parte 5. Agent Mode, Copilot cloud agent y Copilot CLI

## 18. Qué es un agente

Un agente de IA es un sistema capaz de:

- recibir una tarea;
- analizar el contexto;
- decidir pasos intermedios;
- usar herramientas;
- proponer o aplicar cambios;
- iterar sobre el resultado.

En desarrollo, un agente puede ayudar a modificar varios archivos, ejecutar comandos, preparar cambios o crear una pull request.

---

## 19. Diferencia entre Copilot Chat y agentes

| Herramienta          | Uso principal                                                                                                  |
| -------------------- | -------------------------------------------------------------------------------------------------------------- |
| Copilot Chat         | Conversar sobre código, pedir explicaciones, generar fragmentos, resolver dudas.                               |
| Agent Mode en el IDE | Permitir que Copilot proponga cambios en varios archivos dentro del entorno local, con supervisión.            |
| Copilot cloud agent  | Delegar tareas en GitHub para que Copilot investigue, planifique, cree una rama y proponga cambios revisables. |
| Copilot CLI          | Usar Copilot desde la terminal para preguntar, modificar, depurar o interactuar con GitHub.                    |

---

## 20. Cuándo usar cada opción

Usa **Copilot Chat** cuando:

- quieres entender código;
- necesitas una explicación;
- quieres generar una función concreta;
- quieres revisar un fragmento pequeño.

Usa **Agent Mode en el IDE** cuando:

- una tarea afecta a varios archivos;
- quieres trabajar en local;
- quieres aprobar cambios paso a paso;
- necesitas iterar con Copilot dentro del proyecto.

Usa **Copilot cloud agent** cuando:

- la tarea está asociada a un issue;
- quieres que Copilot prepare una rama;
- quieres revisar los cambios después;
- el flujo del equipo gira alrededor de GitHub y pull requests.

Usa **Copilot CLI** cuando:

- trabajas mucho desde terminal;
- quieres preguntar sobre comandos;
- quieres analizar errores de consola;
- quieres resumir cambios;
- quieres automatizar tareas con prompts.

---

## 21. Copilot CLI

GitHub Copilot CLI permite usar Copilot desde la línea de comandos.  
Puede servir para:

- hacer preguntas técnicas;
- analizar errores;
- generar comandos;
- explicar salidas de terminal;
- modificar código;
- interactuar con GitHub;
- preparar cambios.

### Instalación orientativa

En Windows, puede instalarse con WinGet:

```powershell
winget install GitHub.Copilot
```

En cualquier plataforma con Node.js 22 o superior:

```bash
npm install -g @github/copilot
```

En macOS o Linux con Homebrew:

```bash
brew install copilot-cli
```

Después, se puede iniciar una sesión interactiva con:

```bash
copilot
```

En el primer uso, si no has iniciado sesión, Copilot pedirá autenticación.

---

## 22. Ejemplos de uso de Copilot CLI

### Preguntar por un error

```bash
copilot
```

Después, dentro de la sesión:

```text
Estoy ejecutando npm test y aparece este error. Explícalo paso a paso y dime cómo investigarlo.
```

### Pedir resumen de cambios

```bash
copilot -p "Resume los cambios actuales del repositorio y sugiere un mensaje de commit" --allow-tool='shell(git)'
```

### Pedir análisis de estructura

```text
Analiza la estructura de este proyecto y dime dónde debería añadir un nuevo endpoint de productos.
```

---

## 23. Precauciones con Copilot CLI y agentes

Cuando una herramienta puede ejecutar comandos o modificar archivos, hay que actuar con más cuidado.

Buenas prácticas:

- No uses opciones que permitan ejecutar cualquier comando sin revisar.
- Lee los cambios antes de aceptarlos.
- No permitas acceso innecesario a secretos o credenciales.
- Trabaja en una rama separada.
- Usa Git para poder revertir cambios.
- Ejecuta tests después de cada modificación importante.
- No delegues cambios críticos sin revisión humana.

---

# Parte 6. Flujo avanzado recomendado

## 24. Ejemplo de flujo completo con Copilot

Imagina que quieres añadir una nueva funcionalidad: gestión de productos en una API.

### Paso 1. Pedir análisis del proyecto

```text
Analiza este proyecto y dime dónde encajaría una nueva funcionalidad de gestión de productos.
No modifiques archivos.
```

### Paso 2. Pedir plan de implementación

```text
Propón un plan para añadir gestión de productos.
Incluye rutas, controladores, servicios, datos de ejemplo y tests.
No escribas código todavía.
```

### Paso 3. Crear o revisar instrucciones personalizadas

```text
Revisa el archivo .github/copilot-instructions.md y dime si falta alguna instrucción para este proyecto.
```

### Paso 4. Implementar el primer paso

```text
Implementa únicamente las rutas de productos.
No implementes todavía la lógica de negocio.
```

### Paso 5. Implementar la lógica

```text
Ahora crea el servicio de productos con datos en memoria.
Incluye funciones para listar, buscar por id, crear y eliminar.
```

### Paso 6. Crear tests

```text
Genera tests unitarios para el servicio de productos usando Jest.
Incluye casos normales y casos límite.
```

### Paso 7. Revisar cambios

```text
Revisa los cambios realizados.
Busca posibles bugs, inconsistencias de estilo y tests ausentes.
```

### Paso 8. Crear documentación

```text
Actualiza el README con una sección que explique los endpoints de productos.
Incluye ejemplos de petición y respuesta.
```

### Paso 9. Preparar commit o pull request

```text
Genera un mensaje de commit claro para estos cambios.
Después genera un resumen breve para una pull request.
```

---

## 25. Cómo evaluar si Copilot ha trabajado bien

Después de una tarea avanzada, revisa:

- ¿Se ha respetado la estructura del proyecto?
- ¿Se han seguido las instrucciones personalizadas?
- ¿Hay cambios fuera del alcance?
- ¿Se han añadido dependencias innecesarias?
- ¿Los nombres son coherentes?
- ¿Los tests son útiles?
- ¿La documentación coincide con el código?
- ¿El proyecto sigue ejecutándose?
- ¿Hay riesgos de seguridad?
- ¿Puedo explicar el código generado?

Si no puedes explicar el código, no deberías integrarlo todavía.

---

## 26. Prompts recopilatorios del tema

### Analizar proyecto

```text
Analiza la estructura de este proyecto y explícame cómo está organizado.
No modifiques archivos.
```

### Planificar funcionalidad

```text
Quiero implementar [funcionalidad].
Antes de escribir código, propón un plan paso a paso.
Indica archivos a modificar, archivos nuevos, riesgos y pruebas necesarias.
```

### Crear instrucciones

```text
Crea un archivo .github/copilot-instructions.md para este proyecto.
Incluye stack, estilo de código, estructura, comandos, testing y restricciones.
```

### Revisar instrucciones

```text
Revisa estas instrucciones personalizadas.
Dime si son claras, si hay contradicciones y qué añadirías para mejorar la calidad del código generado.
```

### Preparar PR

```text
Genera un resumen de pull request para estos cambios.
Incluye objetivo, cambios principales, pruebas realizadas y aspectos a revisar.
```

### Revisar cambios

```text
Revisa estos cambios como si fueras un revisor senior.
Prioriza bugs, seguridad, mantenibilidad y tests.
Evita comentarios menores de estilo.
```

---

## 27. Resumen

En este tema hemos visto cómo usar GitHub Copilot en flujos de trabajo avanzados:

- análisis de proyectos completos;
- planificación de funcionalidades;
- generación de estructuras;
- instrucciones personalizadas;
- commits y pull requests;
- code review asistida;
- agentes;
- Copilot CLI.

La idea principal es que cuanto más amplia sea la tarea, más importante es trabajar por fases.

No conviene pedir:

```text
Haz todo el proyecto.
```

Conviene pedir:

```text
Analiza, planifica, divide, implementa una parte, prueba, revisa y documenta.
```

Copilot es más potente cuando se le dirige con claridad.

---

## 28. Documentación recomendada

- GitHub Docs — GitHub Copilot.
- GitHub Docs — Custom instructions.
- GitHub Docs — Copilot CLI.
- GitHub Docs — Copilot coding agent.
- GitHub Docs — Pull request summaries.
- GitHub Docs — Copilot code review.
