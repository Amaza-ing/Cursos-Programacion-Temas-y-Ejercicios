# Topic 02 — Copilot ecosystem: Microsoft Copilot, GitHub Copilot, Microsoft 365 Copilot and Copilot Studio

## 1. Objective of the topic

In the previous topic we saw what generative artificial intelligence is and how Copilot can be understood as a work assistant. In this topic we are going to organize the Copilot ecosystem, because one of the most common problems when starting out is that there are several tools with similar names.

The objective of this topic is to learn to differentiate the main types of Copilot and know in which cases it is appropriate to use each one.

Upon finishing this topic you should be able to:

- Differentiate between Microsoft Copilot, GitHub Copilot, Microsoft 365 Copilot and Copilot Studio.
- Know which tool to use depending on the task.
- Recognize which Copilot is oriented towards development, productivity, automation or agent creation.
- Understand that functionalities may vary depending on the license, account and work environment.
- Choose a Copilot tool in a reasoned way.

---

## 2. Why there are several Copilots

Microsoft and GitHub use the name Copilot for different artificial intelligence tools. They all share the same general idea: helping the user perform tasks through generative AI.

However, each tool is designed for a different context.

It is not the same:

- Write code in an editor.
- Summarize a Teams meeting.
- Create a PowerPoint presentation.
- Analyze an Excel table.
- Create a conversational agent for internal support.
- Ask for general help from the browser.

That is why it is important not to talk about “Copilot” in a generic way without clarifying which one we are referring to.

During the course we will work with this classification:

| Tool | Main use |
| --------------------- | -------------------------------------------------------------------------------------------- |
| Microsoft Copilot | General assistant for search, content generation and basic productivity |
| GitHub Copilot | Software Development Assistant |
| Microsoft 365 Copilot | Integrated assistant in Word, Excel, PowerPoint, Outlook, Teams and other Microsoft 365 apps |
| Copilot Studio | Creating and managing AI agents |

---

## 3. Microsoft Copilot

**Microsoft Copilot** is Microsoft's general AI assistant. It is designed to help with broad tasks of productivity, consultation, writing, searching and content generation.

It can be used for tasks such as:

- Ask general questions.
- Summarize information.
- Write texts.
- Generate ideas.
- Help prepare documents.
- Explain concepts.
- Compare options.
- Create drafts.
- Transform content.

Example of use:

```text
Explícame las diferencias entre una aplicación web tradicional y una aplicación SPA con un ejemplo sencillo.
```

Another example:

```text
Redacta un correo profesional para solicitar una reunión de seguimiento sobre un proyecto.
```

Microsoft Copilot can be used in different environments, such as the web, Windows, or Edge, although specific features depend on the country, account, license, configuration, and available version.
### When to use Microsoft Copilot

It is convenient to use Microsoft Copilot when you need:

- A quick explanation.
- A general summary.
- A help for writing.
- Initial ideas.
- A comparison.
- A simple text transformation.
- Support in tasks that are not necessarily technical.

### When it is not the best option

It is not usually the best tool when you need:

- Work directly on the code of a project.
- Access the context of a repository.
- Generate tests connected to your code base.
- Review a pull request.
- Create GitHub Actions workflows within the repository.

For those cases, GitHub Copilot will usually be more suitable.

---

## 4. GitHub Copilot

**GitHub Copilot** is the Copilot aimed at software development.

Its main function is to assist programmers within their usual workflow. It can be used in editors such as Visual Studio Code or JetBrains environments, and also in GitHub and other supported environments.

GitHub Copilot can help:

- Complete code while we write.
- Generate functions.
- Explain existing code.
- Refactor code.
- Create tests.
- Detect errors.
- Write technical documentation.
- Create commit messages.
- Summarize pull requests.
- Propose improvements.
- Work with commands or terminal, depending on the environment.
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

#### Inline Suggestions

They are suggestions that appear directly while we write code.

For example, if we write:

```javascript
function calculateTotalPrice(products) {
```

Copilot can automatically suggest the function body.

This mode is useful for:

- Complete repetitive code.
- Speed ​​up simple functions.
- Generate common structures.
- Save time in predictable fragments.

#### Copilot Chat

Copilot Chat allows you to chat about the code.

It is useful for:

- Ask for explanations.
- Analyze errors.
- Refactor code.
- Generate tests.
- Ask about the project.
- Review a selection of code.
- Request implementation alternatives.

