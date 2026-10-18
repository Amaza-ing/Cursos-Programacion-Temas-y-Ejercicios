# Exercises - Topic 13: Professional best practices and Copilot adoption strategy

Below, you'll find hands-on exercises to use Copilot in a professional, safe and useful way. Try to solve them before looking at the solution.

## Exercise 1: Classify tasks by risk level

Classify the following tasks into three groups: low risk, medium risk or high risk.

1. Ask Copilot to explain a general technical concept.
2. Ask Copilot to draft a final legal contract.
3. Ask Copilot to generate a simple function to sort a list.
4. Ask Copilot to analyze customers' personal data.
5. Ask Copilot to propose a structure for an internal presentation.

<details>
<summary>Show solution</summary>

A possible classification would be:

**Low risk:**

- Explain a general technical concept.
- Propose a structure for an internal presentation.

**Medium risk:**

- Generate a simple function to sort a list.

Although it's a common technical task, the code should be reviewed and tested before you use it.

**High risk:**

- Draft a final legal contract.
- Analyze customers' personal data.

These tasks may involve legal consequences, privacy issues or sensitive decisions. They shouldn't be delegated entirely to Copilot.

</details>

## Exercise 2: Create a review checklist

Imagine that Copilot has generated a function to validate forms in a web application. Create a short checklist to review the code before accepting it.

<details>
<summary>Show solution</summary>

A possible checklist would be:

- Do I understand what each part of the code does?
- Does it do exactly what was asked?
- Does it follow the project's style?
- Does it handle errors or edge cases?
- Does it avoid unnecessary duplication?
- Is it free of sensitive data and secret values?
- Is it easy to maintain?
- Have tests been created or updated?
- Do the tests pass?
- Has the code been reviewed by a person if it affects an important part of the project?

This checklist helps you remember that Copilot can speed up your work, but it's no substitute for a technical review.

</details>

## Exercise 3: Improve a usage policy that is too vague

A company has written this rule:

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

This version is better because it states:

- When AI can be used.
- What limits exist.
- What type of information should not be entered.
- That human review is mandatory.

</details>

## Exercise 4: Design a professional workflow with Copilot

Describe a professional workflow for using Copilot when creating a new feature in an application.

<details>
<summary>Show solution</summary>

A suitable workflow could be:

1. Clearly define the feature you want to create.
2. Review the project's architecture before asking for code.
3. Write a prompt with context, goal, constraints and expected format.
4. Ask Copilot for a first proposal.
5. Check whether the proposal fits the project.
6. Manually change whatever is necessary.
7. Ask Copilot to propose tests.
8. Run the tests.
9. Review security, readability and maintainability.
10. Document the important changes.
11. Create a clear commit.
12. Ask for a review if the change is significant.

Copilot should be integrated into the development flow, not replace it.

</details>

## Exercise 5: Spot a misuse of Copilot

Read the following case:

> A developer copies a Copilot-generated function directly into production. He doesn't review it, he doesn't test it, and he doesn't fully understand how it works. The function processes customer payments.

Explain what mistakes are being made.

<details>
<summary>Show solution</summary>

The main mistakes are:

- Using generated code without reviewing it.
- Not running tests.
- Not understanding the code before adding it.
- Applying it directly in production.
- Using it in a critical part of the system.
- Not reviewing possible security problems.
- Not checking edge cases.
- Not following a peer review process.

This is a misuse of Copilot because a critical decision is being delegated to a tool that can make mistakes.

</details>

## Exercise 6: Choose suitable tasks for Copilot

Say which of these tasks are suitable for Copilot and which require close human supervision:

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

These tasks still need a review, but they're reasonable uses of Copilot.

**Require close human supervision or shouldn't be delegated:**

- Decide whether to fire an employee.
- Review a complex legal clause.

These tasks have important personal, legal or ethical implications.

</details>

## Exercise 7: Create a short guide for a team

Write a guide with 5 rules for a team that is starting to use Copilot responsibly.

<details>
<summary>Show solution</summary>

A possible guide would be:

1. Use Copilot as support, not as a substitute for your professional judgment.
2. Don't enter personal data, credentials, secrets, customer information or confidential documentation into unauthorized tools.
3. Always review generated content before using it.
4. Check the code with tests and reviews before adding it to the project.
5. If an answer affects legal, financial, medical, employment or security decisions, check with a person in charge.

These rules are simple and can serve as a starting point for a more complete internal policy.

</details>

## Exercise 8: Evaluate the quality of a Copilot answer

Imagine that Copilot answers a technical question with an explanation that seems correct, but it doesn't cite sources, doesn't mention any limitations and proposes a command that you don't understand. What should you do before using that answer?

<details>
<summary>Show solution</summary>

Before using the answer, you should:

- Read the explanation calmly.
- Not run commands you don't understand.
- Ask Copilot to explain the command step by step.
- Check the official documentation.
- Test it first in a safe environment.
- Check whether the command can modify, delete or expose information.
- Ask another person for a review if it affects an important system.

A useful prompt would be:

```text
Explica este comando paso a paso. Indica qué modifica, qué riesgos tiene, si puede borrar datos y cómo podría probarlo de forma segura antes de ejecutarlo en un entorno real.
```

</details>
