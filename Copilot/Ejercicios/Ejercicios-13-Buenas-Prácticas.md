# Exercises - Topic 13: Good professional practices and Copilot adoption strategy

Below, you will find practical exercises to apply Copilot in a professional, safe and useful way. Try to solve them before consulting the solution.

## Exercise 1: Classify tasks according to risk level

Classify the following tasks into three groups: low risk, medium risk or high risk.

1. Ask Copilot to explain a general technical concept.
2. Ask Copilot to draft a final legal contract.
3. Ask Copilot to generate a simple function to sort a list.
4. Ask Copilot to analyze personal customer data.
5. Ask Copilot to propose a structure for an internal presentation.

<details>
<summary>Show solution</summary>

A possible classification would be:

**Low risk:**

- Explain a general technical concept.
- Propose a structure for an internal presentation.

**Medium risk:**

- Generate a simple function to sort a list.

Although it is a common technical task, the code should be reviewed and tested before using it.

**High risk:**

- Write a definitive legal contract.
- Analyze personal data of clients.

These tasks may involve legal consequences, privacy, or sensitive decisions. They should not be delegated entirely to Copilot.

</details>

## Exercise 2: Create a review checklist

Imagine that Copilot has generated a function to validate forms in a web application. Create a short checklist to review the code before accepting it.

<details>
<summary>Show solution</summary>

A possible checklist would be:

- Do I understand what each part of the code does?
- Does it exactly meet the requested objective?
- Do you respect the style of the project?
- Do you manage errors or edge cases?
- Do you avoid unnecessary duplication?
- Do you not enter sensitive data or secret values?
- Is it easy to maintain?
- Have tests been created or updated?
- Do the tests pass correctly?
- Has the code been reviewed by a person if it affects an important part of the project?

This checklist helps remember that Copilot can speed up work, but it is not a substitute for technical review.

</details>

## Exercise 3: Improve a usage policy that is too vague

A company has written this standard:

```text
Se puede usar IA siempre que se use bien.
```

Rewrite the rule to make it clearer and more professional.

<details>
<summary>Show solution</summary>

A more suitable version would be:

```text
Las herramientas de inteligencia artificial podrán utilizarse como apoyo en tareas de redacción, análisis, programación, documentación y productividad, siempre que estén autorizadas por la empresa. No se deberá introducir información confidencial, datos personales, credenciales, código privado sensible ni documentación interna restringida en herramientas no aprobadas. Todo resultado generado por IA deberá ser revisado por una persona antes de utilizarse, publicarse o compartirse.
```

This version is better because it indicates:

- When AI can be used.
- What limits exist.
- What type of information should not be entered.
- That human review is mandatory.

</details>

## Exercise 4: Design a professional workflow with Copilot

Describes a professional workflow for using Copilot when creating new functionality in an application.

<details>
<summary>Show solution</summary>

A suitable flow could be:

1. Clearly define the functionality you want to create.
2. Review the project architecture before requesting code.
3. Write a prompt with context, objective, restrictions and expected format.
4. Ask Copilot for a first proposal.
5. Check if the proposal fits with the project.
6. Manually modify what is necessary.
7. Ask Copilot to propose tests.
8. Run the tests.
9. Review security, readability and maintenance.
10. Document important changes.
11. Create a clear commit.
12. Request review if the change is relevant.

Copilot should be integrated into the development flow, not replace it.

</details>

## Exercise 5: Detect misuse of Copilot

Read the following case:

> A developer copies a Copilot-generated feature directly into production. He doesn't review it, he doesn't test it, and he doesn't fully understand how it works. The function processes customer payments.

Explain what mistakes are being made.

<details>
<summary>Show solution</summary>

The main errors are:

- Use code generated without review.
- Do not run tests.
- Not understanding the code before incorporating it.
- Apply it directly in production.
- Use it in a critical part of the system.
- Not reviewing possible security problems.
- Do not check borderline cases.
- Not following a peer review process.

This is a misuse of Copilot because you are delegating a critical decision to a tool that can make mistakes.

</details>

## Exercise 6: Choose suitable tasks for Copilot

Indicate which of these tasks are suitable for Copilot and which require a lot of human supervision:

1. Generate ideas for variable names.
2. Explain a console error.
3. Decide whether to fire an employee.
4. Create a first draft of technical documentation.
5. Review a complex legal clause.
6. Propose unit tests for a function.

<details>
<summary>Show solution</summary>

**Suitable for Copilot:**

- Generate ideas for variable names.
- Explain a console error.
- Create a first draft of technical documentation.
- Propose unit tests for a function.

These tasks still need review, but are reasonable uses of Copilot.

**Requires a lot of human supervision or should not be delegated:**

- Decide whether to fire an employee.
- Review a complex legal clause.

These tasks have important personal, legal, or ethical implications.

</details>

## Exercise 7: Create a brief guide for a team

Write a guide of 5 rules for a team to start using Copilot responsibly.

<details>
<summary>Show solution</summary>

A possible guide would be:

1. Use Copilot as a support, not a substitute for your professional judgment.
2. Do not enter personal data, credentials, secrets, customer information or confidential documentation in unauthorized tools.
3. Always review generated content before using it.
4. Test the code with tests and reviews before incorporating it into the project.
5. If a response affects legal, economic, medical, employment or safety decisions, consult with a responsible person.

These rules are simple and can serve as a starting point for a more complete internal policy.

</details>
## Exercise 8: Evaluate the quality of a Copilot response

Imagine that Copilot answers a technical question with an apparently correct explanation, but does not cite sources, does not indicate limitations, and proposes a command that you do not understand. What should you do before using that answer?

<details>
<summary>Show solution</summary>

Before using the answer you should:

- Read the explanation calmly.
- Do not execute commands that you do not understand.
- Ask Copilot to explain the command step by step.
- Consult official documentation.
- Test first in a safe environment.
- Check if the command can modify, delete or expose information.
- Ask another person for review if it affects an important system.

A useful prompt would be:

```text
Explica este comando paso a paso. Indica qué modifica, qué riesgos tiene, si puede borrar datos y cómo podría probarlo de forma segura antes de ejecutarlo en un entorno real.
```

</details>
