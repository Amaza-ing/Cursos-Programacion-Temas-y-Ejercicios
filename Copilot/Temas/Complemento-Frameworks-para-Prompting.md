# Frameworks de Prompting con Copilot

## IA con Copilot

Este material está pensado perfiles de desarrollo como en perfiles administrativos, de gestión, soporte, documentación o coordinación interna.

La idea principal es aprender a pedir mejor a Copilot. Un buen prompt no consiste en escribir mucho, sino en dar a la IA la información adecuada: qué necesitas, para qué lo necesitas, en qué contexto trabajas, con qué formato debe responder y qué límites debe respetar.

---

## Objetivos de aprendizaje

Al final de esta clase, serás capaz de:

- Comprender para qué sirven los frameworks de prompting en un entorno profesional.
- Elegir el framework adecuado según el tipo de tarea.
- Aplicar frameworks de prompting a tareas de desarrollo, documentación, análisis, comunicación y administración.
- Crear prompts más claros, reutilizables y fáciles de mejorar.
- Revisar críticamente las respuestas de Copilot antes de usarlas en el trabajo.

---

## 1) ¿Qué es un framework de prompting?

Un framework de prompting es una estructura que nos ayuda a escribir instrucciones más claras para una IA.

En lugar de escribir una petición vaga como:

```text
Hazme un resumen de esto.
```

podemos escribir una petición más útil:

```text
Actúa como asistente de documentación interna.
Resume el siguiente texto en 5 ideas clave.
El objetivo es que una persona del equipo pueda entender rápidamente el estado del proyecto.
Usa un tono profesional, claro y directo.
Devuelve la respuesta en formato de lista.
```

La segunda opción funciona mejor porque incluye contexto, objetivo, rol, formato y criterios de calidad.

---

## 2) ¿Por qué usar frameworks en una consultora?

En una consultora, las tareas suelen ser variadas: desarrollo de software, soporte a clientes, documentación, preparación de informes, reuniones, seguimiento de proyectos, análisis de datos, propuestas comerciales o tareas administrativas.

Los frameworks de prompting ayudan a:

- **Ahorrar tiempo:** Reducen el ensayo y error al pedir tareas a Copilot.
- **Mejorar la calidad:** Las respuestas son más completas y ajustadas a lo que necesitamos.
- **Estandarizar el trabajo:** Varias personas pueden usar estructuras parecidas para tareas similares.
- **Reducir ambigüedad:** Copilot entiende mejor el contexto y el formato esperado.
- **Mejorar la revisión:** Es más fácil detectar si la respuesta cumple o no con el objetivo.
- **Trabajar mejor con clientes:** Ayudan a preparar comunicaciones, documentación y entregables más claros.

---

## 3) Buenas prácticas antes de usar Copilot

Antes de pegar información en Copilot, recuerda estas recomendaciones:

1. **No compartas información confidencial si no tienes autorización.** Evita datos reales de clientes, credenciales, contratos, información económica sensible o datos personales.
2. **Anonimiza los ejemplos.** Usa nombres ficticios como `Cliente A`, `Proyecto X`, `Usuario 1` o `Empresa Demo`.
3. **Revisa siempre la respuesta.** Copilot puede equivocarse, inventar datos o interpretar mal la petición.
4. **No copies código sin entenderlo.** Pide explicaciones si algo no está claro.
5. **Indica el formato de salida.** Tabla, lista, pasos, email, checklist, resumen ejecutivo, código comentado, etc.
6. **Da contexto suficiente.** Cuanto más clara sea la situación, mejor será la respuesta.
7. **Pide una segunda versión si hace falta.** Puedes solicitar que sea más breve, más formal, más técnico o más sencillo.

---

## 4) Cómo seleccionar el framework adecuado

No todos los frameworks sirven para lo mismo. Puedes elegirlos según la tarea que tengas delante.

