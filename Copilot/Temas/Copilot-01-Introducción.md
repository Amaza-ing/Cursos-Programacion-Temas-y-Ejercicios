# Tema 01 — Introducción a la IA generativa y al ecosistema Copilot

## 1. Objetivo del tema

En este primer tema vamos a introducir los conceptos fundamentales que permiten entender qué es Copilot, qué relación tiene con la inteligencia artificial generativa y cómo puede utilizarse en contextos profesionales.

El objetivo no es aprender todavía una herramienta concreta en profundidad, sino comprender la lógica general que hay detrás de Copilot y empezar a trabajar con una idea clave: **la IA generativa no sustituye el criterio profesional, sino que amplía la capacidad de trabajo cuando se usa con supervisión y sentido crítico**.

Al terminar este tema deberías ser capaz de:

- Explicar qué es la inteligencia artificial generativa.
- Comprender qué es un modelo de lenguaje.
- Diferenciar entre una búsqueda tradicional y una respuesta generada por IA.
- Entender qué es Copilot como familia de herramientas.
- Identificar casos de uso de Copilot en desarrollo, productividad, análisis y automatización.
- Reconocer riesgos básicos: errores, alucinaciones, privacidad, sesgos y dependencia excesiva.
- Formular tus primeros prompts de manera clara y útil.

---

## 2. Qué es la inteligencia artificial generativa

La **inteligencia artificial generativa** es una rama de la inteligencia artificial capaz de producir contenido nuevo a partir de una instrucción o entrada inicial.

Ese contenido puede tener muchas formas:

- Texto.
- Código.
- Imágenes.
- Resúmenes.
- Tablas.
- Presentaciones.
- Correos electrónicos.
- Documentación técnica.
- Propuestas de solución.
- Ideas para automatizar procesos.

La IA generativa no se limita a buscar una respuesta ya escrita. En lugar de eso, genera una respuesta nueva a partir del contexto recibido y de los patrones que ha aprendido durante su entrenamiento.

Por ejemplo, una herramienta de IA generativa puede recibir una petición como esta:

```text
Explícame qué es una API REST con un ejemplo sencillo para una persona que está aprendiendo desarrollo web.
```

Y puede devolver una explicación adaptada al nivel solicitado.

También puede recibir una petición técnica como esta:

```text
Crea una función en JavaScript que reciba una lista de productos y devuelva solo aquellos cuyo precio sea mayor que 100.
```

Y puede generar una posible implementación:

```javascript
function filterExpensiveProducts(products) {
  return products.filter((product) => product.price > 100);
}
```

Este tipo de herramienta puede ser muy útil, pero es importante recordar que **generar una respuesta no significa garantizar que esa respuesta sea correcta**.

---

## 3. Qué es un modelo de lenguaje

Muchas herramientas de IA generativa actuales se basan en **modelos de lenguaje**.

Un modelo de lenguaje es un sistema entrenado para procesar y generar texto. Para ello, aprende patrones a partir de grandes cantidades de información. Gracias a ese entrenamiento, puede predecir qué palabras, fragmentos de código o estructuras son más probables en un contexto determinado.

Cuando usamos una herramienta como Copilot, normalmente escribimos una instrucción. Esa instrucción se llama **prompt**.

El modelo analiza el prompt, interpreta la intención del usuario y genera una respuesta.

El proceso general sería:

```text
Usuario → Prompt → Modelo de IA → Respuesta generada → Revisión humana
```

La última parte es esencial. La respuesta debe ser revisada por una persona, especialmente si afecta a código, datos, decisiones de negocio, documentos importantes o información sensible.

---

## 4. Diferencia entre búsqueda tradicional e IA generativa

Una búsqueda tradicional intenta localizar información existente. Por ejemplo, si buscamos en Internet:

```text
qué es GitHub Copilot
```

El buscador nos mostrará enlaces a páginas que ya existen.

En cambio, una herramienta de IA generativa puede crear una respuesta nueva a partir de una petición como esta:

