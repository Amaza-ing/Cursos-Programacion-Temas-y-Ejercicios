# Topic 01 — Introduction to generative AI and the Copilot ecosystem

## 1. Goal of the topic

In this first topic, we're going to introduce the fundamental concepts you need to understand what Copilot is, how it relates to generative artificial intelligence and how it can be used in professional contexts.

The goal isn't to learn a specific tool in depth yet, but to understand the general logic behind Copilot and start working with a key idea: **generative AI doesn't replace professional judgment; it expands your capacity to work when it's used with supervision and critical thinking**.

By the end of this topic, you should be able to:

- Explain what generative artificial intelligence is.
- Understand what a language model is.
- Tell the difference between a traditional search and an AI-generated answer.
- Understand what Copilot is as a family of tools.
- Identify Copilot use cases in development, productivity, analysis and automation.
- Recognize basic risks: errors, hallucinations, privacy, biases and overreliance.
- Write your first prompts in a clear and useful way.

---

## 2. What is generative artificial intelligence

**Generative artificial intelligence** is a branch of artificial intelligence capable of producing new content from an initial instruction or input.

That content can take many forms:

- Text.
- Code.
- Images.
- Summaries.
- Tables.
- Presentations.
- Emails.
- Technical documentation.
- Solution proposals.
- Ideas to automate processes.

Generative AI doesn't just search for an answer that has already been written. Instead, it generates a new answer based on the context it receives and the patterns it learned during its training.

For example, a generative AI tool may receive a request like this:

```text
Explícame qué es una API REST con un ejemplo sencillo para una persona que está aprendiendo desarrollo web.
```

And it can return an explanation adapted to the requested level.

It may also receive a technical request like this:

```text
Crea una función en JavaScript que reciba una lista de productos y devuelva solo aquellos cuyo precio sea mayor que 100.
```

And it can generate a possible implementation:

```javascript
function filterExpensiveProducts(products) {
  return products.filter((product) => product.price > 100);
}
```

This type of tool can be very useful, but it's important to remember that **generating an answer doesn't guarantee that the answer is correct**.

---

## 3. What is a language model

Many current generative AI tools are based on **language models**.

A language model is a system trained to process and generate text. To do this, it learns patterns from large amounts of information. Thanks to that training, it can predict which words, code snippets or structures are most likely in a given context.

When we use a tool like Copilot, we usually write an instruction. That instruction is called a **prompt**.

The model analyzes the prompt, interprets the user's intention and generates an answer.

The general process would be:

```text
Usuario → Prompt → Modelo de IA → Respuesta generada → Revisión humana
```

The last part is essential. The answer must be reviewed by a person, especially if it affects code, data, business decisions, important documents or sensitive information.

---

## 4. Difference between traditional search and generative AI

A traditional search tries to find existing information. For example, if we search the internet for:

```text
qué es GitHub Copilot
```

The search engine will show us links to pages that already exist.

A generative AI tool, on the other hand, can create a new answer from a request like this:

```text
Explícame qué es GitHub Copilot en 5 líneas, con un ejemplo práctico para una persona que programa en JavaScript.
```

The main difference is this:

| Traditional search | Generative AI |
| --------------------------------------- | -------------------------------------------------- |
| Finds existing content | Generates new content |
| Returns links or snippets | Returns an elaborate answer |
| Requires the user to compare sources | Can synthesize, explain or transform content |
| Usually shows the original source | Can be wrong if it isn't reviewed |

That's why, in a professional context, we shouldn't treat generative AI as an infallible source. We should treat it as a **work assistant**.

---

## 5. What is Copilot

The term **Copilot** refers to different artificial intelligence tools created for or built into the Microsoft and GitHub ecosystem.

The general idea of Copilot is to act as a **smart assistant** that works alongside the user.

Depending on the specific tool, Copilot can help you:

- Write code.
- Explain existing code.
- Create tests.
- Refactor functions.
- Write emails.
- Summarize documents.
- Analyze data.
- Generate presentations.
- Prepare meetings.
- Create conversational agents.
- Automate workflows.

