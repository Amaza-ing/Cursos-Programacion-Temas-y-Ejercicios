# Topic 01 — Introduction to generative AI and the Copilot ecosystem

## 1. Objective of the topic

In this first topic we are going to introduce the fundamental concepts that allow us to understand what Copilot is, what its relationship is with generative artificial intelligence and how it can be used in professional contexts.

The goal is not to learn a specific tool in depth yet, but to understand the general logic behind Copilot and start working with a key idea: **Generative AI does not replace professional judgment, but rather expands work capacity when used with supervision and critical sense**.

Upon finishing this topic you should be able to:

- Explain what generative artificial intelligence is.
- Understand what a language model is.
- Differentiate between a traditional search and an AI-generated response.
- Understand what Copilot is as a family of tools.
- Identify Copilot use cases in development, productivity, analysis and automation.
- Recognize basic risks: errors, hallucinations, privacy, biases and excessive dependency.
- Formulate your first prompts in a clear and useful way.

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

Generative AI is not limited to searching for an already written answer. Instead, it generates a new response based on the received context and the patterns it has learned during its training.

For example, a generative AI tool may receive a request like this:

```text
Explícame qué es una API REST con un ejemplo sencillo para una persona que está aprendiendo desarrollo web.
```

And it can return an explanation adapted to the requested level.

You may also receive a technical request like this:

```text
Crea una función en JavaScript que reciba una lista de productos y devuelva solo aquellos cuyo precio sea mayor que 100.
```

And you can generate a possible implementation:

```javascript
function filterExpensiveProducts(products) {
  return products.filter((product) => product.price > 100);
}
```

This type of tool can be very useful, but it is important to remember that **generating an answer does not mean guaranteeing that that answer is correct**.

---

## 3. What is a language model

Many current generative AI tools are based on **language models**.

A language model is a system trained to process and generate text. To do this, it learns patterns from large amounts of information. Thanks to that training, you can predict which words, code fragments or structures are most likely in a given context.

When we use a tool like Copilot, we typically write an instruction. That instruction is called **prompt**.

The model analyzes the prompt, interprets the user's intention and generates a response.

The general process would be:

```text
Usuario → Prompt → Modelo de IA → Respuesta generada → Revisión humana
```

The last part is essential. The response must be reviewed by a person, especially if it affects code, data, business decisions, important documents or sensitive information.

---

## 4. Difference between traditional search and generative AI
A traditional search attempts to locate existing information. For example, if we search on the Internet:

```text
qué es GitHub Copilot
```

The search engine will show us links to pages that already exist.

Instead, a generative AI tool can create a new response from a request like this:

```text
Explícame qué es GitHub Copilot en 5 líneas, con un ejemplo práctico para una persona que programa en JavaScript.
```

The main difference is this:

| Traditional search | Generative AI |
| --------------------------------------- | -------------------------------------------------- |
| Find existing content | Generate new content |
| Returns links or snippets | Returns a crafted response |
| Requires the user to compare sources | Can synthesize, explain or transform content |
| Usually shows the original source | You can make a mistake if you don't check it |

Therefore, in a professional context, we should not treat generative AI as an infallible source. We must treat her like a **work assistant**.

---

## 5. What is Copilot

The term **Copilot** is used to refer to different artificial intelligence tools created or integrated into the Microsoft and GitHub ecosystem.

The general idea of ​​Copilot is to act as an **intelligent assistant** that accompanies the user while they work.

Depending on the specific tool, Copilot can help:

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

However, not all Copilots serve the same purpose. Throughout the course we will mainly distinguish between:

- **GitHub Copilot**, focused on software development.
- **Microsoft Copilot**, aimed at general assistance, productivity and daily work.
- **Microsoft 365 Copilot**, integrated into applications such as Word, Excel, PowerPoint, Outlook or Teams.
- **Copilot Studio**, aimed at creating agents and conversational automations.

---

## 6. Copilot as an assistant, not as a substitute

A simple way to understand Copilot is to compare it to a helper who works with you.

It can help you move faster, but you shouldn't make critical decisions without supervision.

Copilot can:

- Propose a first version of a function.
- Suggest a document structure.
- Summarize a long conversation.
- Help detect errors in code.
- Explain a difficult concept.
- Propose an automation flow.

But the user must:

- Check if the result is correct.
- Check if the code works.
- Validate if the information is reliable.
- Adapt the result to the real context.
- Ensure that sensitive data is not shared.
- Decide if the proposal fits with the project objectives.

The basic rule of the course will be:

> Copilot can propose. The person decides, reviews and validates.

---

## 7. What is a prompt

A **prompt** is the instruction we write to request something from a generative AI tool.
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

1. **Context**: what we are doing.
2. **Objective**: what we want to achieve.
3. **Restrictions**: what the response must respect.
4. **Format**: how we want to receive the result.
5. **Level of detail**: brief explanation, step by step, table, code, etc.

---

## 8. Example of unhelpful prompt and improved prompt

### Prompt not very useful

```text
Hazme una función.
```

This prompt is too ambiguous. It does not indicate language, objective, input data, output data or restrictions.

### Prompt improved

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

This second prompt works better because it includes context, objective, data structure, and formatting criteria.

---

## 9. How to work step by step with a generative AI tool

When we use Copilot or any generative AI tool, it is advisable to follow an orderly process.

