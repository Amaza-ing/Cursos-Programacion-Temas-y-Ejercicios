# Prompting Frameworks with Copilot

## AI with Copilot

This material is designed both for development profiles and for administrative, management, support, documentation or internal coordination profiles.

The main idea is to learn how to ask Copilot better. A good prompt isn't about writing a lot, but about giving the AI the right information: what you need, why you need it, what context you work in, what format it should answer in and what limits it should respect.

---

## Learning objectives

By the end of this class, you'll be able to:

- Understand what prompting frameworks are for in a professional environment.
- Choose the right framework for each type of task.
- Apply prompting frameworks to development, documentation, analysis, communication and administration tasks.
- Create prompts that are clearer, reusable and easy to improve.
- Critically review Copilot's answers before using them at work.

---

## 1) What is a prompting framework?

A prompting framework is a structure that helps us write clearer instructions for an AI.

Instead of writing a vague request like:

```text
Hazme un resumen de esto.
```

we can write a more useful request:

```text
Actúa como asistente de documentación interna.
Resume el siguiente texto en 5 ideas clave.
El objetivo es que una persona del equipo pueda entender rápidamente el estado del proyecto.
Usa un tono profesional, claro y directo.
Devuelve la respuesta en formato de lista.
```

The second option works better because it includes context, goal, role, format and quality criteria.

---

## 2) Why use frameworks in a consulting firm?

In a consulting firm, tasks tend to be varied: software development, customer support, documentation, report writing, meetings, project tracking, data analysis, sales proposals or administrative tasks.

Prompting frameworks help you:

- **Save time:** They reduce trial and error when you ask Copilot for tasks.
- **Improve quality:** The answers are more complete and closer to what we need.
- **Standardize work:** Several people can use similar structures for similar tasks.
- **Reduce ambiguity:** Copilot understands the context and the expected format better.
- **Improve the review:** It's easier to see whether or not the answer meets the goal.
- **Work better with clients:** They help prepare clearer communications, documentation and deliverables.

---

## 3) Best practices before using Copilot

Before pasting information into Copilot, remember these recommendations:

1. **Don't share confidential information unless you're authorized to.** Avoid real customer data, credentials, contracts, sensitive financial information or personal data.
2. **Anonymize the examples.** Use fictional names such as `Cliente A`, `Proyecto X`, `Usuario 1` or `Empresa Demo`.
3. **Always check the answer.** Copilot may make mistakes, make up data or misunderstand the request.
4. **Don't copy code without understanding it.** Ask for explanations if something isn't clear.
5. **State the output format.** Table, list, steps, email, checklist, executive summary, commented code, etc.
6. **Give enough context.** The clearer the situation, the better the answer.
7. **Ask for a second version if needed.** You can ask for it to be shorter, more formal, more technical or simpler.

---
## 4) How to choose the right framework

Not all frameworks serve the same purpose. You can choose them depending on the task at hand.

| Need | Recommended framework |
| ----------------------------------------------------------- | --------------------- |
| Explain a technical or functional concept | RACE, CREO |
| Ask for a quick, direct task | TAG |
| Generate documentation, emails or materials based on an example | CARE |
| Create an activity, procedure or deliverable step by step | APE, RISE |
| Design a more complete, fine-tuned prompt | CREATE |
| Analyze a problem or blocker | PAIN |
| Plan a task, meeting, delivery or mini-project | COAST |
| Ask for a complete, structured solution | ROSES |

---

# 5) Prompting frameworks with professional examples

---

## 5.1 RACE Framework

**RACE = Role – Action – Context – Explanation**

- **Role:** The role Copilot should take on.
- **Action:** What it should do.
- **Context:** The situation in which the answer will be used.
- **Explanation:** How it should explain or justify the answer.

### When to use it

Use RACE when you need a clear explanation, especially if you want Copilot to adapt the technical level to the audience.

### Example for development

```text
Role: Actúa como un desarrollador senior especializado en JavaScript.
Action: Explícame qué hace esta función y detecta posibles mejoras.
Context: Soy un desarrollador junior que está revisando código de un proyecto interno de una consultora.
Explanation: Explica primero la lógica general, después los posibles problemas y finalmente propón una versión mejorada con comentarios claros.

Código:
[Pega aquí el código, eliminando datos sensibles]
```