However, not all Copilots serve the same purpose. Throughout the course, we'll mainly distinguish between:

- **GitHub Copilot**, focused on software development.
- **Microsoft Copilot**, aimed at general assistance, productivity and everyday work.
- **Microsoft 365 Copilot**, built into applications such as Word, Excel, PowerPoint, Outlook or Teams.
- **Copilot Studio**, aimed at creating agents and conversational automations.

---

## 6. Copilot as an assistant, not as a substitute

A simple way to understand Copilot is to compare it to an assistant who works with you.

It can help you move faster, but it shouldn't make critical decisions without supervision.

Copilot can:

- Propose a first version of a function.
- Suggest a document structure.
- Summarize a long conversation.
- Help detect errors in code.
- Explain a difficult concept.
- Propose an automation flow.

But the user must:

- Check whether the result is correct.
- Check whether the code works.
- Validate whether the information is reliable.
- Adapt the result to the real context.
- Make sure that no sensitive data is shared.
- Decide whether the proposal fits the project's goals.

The basic rule of the course will be:

> Copilot can propose. The person decides, reviews and validates.

---

## 7. What is a prompt

A **prompt** is the instruction we write to ask a generative AI tool for something.

A prompt can be very simple:

```text
Resume este texto.
```

But we will usually get better results if we give more context:

```text
Resume este texto en 5 líneas, manteniendo un tono profesional y destacando solo las ideas principales.
```

In software development, we can also ask for more specific things:

```text
Genera una función en JavaScript que reciba un array de usuarios y devuelva solo los usuarios activos. Usa nombres de variables en inglés y añade comentarios breves en español.
```

A good prompt usually includes:

1. **Context**: what we're doing.
2. **Goal**: what we want to achieve.
3. **Constraints**: what the answer must respect.
4. **Format**: how we want to receive the result.
5. **Level of detail**: brief explanation, step by step, table, code, etc.

---

## 8. Example of an unhelpful prompt and an improved prompt

### Unhelpful prompt

```text
Hazme una función.
```

This prompt is too ambiguous. It doesn't state the language, the goal, the input data, the output data or any constraints.

### Improved prompt

```text
Crea una función en JavaScript llamada calculateTotalPrice.
La función debe recibir un array de productos.
Cada producto tendrá las propiedades name, price y quantity.
La función debe devolver el precio total del pedido.
Usa nombres de variables en inglés y añade comentarios breves en español.
```

A possible answer would be:

```javascript
function calculateTotalPrice(products) {
  // Recorremos los productos y acumulamos el precio total
  return products.reduce((total, product) => {
    return total + product.price * product.quantity;
  }, 0);
}
```

This second prompt works better because it includes context, a goal, the data structure and formatting criteria.

---

## 9. How to work step by step with a generative AI tool

When we use Copilot or any generative AI tool, it's a good idea to follow an orderly process.

### Step 1. Clearly define what you need

Before writing the prompt, think about what you want to achieve.

Asking:

```text
Explícame este código.
```

isn't the same as asking:

```text
Explícame este código paso a paso, como si estuviera aprendiendo JavaScript desde cero.
```

The second request is more precise and will probably generate a more useful answer.

### Step 2. Give context

The more relevant context you provide, the better the answer will be.

For example:

```text
Estoy creando una aplicación web sencilla con JavaScript. Tengo una lista de tareas y quiero mostrar solo las que están completadas.
```

### Step 3. State the expected result

You can specify whether you want an explanation, code, a table, a list of steps or a review.

```text
Devuélveme la respuesta en forma de pasos numerados.
```

```text
Devuélveme solo el código, sin explicación adicional.
```

```text
Primero explícame el problema y después propón una solución.
```

### Step 4. Add constraints

Constraints help the answer fit your needs better.

Examples:

```text
No uses librerías externas.
```

```text
Usa funciones flecha.
```

```text
No cambies el nombre de las variables existentes.
```

```text
Mantén la estructura actual del proyecto.
```