```text
Explícame qué es GitHub Copilot en 5 líneas, con un ejemplo práctico para una persona que programa en JavaScript.
```

La diferencia principal es esta:

| Búsqueda tradicional                    | IA generativa                                      |
| --------------------------------------- | -------------------------------------------------- |
| Encuentra contenido existente           | Genera contenido nuevo                             |
| Devuelve enlaces o fragmentos           | Devuelve una respuesta elaborada                   |
| Requiere que el usuario compare fuentes | Puede sintetizar, explicar o transformar contenido |
| Suele mostrar la fuente original        | Puede equivocarse si no se revisa                  |

Por eso, en un contexto profesional, no debemos tratar la IA generativa como una fuente infalible. Debemos tratarla como un **asistente de trabajo**.

---

## 5. Qué es Copilot

El término **Copilot** se utiliza para referirse a distintas herramientas de inteligencia artificial creadas o integradas en el ecosistema de Microsoft y GitHub.

La idea general de Copilot es actuar como un **asistente inteligente** que acompaña al usuario mientras trabaja.

Dependiendo de la herramienta concreta, Copilot puede ayudar a:

- Escribir código.
- Explicar código existente.
- Crear tests.
- Refactorizar funciones.
- Redactar correos.
- Resumir documentos.
- Analizar datos.
- Generar presentaciones.
- Preparar reuniones.
- Crear agentes conversacionales.
- Automatizar flujos de trabajo.

Sin embargo, no todos los Copilot sirven para lo mismo. A lo largo del curso distinguiremos principalmente entre:

- **GitHub Copilot**, orientado al desarrollo de software.
- **Microsoft Copilot**, orientado a asistencia general, productividad y trabajo diario.
- **Microsoft 365 Copilot**, integrado en aplicaciones como Word, Excel, PowerPoint, Outlook o Teams.
- **Copilot Studio**, orientado a crear agentes y automatizaciones conversacionales.

---

## 6. Copilot como asistente, no como sustituto

Una forma sencilla de entender Copilot es compararlo con una persona ayudante que trabaja contigo.

Puede ayudarte a avanzar más rápido, pero no debe tomar decisiones críticas sin supervisión.

Copilot puede:

- Proponer una primera versión de una función.
- Sugerir una estructura de documento.
- Resumir una conversación larga.
- Ayudar a detectar errores en código.
- Explicar un concepto difícil.
- Proponer un flujo de automatización.

Pero la persona usuaria debe:

- Revisar si el resultado es correcto.
- Comprobar si el código funciona.
- Validar si la información es fiable.
- Adaptar el resultado al contexto real.
- Asegurarse de que no se comparten datos sensibles.
- Decidir si la propuesta encaja con los objetivos del proyecto.

La regla básica del curso será:

> Copilot puede proponer. La persona decide, revisa y valida.

---

## 7. Qué es un prompt

Un **prompt** es la instrucción que escribimos para pedir algo a una herramienta de IA generativa.

Un prompt puede ser muy simple:

```text
Resume este texto.
```

Pero normalmente obtendremos mejores resultados si damos más contexto:

```text
Resume este texto en 5 líneas, manteniendo un tono profesional y destacando solo las ideas principales.
```

En desarrollo de software, también podemos pedir cosas más concretas:

```text
Genera una función en JavaScript que reciba un array de usuarios y devuelva solo los usuarios activos. Usa nombres de variables en inglés y añade comentarios breves en español.
```

Un buen prompt suele incluir:

1. **Contexto**: qué estamos haciendo.
2. **Objetivo**: qué queremos conseguir.
3. **Restricciones**: qué debe respetar la respuesta.
4. **Formato**: cómo queremos recibir el resultado.
5. **Nivel de detalle**: explicación breve, paso a paso, tabla, código, etc.

---

## 8. Ejemplo de prompt poco útil y prompt mejorado

### Prompt poco útil

```text
Hazme una función.
```

Este prompt es demasiado ambiguo. No indica lenguaje, objetivo, datos de entrada, datos de salida ni restricciones.

