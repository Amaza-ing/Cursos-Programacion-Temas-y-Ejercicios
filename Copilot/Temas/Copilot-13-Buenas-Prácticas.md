# Topic 13 — Good professional practices and Copilot adoption strategy

## 1. Introduction

In the previous topics we have seen how to use Copilot in different contexts:

- Generative AI and Copilot ecosystem;
- GitHub Copilot for development;
- prompting for programmers;
- Copilot Chat;
- testing, debugging and refactoring;
- agents, CLI and custom instructions;
- Docker, APIs and GitHub Actions;
- Microsoft 365 Copilot;
- Copilot Studio.

This last topic has a different objective: learning to integrate Copilot in a professional, sustainable and responsible way into daily work.

Knowing how to use Copilot does not mean asking you anything and accepting the first answer. It means knowing when to use it, how to ask it for help, how to review what it generates, and how to incorporate it into a real workflow.

---

## 2. Objectives of the topic

By the end of this topic you should be able to:

- Design a professional way of working with Copilot.
- Decide which tasks can be partially delegated to AI.
- Know which tasks require mandatory human review.
- Create validation checklists.
- Define basic rules of use for equipment.
- Integrate Copilot into development and productivity flows.
- Avoid excessive dependence on AI.
- Evaluate the quality of the results generated.

---

## 3. The main idea: Copilot as an assistant, not a substitute

Copilot should be understood as an assistant.

It can help:

- speed up tasks;
- generate drafts;
- explain concepts;
- suggest code;
- detect problems;
- summarize information;
- prepare documentation;
- automate repetitive parts.

But it should not replace:

- professional judgment;
- human review;
- technical knowledge;
- responsibility for the result;
- data verification;
- safety regulations;
- the organization's policies.

A good rule of thumb is:

```text
Copilot puede proponer. La persona decide, revisa y se responsabiliza.
```

---

# Part 1. Which tasks to delegate and which not to

## 4. Tasks suitable for Copilot

Copilot usually works well as support in tasks such as:

- generate first versions;
- summarize documents;
- explain code;
- create examples;
- propose structures;
- write documentation;
- suggest tests;
- refactor simple code;
- detect obvious errors;
- convert notes to organized text;
- prepare emails or presentations;
- generate initial ideas.

These tasks are appropriate because they usually allow for subsequent review, correction, and improvement.

---

## 5. Tasks that require special review

There are tasks where Copilot can help, but the review must be stricter:

- production code;
- security settings;
- database queries;
- deployment scripts;
- CI/CD workflows;
- infrastructure as code;
- analysis of important data;
- legal or contractual documents;
- external communication with clients;
- decisions that affect real users.

In these cases, Copilot can be useful in generating an initial proposal, but should not be accepted without testing and validation.

---

## 6. Tasks that should not be delegated completely

It is not advisable to delegate completely:

- strategic decisions;
- legal decisions;
- medical decisions;
- financial decisions;
- final safety evaluation;
- final review of critical code;
- confidential data management;
- approval of changes in production;
- sensitive communication with clients or employees;
- definitive interpretation of internal policies.

Copilot can help prepare information, but should not be the final authority.

---

# Part 2. Professional workflow with Copilot

## 7. Recommended flow

A professional flow with Copilot can follow these steps:

1. Define the objective.
2. Give context.
3. Ask for a first proposal.
4. Review the answer.
5. Ask for improvements.
6. Compare important data.
7. Test if it is code or configuration.
8. Document the changes.
9. Review with another person if necessary.
10. Accept, modify or discard.

This flow avoids the most common mistake: accepting the first thing the AI ​​generates too quickly.

---

## 8. Step 1: define the objective

Before writing a prompt, we must know what we want.

Bad approach:

```text
Hazme esto.
```

Best approach:

```text
Necesito crear una función que valide formularios de registro. Debe comprobar email, contraseña y nombre de usuario. Quiero que el código sea claro, fácil de testear y sin dependencias externas.
```

The clearer the objective, the better the response.

---

## 9. Step 2: Give context

Context allows Copilot to understand the work environment.

Example for development:

```text
Estoy trabajando en una aplicación React con Vite. Uso JavaScript, no TypeScript. Quiero crear un componente sencillo y mantener los estilos en CSS separado.
```

Example for productivity:

```text
Estoy preparando un correo para un cliente que ha pedido una actualización del proyecto. Quiero sonar profesional, transmitir tranquilidad y explicar que enviaremos avances el viernes.
```

---

## 10. Step 3: ask for a first proposal

Once the context is given, we ask for a proposal.

Example:

```text
Propón una primera versión de la función. Después explica brevemente cómo funciona y qué casos debería probar.
```

It is helpful to always ask for an explanation, not just the result.

---

## 11. Step 4: Review

You have to check:

- if it meets the objective;
- if it respects the context;
- if there are errors;
- if information is missing;
- if you introduce unwanted dependencies;
- if the style fits the project;
- if there are security risks;
- if there are invented parts.

---

## 12. Step 5: Ask for improvements

The first answer is rarely the best.

We can ask:

```text
Simplifica esta solución y elimina código innecesario.
```