### Step 5. Check the answer

Never accept an important answer without reviewing it.

In code, you should check:

- Whether it compiles.
- Whether it runs.
- Whether it really solves the problem.
- Whether it follows the project's style.
- Whether it introduces vulnerabilities.
- Whether it generates unnecessarily complex code.

In text, you should check:

- Whether the information is correct.
- Whether the tone is appropriate.
- Whether important data is missing.
- Whether there are questionable claims.
- Whether anything has been made up.

### Step 6. Iterate

The first answer doesn't have to be the final one. You can ask for improvements.

Examples:

```text
Hazlo más sencillo.
```

```text
Explícalo con un ejemplo más básico.
```

```text
Refactoriza la solución para que sea más legible.
```

```text
Añade control de errores.
```

```text
Genera una versión alternativa usando programación funcional.
```

---

## 10. Copilot use cases

Copilot can be applied in different professional areas.

### 10.1 Software development

In development, Copilot can help you:

- Generate functions.
- Complete code snippets.
- Explain existing code.
- Create technical documentation.
- Refactor code.
- Propose tests.
- Detect possible errors.
- Create scripts.
- Generate SQL queries.
- Help with terminal commands.
- Create continuous integration workflows.

Prompt example:

```text
Revisa esta función y dime si puede fallar con valores nulos o arrays vacíos. Después propón una versión más segura.
```

### 10.2 Productivity

In productivity, Copilot can help you:

- Write emails.
- Summarize documents.
- Turn notes into reports.
- Prepare presentations.
- Create outlines.
- Rewrite texts with another tone.
- Extract pending tasks from a conversation.

Prompt example:

```text
Convierte estas notas de reunión en un resumen profesional con tres apartados: decisiones tomadas, tareas pendientes y próximos pasos.
```

### 10.3 Automation

In automation, Copilot can help you:

- Design workflows.
- Create conversational agents.
- Connect information from different sources.
- Generate instructions for repetitive processes.
- Propose integrations between tools.

Prompt example:

```text
Diseña un flujo de automatización para recibir solicitudes de soporte, clasificarlas por prioridad y enviar una respuesta inicial al usuario.
```

### 10.4 Analysis

In analysis, Copilot can help you:

- Interpret tables.
- Generate formulas.
- Create data summaries.
- Detect patterns.
- Propose visualizations.
- Explain results.

Prompt example:

```text
Analiza esta tabla de ventas y señala tres tendencias relevantes, posibles causas y recomendaciones de acción.
```

---

## 11. Risks and limitations of generative AI

Copilot can be very useful, but it also has limits.

### 11.1 It can be wrong

An AI-generated answer can seem right and be wrong.

This is especially dangerous because the answer is often worded confidently.

For example, it can:

- Make up a function that doesn't exist.
- Use an API incorrectly.
- Mix up versions of a library.
- Propose code that doesn't compile.
- Give an incomplete explanation.

### 11.2 It can generate insecure code

The generated code may work and still not be secure.

It may have problems like:

- Lack of data validation.
- Exposure of sensitive information.
- Incorrect use of credentials.
- Vulnerable queries.
- Weak error handling.

### 11.3 It can depend too much on the visible context

Copilot answers based on the context it has available. If the context is incomplete, it may generate an incomplete answer.

For example, if it only sees an isolated function and doesn't know the full architecture of the application, it may propose a solution that doesn't fit well with the project.

### 11.4 It can reinforce bad practices

If a project already has messy code, Copilot can imitate that style.

That's why it's a good idea to define standards:

- Naming conventions.
- Folder structure.
- How tests are written.
- Documentation style.
- Security rules.

### 11.5 It can create dependency

One of the most important risks is using Copilot without understanding what it proposes.

Copilot should accelerate learning and work, not replace understanding.

---

## 12. Step-by-step guide: first interaction with Copilot

This guide works for any Copilot-type generative AI tool.

### Step 1. Write a simple request

Example:

