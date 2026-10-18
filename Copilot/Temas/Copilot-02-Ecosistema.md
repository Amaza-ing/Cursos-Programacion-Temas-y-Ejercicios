# Topic 02 — Copilot ecosystem: Microsoft Copilot, GitHub Copilot, Microsoft 365 Copilot and Copilot Studio

## 1. Goal of the topic

In the previous topic, we saw what generative artificial intelligence is and how Copilot can be understood as a work assistant. In this topic, we're going to put the Copilot ecosystem in order, because one of the most common problems when you're starting out is that there are several tools with similar names.

The goal of this topic is to learn how to tell the main types of Copilot apart and know when it's best to use each one.

By the end of this topic, you should be able to:

- Tell the difference between Microsoft Copilot, GitHub Copilot, Microsoft 365 Copilot and Copilot Studio.
- Know which tool to use depending on the task.
- Recognize which Copilot is aimed at development, productivity, automation or agent creation.
- Understand that features may vary depending on the license, the account and the work environment.
- Choose a Copilot tool on reasoned grounds.

---

## 2. Why there are several Copilots

Microsoft and GitHub use the name Copilot for different artificial intelligence tools. They all share the same general idea: helping the user carry out tasks with generative AI.

However, each tool is designed for a different context.

These are not the same thing:

- Writing code in an editor.
- Summarizing a Teams meeting.
- Creating a PowerPoint presentation.
- Analyzing an Excel table.
- Creating a conversational agent for internal support.
- Asking for general help from the browser.

That's why it's important not to talk about “Copilot” generically without making clear which one we mean.

During the course, we'll work with this classification:

| Tool | Main use |
| --------------------- | -------------------------------------------------------------------------------------------- |
| Microsoft Copilot | General assistant for search, content generation and basic productivity |
| GitHub Copilot | Software development assistant |
| Microsoft 365 Copilot | Assistant built into Word, Excel, PowerPoint, Outlook, Teams and other Microsoft 365 apps |
| Copilot Studio | Creating and managing AI agents |

---

## 3. Microsoft Copilot

**Microsoft Copilot** is Microsoft's general-purpose AI assistant. It's designed to help with a broad range of tasks: productivity, looking things up, writing, searching and content generation.

It can be used for tasks such as:

- Asking general questions.
- Summarizing information.
- Writing texts.
- Generating ideas.
- Helping prepare documents.
- Explaining concepts.
- Comparing options.
- Creating drafts.
- Transforming content.

Usage example:

```text
Explícame las diferencias entre una aplicación web tradicional y una aplicación SPA con un ejemplo sencillo.
```

Another example:

```text
Redacta un correo profesional para solicitar una reunión de seguimiento sobre un proyecto.
```

Microsoft Copilot can be used in different environments, such as the web, Windows or Edge, although the specific features depend on the country, account, license, configuration and available version.

### When to use Microsoft Copilot

It's a good idea to use Microsoft Copilot when you need:

- A quick explanation.
- A general summary.
- Help with writing.
- Initial ideas.
- A comparison.
- A simple text transformation.
- Support with tasks that aren't necessarily technical.

### When it isn't the best option

It isn't usually the best tool when you need to:

- Work directly on a project's code.
- Access the context of a repository.
- Generate tests connected to your codebase.
- Review a pull request.
- Create GitHub Actions workflows inside the repository.

For those cases, GitHub Copilot will usually be more suitable.

---

## 4. GitHub Copilot

**GitHub Copilot** is the Copilot aimed at software development.

Its main purpose is to assist programmers within their usual workflow. It can be used in editors such as Visual Studio Code or JetBrains IDEs, and also on GitHub and in other supported environments.

GitHub Copilot can help you:

- Complete code as we type.
- Generate functions.
- Explain existing code.
- Refactor code.
- Create tests.
- Detect errors.
- Write technical documentation.
- Create commit messages.
- Summarize pull requests.
- Propose improvements.
- Work with commands or the terminal, depending on the environment.
- Create or review GitHub Actions workflows.

Prompt example for GitHub Copilot Chat:

```text
Explica qué hace esta función, detecta posibles problemas y propón una versión más legible sin cambiar su comportamiento.
```

