# Topic 08 — Custom GitHub Copilot: Projects, Custom Instructions, Agents, and CLI

## 1. Introduction

Until now we have used GitHub Copilot for specific tasks: generating functions, explaining code, documenting, refactoring and creating tests.  
In this topic we are going to go one step further: we will use Copilot to support broader workflows.

GitHub Copilot can help with tasks like:

- analyze a complete project;
- plan a functionality;
- generate initial file structure;
- apply project conventions;
- create repository documentation;
- prepare pull requests;
- suggest commit messages;
- use custom instructions;
- work with agents;
- use Copilot from the terminal.

The goal is not for Copilot to “do everything,” but to learn how to direct it correctly so that it works within clear limits.

---

## 2. Objectives of the topic

By the end of this topic you should be able to:

- Use Copilot to analyze the structure of a project.
- Ask for implementation plans before generating code.
- Create custom instructions for a repository.
- Understand the difference between Copilot Chat, Agent Mode, Copilot cloud agent and Copilot CLI.
- Use Copilot in GitHub workflows.
- Request change summaries, commit messages and help with pull requests.
- Apply good practices when working with agents.
- Avoid common risks when delegating broad tasks to AI.

---

## 3. From autocomplete to full workflow

GitHub Copilot started out best known for its code suggestions in the editor.  
Currently you can intervene in more parts of the development process:

- code writing;
- code explanation;
- documentation;
- testing;
- debugging;
- revision;
- commits;
-pull requests;
- agents;
- terminal;
- automation.

This implies an important change: Copilot is no longer used only to “complete lines”, but also to **help organize technical work**.

---

# Part 1. Using Copilot in complete projects

## 4. Analyze the structure of a project

Before asking Copilot to modify a project, it is a good idea to ask it to analyze it.

Recommended Prompt:

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

This prompt helps Copilot act first as a reader of the project, not as a code generator.

---

## 5. Request a plan before requesting a code

When a task is large, it is not advisable to directly ask for implementation.

Inadvisable prompt:

```text
Añade autenticación a este proyecto.
```

Prompt best:

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

The difference is important.  
First you get a plan, then you decide if that plan is correct.

---

## 6. Recommended flow for complex functionalities

For complex functionality, follow this sequence:

1. **Explain the objective.**
2. **Request analysis of the project.**
3. **Ask for an implementation plan.**
4. **Review the plan.**
5. **Break the implementation into small steps.**
6. **Apply changes in parts.**
7. **Run tests or test manually.**
8. **Request review of changes.**
9. **Document what was added.**

Example prompt for step 5:

```text
Divide este plan en pasos pequeños.
Cada paso debe poder revisarse y probarse por separado.
No escribas todavía el código.
```

Example prompt for step 6:

```text
Implementa únicamente el paso 1 del plan.
No modifiques archivos que no sean necesarios.
Explica qué has cambiado y cómo puedo probarlo.
```

---
# Part 2. Project structure generation

## 7. Ask for an initial structure

Copilot can help design an initial project structure.  
For example, for a simple API in Node.js:

```text
Propón una estructura de carpetas para una API REST sencilla con Node.js y Express.
La aplicación tendrá usuarios y productos.
Quiero una separación clara entre rutas, controladores, servicios y datos.
No escribas todavía el código, solo la estructura y una breve explicación de cada carpeta.
```

A possible structure would be:

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

Then you can ask for the implementation step by step:

```text
Crea el archivo src/app.js con una configuración básica de Express.
No añadas base de datos.
Usa datos en memoria.
Incluye comentarios breves en español.
```

---

## 8. Maintain architectural control

When Copilot generates a structure, it may propose more layers than necessary.  
Before accepting, ask yourself:

- Is the structure appropriate for the size of the project?
- Are there too many folders?
- Have unnecessary dependencies been added?
- Is the architecture understandable to the team?
- Can it be tested easily?
- Is it similar to the style of other projects in the company or the course?

A simple and clear structure is usually better than an excessively complex architecture.

---

# Part 3. Custom GitHub Copilot Instructions

## 9. What are custom instructions

Custom instructions are used to give Copilot persistent information about how to work on a project.

Instead of repeating at each prompt:

```text
Usa JavaScript moderno, comentarios en español, nombres de variables en inglés, no añadas dependencias y escribe tests con Jest.
```

we can save these preferences in an instructions file.

---

## 10. `.github/copilot-instructions.md` file

A common way to add instructions to the repository is to create the file:

```text
.github/copilot-instructions.md
```

This file contains natural language prompts that Copilot can use as context when working with the repository.

---

## 11. Step by Step Guide: Create Custom Instructions

### Step 1. Create `.github` folder

In the root of the project, create the folder:

```text
.github
```

If it already exists, there is no need to create it again.

### Step 2. Create the instructions file

Inside `.github`, create this file:

```text
copilot-instructions.md
```

The final route will be:

```text
.github/copilot-instructions.md
```

