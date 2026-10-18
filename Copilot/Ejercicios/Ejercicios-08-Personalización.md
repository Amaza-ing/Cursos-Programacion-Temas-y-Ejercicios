# Exercises - Topic 08: Advanced GitHub Copilot, projects, instructions, agents and CLI

Below, you'll find hands-on exercises for working with GitHub Copilot on more complete projects, using custom instructions, assisted planning, agents, and Copilot from the terminal.

## Exercise 1: Create custom instructions for a repository

Imagine you have a React project with Vite. The team wants Copilot to respect the following rules:

- Use functional components.
- Use variable and function names in English.
- Write comments in Spanish only when necessary.
- Use `fetch` for simple HTTP calls.
- Keep components small.
- Do not add external libraries without asking for confirmation.

Write the content that you would put in an `.github/copilot-instructions.md` file.

<details>
<summary>Show solution</summary>

A possible solution would be:

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


These instructions help Copilot generate responses that are more consistent with the project style and reduce the need to repeat the same rules at each prompt.

</details>

## Exercise 2: Ask Copilot for a plan before generating code

You want to create a small task management app with these features:

- List tasks.
- Create tasks.
- Mark tasks as completed.
- Delete tasks.
- Save the data in `localStorage`.

Before requesting code, you want Copilot to propose an implementation plan.

Write an appropriate prompt.

<details>
<summary>Show solution</summary>

A suitable prompt would be:

```text
Quiero crear una pequeña aplicación de gestión de tareas con React.
Antes de generar código, propón un plan de implementación paso a paso.
La aplicación debe permitir listar tareas, crear tareas, marcarlas como completadas, eliminarlas y guardar los datos en localStorage.
No escribas todavía el código completo.
Primero indica la estructura de componentes, el estado necesario y el orden recomendado de implementación.
```


A good Copilot response should include something like this:

1. Create a main component `App`.
2. Define an `tasks` state.
3. Load the tasks from `localStorage` when starting the application.
4. Save tasks to `localStorage` every time they change.
5. Create an `TaskForm` component to add tasks.
6. Create an `TaskList` component to display the tasks.
7. Create an `TaskItem` component for each task.
8. Add functions to create, complete and delete tasks.
9. Manually test the entire flow.

Asking for a plan first helps you maintain control of the project and avoids accepting overly large code without understanding its structure.

</details>

## Exercise 3: Use Copilot as an assistant to divide a large task

You have this request too broad:

```text
Crea una API completa para una tienda online.
```


Rewrite the request so that Copilot breaks it into manageable subtasks before generating code.

<details>
<summary>Show solution</summary>

A possible improved version would be:

```text
Quiero crear una API para una tienda online con Node.js y Express, pero no quiero generar todo el código de golpe.
Divide el proyecto en subtareas manejables.
Incluye, como mínimo, productos, usuarios, pedidos y autenticación básica.
Para cada subtarea, indica qué archivos habría que crear, qué endpoints serían necesarios y qué debería probarse.
No escribas todavía la implementación completa.
```


This request is better because:

- Defines the technological stack.
- Ask for planning before implementation.
- Divide the problem into small parts.
- Prevent Copilot from generating too much code at once.
- Allows you to review the architecture before starting.

</details>

## Exercise 4: Design a prompt for Copilot CLI
You are working from the terminal and want to ask for help understanding the scripts available in a Node.js project. The `package.json` file contains several scripts, but you don't know which one to use to run tests, start development or create the build.

Write a request you could make to Copilot CLI.

<details>
<summary>Show solution</summary>

A possible request would be:

```text
Explica los scripts definidos en el package.json de este proyecto.
Indica cuál debería usar para iniciar el entorno de desarrollo, cuál para ejecutar los tests y cuál para generar la build de producción.
No modifiques ningún archivo.
```


If you were using Copilot CLI from the terminal, the idea would be to ask for a contextual explanation of the project before executing commands. A good answer should identify scripts like:

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


And explain them like this:

- `npm run dev`: starts the development environment.
- `npm test` or `npm run test`: run the tests.
- `npm run build`: generates the production version.
- `npm run preview`: preview the generated build.

</details>

## Exercise 5: Review an agent proposal before accepting changes

Imagine that Copilot Agent proposes to resolve an issue with these changes:

- Create a new `UserCard` component.
- Rename the `username` property to `name` throughout the application.
- Add the `axios` library.
- Modify three existing tests.

The issue only asked to show the username and email on a card.

Write a review checklist before accepting the pull request generated by the agent.

<details>
<summary>Show solution</summary>

A suitable checklist would be:

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


The most suspicious part is the global change from `username` to `name` and the addition of `axios`. They may be unnecessary changes for a small task and should be reviewed before accepting the pull request.

</details>

## Exercise 6: Create a reusable prompt file

You want to create a reusable prompt to ask Copilot to review JavaScript functions before uploading them to GitHub.

The prompt should ask:

- Possible bugs.
- Readability problems.
- Borderline cases.
- Recommended tests.
- A minimal correction if you find errors.

Write the content of that prompt file.

<details>
<summary>Show solution</summary>

A possible solution would be:

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


This prompt file would be useful because it turns a regular request into a reusable template. This avoids writing the same instruction every time you want to review a function.

</details>