| Necesidad                                                   | Framework recomendado |
| ----------------------------------------------------------- | --------------------- |
| Explicar un concepto técnico o funcional                    | RACE, CREO            |
| Pedir una tarea rápida y directa                            | TAG                   |
| Generar documentación, emails o materiales con ejemplo      | CARE                  |
| Crear una actividad, procedimiento o entregable paso a paso | APE, RISE             |
| Diseñar un prompt más completo y ajustado                   | CREATE                |
| Analizar un problema o bloqueo                              | PAIN                  |
| Planificar una tarea, reunión, entrega o mini-proyecto      | COAST                 |
| Pedir una solución completa y estructurada                  | ROSES                 |

---

# 5) Frameworks de prompting con ejemplos profesionales

---

## 5.1 RACE Framework

**RACE = Role – Action – Context – Explanation**

- **Role:** Qué papel debe adoptar Copilot.
- **Action:** Qué debe hacer.
- **Context:** En qué situación se va a usar la respuesta.
- **Explanation:** Cómo debe explicar o justificar la respuesta.

### Cuándo usarlo

Usa RACE cuando necesites una explicación clara, especialmente si quieres que Copilot adapte el nivel técnico al público.

### Ejemplo para desarrollo

```text
Role: Actúa como un desarrollador senior especializado en JavaScript.
Action: Explícame qué hace esta función y detecta posibles mejoras.
Context: Soy un desarrollador junior que está revisando código de un proyecto interno de una consultora.
Explanation: Explica primero la lógica general, después los posibles problemas y finalmente propón una versión mejorada con comentarios claros.

Código:
[Pega aquí el código, eliminando datos sensibles]
```

### Ejemplo para administración

```text
Role: Actúa como asistente administrativo de una consultora.
Action: Explícame de forma sencilla este procedimiento interno.
Context: Tengo que seguir el proceso para registrar gastos de viaje de un equipo de proyecto.
Explanation: Divide la explicación en pasos claros, indica qué documentos necesito y señala errores comunes que debería evitar.

Procedimiento:
[Pega aquí el texto del procedimiento]
```

### Plantilla reutilizable

```text
Role: Actúa como [rol].
Action: Necesito que [tarea].
Context: La situación es [contexto].
Explanation: Explica la respuesta de forma [nivel de detalle, tono o formato].
```

---

## 5.2 CARE Framework

**CARE = Context – Action – Result – Example**

- **Context:** Situación de partida.
- **Action:** Tarea concreta.
- **Result:** Resultado esperado.
- **Example:** Ejemplo o referencia del tipo de respuesta que quieres.

### Cuándo usarlo

Usa CARE cuando quieras que Copilot genere un resultado práctico con un ejemplo claro del estilo esperado.

### Ejemplo para desarrollo

```text
Context: Estoy documentando una API interna para que otros desarrolladores puedan usarla.
Action: Redacta una explicación breve del endpoint POST /tickets.
Result: Quiero que cualquier miembro del equipo entienda qué hace el endpoint, qué datos recibe y qué devuelve.
Example: Usa este estilo: "Este endpoint permite crear un nuevo ticket de soporte. Recibe los datos principales del ticket y devuelve el identificador generado."

Información del endpoint:
- Método: POST
- Ruta: /tickets
- Campos: title, description, priority, assignedTeam
- Respuesta: id, status, createdAt
```

### Ejemplo para administración

```text
Context: Tengo que enviar un correo a un cliente para solicitar documentación pendiente.
Action: Redacta un email profesional y amable.
Result: El cliente debe entender claramente qué documentos faltan y cuál es la fecha límite.
Example: Usa un tono parecido a: "Te escribo para hacer seguimiento de la documentación pendiente..."

Documentos pendientes:
- Certificado fiscal
- Datos de facturación actualizados
- Confirmación del responsable de contacto
Fecha límite: viernes 15
```

### Plantilla reutilizable

```text
Context: [Situación].
Action: [Qué debe hacer Copilot].
Result: [Qué resultado necesitas conseguir].
Example: [Ejemplo de estilo, estructura o contenido].
```