```text
Explícame qué es la inteligencia artificial generativa en un lenguaje sencillo.
```

### Step 2. Add context

Now improve the request:

```text
Explícame qué es la inteligencia artificial generativa en un lenguaje sencillo, pensando en personas que trabajan en desarrollo web y nunca han usado herramientas de IA.
```

### Step 3. Ask for a specific format

```text
Explícame qué es la inteligencia artificial generativa en un lenguaje sencillo. Usa una introducción breve, una lista de usos profesionales y un ejemplo aplicado a desarrollo web.
```

### Step 4. Ask for an improvement

```text
Haz la explicación más práctica y añade un ejemplo de prompt para generar una función en JavaScript.
```

### Step 5. Check the result

Check:

- Is the explanation correct?
- Is the example easy to understand?
- Does the code work?
- Has anything been made up?
- Is any important warning missing?

### Step 6. Adjust the prompt

If the result doesn't fit, modify your instruction:

```text
La explicación sigue siendo demasiado general. Reescríbela como material de clase para alumnado principiante, con ejemplos claros y sin tecnicismos innecesarios.
```

---

## 13. Recommendations for writing good prompts

A good prompt usually answers these questions:

| Question | Example |
| ----------------------- | ------------------------------------------------------------ |
| What do I want to achieve?  | Create a function, summarize a text, explain a concept |
| In what context?       | Web project, business document, meeting, data table |
| What constraints are there? | No external libraries, formal tone, maximum 10 lines |
| What format do I want?    | Code, table, numbered steps, summary, checklist |
| What level do I need?    | Beginner, intermediate, advanced, technical, executive |

General template:

```text
Estoy trabajando en [contexto].
Necesito [objetivo].
Ten en cuenta estas restricciones: [restricciones].
Devuélveme la respuesta en formato [formato].
El nivel debe ser [nivel].
```

Applied example:

```text
Estoy trabajando en una aplicación sencilla de gestión de tareas con JavaScript.
Necesito una función que filtre las tareas completadas.
Ten en cuenta que cada tarea tiene las propiedades title, completed y priority.
No uses librerías externas.
Devuélveme solo el código con comentarios breves en español.
```

---

## 14. Best practices from day one

When working with Copilot, follow these recommendations:

1. **Don't paste sensitive information** if you're not sure about the environment, the license and the applicable privacy policy.
2. **Don't accept code without reading it**.
3. **Run and test the generated code**.
4. **Ask for explanations when you don't understand a solution**.
5. **Break big problems into small steps**.
6. **Don't use Copilot to hide a lack of understanding**.
7. **Check the version of the tools or libraries**.
8. **Adapt the result to your project's style**.
9. **Use specific prompts**.
10. **Always keep your professional judgment**.

---

## 15. Summary of the topic

In this topic, we've seen that generative AI lets us create new content based on instructions given by the user. Copilot belongs to this type of tool, but it isn't a single tool: it's an ecosystem with different applications aimed at development, productivity, automation and agent creation.

The fundamental idea is that Copilot should be understood as an assistant. It can speed up tasks, propose solutions and help you understand information, but it shouldn't replace human review.

To get good results, you need to learn how to write good prompts, provide context, define constraints and always review the answers generated.

---

## 16. Final checklist

Before moving on to the next topic, make sure you can answer these questions:

- What is generative AI?
- What is a language model?
- What is the difference between searching for information and generating an answer?
- What is a prompt?
- What types of tasks can Copilot do?
- Why is it important to review its answers?
- What are the risks of using Copilot without supervision?
- What elements should a good prompt have?

---

## 17. Recommended official documentation

- GitHub Copilot documentation: https://docs.github.com/copilot
- GitHub Copilot features: https://docs.github.com/en/copilot/get-started/features
- Microsoft Copilot: https://www.microsoft.com/microsoft-copilot
- Microsoft 365 Copilot: https://learn.microsoft.com/en-us/microsoft-365-copilot/
- Microsoft Copilot Studio: https://learn.microsoft.com/en-us/microsoft-copilot-studio/
