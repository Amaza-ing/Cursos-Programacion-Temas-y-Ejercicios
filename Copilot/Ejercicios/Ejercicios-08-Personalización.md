# Ejercicios - Tema 08: GitHub Copilot avanzado, proyectos, instrucciones, agentes y CLI

A continuación, encontrarás ejercicios prácticos para trabajar con GitHub Copilot en proyectos más completos, usando instrucciones personalizadas, planificación asistida, agentes y Copilot desde la terminal.

## Ejercicio 1: Crear instrucciones personalizadas para un repositorio

Imagina que tienes un proyecto de React con Vite. El equipo quiere que Copilot respete las siguientes normas:

- Usar componentes funcionales.
- Usar nombres de variables y funciones en inglés.
- Escribir comentarios en español solo cuando sean necesarios.
- Usar `fetch` para llamadas HTTP sencillas.
- Mantener los componentes pequeños.
- No añadir librerías externas sin pedir confirmación.

Escribe el contenido que pondrías en un archivo `.github/copilot-instructions.md`.

<details>
<summary>Mostrar solución</summary>

Una posible solución sería:

```markdown
# Instrucciones para GitHub Copilot

Este proyecto es una aplicación de React creada con Vite.

## Estilo de código

- Usa componentes funcionales de React.
- Usa nombres de variables, funciones, componentes y archivos en inglés.
- Escribe código claro y fácil de mantener.
- Mantén los componentes pequeños y con una responsabilidad principal.
- Evita duplicar lógica entre componentes.

## Comentarios

- Escribe comentarios en español solo cuando ayuden a entender una decisión importante.
- No añadas comentarios obvios.

## Peticiones HTTP

- Usa `fetch` para llamadas HTTP sencillas.
- Controla errores básicos con `try/catch` o comprobando `response.ok`.
- No incluyas datos sensibles directamente en el código.

## Dependencias

- No añadas librerías externas sin pedir confirmación.
- Si propones una librería, explica por qué sería necesaria.

## Calidad

- Propón tests cuando una función tenga lógica relevante.
- Prioriza soluciones simples antes que soluciones complejas.
```

Estas instrucciones ayudan a Copilot a generar respuestas más coherentes con el estilo del proyecto y reducen la necesidad de repetir las mismas normas en cada prompt.

</details>

## Ejercicio 2: Pedir a Copilot un plan antes de generar código

Quieres crear una pequeña aplicación de gestión de tareas con estas características:

- Listar tareas.
- Crear tareas.
- Marcar tareas como completadas.
- Eliminar tareas.
- Guardar los datos en `localStorage`.

Antes de pedir código, quieres que Copilot te proponga un plan de implementación.

Escribe un prompt adecuado.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado sería:

```text
Quiero crear una pequeña aplicación de gestión de tareas con React.
Antes de generar código, propón un plan de implementación paso a paso.
La aplicación debe permitir listar tareas, crear tareas, marcarlas como completadas, eliminarlas y guardar los datos en localStorage.
No escribas todavía el código completo.
Primero indica la estructura de componentes, el estado necesario y el orden recomendado de implementación.
```

Una buena respuesta de Copilot debería incluir algo parecido a esto:

1. Crear un componente principal `App`.
2. Definir un estado `tasks`.
3. Cargar las tareas desde `localStorage` al iniciar la aplicación.
4. Guardar las tareas en `localStorage` cada vez que cambien.
5. Crear un componente `TaskForm` para añadir tareas.
6. Crear un componente `TaskList` para mostrar las tareas.
7. Crear un componente `TaskItem` para cada tarea.
8. Añadir funciones para crear, completar y eliminar tareas.
9. Probar manualmente el flujo completo.

Pedir primero un plan ayuda a mantener el control del proyecto y evita aceptar código demasiado grande sin entender su estructura.

</details>

## Ejercicio 3: Usar Copilot como asistente para dividir una tarea grande

Tienes esta petición demasiado amplia:

```text
Crea una API completa para una tienda online.
```

Reescribe la petición para que Copilot la divida en subtareas manejables antes de generar código.

<details>
<summary>Mostrar solución</summary>

Una posible versión mejorada sería:

```text
Quiero crear una API para una tienda online con Node.js y Express, pero no quiero generar todo el código de golpe.
Divide el proyecto en subtareas manejables.
Incluye, como mínimo, productos, usuarios, pedidos y autenticación básica.
Para cada subtarea, indica qué archivos habría que crear, qué endpoints serían necesarios y qué debería probarse.
No escribas todavía la implementación completa.
```