Example:

```text
¿Por qué esta función devuelve undefined en algunos casos? Explícalo paso a paso y propón una corrección mínima.
```

### When to use GitHub Copilot

It's a good idea to use GitHub Copilot when you need to:

- Schedule.
- Understand code.
- Improve existing code.
- Create tests.
- Document code.
- Automate development tasks.
- Work with repositories.
- Review technical changes.
- Create CI/CD workflows.

### When it is not the best option

It is not usually the best tool when you need:

- Write a long business report.
- Summarize a Teams meeting.
- Create a corporate presentation.
- Analyze a business spreadsheet within Excel.

For those cases, Microsoft 365 Copilot will usually be more suitable.

---

## 5. Microsoft 365 Copilot

**Microsoft 365 Copilot** is Copilot integrated into Microsoft 365 applications.

It is designed to work with tools such as:

-Word.
- Excel.
- PowerPoint.
- Outlook.
-Teams.
-OneNote.
-Loop.
- Other applications in the Microsoft 365 environment, according to license and availability.

Its main use is in productivity and information management tasks.

### 5.1 Copilot in Word

It can help:

- Create drafts.
- Rewrite texts.
- Summarize documents.
- Change the tone.
- Transform notes into structured documents.
- Create introductions, conclusions or outlines.

Prompt example:

```text
Reescribe este texto con un tono más profesional, manteniendo las ideas principales y reduciendo la extensión en un 30%.
```

### 5.2 Copilot in Excel

It can help:

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

It can help:

- Create presentations from a document.
- Summarize content in slides.
- Rearrange a presentation.
- Create presenter notes.
- Propose titles and structure.

Prompt example:

```text
Crea una estructura de presentación de 8 diapositivas a partir de este documento. El público será técnico pero no experto.
```

### 5.4 Copilot in Outlook

It can help:

- Write emails.
- Summarize long threads.
- Propose answers.
- Change the tone.
- Extract pending tasks.

Prompt example:

```text
Resume este hilo de correos e indica qué decisiones se han tomado y qué tareas quedan pendientes.
```

### 5.5 Copilot in Teams

It can help:

- Summarize meetings.
- Identify decisions made.
- Extract assigned tasks.
- Collect unanswered questions.
- Generate minutes.
- Review key points of a conversation.

Prompt example:

```text
Resume la reunión en tres apartados: decisiones tomadas, tareas asignadas y temas que requieren seguimiento.
```

### When to use Microsoft 365 Copilot

It is convenient to use Microsoft 365 Copilot when you work within documents, spreadsheets, emails, meetings or presentations.

It is especially useful when the information is already within the Microsoft 365 environment and needs to be transformed, summarized, analyzed or reused.

---

## 6. Copilot Studio

**Copilot Studio** is a tool aimed at creating, customizing and managing AI agents.

An agent is a system that can converse with users and, in some cases, execute actions or consult connected sources of information.

Copilot Studio allows you to create agents with a low-code approach. This means that many tasks can be configured visually, without having to program everything from scratch.

### What an agent can do

An agent created with Copilot Studio can be used to:

- Answer frequently asked questions.
- Help employees with internal documentation.
- Respond to support requests.
- Guide users in a process.
- Consult information from different sources.
- Activate workflows.
- Connect to business systems using connectors.

Use case example:

```text
Una empresa crea un agente interno para responder preguntas sobre vacaciones, permisos, teletrabajo y políticas de recursos humanos.
```

Another example:

```text
Un equipo técnico crea un agente que consulta documentación interna y ayuda a resolver dudas sobre despliegues, ramas Git y entornos de desarrollo.
```

### Basic elements of an agent

When designing an agent, it is useful to define:

1. **Objective**: what the agent exists for.
2. **Users**: who is going to use it.
3. **Sources of information**: what documentation or data you can consult.
4. **Instructions**: how you should respond.
5. **Actions**: What you can do, if you have permissions to run tasks.
6. **Boundaries**: What should not be answered or what should be escalated to a person.
7. **Channels**: where it will be published, for example Teams, web or other channels.

### When to use Copilot Studio
It is convenient to use Copilot Studio when you need to create your own AI solution for a specific process.

For example:

- An internal support assistant.
- An agent to consult technical documentation.
- A chatbot for customer service.
- A human resources assistant.
- An agent to guide administrative processes.
- A conversational automation connected to business data.