### Prompt mejorado

```text
Crea una función en JavaScript llamada calculateTotalPrice.
La función debe recibir un array de productos.
Cada producto tendrá las propiedades name, price y quantity.
La función debe devolver el precio total del pedido.
Usa nombres de variables en inglés y añade comentarios breves en español.
```

Una posible respuesta sería:

```javascript
function calculateTotalPrice(products) {
  // Recorremos los productos y acumulamos el precio total
  return products.reduce((total, product) => {
    return total + product.price * product.quantity;
  }, 0);
}
```

Este segundo prompt funciona mejor porque incluye contexto, objetivo, estructura de datos y criterios de formato.

---

## 9. Cómo trabajar paso a paso con una herramienta de IA generativa

Cuando usamos Copilot o cualquier herramienta de IA generativa, conviene seguir un proceso ordenado.

### Paso 1. Define claramente qué necesitas

Antes de escribir el prompt, piensa qué quieres conseguir.

No es lo mismo pedir:

```text
Explícame este código.
```

Que pedir:

```text
Explícame este código paso a paso, como si estuviera aprendiendo JavaScript desde cero.
```

La segunda petición es más precisa y probablemente generará una respuesta más útil.

### Paso 2. Da contexto

Cuanto más contexto relevante proporciones, mejor será la respuesta.

Por ejemplo:

```text
Estoy creando una aplicación web sencilla con JavaScript. Tengo una lista de tareas y quiero mostrar solo las que están completadas.
```

### Paso 3. Indica el resultado esperado

Puedes especificar si quieres una explicación, código, una tabla, una lista de pasos o una revisión.

```text
Devuélveme la respuesta en forma de pasos numerados.
```

```text
Devuélveme solo el código, sin explicación adicional.
```

```text
Primero explícame el problema y después propón una solución.
```

### Paso 4. Añade restricciones

Las restricciones ayudan a que la respuesta se ajuste mejor a tus necesidades.

Ejemplos:

```text
No uses librerías externas.
```

```text
Usa funciones flecha.
```

```text
No cambies el nombre de las variables existentes.
```

```text
Mantén la estructura actual del proyecto.
```

### Paso 5. Revisa la respuesta

Nunca aceptes una respuesta importante sin revisarla.

En código, debes comprobar:

- Si compila.
- Si se ejecuta.
- Si resuelve realmente el problema.
- Si respeta el estilo del proyecto.
- Si introduce vulnerabilidades.
- Si genera código innecesariamente complejo.

En texto, debes comprobar:

- Si la información es correcta.
- Si el tono es adecuado.
- Si faltan datos importantes.
- Si hay afirmaciones dudosas.
- Si se ha inventado algo.

### Paso 6. Itera

La primera respuesta no tiene por qué ser la definitiva. Puedes pedir mejoras.

Ejemplos:

```text
Hazlo más sencillo.
```

```text
Explícalo con un ejemplo más básico.
```

```text
Refactoriza la solución para que sea más legible.
```

```text
Añade control de errores.
```

```text
Genera una versión alternativa usando programación funcional.
```

---

## 10. Casos de uso de Copilot

Copilot puede aplicarse en diferentes áreas profesionales.

### 10.1 Desarrollo de software

En desarrollo, Copilot puede ayudar a:

- Generar funciones.
- Completar fragmentos de código.
- Explicar código existente.
- Crear documentación técnica.
- Refactorizar código.
- Proponer tests.
- Detectar posibles errores.
- Crear scripts.
- Generar consultas SQL.
- Ayudar con comandos de terminal.
- Crear workflows de integración continua.

Ejemplo de prompt:

```text
Revisa esta función y dime si puede fallar con valores nulos o arrays vacíos. Después propón una versión más segura.
```

### 10.2 Productividad

En productividad, Copilot puede ayudar a:

- Redactar correos.
- Resumir documentos.
- Transformar notas en informes.
- Preparar presentaciones.
- Crear esquemas.
- Reescribir textos con otro tono.
- Extraer tareas pendientes de una conversación.