### Step 1. Clearly define what you need

Before writing the prompt, think about what you want to achieve.

It is not the same to ask:

```text
Explícame este código.
```

What to order:

```text
Explícame este código paso a paso, como si estuviera aprendiendo JavaScript desde cero.
```

The second request is more precise and will probably generate a more useful response.

### Step 2. Give context

The more relevant context you provide, the better the answer will be.

For example:

```text
Estoy creando una aplicación web sencilla con JavaScript. Tengo una lista de tareas y quiero mostrar solo las que están completadas.
```

### Step 3. Indicates the expected result

You can specify whether you want an explanation, code, a table, a list of steps, or a review.

```text
Devuélveme la respuesta en forma de pasos numerados.
```

```text
Devuélveme solo el código, sin explicación adicional.
```

```text
Primero explícame el problema y después propón una solución.
```

### Step 4. Add restrictions

Constraints help the answer better fit your needs.

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

- Yes it compiles.
- If it is executed.
- If it really solves the problem.
- If it respects the style of the project.
- If it introduces vulnerabilities.
- If it generates unnecessarily complex code.

In text, you must check:

- If the information is correct.
- If the tone is appropriate.
- If important data is missing.
- If there are doubtful claims.
- If something has been invented.

### Step 6. Iterate

The first answer does not have to be the definitive one. You can ask for improvements.

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

## 10. Copilot Use Cases

Copilot can be applied in different professional areas.

### 10.1 Software development

In development, Copilot can help:

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

In productivity, Copilot can help:

- Write emails.
- Summarize documents.
- Transform notes into reports.
- Prepare presentations.
- Create schemes.
- Rewrite texts with another tone.
- Extract pending tasks from a conversation.

Prompt example:

```text
Convierte estas notas de reunión en un resumen profesional con tres apartados: decisiones tomadas, tareas pendientes y próximos pasos.
```

### 10.3 Automation

In automation, Copilot can help:

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

In analysis, Copilot can help:

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

### 11.1 You can be wrong

An AI-generated answer can seem right and be wrong.

This is especially dangerous because many times the response is worded confidently.

For example, you can:

- Invent a function that does not exist.
- Using an API incorrectly.
- Confuse versions of a library.
- Propose code that does not compile.
- Give an incomplete explanation.

### 11.2 May generate unsafe code

The generated code may work, but may not be secure.

You may have problems like:

- Lack of data validation.
- Exposure of sensitive information.
- Incorrect use of credentials.
- Vulnerable queries.
- Weak error handling.

### 11.3 May depend too much on visible context

Copilot responds based on the context available to him. If the context is incomplete, it may generate an incomplete response.

For example, if you only see an isolated feature and don't know the full architecture of the application, you may propose a solution that doesn't fit well with the project.

### 11.4 Can reinforce bad practices

If a project already has messy code, Copilot can mimic that style.

That is why it is convenient to define standards:

- Naming conventions.
- Folder structure.
- Way of writing tests.
- Documentation style.
- Safety rules.

### 11.5 May generate dependency

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

### Step 3. Request a specific format

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
- Is the example understood?
- Does the code work?
- Has something been invented?
- Are there any important warnings missing?

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
| What restrictions are there? | No external libraries, formal tone, maximum 10 lines |
| What format do I want?    | Code, table, numbered steps, summary, checklist |
| What level do I need?    | Beginner, Intermediate, Advanced, Technical, Executive |

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

## 14. Good practices from day one

When working with Copilot, follow these recommendations:

1. **Do not paste sensitive information** if you are not clear about the environment, license and applicable privacy policy.
2. **Do not accept code without reading it**.
3. **Run and test the generated code**.
4. **Ask for explanations when you don't understand a solution**.
5. **Break big problems into small steps**.
6. **Don't use Copilot to hide lack of understanding**.
7. **Check the version of the tools or libraries**.
8. **Adapt the result to the style of your project**.
9. **Use specific prompts**.
10. **Always maintain professional judgment**.

---

## 15. Summary of the topic

In this topic we have seen that generative AI allows us to create new content based on instructions given by the user. Copilot is part of this type of tools, but it is not a single tool: it is an ecosystem with different applications aimed at development, productivity, automation and the creation of agents.

The fundamental idea is that Copilot should be understood as an assistant. It can speed up tasks, propose solutions, and help understand information, but it should not replace human review.

To obtain good results, it is necessary to learn to write good prompts, provide context, define restrictions and always review the responses generated.

---

## 16. Final checklist

Before moving on to the next topic, make sure you can answer these questions:

- What is generative AI?
- What is a language model?
- What is the difference between searching for information and generating a response?
- What is a prompt?
- What types of tasks can Copilot do?
- Why is it important to review your answers?
- What are the risks of using Copilot without supervision?
- What elements should a good prompt have?

---

## 17. Recommended official documentation

- GitHub Copilot documentation: https://docs.github.com/copilot
- GitHub Copilot features: https://docs.github.com/en/copilot/get-started/features
- Microsoft Copilot: https://www.microsoft.com/microsoft-copilot
- Microsoft 365 Copilot: https://learn.microsoft.com/en-us/microsoft-365-copilot/
- Microsoft Copilot Studio: https://learn.microsoft.com/en-us/microsoft-copilot-studio/