Example of a prompt to generate tests:

```text
Genera tests unitarios para esta función usando Jest. Incluye casos normales, casos límite y casos de error.
```

### Difference between inline suggestions and Copilot Chat

GitHub Copilot can be used in several ways.

#### Inline suggestions

These are suggestions that appear directly as we type code.

For example, if we write:

```javascript
function calculateTotalPrice(products) {
```

Copilot can automatically suggest the function body.

This mode is useful for:

- Completing repetitive code.
- Writing simple functions faster.
- Generating common structures.
- Saving time on predictable snippets.

#### Copilot Chat

Copilot Chat lets you have a conversation about the code.

It's useful for:

- Asking for explanations.
- Analyzing errors.
- Refactoring code.
- Generating tests.
- Asking about the project.
- Reviewing a selection of code.
- Asking for implementation alternatives.

Example:

```text
¿Por qué esta función devuelve undefined en algunos casos? Explícalo paso a paso y propón una corrección mínima.
```

### When to use GitHub Copilot

It's a good idea to use GitHub Copilot when you need to:

- Program.
- Understand code.
- Improve existing code.
- Create tests.
- Document code.
- Automate development tasks.
- Work with repositories.
- Review technical changes.
- Create CI/CD workflows.

### When it isn't the best option

It isn't usually the best tool when you need to:

- Write a long business report.
- Summarize a Teams meeting.
- Create a corporate presentation.
- Analyze a business spreadsheet in Excel.

For those cases, Microsoft 365 Copilot will usually be more suitable.

---

## 5. Microsoft 365 Copilot

**Microsoft 365 Copilot** is Copilot built into the Microsoft 365 apps.

It's designed to work with tools such as:

- Word.
- Excel.
- PowerPoint.
- Outlook.
- Teams.
- OneNote.
- Loop.
- Other apps in the Microsoft 365 environment, depending on license and availability.

It's mainly useful for productivity and information management tasks.

### 5.1 Copilot in Word

It can help you:

- Create drafts.
- Rewrite texts.
- Summarize documents.
- Change the tone.
- Turn notes into structured documents.
- Create introductions, conclusions or outlines.

Prompt example:

```text
Reescribe este texto con un tono más profesional, manteniendo las ideas principales y reduciendo la extensión en un 30%.
```

### 5.2 Copilot in Excel

It can help you:

- Interpret tables.
- Create formulas.
- Explain data.
- Detect trends.
- Generate summaries.
- Propose visualizations.
- Identify outliers.

Prompt example:

```text
Analiza esta tabla de ventas y resume las principales tendencias por trimestre.
```

### 5.3 Copilot in PowerPoint

It can help you:

- Create presentations from a document.
- Summarize content into slides.
- Reorganize a presentation.
- Create speaker notes.
- Propose titles and a structure.

Prompt example:

```text
Crea una estructura de presentación de 8 diapositivas a partir de este documento. El público será técnico pero no experto.
```

### 5.4 Copilot in Outlook

It can help you:

- Write emails.
- Summarize long threads.
- Propose replies.
- Change the tone.
- Extract pending tasks.

Prompt example:

```text
Resume este hilo de correos e indica qué decisiones se han tomado y qué tareas quedan pendientes.
```

### 5.5 Copilot in Teams

It can help you:

- Summarize meetings.
- Identify the decisions made.
- Extract assigned tasks.
- Gather unanswered questions.
- Generate meeting minutes.
- Review the key points of a conversation.

Prompt example:

```text
Resume la reunión en tres apartados: decisiones tomadas, tareas asignadas y temas que requieren seguimiento.
```

### When to use Microsoft 365 Copilot

It's a good idea to use Microsoft 365 Copilot when you're working with documents, spreadsheets, emails, meetings or presentations.

It's especially useful when the information is already inside the Microsoft 365 environment and needs to be transformed, summarized, analyzed or reused.

---

## 6. Copilot Studio

**Copilot Studio** is a tool for creating, customizing and managing AI agents.

An agent is a system that can have conversations with users and, in some cases, run actions or query connected information sources.