### Step 3. Add project instructions

Example:

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

### Step 4. Save the file

Save the changes.

### Step 5. Test the instructions

Open Copilot Chat and ask:

```text
Resume las instrucciones personalizadas de este repositorio.
```

Then try a prompt:

```text
Genera una función para calcular el precio final de un producto con descuento e impuestos.
```

Check if Copilot respects:

- names in English;
- comments in Spanish;
- clear style;
- absence of unnecessary dependencies.

---

## 12. What to include in the instructions

A good instructions file may include:

- technological stack;
- language version;
- code style;
- naming conventions;
- folder structure;
- installation commands;
- test commands;
- safety regulations;
- what dependencies are used;
- what dependencies should not be added;
- documentation style;
- review criteria.

More complete example:

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

## 13. Specific instructions per route

In some projects it may be useful to give specific instructions for certain file types.

Conceptual example:

```text
.github/instructions/javascript.instructions.md
```

Content:

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

Another example:

```text
.github/instructions/tests.instructions.md
```

Content:

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

These instructions help Copilot better tailor its responses depending on the file type.

---

## 14. Good practices with personalized instructions

- Write clear and concrete instructions.
- Avoid contradictory instructions.
- Don't write a huge document if it is not necessary.
- Update instructions when the project changes.
- Includes actual project commands.
- Includes explicit restrictions.
- Do not keep secrets or sensitive information.
- Check if Copilot is respecting the instructions.

---

# Part 4. Copilot on GitHub: commits, pull requests and code review

## 15. Generate commit messages

Copilot can help generate commit messages from the changes made.  
Even so, the message should be reviewed before confirming it.

A good commit message should explain:

- what has been changed;
- why it has been changed;
- if there are any important consequences.

Examples:

```text
Refactor product price calculation
```

```text
Add unit tests for discount validation
```

```text
Fix null profile handling in user name formatter
```

You can ask Copilot:

```text
Genera un mensaje de commit claro y breve para estos cambios.
Usa estilo imperativo.
No exageres el alcance del cambio.
```

---

## 16. Pull request summaries

When a pull request is opened, Copilot can help summarize the changes so other people better understand what has been changed.

A good PR summary should include:

- objective of the change;
- modified main files;
- relevant decisions;
- tests carried out;
- risks or aspects that should be reviewed.

Useful prompt:

```text
Genera un resumen para esta pull request.
Incluye:
- qué problema resuelve;
- cambios principales;
- cómo se ha probado;
- qué debería revisar con más atención la persona revisora.
```

---

## 17. Assisted code review

Copilot can also assist in code review.

Recommended Prompt:

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

The Copilot review should be treated as a preliminary review.  
The final decision must be made by one person.

---

# Part 5. Agent Mode, Copilot cloud agent and Copilot CLI

## 18. What is an agent

An AI agent is a system capable of:

- receive a task;
- analyze the context;
- decide intermediate steps;
- use tools;
- propose or apply changes;
- iterate over the result.

In development, an agent can help modify multiple files, execute commands, prepare changes, or create a pull request.

---

## 19. Difference between Copilot Chat and agents

| Tool | Main use |
| -------------------- | ----------------------------------------------------------------------------------------------------------- |
| Copilot Chat | Talk about code, ask for explanations, generate fragments, resolve doubts.                               |
| Agent Mode in the IDE | Allow Copilot to propose changes to multiple files within the local environment, with monitoring.            |
| Copilot cloud agent | Delegate tasks to GitHub for Copilot to research, plan, branch, and propose reviewable changes. |
| Copilot CLI | Use Copilot from the terminal to ask, modify, debug, or interact with GitHub.                    |

---

## 20. When to use each option

Use **Copilot Chat** when:

- you want to understand code;
- you need an explanation;
- you want to generate a specific function;
- you want to review a small fragment.

Use **Agent Mode in the IDE** when:

- a task affects several files;
- you want to work locally;
- you want to approve changes step by step;
- you need to iterate with Copilot within the project.

Use **Copilot cloud agent** when:

- the task is associated with an issue;
- you want Copilot to prepare a branch;
- you want to review the changes later;
- the team flow revolves around GitHub and pull requests.

Use **Copilot CLI** when:

- you work a lot from terminal;
- you want to ask about commands;
- you want to analyze console errors;
- you want to summarize changes;
- you want to automate tasks with prompts.

---

## 21. Copilot CLI

GitHub Copilot CLI allows you to use Copilot from the command line.  
It can be used for:

- ask technical questions;
- analyze errors;
- generate commands;
- explain terminal outputs;
- modify code;
- interact with GitHub;
- prepare changes.

### Orientative installation

On Windows, it can be installed with WinGet:

```powershell
winget install GitHub.Copilot
```

On any platform with Node.js 22 or higher:

```bash
npm install -g @github/copilot
```

On macOS or Linux with Homebrew:

```bash
brew install copilot-cli
```

You can then start an interactive session with:

```bash
copilot
```

On first use, if you are not logged in, Copilot will ask for authentication.

---

## 22. Copilot CLI Usage Examples

### Ask about a bug

```bash
copilot
```

Then, within the session:

```text
Estoy ejecutando npm test y aparece este error. Explícalo paso a paso y dime cómo investigarlo.
```

### Request summary of changes

```bash
copilot -p "Resume los cambios actuales del repositorio y sugiere un mensaje de commit" --allow-tool='shell(git)'
```

### Request structure analysis

```text
Analiza la estructura de este proyecto y dime dónde debería añadir un nuevo endpoint de productos.
```

---

## 23. Precautions with Copilot CLI and agents

When a tool can execute commands or modify files, you have to be more careful.

Good practices:

- Do not use options that allow any command to be executed without review.
- Read the changes before accepting them.
- Do not allow unnecessary access to secrets or credentials.
- Work in a separate branch.
- Use Git to be able to revert changes.
- Run tests after each major modification.
- Do not delegate critical changes without human review.

---

# Part 6. Recommended Advanced Flow

## 24. Complete Flow Example with Copilot

Imagine you want to add a new functionality: product management in an API.

### Step 1. Request project analysis

```text
Analiza este proyecto y dime dónde encajaría una nueva funcionalidad de gestión de productos.
No modifiques archivos.
```

### Step 2. Request implementation plan

```text
Propón un plan para añadir gestión de productos.
Incluye rutas, controladores, servicios, datos de ejemplo y tests.
No escribas código todavía.
```

### Step 3. Create or review custom instructions

```text
Revisa el archivo .github/copilot-instructions.md y dime si falta alguna instrucción para este proyecto.
```

### Step 4. Implement the first step

```text
Implementa únicamente las rutas de productos.
No implementes todavía la lógica de negocio.
```

### Step 5. Implement the logic

```text
Ahora crea el servicio de productos con datos en memoria.
Incluye funciones para listar, buscar por id, crear y eliminar.
```

### Step 6. Create tests

```text
Genera tests unitarios para el servicio de productos usando Jest.
Incluye casos normales y casos límite.
```

### Step 7. Review changes

```text
Revisa los cambios realizados.
Busca posibles bugs, inconsistencias de estilo y tests ausentes.
```

### Step 8. Create documentation

```text
Actualiza el README con una sección que explique los endpoints de productos.
Incluye ejemplos de petición y respuesta.
```

### Step 9. Prepare commit or pull request

```text
Genera un mensaje de commit claro para estos cambios.
Después genera un resumen breve para una pull request.
```

---

## 25. How to evaluate if Copilot has worked well

After an advanced task, check:

- Has the project structure been respected?
- Have the personalized instructions been followed?
- Are there changes out of scope?
- Have unnecessary dependencies been added?
- Are the names consistent?
- Are the tests useful?
- Does the documentation match the code?
- Is the project still running?
- Are there security risks?
- Can I explain the generated code?

If you can't explain the code, you shouldn't integrate it yet.

---

## 26. Compilation prompts of the topic

### Analyze project

```text
Analiza la estructura de este proyecto y explícame cómo está organizado.
No modifiques archivos.
```

### Plan functionality

```text
Quiero implementar [funcionalidad].
Antes de escribir código, propón un plan paso a paso.
Indica archivos a modificar, archivos nuevos, riesgos y pruebas necesarias.
```

### Create instructions

```text
Crea un archivo .github/copilot-instructions.md para este proyecto.
Incluye stack, estilo de código, estructura, comandos, testing y restricciones.
```

### Review instructions

```text
Revisa estas instrucciones personalizadas.
Dime si son claras, si hay contradicciones y qué añadirías para mejorar la calidad del código generado.
```

### Prepare PR

```text
Genera un resumen de pull request para estos cambios.
Incluye objetivo, cambios principales, pruebas realizadas y aspectos a revisar.
```

### Review changes
```text
Revisa estos cambios como si fueras un revisor senior.
Prioriza bugs, seguridad, mantenibilidad y tests.
Evita comentarios menores de estilo.
```

---

## 27. Summary

In this topic we have seen how to use GitHub Copilot in advanced workflows:

- analysis of complete projects;
- functionality planning;
- structure generation;
- personalized instructions;
- commits and pull requests;
- assisted code review;
- agents;
- Copilot CLI.

The main idea is that the larger the task, the more important it is to work in phases.

It is not advisable to ask:

```text
Haz todo el proyecto.
```

It is advisable to ask:

```text
Analiza, planifica, divide, implementa una parte, prueba, revisa y documenta.
```

Copilot is most powerful when clearly directed.

---

## 28. Recommended documentation

- GitHub Docs — GitHub Copilot.
- GitHub Docs — Custom instructions.
- GitHub Docs — Copilot CLI.
- GitHub Docs — Copilot coding agent.
- GitHub Docs — Pull request summaries.
- GitHub Docs — Copilot code review.