---

## 5.3 APE Framework

**APE = Action – Purpose – Execution**

- **Action:** Qué quieres que haga.
- **Purpose:** Para qué lo necesitas.
- **Execution:** Cómo debe entregarlo.

### Cuándo usarlo

Usa APE cuando tienes clara la tarea y quieres definir también su finalidad y el formato de ejecución.

### Ejemplo para desarrollo

```text
Action: Crea una lista de pruebas manuales para validar un formulario de registro.
Purpose: Necesito comprobar que el formulario funciona correctamente antes de pasarlo a QA.
Execution: Organiza la respuesta en una tabla con las columnas: caso de prueba, pasos, resultado esperado y prioridad.

Contexto del formulario:
- Campos: name, email, password, confirmPassword
- El email debe tener formato válido
- La contraseña debe tener mínimo 8 caracteres
```

### Ejemplo para administración

```text
Action: Prepara una checklist para organizar una reunión de seguimiento con un cliente.
Purpose: Quiero asegurarme de que no se olvida ninguna tarea antes, durante y después de la reunión.
Execution: Divide la checklist en tres apartados: antes de la reunión, durante la reunión y después de la reunión.
```

### Plantilla reutilizable

```text
Action: [Tarea].
Purpose: [Objetivo de la tarea].
Execution: [Formato, estructura o pasos que debe seguir].
```

---

## 5.4 CREATE Framework

**CREATE = Character – Request – Examples – Adjustment – Type – Extras**

- **Character:** Rol que debe asumir Copilot.
- **Request:** Petición principal.
- **Examples:** Ejemplos o referencias.
- **Adjustment:** Ajustes de tono, nivel o criterios.
- **Type:** Tipo de salida.
- **Extras:** Elementos adicionales.

### Cuándo usarlo

Usa CREATE cuando necesites una respuesta más completa, cuidada y adaptada a un contexto concreto.

### Ejemplo para desarrollo

```text
Character: Eres un mentor técnico de una consultora.
Request: Ayúdame a preparar una explicación sobre qué es una arquitectura MVC.
Examples: Puedes usar ejemplos sencillos relacionados con una aplicación de gestión de tareas.
Adjustment: El público tiene conocimientos básicos de programación, pero no experiencia profesional.
Type: Devuelve la explicación en formato markdown.
Extras: Añade una analogía, un ejemplo de carpetas y tres preguntas de repaso.
```

### Ejemplo para administración

```text
Character: Eres un consultor especializado en mejora de procesos administrativos.
Request: Ayúdame a mejorar este procedimiento de alta de proveedores.
Examples: El procedimiento debe ser claro, ordenado y fácil de seguir.
Adjustment: Usa lenguaje profesional, pero no demasiado técnico.
Type: Devuelve una versión reescrita con títulos y pasos numerados.
Extras: Añade una checklist final para validar que el alta está completa.

Procedimiento actual:
[Pega aquí el procedimiento]
```

### Plantilla reutilizable

```text
Character: Eres [rol].
Request: Necesito que [petición principal].
Examples: Ten en cuenta estos ejemplos o referencias: [ejemplos].
Adjustment: Ajusta la respuesta a [tono, nivel, longitud o restricciones].
Type: Devuelve el resultado en formato [tipo de salida].
Extras: Añade [elementos adicionales].
```

---

## 5.5 TAG Framework

**TAG = Task – Action – Goal**

- **Task:** Tarea general.
- **Action:** Acción concreta.
- **Goal:** Objetivo final.

### Cuándo usarlo

Usa TAG para peticiones rápidas y directas. Es útil cuando la tarea no necesita mucho contexto.

### Ejemplo para desarrollo

```text
Task: Revisión rápida de código.
Action: Detecta errores evidentes y sugiere mejoras de legibilidad.
Goal: Dejar el código más claro antes de subirlo al repositorio.

Código:
[Pega aquí el código]
```