Copilot Studio lets you create agents with a low-code approach. This means that many tasks can be configured visually, without having to program everything from scratch.

### What an agent can do

An agent created with Copilot Studio can be used to:

- Answer frequently asked questions.
- Help employees with internal documentation.
- Handle support requests.
- Guide users through a process.
- Look up information from different sources.
- Trigger workflows.
- Connect to business systems through connectors.

Use case example:

```text
Una empresa crea un agente interno para responder preguntas sobre vacaciones, permisos, teletrabajo y políticas de recursos humanos.
```

Another example:

```text
Un equipo técnico crea un agente que consulta documentación interna y ayuda a resolver dudas sobre despliegues, ramas Git y entornos de desarrollo.
```

### Basic elements of an agent

When designing an agent, it's useful to define:

1. **Goal**: what the agent exists for.
2. **Users**: who is going to use it.
3. **Information sources**: what documentation or data it can query.
4. **Instructions**: how it should answer.
5. **Actions**: what it can do, if it has permissions to run tasks.
6. **Limits**: what it shouldn't answer or what it should escalate to a person.
7. **Channels**: where it will be published, for example Teams, the web or other channels.

### When to use Copilot Studio

It's a good idea to use Copilot Studio when you need to create your own AI solution for a specific process.

For example:

- An internal support assistant.
- An agent to look up technical documentation.
- A chatbot for customer service.
- A human resources assistant.
- An agent to guide administrative processes.
- A conversational automation connected to business data.

### When you don't need Copilot Studio

There's no need to use Copilot Studio for individual tasks such as:

- Asking for a quick explanation.
- Generating a simple function.
- Summarizing an isolated document.
- Writing a one-off email.

In those cases, Microsoft Copilot, Microsoft 365 Copilot or GitHub Copilot will probably be enough.

---

## 7. General comparison

| Tool | Main user | Context | Usage examples |
| --------------------- | -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ |
| Microsoft Copilot | General user | Web, Windows, Edge, Copilot app | Ask, write, summarize, generate ideas |
| GitHub Copilot | Developers | IDE, GitHub, terminal, repositories | Code, tests, refactoring, documentation, pull requests |
| Microsoft 365 Copilot | Microsoft 365 users | Word, Excel, PowerPoint, Outlook, Teams | Documents, emails, meetings, data, presentations |
| Copilot Studio | Business, technology and automation teams | Agent creation platform | Internal agents, chatbots, support, automations |

---

## 8. How to choose which Copilot to use

To choose the right tool, we can follow this guide.

### Step 1. Identify the type of task

Ask yourself:

```text
¿Estoy trabajando con código, documentos, correos, reuniones, datos o agentes?
```

### Step 2. Choose the tool according to the context

| I need... | Recommended tool |
| ------------------------------------ | ----------------------------------------- |
| Create or review code | GitHub Copilot |
| Explain a function | GitHub Copilot |
| Generate tests | GitHub Copilot |
| Create a GitHub Actions workflow | GitHub Copilot |
| Write an email | Microsoft Copilot or Microsoft 365 Copilot |
| Summarize a Word document | Microsoft 365 Copilot |
| Analyze an Excel table | Microsoft 365 Copilot |
| Summarize a Teams meeting | Microsoft 365 Copilot |
| Create an agent for internal support | Copilot Studio |
| Ask a general question | Microsoft Copilot |

### Step 3. Check the available context

The tool will be more useful if it has access to the necessary context.

For example:

- GitHub Copilot works best when it can see the relevant code.
- Microsoft 365 Copilot works best when the document, email or meeting is inside the Microsoft 365 environment.
- Copilot Studio works best when the agent is connected to well-organized information sources.

### Step 4. Review the terms of use

Before using a Copilot tool in a company or a class, it's a good idea to check:

- The type of account.
- The available license.
- Privacy policies.
- User permissions.
- The data it can access.
- Internal rules on the use of AI.

---

## 9. Practical decision scenarios

### Scenario 1. I need to create a function in JavaScript

Recommended tool: **GitHub Copilot**.

Possible prompt:

```text
Crea una función en JavaScript que reciba un array de usuarios y devuelva solo los usuarios activos. Usa nombres de variables en inglés y comentarios breves en español.
```