### Example for administration

```text
Role: Actúa como asistente administrativo de una consultora.
Action: Explícame de forma sencilla este procedimiento interno.
Context: Tengo que seguir el proceso para registrar gastos de viaje de un equipo de proyecto.
Explanation: Divide la explicación en pasos claros, indica qué documentos necesito y señala errores comunes que debería evitar.

Procedimiento:
[Pega aquí el texto del procedimiento]
```

### Reusable template

```text
Role: Actúa como [rol].
Action: Necesito que [tarea].
Context: La situación es [contexto].
Explanation: Explica la respuesta de forma [nivel de detalle, tono o formato].
```

---

## 5.2 CARE Framework

**CARE = Context – Action – Result – Example**

- **Context:** Starting situation.
- **Action:** Specific task.
- **Result:** Expected result.
- **Example:** An example or reference of the type of answer you want.

### When to use it

Use CARE when you want Copilot to generate a practical result with a clear example of the expected style.

### Example for development

```text
Context: Estoy documentando una API interna para que otros desarrolladores puedan usarla.
Action: Redacta una explicación breve del endpoint POST /tickets.
Result: Quiero que cualquier miembro del equipo entienda qué hace el endpoint, qué datos recibe y qué devuelve.
Example: Usa este estilo: "Este endpoint permite crear un nuevo ticket de soporte. Recibe los datos principales del ticket y devuelve el identificador generado."

Información del endpoint:
- Método: POST
- Ruta: /tickets
- Campos: title, description, priority, assignedTeam
- Respuesta: id, status, createdAt
```

### Example for administration

```text
Context: Tengo que enviar un correo a un cliente para solicitar documentación pendiente.
Action: Redacta un email profesional y amable.
Result: El cliente debe entender claramente qué documentos faltan y cuál es la fecha límite.
Example: Usa un tono parecido a: "Te escribo para hacer seguimiento de la documentación pendiente..."

Documentos pendientes:
- Certificado fiscal
- Datos de facturación actualizados
- Confirmación del responsable de contacto
Fecha límite: viernes 15
```

### Reusable template

```text
Context: [Situación].
Action: [Qué debe hacer Copilot].
Result: [Qué resultado necesitas conseguir].
Example: [Ejemplo de estilo, estructura o contenido].
```

---

## 5.3 APE Framework

**APE = Action – Purpose – Execution**

- **Action:** What you want it to do.
- **Purpose:** What you need it for.
- **Execution:** How it should deliver it.

### When to use it

Use APE when the task is clear to you and you also want to define its purpose and the execution format.

### Example for development

```text
Action: Crea una lista de pruebas manuales para validar un formulario de registro.
Purpose: Necesito comprobar que el formulario funciona correctamente antes de pasarlo a QA.
Execution: Organiza la respuesta en una tabla con las columnas: caso de prueba, pasos, resultado esperado y prioridad.

Contexto del formulario:
- Campos: name, email, password, confirmPassword
- El email debe tener formato válido
- La contraseña debe tener mínimo 8 caracteres
```

### Example for administration

```text
Action: Prepara una checklist para organizar una reunión de seguimiento con un cliente.
Purpose: Quiero asegurarme de que no se olvida ninguna tarea antes, durante y después de la reunión.
Execution: Divide la checklist en tres apartados: antes de la reunión, durante la reunión y después de la reunión.
```

### Reusable template

```text
Action: [Tarea].
Purpose: [Objetivo de la tarea].
Execution: [Formato, estructura o pasos que debe seguir].
```

---

## 5.4 CREATE Framework

**CREATE = Character – Request – Examples – Adjustment – Type – Extras**

- **Character:** The role Copilot must take on.
- **Request:** Main request.
- **Examples:** Examples or references.
- **Adjustment:** Adjustments to tone, level or criteria.
- **Type:** Type of output.
- **Extras:** Additional elements.

### When to use it

Use CREATE when you need a more complete, polished answer tailored to a specific context.

### Example for development