Ejemplo de prompt:

```text
Convierte estas notas de reunión en un resumen profesional con tres apartados: decisiones tomadas, tareas pendientes y próximos pasos.
```

### 10.3 Automatización

En automatización, Copilot puede ayudar a:

- Diseñar flujos de trabajo.
- Crear agentes conversacionales.
- Conectar información de distintas fuentes.
- Generar instrucciones para procesos repetitivos.
- Proponer integraciones entre herramientas.

Ejemplo de prompt:

```text
Diseña un flujo de automatización para recibir solicitudes de soporte, clasificarlas por prioridad y enviar una respuesta inicial al usuario.
```

### 10.4 Análisis

En análisis, Copilot puede ayudar a:

- Interpretar tablas.
- Generar fórmulas.
- Crear resúmenes de datos.
- Detectar patrones.
- Proponer visualizaciones.
- Explicar resultados.

Ejemplo de prompt:

```text
Analiza esta tabla de ventas y señala tres tendencias relevantes, posibles causas y recomendaciones de acción.
```

---

## 11. Riesgos y limitaciones de la IA generativa

Copilot puede ser muy útil, pero también tiene límites.

### 11.1 Puede equivocarse

Una respuesta generada por IA puede parecer correcta y estar mal.

Esto es especialmente peligroso porque muchas veces la respuesta está redactada con seguridad.

Por ejemplo, puede:

- Inventar una función que no existe.
- Usar una API de forma incorrecta.
- Confundir versiones de una librería.
- Proponer código que no compila.
- Dar una explicación incompleta.

### 11.2 Puede generar código inseguro

El código generado puede funcionar, pero no ser seguro.

Puede tener problemas como:

- Falta de validación de datos.
- Exposición de información sensible.
- Uso incorrecto de credenciales.
- Consultas vulnerables.
- Manejo débil de errores.

### 11.3 Puede depender demasiado del contexto visible

Copilot responde a partir del contexto que tiene disponible. Si el contexto es incompleto, puede generar una respuesta incompleta.

Por ejemplo, si solo ve una función aislada y no conoce la arquitectura completa de la aplicación, puede proponer una solución que no encaje bien con el proyecto.

### 11.4 Puede reforzar malas prácticas

Si un proyecto ya tiene código desordenado, Copilot puede imitar ese estilo.

Por eso conviene definir estándares:

- Convenciones de nombres.
- Estructura de carpetas.
- Forma de escribir tests.
- Estilo de documentación.
- Reglas de seguridad.

### 11.5 Puede generar dependencia

Uno de los riesgos más importantes es usar Copilot sin entender lo que propone.

Copilot debe acelerar el aprendizaje y el trabajo, no sustituir la comprensión.

---

## 12. Guía paso a paso: primera interacción con Copilot

Esta guía sirve para cualquier herramienta de IA generativa tipo Copilot.

### Paso 1. Escribe una petición sencilla

Ejemplo:

```text
Explícame qué es la inteligencia artificial generativa en un lenguaje sencillo.
```

### Paso 2. Añade contexto

Ahora mejora la petición:

```text
Explícame qué es la inteligencia artificial generativa en un lenguaje sencillo, pensando en personas que trabajan en desarrollo web y nunca han usado herramientas de IA.
```

### Paso 3. Pide un formato concreto

```text
Explícame qué es la inteligencia artificial generativa en un lenguaje sencillo. Usa una introducción breve, una lista de usos profesionales y un ejemplo aplicado a desarrollo web.
```

### Paso 4. Pide una mejora

```text
Haz la explicación más práctica y añade un ejemplo de prompt para generar una función en JavaScript.
```

### Paso 5. Revisa el resultado

Comprueba:

- ¿La explicación es correcta?
- ¿El ejemplo se entiende?
- ¿El código funciona?
- ¿Se ha inventado algo?
- ¿Falta alguna advertencia importante?

