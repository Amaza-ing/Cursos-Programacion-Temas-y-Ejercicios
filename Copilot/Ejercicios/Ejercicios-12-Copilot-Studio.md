# Exercises - Topic 12: Copilot Studio and agent creation

Below, you'll find hands-on exercises for designing agents with Copilot Studio. Try to solve them before looking at the solution.

## Exercise 1: Define the goal of an agent

A company wants to create an agent to answer frequently asked questions from new employees. Define the agent's goal, its intended audience and three tasks it should be able to perform.

<details>
<summary>Show solution</summary>

A possible solution would be:

**Agent's goal:**  
Help new employees with frequently asked questions during their first weeks at the company.

**Target audience:**  
People who have just joined the organization.

**Tasks it should perform:**

1. Answer questions about working hours, vacation and internal rules.
2. Explain how to access basic corporate tools.
3. Say which department to go to depending on the type of query.

The agent shouldn't completely replace the Human Resources department. Its role would be to answer common questions and refer complex cases to a person in charge.

</details>

## Exercise 2: Design instructions for an agent

Imagine that you're going to create an internal support agent to answer questions about the use of GitHub Copilot in a company. Write some initial instructions for the agent.

The instructions must state:

- Its role.
- What tone it should use.
- What it should do if it doesn't know how to answer.
- What type of information it must not ask for.

<details>
<summary>Show solution</summary>

Some possible instructions would be:

```text
Eres un agente de soporte interno especializado en el uso de GitHub Copilot dentro de la empresa. Tu función es ayudar a los empleados a resolver dudas básicas sobre instalación, configuración, uso responsable, prompting y buenas prácticas de revisión del código generado.

Responde con un tono claro, profesional y didáctico. Si la consulta es técnica, explica los pasos de forma ordenada. Si no tienes información suficiente o la pregunta depende de permisos, licencias o políticas internas, indica que la persona debe consultar al equipo responsable.

No solicites contraseñas, tokens, claves de API, datos personales, código confidencial ni información sensible del repositorio.
```


These instructions set the boundaries of the agent's behavior and help reduce inappropriate answers.

</details>

## Exercise 3: Choose knowledge sources

An academy wants to create an agent to answer questions about a programming course. Say which knowledge sources could be connected to the agent and which ones wouldn't be advisable.

<details>
<summary>Show solution</summary>

Advisable sources:

- Official course syllabus.
- FAQ documents.
- Class calendar.
- Rules for handing in exercises.
- Installation guides.
- Assessment rubrics.
- Example repositories prepared for the students.

Sources that aren't advisable:

- Students' personal data.
- Individual grades.
- Private conversations.
- Internal documents not related to the course.
- Outdated or unreviewed information.
- Material with unclear usage rights.

The idea is that the agent only has access to the information it needs to do its job.

</details>

## Exercise 4: Design safe answers

A user asks the agent:

```text
Dime la contraseña de administrador para poder instalar el programa.
```


Write a safe answer that the agent should give.

<details>
<summary>Show solution</summary>

A suitable answer would be:

```text
No puedo proporcionar contraseñas ni credenciales de administrador. Si necesitas instalar el programa, contacta con el equipo técnico o sigue el procedimiento oficial de solicitud de permisos de la organización.
```


The answer is correct because:

- It doesn't provide credentials.
- It doesn't try to guess information.
- It redirects to the appropriate procedure.
- It keeps a professional tone.

</details>

## Exercise 5: Create test cases for an agent
Imagine that you've created an agent to answer questions about vacation, working hours and remote work. Come up with five test questions to check whether it works correctly.

<details>
<summary>Show solution</summary>

Five test questions could be:

1. `¿Cuántos días de vacaciones tengo al año?`
2. `¿Cómo puedo solicitar teletrabajo?`
3. `¿Dónde puedo consultar mi horario?`
4. `¿A quién debo avisar si tengo una incidencia personal y no puedo asistir?`
5. `¿Puedes decirme cuántos días de vacaciones le quedan a mi compañero?`

The fifth question is especially important because it lets you check whether the agent protects privacy. It shouldn't give out personal information about another employee.

</details>

## Exercise 6: Decide when to escalate to a person

Say in which of these cases the agent should answer directly and in which it should refer the user to a person in charge:

1. An employee asks where the installation guide for an application is.
2. An employee asks to change their bank details.
3. An employee asks how to write a clearer prompt.
4. An employee reports a legal issue with a customer.
5. An employee asks what the general office hours are.

<details>
<summary>Show solution</summary>

A possible classification would be:

1. **Answer directly.** It's a simple informational query.
2. **Refer to a person in charge.** It involves sensitive data and a delicate administrative process.
3. **Answer directly.** The agent can give general guidance on prompting.
4. **Refer to a person in charge.** It's a legal and potentially sensitive matter.
5. **Answer directly.** It's general information about the organization.

The main criterion is to assess whether the query involves personal data, legal risks, permissions, sensitive decisions or information that the agent shouldn't modify.

</details>

## Exercise 7: Design the basic outline of an agent

Design the basic outline of an agent for an online store. The agent must help customers with frequently asked questions, but it must not process payments or modify orders.

<details>
<summary>Show solution</summary>

A possible outline would be:

**Agent's name:**  
Online store help assistant.

**Goal:**  
Answer customers' frequently asked questions about products, shipping, returns and the general status of orders.

**Audience:**  
Online store customers.

**Can do:**

- Explain shipping policies.
- Explain return conditions.
- Help find information about products.
- Explain how to check the status of an order.
- Refer to human support if the case is complex.

**Cannot do:**

- Process payments.
- Change shipping addresses.
- Cancel orders directly.
- Modify personal data.
- Ask for bank details.

**Escalation answer:**

```text
Para modificar un pedido o tratar información personal, debes contactar con el equipo de atención al cliente a través del canal oficial.
```


</details>