```text
Character: Eres un mentor técnico de una consultora.
Request: Ayúdame a preparar una explicación sobre qué es una arquitectura MVC.
Examples: Puedes usar ejemplos sencillos relacionados con una aplicación de gestión de tareas.
Adjustment: El público tiene conocimientos básicos de programación, pero no experiencia profesional.
Type: Devuelve la explicación en formato markdown.
Extras: Añade una analogía, un ejemplo de carpetas y tres preguntas de repaso.
```

### Example for administration

```text
Character: Eres un consultor especializado en mejora de procesos administrativos.
Request: Ayúdame a mejorar este procedimiento de alta de proveedores.
Examples: El procedimiento debe ser claro, ordenado y fácil de seguir.
Adjustment: Usa lenguaje profesional, pero no demasiado técnico.
Type: Devuelve una versión reescrita con títulos y pasos numerados.
Extras: Añade una checklist final para validar que el alta está completa.

Procedimiento actual:
[Pega aquí el procedimiento]
```

### Reusable template

```text
Character: Eres [rol].
Request: Necesito que [petición principal].
Examples: Ten en cuenta estos ejemplos o referencias: [ejemplos].
Adjustment: Ajusta la respuesta a [tono, nivel, longitud o restricciones].
Type: Devuelve el resultado en formato [tipo de salida].
Extras: Añade [elementos adicionales].
```

---
## 5.5 TAG Framework

**TAG = Task – Action – Goal**

- **Task:** General task.
- **Action:** Specific action.
- **Goal:** Final goal.

### When to use it

Use TAG for quick, direct requests. It's useful when the task doesn't need much context.

### Example for development

```text
Task: Revisión rápida de código.
Action: Detecta errores evidentes y sugiere mejoras de legibilidad.
Goal: Dejar el código más claro antes de subirlo al repositorio.

Código:
[Pega aquí el código]
```

### Example for administration

```text
Task: Resumen de reunión.
Action: Convierte estas notas en un resumen ordenado con acuerdos y tareas pendientes.
Goal: Enviar el resumen al equipo de proyecto.

Notas:
[Pega aquí las notas de la reunión]
```

### Reusable template

```text
Task: [Tarea general].
Action: [Acción concreta].
Goal: [Objetivo final].
```

---

## 5.6 CREO Framework

**CREO = Context – Request – Explanation – Outcome**

- **Context:** Situation.
- **Request:** Request.
- **Explanation:** Type of explanation you need.
- **Outcome:** Expected final result.

### When to use it

Use CREO when you want Copilot not only to generate an answer, but also to explain why it's proposing that answer.

### Example for development

```text
Context: Estoy aprendiendo a usar Git en un equipo de desarrollo.
Request: Explícame la diferencia entre git merge y git rebase.
Explanation: Usa un lenguaje sencillo, con un ejemplo práctico y sin asumir conocimientos avanzados.
Outcome: Al final, añade una recomendación sobre cuándo usar cada opción en un proyecto de consultora.
```

### Example for administration

```text
Context: Estoy revisando una hoja de cálculo con tareas de varios proyectos.
Request: Propón una forma de organizar mejor las columnas.
Explanation: Explica por qué cada columna sería útil.
Outcome: Devuelve una tabla con las columnas recomendadas y una breve descripción de cada una.
```

### Reusable template

```text
Context: [Situación].
Request: [Qué necesitas].
Explanation: [Cómo debe explicarlo].
Outcome: [Resultado final esperado].
```

---

## 5.7 RISE Framework

**RISE = Role – Input – Steps – Execution**

- **Role:** The role Copilot must take on.
- **Input:** Input information.
- **Steps:** Steps it must follow.
- **Execution:** How it should deliver the answer.

### When to use it

Use RISE for step-by-step processes, especially when you want Copilot to work in an orderly way.

### Example for development

```text
Role: Actúa como un desarrollador senior revisando una incidencia.
Input: La aplicación muestra un error 500 al enviar un formulario.
Steps:
1. Enumera posibles causas.
2. Indica qué archivos o logs revisaría.
3. Propón pruebas para aislar el problema.
4. Sugiere una solución inicial.
Execution: Devuelve la respuesta como una guía de diagnóstico paso a paso.
```

