# Topic 03 — Privacy, security, limits and responsible use of AI

## 1. Goal of the topic

In the previous topics, we've seen what generative AI is and how the Copilot ecosystem is organized. In this topic, we're going to work on a fundamental part: how to use these tools safely, responsibly and professionally.

Copilot can speed up work a lot, but it can also generate errors, propose insecure solutions or receive information that we shouldn't share. That's why, before diving into GitHub Copilot and Microsoft Copilot, we need to set some basic rules of use.

By the end of this topic, you should be able to:

- Identify what information shouldn't be shared with an AI tool.
- Understand the difference between prompt, context and sensitive data.
- Recognize the main risks of AI-generated answers.
- Review Copilot-generated code with technical judgment.
- Apply a basic security, privacy and quality checklist.
- Use Copilot responsibly in a professional environment.

---

## 2. Why this topic is important

Generative AI can give a false sense of security. Many answers are well written, seem logical and are presented with confidence. However, that doesn't guarantee that they're correct.

In a professional environment, accepting an answer without reviewing it can lead to problems such as:

- Code that doesn't work.
- Insecure code.
- Leaks of confidential information.
- Use of personal data without authorization.
- Documents with incorrect information.
- Poorly designed automations.
- Decisions made based on made-up or incomplete information.

That's why any professional use of Copilot must be based on three principles:

1. **Human control**.
2. **Review of the result**.
3. **Protection of information**.

---

## 3. Prompt, context and data

To use Copilot safely, we first need to tell three concepts apart.

### 3.1 Prompt

The prompt is the instruction that the user writes.

Example:

```text
Resume este documento en cinco puntos principales.
```

Or in development:

```text
Revisa esta función y dime si puede fallar cuando el array está vacío.
```

### 3.2 Context

Context is the additional information that the tool can use to generate an answer.

In GitHub Copilot, the context can include things like:

- Code near the cursor.
- The open file.
- Related files.
- A code selection.
- The file name.
- The project structure.
- Repository custom instructions, if there are any.

In Microsoft 365 Copilot, the context can be related to:

- Documents.
- Emails.
- Meetings.
- Chats.
- OneDrive or SharePoint files.
- Information available depending on permissions and configuration.

### 3.3 Sensitive data

Sensitive data is data that shouldn't be shared without authorization or sufficient safeguards.

Examples:

- Passwords.
- Tokens.
- API keys.
- Personal data.
- Medical information.
- Financial information.
- Customer data.
- Contracts.
- Proprietary code.
- Internal company information.
- Access credentials.
- Data subject to legal or contractual regulations.

Basic rule:

> If you wouldn't share that information in a public chat or with someone outside the organization, don't paste it into an AI tool without first checking the terms of use, the license and the privacy conditions.

---

## 4. Privacy when using Copilot

Copilot tools may work differently depending on the product, the license and the configuration of the environment.

These are not the same thing:

- Using a personal account.
- Using an educational account.
- Using a business account.
- Using an environment managed by an organization.
- Using an individual license.
- Using a corporate license.

Before using Copilot with real information, it's a good idea to check:

1. What data it can use as context.
2. Whether the organization allows that tool to be used.
3. What information can be entered.
4. Whether there's an internal policy on the use of AI.
5. Whether the answers can be stored or reviewed.
6. Whether or not the provider uses the data to train models.
7. What protection measures the specific license offers.

In class, we can work with fictional examples, simple code snippets and made-up data. In a real professional environment, the organization's policy must always be followed.

---

## 5. Information we shouldn't enter without authorization

Sensitive information shouldn't be entered into Copilot without clear authorization.

### 5.1 Credentials and secrets

Never paste:

```text
password=...
```

```text
API_KEY=...
```

```text
PRIVATE_TOKEN=...
```

```text
DATABASE_URL=...
```

```text
JWT_SECRET=...
```

If you need help with an error related to credentials, replace the real values with dummy values.

Unsafe example:

```text
Mi conexión falla. Este es mi usuario, contraseña y cadena de conexión real...
```

Safe example:

```text
Mi conexión falla. He sustituido los datos reales por valores ficticios:
DATABASE_URL=postgres://user:password@host:5432/database
¿Qué partes debería revisar?
```

### 5.2 Personal data

Avoid entering data such as:

- National ID numbers.
- Addresses.
- Phone numbers.
- Personal email addresses.
- Medical data.
- Sensitive employment information.
- Customer data.