### Ejemplo para administración

```text
Task: Resumen de reunión.
Action: Convierte estas notas en un resumen ordenado con acuerdos y tareas pendientes.
Goal: Enviar el resumen al equipo de proyecto.

Notas:
[Pega aquí las notas de la reunión]
```

### Plantilla reutilizable

```text
Task: [Tarea general].
Action: [Acción concreta].
Goal: [Objetivo final].
```

---

## 5.6 CREO Framework

**CREO = Context – Request – Explanation – Outcome**

- **Context:** Situación.
- **Request:** Petición.
- **Explanation:** Tipo de explicación que necesitas.
- **Outcome:** Resultado final esperado.

### Cuándo usarlo

Usa CREO cuando quieres que Copilot no solo genere una respuesta, sino que también explique por qué propone esa respuesta.

### Ejemplo para desarrollo

```text
Context: Estoy aprendiendo a usar Git en un equipo de desarrollo.
Request: Explícame la diferencia entre git merge y git rebase.
Explanation: Usa un lenguaje sencillo, con un ejemplo práctico y sin asumir conocimientos avanzados.
Outcome: Al final, añade una recomendación sobre cuándo usar cada opción en un proyecto de consultora.
```

### Ejemplo para administración

```text
Context: Estoy revisando una hoja de cálculo con tareas de varios proyectos.
Request: Propón una forma de organizar mejor las columnas.
Explanation: Explica por qué cada columna sería útil.
Outcome: Devuelve una tabla con las columnas recomendadas y una breve descripción de cada una.
```

### Plantilla reutilizable

```text
Context: [Situación].
Request: [Qué necesitas].
Explanation: [Cómo debe explicarlo].
Outcome: [Resultado final esperado].
```

---

## 5.7 RISE Framework

**RISE = Role – Input – Steps – Execution**

- **Role:** Rol que debe adoptar Copilot.
- **Input:** Información de entrada.
- **Steps:** Pasos que debe seguir.
- **Execution:** Cómo debe entregar la respuesta.

### Cuándo usarlo

Usa RISE para procesos paso a paso, especialmente cuando quieres que Copilot trabaje de forma ordenada.

### Ejemplo para desarrollo

```text
Role: Actúa como un desarrollador senior revisando una incidencia.
Input: La aplicación muestra un error 500 al enviar un formulario.
Steps:
1. Enumera posibles causas.
2. Indica qué archivos o logs revisaría.
3. Propón pruebas para aislar el problema.
4. Sugiere una solución inicial.
Execution: Devuelve la respuesta como una guía de diagnóstico paso a paso.
```

### Ejemplo para administración

```text
Role: Actúa como coordinador de operaciones de una consultora.
Input: Tenemos que preparar la incorporación de una nueva persona al equipo.
Steps:
1. Lista la documentación necesaria.
2. Define tareas para RR. HH., IT y responsable de proyecto.
3. Propón un calendario de incorporación para la primera semana.
4. Añade una checklist final.
Execution: Presenta la respuesta en formato tabla.
```

### Plantilla reutilizable

```text
Role: Actúa como [rol].
Input: La información de partida es [datos o situación].
Steps: Sigue estos pasos: [pasos].
Execution: Devuelve la respuesta en formato [formato].
```

---

## 5.8 PAIN Framework

**PAIN = Problem – Action – Information – Next Steps**

- **Problem:** Problema o bloqueo.
- **Action:** Qué debe hacer Copilot.
- **Information:** Información disponible o información que falta.
- **Next Steps:** Próximas acciones recomendadas.

### Cuándo usarlo

Usa PAIN cuando hay un problema que necesitas analizar, desbloquear o convertir en un plan de acción.

### Ejemplo para desarrollo

```text
Problem: El equipo tarda demasiado en revisar pull requests y se acumulan cambios pendientes.
Action: Analiza posibles causas y propón mejoras.
Information: Somos 5 desarrolladores, usamos GitHub y solemos revisar los PR al final del día.
Next Steps: Dame un plan de mejora con acciones concretas para la próxima semana.
```