### Paso 6. Ajusta el prompt

Si el resultado no encaja, modifica tu instrucción:

```text
La explicación sigue siendo demasiado general. Reescríbela como material de clase para alumnado principiante, con ejemplos claros y sin tecnicismos innecesarios.
```

---

## 13. Recomendaciones para escribir buenos prompts

Un buen prompt suele responder a estas preguntas:

| Pregunta                | Ejemplo                                                      |
| ----------------------- | ------------------------------------------------------------ |
| ¿Qué quiero conseguir?  | Crear una función, resumir un texto, explicar un concepto    |
| ¿En qué contexto?       | Proyecto web, documento empresarial, reunión, tabla de datos |
| ¿Qué restricciones hay? | Sin librerías externas, tono formal, máximo 10 líneas        |
| ¿Qué formato quiero?    | Código, tabla, pasos numerados, resumen, checklist           |
| ¿Qué nivel necesito?    | Principiante, intermedio, avanzado, técnico, ejecutivo       |

Plantilla general:

```text
Estoy trabajando en [contexto].
Necesito [objetivo].
Ten en cuenta estas restricciones: [restricciones].
Devuélveme la respuesta en formato [formato].
El nivel debe ser [nivel].
```

Ejemplo aplicado:

```text
Estoy trabajando en una aplicación sencilla de gestión de tareas con JavaScript.
Necesito una función que filtre las tareas completadas.
Ten en cuenta que cada tarea tiene las propiedades title, completed y priority.
No uses librerías externas.
Devuélveme solo el código con comentarios breves en español.
```

---

## 14. Buenas prácticas desde el primer día

Cuando trabajes con Copilot, sigue estas recomendaciones:

1. **No pegues información sensible** si no tienes claro el entorno, la licencia y la política de privacidad aplicable.
2. **No aceptes código sin leerlo**.
3. **Ejecuta y prueba el código generado**.
4. **Pide explicaciones cuando no entiendas una solución**.
5. **Divide los problemas grandes en pasos pequeños**.
6. **No uses Copilot para ocultar falta de comprensión**.
7. **Comprueba la versión de las herramientas o librerías**.
8. **Adapta el resultado al estilo de tu proyecto**.
9. **Usa prompts específicos**.
10. **Mantén siempre criterio profesional**.

---

## 15. Resumen del tema

En este tema hemos visto que la IA generativa permite crear contenido nuevo a partir de instrucciones dadas por el usuario. Copilot forma parte de este tipo de herramientas, pero no es una única herramienta: es un ecosistema con distintas aplicaciones orientadas al desarrollo, la productividad, la automatización y la creación de agentes.

La idea fundamental es que Copilot debe entenderse como un asistente. Puede acelerar tareas, proponer soluciones y ayudar a comprender información, pero no debe sustituir la revisión humana.

Para obtener buenos resultados, es necesario aprender a escribir buenos prompts, dar contexto, definir restricciones y revisar siempre las respuestas generadas.

---

## 16. Checklist final

Antes de pasar al siguiente tema, asegúrate de que puedes responder a estas preguntas:

- ¿Qué es la IA generativa?
- ¿Qué es un modelo de lenguaje?
- ¿Qué diferencia hay entre buscar información y generar una respuesta?
- ¿Qué es un prompt?
- ¿Qué tipos de tareas puede hacer Copilot?
- ¿Por qué es importante revisar sus respuestas?
- ¿Qué riesgos tiene usar Copilot sin supervisión?
- ¿Qué elementos debe tener un buen prompt?

---

## 17. Documentación oficial recomendada

- GitHub Copilot documentation: https://docs.github.com/copilot
- GitHub Copilot features: https://docs.github.com/en/copilot/get-started/features
- Microsoft Copilot: https://www.microsoft.com/microsoft-copilot
- Microsoft 365 Copilot: https://learn.microsoft.com/en-us/microsoft-365-copilot/
- Microsoft Copilot Studio: https://learn.microsoft.com/en-us/microsoft-copilot-studio/