Safe example:

```text
Tengo una tabla ficticia con columnas name, email y purchaseAmount. ¿Cómo podría anonimizar el campo email antes de analizar los datos?
```

### 5.3 Proprietary code

In professional environments, code may be protected by contracts, confidentiality agreements or internal policies.

Before pasting real code into an AI tool, check whether it's allowed.

If you can't share the code, you can describe the problem in abstract terms.

Example:

```text
Tengo una función que recibe una lista de pedidos, agrupa por cliente y calcula el total. El problema es que algunos pedidos no tienen cliente asignado. ¿Qué estrategia de validación podría aplicar?
```

---

## 6. Common risks of AI-generated answers

### 6.1 Hallucinations

A hallucination occurs when AI generates false or made-up information that looks true.

It can make up:

- Functions that don't exist.
- Incorrect parameters.
- Library methods.
- Bibliographic references.
- Commands.
- Configuration options.
- Incorrect explanations.

Example:

```text
Usa el método array.removeByCondition() para eliminar elementos.
```

That method doesn't exist natively in JavaScript. The answer might seem reasonable, but it would be wrong.

### 6.2 Code that works, but isn't suitable

Sometimes the generated code runs, but it isn't a good solution.

It can be:

- Hard to read.
- Hard to maintain.
- Inefficient.
- Insecure.
- Inconsistent with the project's style.
- Too complex for the problem.

### 6.3 Lack of context

If Copilot doesn't have enough context, it may propose solutions that don't fit.

For example:

```text
Crea un sistema de autenticación.
```

This request is too broad. Copilot doesn't know:

- What stack is used.
- What database there is.
- What types of users there are.
- What level of security is required.
- Whether sessions or tokens are used.
- Whether there's already a defined architecture.

A better prompt would be:

```text
Estoy trabajando en una API REST con Node.js y Express. Ya tengo una tabla users con email y passwordHash. Quiero una propuesta para implementar login con JWT, explicando los pasos y señalando riesgos de seguridad. No escribas todavía el código completo.
```

### 6.4 Biases

AI can reproduce biases present in the data it was trained on or in the instructions it receives.

In professional contexts, this is especially important in tasks related to:

- Recruitment.
- Performance reviews.
- Personalized recommendations.
- Customer service.
- User classification.
- Analysis of sensitive data.

### 6.5 Overreliance

If a person accepts every answer without understanding it, they may lose their critical thinking and technical autonomy.

Copilot should help you learn, not stop you from learning.

A good practice is to ask for explanations:

```text
Explícame esta solución paso a paso y dime qué conceptos necesito entender para mantener este código en el futuro.
```

---

## 7. Responsible use in software development

When we use GitHub Copilot to program, we should review its proposals with the same criteria we would use to review someone else's code.

### 7.1 Checklist for reviewing generated code

Before accepting Copilot-generated code, check:

- Do I understand what it does?
- Does it really solve the problem?
- Does it compile or run?
- Has it been tested?
- Does it handle errors?
- Does it validate the input data?
- Does it follow the project's style?
- Does it introduce unnecessary dependencies?
- Does it use functions or APIs that actually exist?
- Could it have security problems?
- Can it break another part of the application?

### 7.2 Review example

Suppose Copilot generates this function:

```javascript
function getUserByEmail(users, email) {
  return users.find((user) => user.email === email);
}
```

The function may seem correct, but we should ask ourselves:

- What happens if users is null?
- What happens if email is empty?
- Should it ignore uppercase and lowercase?
- Should it throw an error or return undefined?
- Does the email format have to be validated?

We can ask for an improvement:

```text
Mejora esta función para que valide entradas nulas, compare el email sin distinguir mayúsculas y minúsculas, y mantenga el código simple.
```

A possible improved version would be:

```javascript
function getUserByEmail(users, email) {
  // Validamos que users sea un array y que email tenga contenido
  if (
    !Array.isArray(users) ||
    typeof email !== "string" ||
    email.trim() === ""
  ) {
    return undefined;
  }

  const normalizedEmail = email.trim().toLowerCase();

  return users.find((user) => {
    return (
      typeof user.email === "string" &&
      user.email.toLowerCase() === normalizedEmail
    );
  });
}
```

This version isn't automatically perfect, but it shows a more responsible review process.

---

## 8. Responsible use in documents and productivity