### Example for administration

```text
Role: Actúa como coordinador de operaciones de una consultora.
Input: Tenemos que preparar la incorporación de una nueva persona al equipo.
Steps:
1. Lista la documentación necesaria.
2. Define tareas para RR. HH., IT y responsable de proyecto.
3. Propón un calendario de incorporación para la primera semana.
4. Añade una checklist final.
Execution: Presenta la respuesta en formato tabla.
```

### Reusable template

```text
Role: Actúa como [rol].
Input: La información de partida es [datos o situación].
Steps: Sigue estos pasos: [pasos].
Execution: Devuelve la respuesta en formato [formato].
```

---

## 5.8 PAIN Framework

**PAIN = Problem – Action – Information – Next Steps**

- **Problem:** Problem or blocker.
- **Action:** What Copilot should do.
- **Information:** Available information or missing information.
- **Next Steps:** Recommended next actions.

### When to use it

Use PAIN when there's a problem that you need to analyze, unblock or turn into an action plan.

### Example for development

```text
Problem: El equipo tarda demasiado en revisar pull requests y se acumulan cambios pendientes.
Action: Analiza posibles causas y propón mejoras.
Information: Somos 5 desarrolladores, usamos GitHub y solemos revisar los PR al final del día.
Next Steps: Dame un plan de mejora con acciones concretas para la próxima semana.
```

### Example for administration

```text
Problem: Se están retrasando varias facturas porque la información llega incompleta.
Action: Identifica posibles puntos de fallo en el proceso.
Information: Los datos suelen llegar por email, cada proyecto usa un formato distinto y a veces falta el número de pedido.
Next Steps: Propón un procedimiento sencillo para reducir errores y una plantilla de solicitud de datos.
```

### Reusable template

```text
Problem: [Problema].
Action: [Qué quieres que haga Copilot].
Information: [Datos disponibles o información que falta].
Next Steps: [Qué tipo de próximos pasos necesitas].
```

---

## 5.9 COAST Framework

**COAST = Context – Objective – Actions – Scenario – Task**

- **Context:** General situation.
- **Objective:** The objective you want to achieve.
- **Actions:** Actions that must be taken into account.
- **Scenario:** Scenario or conditions.
- **Task:** Final task for Copilot.

### When to use it

Use COAST to plan tasks, meetings, deliveries, processes or small projects.

### Example for development

```text
Context: Tenemos que preparar la entrega de una nueva funcionalidad para un cliente.
Objective: Llegar a la demo con la funcionalidad probada y una explicación clara.
Actions: Revisar código, probar casos principales, preparar datos de ejemplo y documentar cambios.
Scenario: El equipo tiene tres días y participan desarrollo, QA y responsable funcional.
Task: Crea un plan de trabajo dividido por días, responsables y entregables.
```

### Example for administration

```text
Context: La consultora va a organizar una sesión interna de formación sobre Copilot.
Objective: Conseguir que el personal administrativo aprenda a usar prompts básicos en su trabajo diario.
Actions: Preparar ejemplos, ejercicios, material de apoyo y una encuesta final.
Scenario: La sesión dura 2 horas y los asistentes tienen niveles muy distintos.
Task: Diseña una agenda de la sesión con tiempos, actividades y materiales necesarios.
```

### Reusable template

```text
Context: [Situación general].
Objective: [Objetivo].
Actions: [Acciones que deben incluirse].
Scenario: [Condiciones, restricciones o participantes].
Task: [Tarea concreta que debe realizar Copilot].
```

---

## 5.10 ROSES Framework

**ROSES = Role – Objective – Scenario – Expected solution – Steps**

- **Role:** The role Copilot takes on.
- **Objective:** Main objective.
- **Scenario:** Specific scenario.
- **Expected solution:** Type of solution expected.
- **Steps:** Steps it must follow or include.

### When to use it

Use ROSES to ask for more complete, structured and professional solutions.

### Example for development