### Ejemplo para administración

```text
Problem: Se están retrasando varias facturas porque la información llega incompleta.
Action: Identifica posibles puntos de fallo en el proceso.
Information: Los datos suelen llegar por email, cada proyecto usa un formato distinto y a veces falta el número de pedido.
Next Steps: Propón un procedimiento sencillo para reducir errores y una plantilla de solicitud de datos.
```

### Plantilla reutilizable

```text
Problem: [Problema].
Action: [Qué quieres que haga Copilot].
Information: [Datos disponibles o información que falta].
Next Steps: [Qué tipo de próximos pasos necesitas].
```

---

## 5.9 COAST Framework

**COAST = Context – Objective – Actions – Scenario – Task**

- **Context:** Situación general.
- **Objective:** Objetivo que quieres conseguir.
- **Actions:** Acciones que deben contemplarse.
- **Scenario:** Escenario o condiciones.
- **Task:** Tarea final para Copilot.

### Cuándo usarlo

Usa COAST para planificar tareas, reuniones, entregas, procesos o pequeños proyectos.

### Ejemplo para desarrollo

```text
Context: Tenemos que preparar la entrega de una nueva funcionalidad para un cliente.
Objective: Llegar a la demo con la funcionalidad probada y una explicación clara.
Actions: Revisar código, probar casos principales, preparar datos de ejemplo y documentar cambios.
Scenario: El equipo tiene tres días y participan desarrollo, QA y responsable funcional.
Task: Crea un plan de trabajo dividido por días, responsables y entregables.
```

### Ejemplo para administración

```text
Context: La consultora va a organizar una sesión interna de formación sobre Copilot.
Objective: Conseguir que el personal administrativo aprenda a usar prompts básicos en su trabajo diario.
Actions: Preparar ejemplos, ejercicios, material de apoyo y una encuesta final.
Scenario: La sesión dura 2 horas y los asistentes tienen niveles muy distintos.
Task: Diseña una agenda de la sesión con tiempos, actividades y materiales necesarios.
```

### Plantilla reutilizable

```text
Context: [Situación general].
Objective: [Objetivo].
Actions: [Acciones que deben incluirse].
Scenario: [Condiciones, restricciones o participantes].
Task: [Tarea concreta que debe realizar Copilot].
```

---

## 5.10 ROSES Framework

**ROSES = Role – Objective – Scenario – Expected solution – Steps**

- **Role:** Rol que adopta Copilot.
- **Objective:** Objetivo principal.
- **Scenario:** Escenario concreto.
- **Expected solution:** Tipo de solución esperada.
- **Steps:** Pasos que debe seguir o incluir.

### Cuándo usarlo

Usa ROSES para pedir soluciones más completas, estructuradas y profesionales.

### Ejemplo para desarrollo

```text
Role: Actúa como arquitecto de software en una consultora.
Objective: Proponer una estructura inicial para una aplicación web de gestión de incidencias.
Scenario: El proyecto será desarrollado por un equipo junior usando frontend, backend y base de datos.
Expected solution: Una propuesta clara de módulos, carpetas principales y responsabilidades.
Steps:
1. Describe la estructura general.
2. Explica la responsabilidad de cada módulo.
3. Indica buenas prácticas básicas.
4. Añade riesgos habituales en proyectos junior.
```

### Ejemplo para administración

```text
Role: Actúa como responsable de operaciones de una consultora.
Objective: Mejorar el proceso de seguimiento de tareas administrativas.
Scenario: El equipo usa hojas de cálculo, email y reuniones semanales.
Expected solution: Un sistema sencillo de seguimiento que no requiera herramientas nuevas.
Steps:
1. Propón una estructura de hoja de seguimiento.
2. Define estados de tarea.
3. Sugiere una dinámica semanal de revisión.
4. Añade una plantilla breve para informar avances.
```

