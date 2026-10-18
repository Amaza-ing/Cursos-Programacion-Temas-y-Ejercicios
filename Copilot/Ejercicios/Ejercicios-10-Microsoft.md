# Exercises - Topic 10: Microsoft Copilot on Windows and Edge

Below, you'll find hands-on exercises for working with Microsoft Copilot on Windows and Edge. Try to solve them before looking at the solution.

## Exercise 1: Create a prompt to summarize a web page

Imagine that you're reading a long web page about artificial intelligence trends in companies. Write a prompt to ask Copilot in Edge to summarize the page and extract the most important ideas.

The prompt should ask for:

- A brief summary.
- The 5 main ideas.
- Possible professional applications.
- A warning about information that should be verified.

<details>
<summary>Show solution</summary>

A possible prompt would be:

```text
Resume esta página web en un máximo de 10 líneas. Después, extrae las 5 ideas principales en forma de lista y explica brevemente cómo podrían aplicarse en un contexto profesional. Al final, indica qué datos, cifras o afirmaciones importantes debería verificar antes de usarlos en un informe.
```


This prompt is suitable because it doesn't just ask for a general summary. It also sets the format of the answer, asks for a practical application and reminds you that the generated information must be reviewed before being used professionally.

</details>

## Exercise 2: Turn information into a simple explanation

Suppose you have a technical article on cybersecurity open in Edge and you want to understand it without any advanced knowledge. Write a prompt to ask Copilot to explain it simply.

<details>
<summary>Show solution</summary>

A possible prompt would be:

```text
Explícame el contenido de esta página como si estuviera empezando a estudiar ciberseguridad. Usa un lenguaje sencillo, evita tecnicismos innecesarios y añade ejemplos cotidianos para entender los conceptos principales.
```


You could also add a request about the structure:

```text
Organiza la explicación en tres apartados: concepto principal, riesgos importantes y ejemplo práctico.
```


The key is to adapt the level of the explanation to the user's knowledge, not just to ask for a literal translation of the content.

</details>

## Exercise 3: Prepare a smart search

You want to find information about AI tools to improve the productivity of an administrative team. Write a prompt for Copilot that helps organize the search.

It must include:

- What type of tools to look for.
- Comparison criteria.
- A final table.
- A recommendation to review the sources.

<details>
<summary>Show solution</summary>

A possible prompt would be:

```text
Ayúdame a buscar herramientas de inteligencia artificial para mejorar la productividad de un equipo administrativo. Organiza la información en una tabla con estas columnas: herramienta, uso principal, ventajas, posibles limitaciones, coste aproximado si está disponible y fuente consultada. Prioriza herramientas que sirvan para redactar documentos, resumir información, organizar tareas y preparar reuniones. Indica al final qué datos debería comprobar manualmente antes de tomar una decisión.
```


This prompt works because it turns a general search into an organized comparison. It also asks for sources and keeps in mind that prices, availability or features may change.

</details>

## Exercise 4: Spot sensitive information before using Copilot

Read the following case:

> A worker wants to use Copilot to summarize an internal document that contains customer names, contract numbers, amounts of money and private comments from meetings.

Say what she should do before copying that content into Copilot.

<details>
<summary>Show solution</summary>

Before using Copilot, she should check whether she has permission to enter that information into the tool. She should also delete or anonymize the sensitive data.

A suitable answer would be:

- Don't copy real customer names directly.
- Delete contract numbers, confidential amounts and private data.
- Replace real data with fictional examples if she only needs help with the structure.
- Check the company's policy on the use of AI.
- Use only tools authorized by the organization.
- Review the result before sharing it.

For example, instead of entering:

```text
El cliente Juan Pérez, contrato 4588-XZ, reclama una devolución de 12.500 €.
```


She could write:

```text
Un cliente solicita una devolución económica asociada a un contrato. Resume el caso de forma profesional sin incluir datos personales.
```


</details>

## Exercise 5: Create a workflow with Copilot in Edge

Imagine that you have to prepare a brief explanation of the advantages and risks of using generative AI in a company. Describe step by step how you would use Copilot in Edge to help you.

<details>
<summary>Show solution</summary>

A possible workflow would be:

1. Search for reliable pages on generative AI in companies.
2. Open a relevant page in Microsoft Edge.
3. Ask Copilot for a summary of the content.
4. Ask it to extract the advantages and risks into two separate lists.
5. Ask for practical examples of how to apply it in a company.
6. Compare the information with other sources.
7. Ask for a clearer, shorter version to explain out loud.
8. Manually review the content before using it.

A possible prompt would be:

```text
Resume esta página sobre IA generativa en empresas. Después, separa la información en dos apartados: ventajas y riesgos. Añade ejemplos concretos de uso empresarial y señala qué afirmaciones debería verificar con otras fuentes.
```


</details>

## Exercise 6: Improve a prompt that is too general

Look at this prompt:

```text
Háblame de Copilot.
```


Improve it so that it can be used to prepare a short explanation of Microsoft Copilot on Windows and Edge for non-technical people.

<details>
<summary>Show solution</summary>

An improved version would be:

```text
Prepara una explicación breve sobre Microsoft Copilot en Windows y Edge para personas sin conocimientos técnicos. Explica qué es, para qué puede servir, qué tareas puede ayudar a realizar y qué precauciones básicas deben tenerse en cuenta. Usa un tono claro, ejemplos sencillos y una extensión máxima de 300 palabras.
```


This prompt is better because it specifies:

- The topic.
- The audience.
- The goal.
- The tone.
- The type of content.
- The approximate length.
- The need to include precautions.

</details>
