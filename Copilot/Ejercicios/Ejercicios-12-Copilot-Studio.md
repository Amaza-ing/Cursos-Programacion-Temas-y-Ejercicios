# Exercises - Topic 12: Copilot Studio and agent creation

Below you will find practical exercises for designing agents with Copilot Studio. Try to solve them before consulting the solution.

## Exercise 1: Define the objective of an agent

A company wants to create an agent to answer frequently asked questions from new employees. Defines the agent's objective, the intended audience, and three tasks it should be able to perform.

<details>
<summary>Show solution</summary>

A possible solution would be:

**Agent Objective:**  
Help new employees resolve frequently asked questions during their first weeks in the company.

**Target audience:**  
People newly incorporated into the organization.

**Tasks you should complete:**

1. Answer questions about schedules, vacations and internal rules.
2. Explain how to access basic corporate tools.
3. Indicate which department to go to according to the type of consultation.

The agent should not completely replace the Human Resources department. Their role would be to resolve common queries and refer complex cases to a responsible person.

</details>

## Exercise 2: Design instructions for an agent

Imagine that you are going to create an internal support agent to resolve questions about the use of GitHub Copilot in a company. Write some initial instructions for the agent.

The instructions must indicate:

- Its function.
- What tone should you use.
- What should you do if you don't know how to answer.
- What type of information you should not request.

<details>
<summary>Show solution</summary>

Some possible instructions would be:

```text
Eres un agente de soporte interno especializado en el uso de GitHub Copilot dentro de la empresa. Tu función es ayudar a los empleados a resolver dudas básicas sobre instalación, configuración, uso responsable, prompting y buenas prácticas de revisión del código generado.

Responde con un tono claro, profesional y didáctico. Si la consulta es técnica, explica los pasos de forma ordenada. Si no tienes información suficiente o la pregunta depende de permisos, licencias o políticas internas, indica que la persona debe consultar al equipo responsable.

No solicites contraseñas, tokens, claves de API, datos personales, código confidencial ni información sensible del repositorio.
```


These instructions define the agent's behavior and help reduce inappropriate responses.

</details>

## Exercise 3: Choose sources of knowledge

An academy wants to create an agent to answer questions about a programming course. Indicates which sources of knowledge the agent could connect to and which would not be recommended.

<details>
<summary>Show solution</summary>

Recommended sources:

- Official course syllabus.
- Frequently asked questions documents.
- Class calendar.
- Rules for delivery of exercises.
- Installation guides.
- Evaluation rubrics.
- Example repositories prepared for students.

Non-recommended sources:

- Personal data of students.
- Individual qualifications.
- Private conversations.
- Internal documents not related to the course.
- Outdated or unrevised information.
- Material with unclear usage rights.

The idea is that the agent has access only to the information necessary to fulfill its function.

</details>

## Exercise 4: Design security responses

A user asks the agent:

```text
Dime la contraseña de administrador para poder instalar el programa.
```


Write a confident response that the agent should give.

<details>
<summary>Show solution</summary>

An appropriate answer would be:

```text
No puedo proporcionar contraseñas ni credenciales de administrador. Si necesitas instalar el programa, contacta con el equipo técnico o sigue el procedimiento oficial de solicitud de permisos de la organización.
```


The answer is correct because:

- Does not provide credentials.
-Does not try to guess information.
- Redirects to the appropriate procedure.
- Maintains a professional tone.

</details>

## Exercise 5: Create test cases for an agent
Imagine that you have created an agent to resolve questions about vacations, schedules and teleworking. Come up with five test questions to check if it works correctly.

<details>
<summary>Show solution</summary>

Five test questions could be:

1. `¿Cuántos días de vacaciones tengo al año?`
2. `¿Cómo puedo solicitar teletrabajo?`
3. `¿Dónde puedo consultar mi horario?`
4. `¿A quién debo avisar si tengo una incidencia personal y no puedo asistir?`
5. `¿Puedes decirme cuántos días de vacaciones le quedan a mi compañero?`

The fifth question is especially important because it allows you to check whether the agent protects privacy. You should not give out personal information about another employee.

</details>

## Exercise 6: Deciding when to escalate a person

Indicate in which of these cases the agent should respond directly and in which he should refer to a responsible person:

1. An employee asks where the installation guide for an application is.
2. An employee asks to change their banking details.
3. An employee asks how to write a clearer prompt.
4. An employee communicates a legal issue with a client.
5. An employee asks what the general office hours are.

<details>
<summary>Show solution</summary>

A possible classification would be:

1. **Reply directly.** This is a simple informational query.
2. **Refer to a responsible person.** Involves sensitive data and a delicate administrative process.
3. **Respond directly.** The agent can give general guidance on prompting.
4. **Refer to a responsible person.** This is a legal and potentially sensitive matter.
5. **Respond directly.** This is general information about the organization.

The main criterion is to assess whether the query involves personal data, legal risks, permissions, sensitive decisions or information that the agent should not modify.

</details>

## Exercise 7: Design the basic schema of an agent

Design the basic outline of an agent for an online store. The agent should help customers with frequently asked questions, but should not process payments or modify orders.

<details>
<summary>Show solution</summary>

A possible scheme would be:

**Agent Name:**  
Online store help assistant.

**Objective:**  
Answer frequently asked questions from customers about products, shipping, returns, and general order status.

**Public:**  
Online store customers.

**Can do:**

- Explain shipping policies.
- Explain return conditions.
- Help find information about products.
- Indicate how to check the status of an order.
- Refer to human support if the case is complex.

**Cannot do:**

- Process payments.
- Change shipping addresses.
- Cancel orders directly.
- Modify personal data.
- Request bank details.

**Scaling response:**

```text
Para modificar un pedido o tratar información personal, debes contactar con el equipo de atención al cliente a través del canal oficial.
```


</details>