### When it is not necessary to use Copilot Studio

There is no need to use Copilot Studio for individual tasks such as:

- Ask for a quick explanation.
- Generate a simple function.
- Summarize an isolated document.
- Create a specific email.

In those cases, Microsoft Copilot, Microsoft 365 Copilot, or GitHub Copilot will probably suffice.

---

## 7. General comparison

| Tool | Main user | Context | Examples of use |
| --------------------- | -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ |
| Microsoft Copilot | General user | Web, Windows, Edge, Copilot app | Ask, write, summarize, generate ideas |
| GitHub Copilot | Developers | IDE, GitHub, terminal, repositories | Code, tests, refactoring, documentation, pull requests |
| Microsoft 365 Copilot | Microsoft 365 users | Word, Excel, PowerPoint, Outlook, Teams | Documents, emails, meetings, data, presentations |
| Copilot Studio | Business, technology and automation teams | Agent Creation Platform | Internal agents, chatbots, support, automations |

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
| Make a general inquiry | Microsoft Copilot |

### Step 3. Check the available context
The tool will be more useful if you have access to the necessary context.

For example:

- GitHub Copilot works best when you can see the relevant code.
- Microsoft 365 Copilot works best when the document, email, or meeting is within the Microsoft 365 environment.
- Copilot Studio works best when the agent is connected to well-organized information sources.

### Step 4. Review the conditions of use

Before using a Copilot tool in a company or class, it is worth checking:

- Account type.
- License available.
- Privacy policies.
- User permissions.
- Data you can access.
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

Prompt or initial agent instruction:

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

Not all Copilots have the same context or the same functions. Using the wrong tool can lead to less useful answers.

### Error 2. Using too general prompts

A prompt like this is of little use:

```text
Hazme un resumen.
```

It is better:

```text
Resume este documento en 10 líneas, destacando los objetivos, las conclusiones y las tareas pendientes.
```

### Error 3. Not checking the answer

Copilot can be wrong. You always have to review, test and validate.

### Error 4. Sharing sensitive information without checking the environment

You should not paste private code, personal data, credentials, contracts or confidential information without knowing the applicable privacy and security conditions.

### Mistake 5. Asking for too large tasks at once

It's better to break down a big goal into small steps.

Instead of:

```text
Créame una aplicación completa.
```

It is better to start with:

```text
Propón la estructura de carpetas para una aplicación sencilla de gestión de tareas con frontend, backend y base de datos.
```

Then you can continue step by step.

---

## 11. Good practices for choosing and using Copilot

1. **Define the task first**.
2. **Choose the tool according to the context**.
3. **Give specific instructions**.
4. **Do not mix different objectives in a single prompt**.
5. **Ask for intermediate steps when the task is complex**.
6. **Always check the result**.
7. **Do not share sensitive data without authorization**.
8. **Please note the license and available configuration**.
9. **Use Copilot as a support, not a substitute for professional judgment**.
10. **Document any important changes you accept**.

---

## 12. Summary of the topic
The Copilot ecosystem is made up of several tools that share a common idea: assisting the user through generative artificial intelligence. However, each one has a different objective.

Microsoft Copilot is useful for general queries and content generation. GitHub Copilot is aimed at software development. Microsoft 365 Copilot integrates into applications such as Word, Excel, PowerPoint, Outlook and Teams. Copilot Studio allows you to create and manage AI agents.

The key is to choose the right tool based on the task, the available context and the conditions of use.

---

## 13. Final checklist

Before moving on to the next topic, make sure you can answer these questions:

- What is the difference between Microsoft Copilot and GitHub Copilot?
- What is Microsoft 365 Copilot for?
- What type of tool is Copilot Studio?
- Which Copilot would you use to generate tests?
- Which Copilot would you use to summarize a meeting?
- Which Copilot would you use to create an internal agent?
- Why is it important to consider license and context?

---

## 14. Recommended official documentation

- GitHub Copilot documentation: https://docs.github.com/copilot
- GitHub Copilot features: https://docs.github.com/en/copilot/get-started/features
- Microsoft 365 Copilot documentation: https://learn.microsoft.com/en-us/microsoft-365-copilot/
- Microsoft Copilot Studio documentation: https://learn.microsoft.com/en-us/microsoft-copilot-studio/
- What is Copilot Studio: https://learn.microsoft.com/en-us/microsoft-copilot-studio/fundamentals-what-is-copilot-studio