### Scenario 2. I need to summarize a 20-page document

Recommended tool: **Microsoft 365 Copilot**, if the document is in Word or OneDrive.

Possible prompt:

```text
Resume este documento en una página. Mantén los conceptos principales y señala las conclusiones más importantes.
```

### Scenario 3. I need to prepare a meeting

Recommended tool: **Microsoft 365 Copilot**, especially in Outlook or Teams.

Possible prompt:

```text
Resume los correos relacionados con esta reunión e indica los temas que debería preparar antes de asistir.
```

### Scenario 4. I need to create an internal FAQ assistant

Recommended tool: **Copilot Studio**.

Prompt or initial instruction for the agent:

```text
Eres un asistente interno para responder preguntas frecuentes sobre procesos de incorporación, vacaciones y herramientas corporativas. Responde de forma breve y, si no tienes información suficiente, indica que la consulta debe escalarse al equipo correspondiente.
```

### Scenario 5. I need to understand a bug in my application

Recommended tool: **GitHub Copilot**.

Possible prompt:

```text
Analiza este error y dime qué puede estar provocándolo. Después propón una corrección paso a paso.
```

---

## 10. Common mistakes when starting out

### Mistake 1. Thinking that all Copilots are the same

Not all Copilots have the same context or the same features. Using the wrong tool can lead to less useful answers.

### Mistake 2. Using prompts that are too general

A prompt like this isn't very useful:

```text
Hazme un resumen.
```

This is better:

```text
Resume este documento en 10 líneas, destacando los objetivos, las conclusiones y las tareas pendientes.
```

### Mistake 3. Not checking the answer

Copilot can be wrong. You always have to review, test and validate.

### Mistake 4. Sharing sensitive information without checking the environment

You shouldn't paste private code, personal data, credentials, contracts or confidential information without knowing the applicable privacy and security conditions.

### Mistake 5. Asking for tasks that are too big all at once

It's better to break a big goal down into small steps.

Instead of:

```text
Créame una aplicación completa.
```

It's better to start with:

```text
Propón la estructura de carpetas para una aplicación sencilla de gestión de tareas con frontend, backend y base de datos.
```

Then you can continue step by step.

---

## 11. Best practices for choosing and using Copilot

1. **Define the task first**.
2. **Choose the tool according to the context**.
3. **Give specific instructions**.
4. **Don't mix different goals in a single prompt**.
5. **Ask for intermediate steps when the task is complex**.
6. **Always check the result**.
7. **Don't share sensitive data without authorization**.
8. **Keep in mind the license and the available configuration**.
9. **Use Copilot as support, not as a substitute for professional judgment**.
10. **Document any important changes you accept**.

---

## 12. Summary of the topic

The Copilot ecosystem is made up of several tools that share a common idea: assisting the user with generative artificial intelligence. However, each one has a different goal.

Microsoft Copilot is useful for general questions and content generation. GitHub Copilot is aimed at software development. Microsoft 365 Copilot is built into applications such as Word, Excel, PowerPoint, Outlook and Teams. Copilot Studio lets you create and manage AI agents.

The key is to choose the right tool based on the task, the available context and the terms of use.

---

## 13. Final checklist

Before moving on to the next topic, make sure you can answer these questions:

- What is the difference between Microsoft Copilot and GitHub Copilot?
- What is Microsoft 365 Copilot for?
- What type of tool is Copilot Studio?
- Which Copilot would you use to generate tests?
- Which Copilot would you use to summarize a meeting?
- Which Copilot would you use to create an internal agent?
- Why is it important to take the license and the context into account?

---

## 14. Recommended official documentation

- GitHub Copilot documentation: https://docs.github.com/copilot
- GitHub Copilot features: https://docs.github.com/en/copilot/get-started/features
- Microsoft 365 Copilot documentation: https://learn.microsoft.com/en-us/microsoft-365-copilot/
- Microsoft Copilot Studio documentation: https://learn.microsoft.com/en-us/microsoft-copilot-studio/
- What is Copilot Studio: https://learn.microsoft.com/en-us/microsoft-copilot-studio/fundamentals-what-is-copilot-studio