```text
Role: Actúa como arquitecto de software en una consultora.
Objective: Proponer una estructura inicial para una aplicación web de gestión de incidencias.
Scenario: El proyecto será desarrollado por un equipo junior usando frontend, backend y base de datos.
Expected solution: Una propuesta clara de módulos, carpetas principales y responsabilidades.
Steps:
1. Describe la estructura general.
2. Explica la responsabilidad de cada módulo.
3. Indica buenas prácticas básicas.
4. Añade riesgos habituales en proyectos junior.
```

### Example for administration

```text
Role: Actúa como responsable de operaciones de una consultora.
Objective: Mejorar el proceso de seguimiento de tareas administrativas.
Scenario: El equipo usa hojas de cálculo, email y reuniones semanales.
Expected solution: Un sistema sencillo de seguimiento que no requiera herramientas nuevas.
Steps:
1. Propón una estructura de hoja de seguimiento.
2. Define estados de tarea.
3. Sugiere una dinámica semanal de revisión.
4. Añade una plantilla breve para informar avances.
```

### Reusable template

```text
Role: Actúa como [rol].
Objective: El objetivo es [objetivo].
Scenario: El escenario es [situación].
Expected solution: Espero una solución con [características].
Steps: Incluye estos pasos: [pasos].
```

---

# 6) Checklist for writing better prompts

Before sending a prompt to Copilot, check whether you've included:

- [ ] What you want it to do.
- [ ] What you need it for.
- [ ] What role it should take on.
- [ ] What context it should know.
- [ ] What output format you want.
- [ ] What level of detail you need.
- [ ] What tone it should use.
- [ ] What information it should avoid or protect.
- [ ] What examples it can follow.
- [ ] How you'll know whether the answer is useful.

---

# 7) Common mistakes when using Copilot

## Mistake 1: Asking for something too generic

```text
Explícame Git.
```

Better:

```text
Explícame Git para una persona que empieza a trabajar en una consultora tecnológica.
Céntrate en commit, branch, merge y pull request.
Usa ejemplos sencillos y termina con una tabla resumen.
```

## Mistake 2: Not stating the format

```text
Organiza estas tareas.
```

Better:

```text
Organiza estas tareas en una tabla con las columnas: tarea, responsable, prioridad, fecha límite y estado.
```

## Mistake 3: Not stating the audience

```text
Redacta una explicación sobre este proyecto.
```

Better:

```text
Redacta una explicación sobre este proyecto para una persona del área administrativa que no tiene conocimientos técnicos.
Usa lenguaje claro y evita jerga de programación.
```

## Mistake 4: Not asking for a critical review

```text
Crea este procedimiento.
```

Better:

```text
Crea este procedimiento y después añade una sección final con posibles riesgos, puntos ambiguos y mejoras recomendadas.
```

---

# 8) Key takeaways

- A good prompt gives context, goal, format and limits.
- Frameworks help turn vague requests into clear instructions.
- You don't always need to use the longest framework: choose according to the task.
- Copilot is useful for generating drafts, ideas, explanations, documentation and work plans.
- Copilot's answers should always be reviewed before being used professionally.
- In a consulting firm, confidentiality and the quality of information are as important as speed.

---

# 9) Quick overview of frameworks

| Framework | Meaning | Best for |
| --------- | ------------------------------------------------------ | ---------------------------------- |
| RACE | Role, Action, Context, Explanation | Clear explanations |
| CARE | Context, Action, Result, Example | Practical results based on an example |
| APE | Action, Purpose, Execution | Tasks with a goal and a format |
| CREATE | Character, Request, Examples, Adjustment, Type, Extras | Complete, tailored prompts |
| TAG | Task, Action, Goal | Quick requests |
| CREO | Context, Request, Explanation, Outcome | Explanations with a final result |
| RISE | Role, Input, Steps, Execution | Step-by-step processes |
| PAIN | Problem, Action, Information, Next Steps | Problem analysis |
| COAST | Context, Objective, Actions, Scenario, Task | Planning |
| ROSES | Role, Objective, Scenario, Expected solution, Steps | Structured solutions |

---

## Closing

The best way to learn prompting is to practice. Start with simple prompts, review Copilot's answer and gradually improve your instructions. If the answer isn't helpful, it doesn't necessarily mean that Copilot can't help you: it often means that the prompt needs more context, more limits or a clearer format.