When we use Microsoft Copilot or Microsoft 365 Copilot to work with text, documents, emails or meetings, we must also review the result.

### 8.1 Common risks

- Incomplete summaries.
- Inappropriate tone.
- Loss of important nuances.
- Misinterpretation of a meeting.
- Pending tasks left out.
- Unconfirmed information included.
- Writing that is too generic.

### 8.2 Checklist for reviewing generated texts

Before sending or using a generated text, check:

- Is the content correct?
- Is the tone appropriate?
- Is any important information missing?
- Is there any made-up data?
- Does the text reflect my intention well?
- Have the instructions been followed?
- Is there sensitive information that shouldn't appear?
- Does the text need to be adapted to the recipient?

### 8.3 Example of a responsible prompt

Instead of asking:

```text
Escribe un correo para mi jefe.
```

It's better to ask:

```text
Redacta un correo profesional y breve para informar de que el informe estará listo mañana. Mantén un tono claro, responsable y sin dar excusas excesivas. No inventes detalles que no te haya dado.
```

---

## 9. Responsible use in automation and agents

When agents or automations are created, the risks are higher because the system can interact with users or run actions.

A poorly designed agent can:

- Give wrong answers to many people.
- Access information it shouldn't.
- Run actions without enough control.
- Not know when to escalate to a person.
- Create a bad user experience.

### 9.1 Checklist for designing agents

Before publishing an agent, check:

- What is its exact goal?
- Which users is it aimed at?
- What information sources can it query?
- What data must it not show?
- What actions can it run?
- When should it say it doesn't know?
- When should it escalate to a person?
- Has it been tested with real cases?
- Have edge cases been tested?
- Is there a way to monitor how it works?

### 9.2 Example of a safe instruction for an agent

```text
Eres un agente de soporte interno. Responde únicamente usando la documentación proporcionada. Si no encuentras una respuesta clara, indica que no tienes información suficiente y recomienda contactar con el equipo responsable. No inventes políticas internas ni proporciones datos personales.
```

This instruction is safer than a generic instruction like:

```text
Responde a cualquier pregunta de los empleados.
```

---

## 10. Basic ethical principles

The use of Copilot must respect certain ethical principles.

### 10.1 Transparency

In some contexts, it may be necessary to state that AI has been used as support.

For example:

- Academic documents.
- Corporate reports.
- Regulated processes.
- Production of public content.

### 10.2 Accountability

The final responsibility doesn't lie with Copilot, but with the person or team that decides to use the result.

If Copilot generates an error and we accept it without reviewing it, the problem doesn't go away just because an AI generated it.

### 10.3 Data protection

Personal and confidential data must be handled with care.

Real data shouldn't be entered if it isn't necessary or if there's no authorization.

### 10.4 Non-discrimination

You have to watch out for possible biases, especially when working with people, profiles, evaluations or sensitive decisions.

### 10.5 Human supervision

AI should support decision-making, not completely replace it in important contexts.

---

## 11. Step-by-step guide to using Copilot safely

### Step 1. Identify the task

Before using Copilot, define what you want to do.

Example:

```text
Quiero refactorizar una función.
```

```text
Quiero resumir un documento.
```

```text
Quiero crear un correo.
```

### Step 2. Decide whether you can share the context

Ask yourself:

- Is there personal data?
- Are there credentials?
- Is there confidential information?
- Is there proprietary code?
- Do I have permission to use this information?

If you have any doubts about the answer, don't paste the real information.

### Step 3. Anonymize or simplify

Replace real data with fictional data.

Example:

```text
Cliente real: Empresa XYZ S.L.
```

It can become:

```text
Cliente ficticio: Company A
```

### Step 4. Write a clear prompt

Include the goal, the context, the constraints and the format.

```text
Analiza esta función ficticia y señala posibles problemas de seguridad. No propongas una solución completa todavía; primero enumera los riesgos principales.
```

### Step 5. Check the answer

Don't accept the result automatically.

Check:

- Accuracy.
- Security.
- Consistency.
- Fit with the context.
- Possible omissions.

### Step 6. Ask for clarification

If something isn't clear, ask.

```text
Explícame por qué esa solución sería más segura.
```

```text
¿Qué riesgos seguirían existiendo incluso después de aplicar esa corrección?
```

### Step 7. Test before using

In code, run tests.

In documents, review the content.

In automations, test with controlled cases.

### Step 8. Document important decisions