```text
Adapta la solución para que sea más fácil de testear.
```

```text
Reescribe el texto con un tono más claro y menos comercial.
```

```text
Señala posibles problemas antes de darme la versión final.
```

---

## 13. Step 6: Test and Verify

If it is code:

- execute the project;
- pass tests;
- check errors;
- check borderline cases;
- do manual review;
- review security.

If it is text:

- check data;
- check tone;
- verify names and dates;
- adapt to the public;
- remove repetitions;
- confirm that there is no confidential information.

If it is data analysis:

- review columns;
- check formulas;
- compare results;
- validate assumptions;
- check for missing or atypical data.

---

# Part 3. Quality checklist

## 14. General checklist for any Copilot results

Before using a response generated by Copilot, review:

- [ ] Does it respond exactly to the objective?
- [ ] Do you use the correct context?
- [ ] Is the format appropriate?
- [ ] Is there invented data?
- [ ] Are there technical errors?
- [ ] Has sensitive information been included?
- [ ] Is the tone appropriate?
- [ ] Do you need verification with external sources?
- [ ] Does it require review by another person?
- [ ] Is the final responsibility clear?

---

## 15. Checklist for generated code

Before accepting code generated by Copilot:

- [ ] Do I understand what it does?
- [ ] Does it compile or run correctly?
- [ ] Do you respect the project architecture?
- [ ] Do you follow the team's style?
- [ ] Do you have clear names?
- [ ] Avoid unnecessary duplication?
- [ ] Do you have tests?
- [ ] Do you control errors?
- [ ] Are there security problems?
- [ ] Does it introduce unnecessary dependencies?
- [ ] Does it work in extreme cases?
- [ ] Is it documented if necessary?

---

## 16. Checklist for documentation

Before publishing documentation generated with Copilot:

- [ ] Is it updated?
- [ ] Is it clear for the target audience?
- [ ] Do you have correct examples?
- [ ] Don't you promise things that aren't true?
- [ ] Does not contain unauthorized internal information?
- [ ] Is it well structured?
- [ ] Do you avoid repetitions?
- [ ] Do you distinguish facts from recommendations?

---

## 17. Checklist for presentations and emails

Before submitting or submitting generated content:

- [ ] Is the tone appropriate?
- [ ] Is the message clear?
- [ ] Is there sensitive information?
- [ ] Are the names and dates correct?
- [ ] Is the content too generic?
- [ ] Missing context?
- [ ] Can it be misinterpreted?
- [ ] Need a shorter version?
- [ ] Does it represent the position of the person or company well?

---

# Part 4. Use in teams

## 18. Why teams need norms

When a person uses Copilot individually, they can review their own results.

But when a whole team uses it, new questions arise:

- What data can be entered?
- What tools are allowed?
- Can it be used with private code?
- Who reviews the generated code?
- How is the use of AI documented?
- What happens if Copilot generates something incorrect?
- Are there prohibited tasks?
- What quality criteria are applied?

That is why it is convenient to define internal rules.

---

## 19. Basic Copilot usage policy for teams

A simple policy could include:

```text
1. Copilot puede usarse como herramienta de apoyo, pero no sustituye la revisión humana.
2. No se deben introducir contraseñas, claves privadas, tokens ni información confidencial no autorizada.
3. Todo código generado debe revisarse antes de integrarse.
4. Los cambios importantes deben pasar por pull request y revisión.
5. Los tests deben ejecutarse antes de aceptar código generado.
6. La documentación generada debe validarse antes de publicarse.
7. Las respuestas de Copilot no se consideran fuente oficial.
8. Las decisiones críticas requieren aprobación humana.
```

---

## 20. Roles in a flow with Copilot

In a team there can be different roles:

| Role | Responsibility |
| ------------------------ | ---------------------------------------------------- |
| User person | Formulate prompts, review results and decide what to use |
| Technical reviewer | Review code, architecture and security |
| Data Manager | Defines what information can be used |
| Security Manager | Evaluate risks and permissions |
| Team manager | Defines standards and good practices |

They will not always be different people, but responsibilities must be clear.

---

## 21. Integration with Git and GitHub

In development projects, a recommended flow would be:

1. Create a branch for the change.
2. Use Copilot to generate or improve specific parts.
3. Manually review the result.
4. Run tests.
5. Create clear commits.
6. Open a pull request.
7. Review with another person.
8. Use GitHub Actions to validate.
9. Correct problems.
10. Merge only when approved.

Copilot can participate in various parts of the process, but must not bypass the team controls.

---

# Part 5. Adoption Strategy
## 22. How to introduce Copilot in an organization

A reasonable adoption can be done in phases.

### Phase 1. Exploration

Objective: understand possibilities and limits.

Actions:

- test simple cases;
- identify repetitive tasks;
- form a small group;
- collect doubts and risks.

### Phase 2. Pilot

Objective: test Copilot in a controlled environment.

Actions:

- choose a team or project;
- define basic standards;
- measure time savings;
- check quality;
- document frequent errors.

### Phase 3. Standardization

Objective: create common practices.

Actions:

- define recommended prompts;
- create checklists;
- document good practices;
- train more people;
- review security policies.

### Phase 4. Scaling

Objective: expand use safely.

Actions:

- extend to more teams;
- integrate with workflows;
- create agents if applicable;
- measure impact;
- periodically review the policy.

---

## 23. Metrics to evaluate Copilot

To know if Copilot is providing value, you can measure indicators such as:

- reduction of time on repetitive tasks;
- improvement in documentation;
- number of tests generated;
- reduction of simple errors;
- team satisfaction;
- quality of the prompts;
- number of discarded results;
- incidents related to incorrect use;
- review time;
- impact on onboarding of new members.

It is not enough to measure how much Copilot is used. You have to measure if the work improves.

---

## 24. Risks of a bad adoption

A poorly managed adoption can cause:

- excessive dependence;
- loss of technical judgment;
- unreviewed code;
- errors in production;
- incorrect documentation;
- information leak;
- decisions based on unverified answers;
- false sense of productivity;
- reduction of real learning;
- conflicts over responsibility.

---

## 25. Good practices for learning with Copilot

Copilot can also be a learning tool.

But to really learn, you should:

- ask for explanations, not just solutions;
- compare alternatives;
- try to solve one part first;
- ask about errors;
- ask for progressive examples;
- modify the generated code;
- check if each line is understood;
- create your own summaries;
- do not copy without understanding.

A good learning prompt would be:

```text
Explícame esta solución paso a paso. Después hazme tres preguntas para comprobar si la he entendido.
```

Another example:

```text
Dame dos formas de resolver este problema, compara ventajas e inconvenientes y recomiéndame una para un proyecto pequeño.
```

---

# Part 6. Final templates

## 26. Professional prompt template

```text
Necesito [objetivo].
Estoy trabajando en [contexto].
El resultado debe servir para [uso final].
Debes tener en cuenta [restricciones].
Quiero la respuesta en formato [formato].
Antes de dar la respuesta final, señala posibles problemas o riesgos.
```

Example:

```text
Necesito refactorizar esta función.
Estoy trabajando en una aplicación JavaScript sencilla para alumnos principiantes.
El resultado debe servir para explicar buenas prácticas de legibilidad.
Debes mantener el mismo comportamiento y no añadir librerías externas.
Quiero la respuesta en formato: código refactorizado, explicación y posibles tests.
Antes de dar la respuesta final, señala posibles problemas o riesgos.
```

---

## 27. Template for reviewing a Copilot response

```text
Revisa la respuesta anterior.
Comprueba si cumple el objetivo inicial.
Señala errores, ambigüedades, riesgos o partes inventadas.
Propón una versión mejorada.
No añadas información que no puedas justificar.
```

---

## 28. Template for ordering alternatives

```text
Dame tres alternativas para resolver este problema.
Para cada alternativa, indica ventajas, inconvenientes, nivel de dificultad y cuándo conviene usarla.
Termina recomendando una opción para mi caso concreto.
```

---

## 29. Template for documentation

```text
Genera documentación para este código.
Incluye: propósito, parámetros, valor devuelto, ejemplo de uso, posibles errores y notas importantes.
Usa un lenguaje claro para personas con nivel principiante/intermedio.
```

---

## 30. Meeting and Productivity Template

```text
Convierte estas notas en un resumen profesional.
Organiza la información en: contexto, decisiones tomadas, tareas pendientes, responsables, fechas y dudas abiertas.
Usa un tono claro y directo.
```

---

## 31. Conclusion of the course

Copilot and GitHub Copilot are very powerful tools, but their value depends on how they are used.

During the course we have seen that Copilot can help:

- write and review code;
- document;
- generate tests;
- detect errors;
- automate workflows;
- work with APIs;
- prepare documents;
- analyze data;
- create presentations;
- summarize meetings;
- design agents.

But we have also seen that there are limits:

- you can be wrong;
- can invent;
- may propose unsafe code;
- may not understand the context;
- may generate results that are too generic;
- can create dependency if used incorrectly.

Professional competence is not about using Copilot to avoid thinking, but about using it to think better, work faster, and review more judiciously.

---

## 32. Summary of the topic

The main ideas are:

- Copilot should be used as an assistant, not a substitute.
- The professional flow includes context, review, testing and validation.
- Not all tasks are equally suitable for AI.
- The equipment needs clear rules of use.
- Adoption must be gradual and measurable.
- Human review remains essential.
- A good use of Copilot combines productivity, technical judgment and responsibility.

---

## 33. Recommended documentation

- Microsoft Learn — Microsoft Copilot documentation: https://learn.microsoft.com/en-us/copilot/
- Microsoft Learn — Microsoft 365 Copilot documentation: https://learn.microsoft.com/en-us/microsoft-365/copilot/
- Microsoft Learn — Copilot Studio documentation: https://learn.microsoft.com/en-us/microsoft-copilot-studio/
- GitHub Docs — GitHub Copilot documentation: https://docs.github.com/copilot
- GitHub Docs — Responsible use of GitHub Copilot: https://docs.github.com/en/copilot/responsible-use