Esta petición es mejor porque:

- Define el stack tecnológico.
- Pide planificación antes que implementación.
- Divide el problema en partes pequeñas.
- Evita que Copilot genere demasiado código de golpe.
- Permite revisar la arquitectura antes de empezar.

</details>

## Ejercicio 4: Diseñar un prompt para Copilot CLI

Estás trabajando desde la terminal y quieres pedir ayuda para entender los scripts disponibles en un proyecto Node.js. El archivo `package.json` contiene varios scripts, pero no sabes cuál usar para ejecutar tests, iniciar desarrollo o crear la build.

Escribe una petición que podrías hacer a Copilot CLI.

<details>
<summary>Mostrar solución</summary>

Una posible petición sería:

```text
Explica los scripts definidos en el package.json de este proyecto.
Indica cuál debería usar para iniciar el entorno de desarrollo, cuál para ejecutar los tests y cuál para generar la build de producción.
No modifiques ningún archivo.
```

Si se estuviera usando Copilot CLI desde terminal, la idea sería pedir una explicación contextual del proyecto antes de ejecutar comandos. Una buena respuesta debería identificar scripts como:

```json
{
  "scripts": {
    "dev": "vite",
    "test": "vitest",
    "build": "vite build",
    "preview": "vite preview"
  }
}
```

Y explicarlos así:

- `npm run dev`: inicia el entorno de desarrollo.
- `npm test` o `npm run test`: ejecuta los tests.
- `npm run build`: genera la versión de producción.
- `npm run preview`: previsualiza la build generada.

</details>

## Ejercicio 5: Revisar una propuesta de agente antes de aceptar cambios

Imagina que Copilot Agent propone resolver una issue con estos cambios:

- Crear un nuevo componente `UserCard`.
- Cambiar el nombre de la propiedad `username` por `name` en toda la aplicación.
- Añadir la librería `axios`.
- Modificar tres tests existentes.

La issue solo pedía mostrar el nombre de usuario y el correo en una tarjeta.

Escribe una checklist de revisión antes de aceptar la pull request generada por el agente.

<details>
<summary>Mostrar solución</summary>

Una checklist adecuada sería:

```markdown
## Checklist de revisión

- [ ] Comprobar que la solución responde exactamente a la issue original.
- [ ] Revisar si era necesario cambiar `username` por `name` en toda la aplicación.
- [ ] Comprobar si añadir `axios` está justificado o si se puede mantener `fetch`.
- [ ] Revisar que el nuevo componente `UserCard` sea pequeño y reutilizable.
- [ ] Confirmar que no se han roto otros componentes que usaban `username`.
- [ ] Ejecutar los tests existentes.
- [ ] Revisar los tests modificados para confirmar que no se han relajado las comprobaciones.
- [ ] Comprobar que no se han añadido datos sensibles ni código innecesario.
- [ ] Revisar manualmente la interfaz si el cambio afecta a la vista.
```

La parte más sospechosa es el cambio global de `username` a `name` y la incorporación de `axios`. Pueden ser cambios innecesarios para una tarea pequeña y conviene revisarlos antes de aceptar la pull request.

</details>

## Ejercicio 6: Crear un prompt file reutilizable

Quieres crear un prompt reutilizable para pedir a Copilot que revise funciones JavaScript antes de subirlas a GitHub.

El prompt debe pedir:

- Posibles bugs.
- Problemas de legibilidad.
- Casos límite.
- Tests recomendados.
- Una corrección mínima si encuentra errores.

Escribe el contenido de ese prompt file.

<details>
<summary>Mostrar solución</summary>

Una posible solución sería:

```markdown
# Revisión de función JavaScript

Revisa la función seleccionada como si fueras un revisor de código.

Comprueba los siguientes puntos:

1. Posibles bugs o comportamientos inesperados.
2. Problemas de legibilidad.
3. Casos límite que no estén controlados.
4. Tests unitarios que deberían añadirse.
5. Posibles mejoras sin cambiar el comportamiento principal.

Si encuentras un error, propón una corrección mínima.
No reescribas toda la función salvo que sea necesario.
Explica cada cambio de forma breve.
```

Este prompt file sería útil porque convierte una petición habitual en una plantilla reutilizable. Así se evita escribir la misma instrucción cada vez que se quiere revisar una función.

</details>