If a Copilot proposal affects the project, it's a good idea to document what has been changed and why.

---

## 12. Examples of safe prompts

### To review code

```text
Revisa esta función y señala posibles problemas de seguridad, rendimiento y legibilidad. No modifiques el código todavía. Primero dame una lista priorizada de problemas.
```

### To refactor

```text
Refactoriza esta función manteniendo exactamente el mismo comportamiento. No añadas nuevas dependencias y explica brevemente cada cambio realizado.
```

### To generate tests

```text
Genera tests unitarios para esta función. Incluye casos normales, casos límite y entradas inválidas. No supongas requisitos que no aparezcan en el código.
```

### To summarize documentation

```text
Resume este documento en lenguaje claro. No añadas información externa y separa el resultado en: ideas principales, dudas abiertas y tareas pendientes.
```

### To work with fictional data

```text
Usa estos datos ficticios para mostrar cómo se calcularía el promedio de ventas por mes. No asumas que representan datos reales.
```

---

## 13. Examples of unsafe prompts

### Unsafe prompt 1

```text
Aquí está mi archivo .env completo. Dime por qué falla la conexión.
```

Problem: it may include real credentials.

Safer version:

```text
He sustituido los valores reales de mi archivo .env por valores ficticios. Dime qué partes debería revisar si falla la conexión a la base de datos.
```

### Unsafe prompt 2

```text
Te paso los datos reales de mis clientes para que los analices.
```

Problem: it may include personal or confidential data.

Safer version:

```text
Te paso una muestra ficticia con la misma estructura que mis datos reales. Ayúdame a diseñar un análisis sin usar información personal.
```

### Unsafe prompt 3

```text
Crea una política interna sobre permisos laborales aunque no tengas más información.
```

Problem: it may make up rules.

Safer version:

```text
Ayúdame a estructurar una política interna sobre permisos laborales. No inventes normas concretas; deja marcados los apartados que deben completarse con información oficial de la empresa.
```

---

## 14. General checklist for responsible use

Before using a Copilot answer, go through this list:

### Privacy

- Have I entered personal data?
- Have I entered credentials?
- Have I shared confidential information?
- Do I have permission to use this information?
- Can I anonymize the content?

### Security

- Does the code validate inputs?
- Does it handle errors?
- Does it avoid exposing secrets?
- Does it introduce unnecessary dependencies?
- Does it follow secure practices?

### Quality

- Does the answer solve the problem?
- Is it understandable?
- Is it adapted to the context?
- Is it maintainable?
- Does it need simplifying?

### Verification

- Have I tested the code?
- Have I reviewed the text?
- Have I checked the sources if there's external data?
- Have I asked for clarification if something isn't clear?

### Accountability

- Can I explain the result in my own words?
- Am I willing to take ownership of this change?
- Have I documented what's important?

---

## 15. Summary of the topic

Copilot can be a very powerful tool, but it must be used responsibly. The answers it generates may contain errors, biases, made-up information or insecure solutions. In addition, using personal data, credentials or confidential information requires special care.

The main idea of this topic is that Copilot should be used as an assistant, not as the final authority. The user must review, test, adapt and validate any result before adding it to a project, document or professional process.

Using Copilot well isn't just about asking it for things. It's about knowing what to ask for, what not to share, how to review the answer and when not to accept a proposal.

---

## 16. Final checklist

Before moving on to the next topic, make sure you can answer these questions:

- What is the difference between prompt and context?
- What types of data shouldn't be shared without authorization?
- What is a hallucination in generative AI?
- Why shouldn't we accept generated code without reviewing it?
- What risks exist when creating agents or automations?
- What steps would you follow to use Copilot safely?
- What should a generated code review checklist include?

---

## 17. Recommended official documentation

- GitHub Copilot documentation: https://docs.github.com/copilot
- Responsible use of GitHub Copilot Chat in your IDE: https://docs.github.com/en/copilot/responsible-use/chat-in-your-ide
- GitHub Copilot Business Privacy Statement: https://docs.github.com/en/site-policy/privacy-policies/github-copilot-business-privacy-statement
- GitHub Privacy Statement: https://docs.github.com/site-policy/privacy-policies/github-privacy-statement
- GitHub Copilot model hosting: https://docs.github.com/en/copilot/reference/ai-models/model-hosting
- Microsoft Copilot Studio documentation: https://learn.microsoft.com/en-us/microsoft-copilot-studio/