### Plantilla reutilizable

```text
Role: Actúa como [rol].
Objective: El objetivo es [objetivo].
Scenario: El escenario es [situación].
Expected solution: Espero una solución con [características].
Steps: Incluye estos pasos: [pasos].
```

---

# 6) Checklist para escribir mejores prompts

Antes de enviar un prompt a Copilot, revisa si has incluido:

- [ ] Qué quieres que haga.
- [ ] Para qué lo necesitas.
- [ ] Qué rol debe asumir.
- [ ] Qué contexto debe conocer.
- [ ] Qué formato de salida quieres.
- [ ] Qué nivel de detalle necesitas.
- [ ] Qué tono debe usar.
- [ ] Qué información debe evitar o proteger.
- [ ] Qué ejemplos puede seguir.
- [ ] Cómo sabrás si la respuesta es útil.

---

# 7) Errores comunes al usar Copilot

## Error 1: Pedir algo demasiado genérico

```text
Explícame Git.
```

Mejor:

```text
Explícame Git para una persona que empieza a trabajar en una consultora tecnológica.
Céntrate en commit, branch, merge y pull request.
Usa ejemplos sencillos y termina con una tabla resumen.
```

## Error 2: No indicar el formato

```text
Organiza estas tareas.
```

Mejor:

```text
Organiza estas tareas en una tabla con las columnas: tarea, responsable, prioridad, fecha límite y estado.
```

## Error 3: No indicar el público

```text
Redacta una explicación sobre este proyecto.
```

Mejor:

```text
Redacta una explicación sobre este proyecto para una persona del área administrativa que no tiene conocimientos técnicos.
Usa lenguaje claro y evita jerga de programación.
```

## Error 4: No pedir revisión crítica

```text
Crea este procedimiento.
```

Mejor:

```text
Crea este procedimiento y después añade una sección final con posibles riesgos, puntos ambiguos y mejoras recomendadas.
```

---

# 8) Conclusiones clave

- Un buen prompt da contexto, objetivo, formato y límites.
- Los frameworks ayudan a convertir peticiones vagas en instrucciones claras.
- No hace falta usar siempre el framework más largo: elige según la tarea.
- Copilot es útil para generar borradores, ideas, explicaciones, documentación y planes de trabajo.
- Las respuestas de Copilot siempre deben revisarse antes de usarse profesionalmente.
- En una consultora, la confidencialidad y la calidad de la información son tan importantes como la rapidez.

---

# 9) Resumen rápido de frameworks

| Framework | Significado                                            | Mejor para                         |
| --------- | ------------------------------------------------------ | ---------------------------------- |
| RACE      | Role, Action, Context, Explanation                     | Explicaciones claras               |
| CARE      | Context, Action, Result, Example                       | Resultados prácticos con ejemplo   |
| APE       | Action, Purpose, Execution                             | Tareas con objetivo y formato      |
| CREATE    | Character, Request, Examples, Adjustment, Type, Extras | Prompts completos y personalizados |
| TAG       | Task, Action, Goal                                     | Peticiones rápidas                 |
| CREO      | Context, Request, Explanation, Outcome                 | Explicaciones con resultado final  |
| RISE      | Role, Input, Steps, Execution                          | Procesos paso a paso               |
| PAIN      | Problem, Action, Information, Next Steps               | Análisis de problemas              |
| COAST     | Context, Objective, Actions, Scenario, Task            | Planificación                      |
| ROSES     | Role, Objective, Scenario, Expected solution, Steps    | Soluciones estructuradas           |

---

## Cierre

La mejor forma de aprender prompting es practicar. Empieza con prompts sencillos, revisa la respuesta de Copilot y mejora poco a poco tus instrucciones. Si la respuesta no es útil, no significa necesariamente que Copilot no pueda ayudarte: muchas veces significa que el prompt necesita más contexto, más límites o un formato más claro.
