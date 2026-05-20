# Tema 02 — Ecosistema de Copilot: Microsoft Copilot, GitHub Copilot, Microsoft 365 Copilot y Copilot Studio

## 1. Objetivo del tema

En el tema anterior vimos qué es la inteligencia artificial generativa y cómo Copilot puede entenderse como un asistente de trabajo. En este tema vamos a ordenar el ecosistema Copilot, porque uno de los problemas más habituales al empezar es que existen varias herramientas con nombres parecidos.

El objetivo de este tema es aprender a diferenciar los principales tipos de Copilot y saber en qué casos conviene usar cada uno.

Al terminar este tema deberías ser capaz de:

- Diferenciar entre Microsoft Copilot, GitHub Copilot, Microsoft 365 Copilot y Copilot Studio.
- Saber qué herramienta usar según la tarea.
- Reconocer qué Copilot está orientado a desarrollo, productividad, automatización o creación de agentes.
- Entender que las funcionalidades pueden variar según la licencia, la cuenta y el entorno de trabajo.
- Elegir una herramienta de Copilot de forma razonada.

---

## 2. Por qué existen varios Copilot

Microsoft y GitHub utilizan el nombre Copilot para distintas herramientas de inteligencia artificial. Todas comparten una misma idea general: ayudar al usuario a realizar tareas mediante IA generativa.

Sin embargo, cada herramienta está pensada para un contexto diferente.

No es lo mismo:

- Escribir código en un editor.
- Resumir una reunión de Teams.
- Crear una presentación en PowerPoint.
- Analizar una tabla de Excel.
- Crear un agente conversacional para soporte interno.
- Pedir ayuda general desde el navegador.

Por eso es importante no hablar de “Copilot” de forma genérica sin aclarar a cuál nos referimos.

Durante el curso trabajaremos con esta clasificación:

| Herramienta           | Uso principal                                                                                |
| --------------------- | -------------------------------------------------------------------------------------------- |
| Microsoft Copilot     | Asistente general para búsqueda, generación de contenido y productividad básica              |
| GitHub Copilot        | Asistente de desarrollo de software                                                          |
| Microsoft 365 Copilot | Asistente integrado en Word, Excel, PowerPoint, Outlook, Teams y otras apps de Microsoft 365 |
| Copilot Studio        | Creación y gestión de agentes de IA                                                          |

---

## 3. Microsoft Copilot

**Microsoft Copilot** es el asistente de IA general de Microsoft. Está pensado para ayudar en tareas amplias de productividad, consulta, redacción, búsqueda y generación de contenido.

Puede utilizarse para tareas como:

- Hacer preguntas generales.
- Resumir información.
- Redactar textos.
- Generar ideas.
- Ayudar a preparar documentos.
- Explicar conceptos.
- Comparar opciones.
- Crear borradores.
- Transformar contenido.

Ejemplo de uso:

```text
Explícame las diferencias entre una aplicación web tradicional y una aplicación SPA con un ejemplo sencillo.
```

Otro ejemplo:

```text
Redacta un correo profesional para solicitar una reunión de seguimiento sobre un proyecto.
```

Microsoft Copilot puede utilizarse en distintos entornos, como la web, Windows o Edge, aunque las funciones concretas dependen del país, cuenta, licencia, configuración y versión disponible.

### Cuándo usar Microsoft Copilot

Conviene usar Microsoft Copilot cuando necesitas:

- Una explicación rápida.
- Un resumen general.
- Una ayuda para redactar.
- Ideas iniciales.
- Una comparación.
- Una transformación sencilla de texto.
- Apoyo en tareas no necesariamente técnicas.

### Cuándo no es la mejor opción

No suele ser la mejor herramienta cuando necesitas:

- Trabajar directamente sobre el código de un proyecto.
- Acceder al contexto de un repositorio.
- Generar tests conectados a tu base de código.
- Revisar una pull request.
- Crear workflows de GitHub Actions dentro del repositorio.

Para esos casos, normalmente será más adecuado GitHub Copilot.

---

## 4. GitHub Copilot

**GitHub Copilot** es el Copilot orientado al desarrollo de software.

Su función principal es asistir a personas programadoras dentro de su flujo de trabajo habitual. Puede utilizarse en editores como Visual Studio Code o entornos de JetBrains, y también en GitHub y otros entornos compatibles.

GitHub Copilot puede ayudar a:

- Completar código mientras escribimos.
- Generar funciones.
- Explicar código existente.
- Refactorizar código.
- Crear tests.
- Detectar errores.
- Escribir documentación técnica.
- Crear mensajes de commit.
- Resumir pull requests.
- Proponer mejoras.
- Trabajar con comandos o terminal, según el entorno.
- Crear o revisar workflows de GitHub Actions.

Ejemplo de prompt para GitHub Copilot Chat:

```text
Explica qué hace esta función, detecta posibles problemas y propón una versión más legible sin cambiar su comportamiento.
```

Ejemplo de prompt para generar tests:

```text
Genera tests unitarios para esta función usando Jest. Incluye casos normales, casos límite y casos de error.
```

### Diferencia entre sugerencias inline y Copilot Chat

GitHub Copilot se puede usar de varias formas.

#### Sugerencias inline

Son sugerencias que aparecen directamente mientras escribimos código.

Por ejemplo, si escribimos:

```javascript
function calculateTotalPrice(products) {
```

Copilot puede sugerir automáticamente el cuerpo de la función.

Este modo es útil para:

- Completar código repetitivo.
- Acelerar funciones sencillas.
- Generar estructuras comunes.
- Ahorrar tiempo en fragmentos previsibles.

#### Copilot Chat

Copilot Chat permite conversar sobre el código.

Es útil para:

- Pedir explicaciones.
- Analizar errores.
- Refactorizar código.
- Generar tests.
- Preguntar sobre el proyecto.
- Revisar una selección de código.
- Pedir alternativas de implementación.

Ejemplo:

```text
¿Por qué esta función devuelve undefined en algunos casos? Explícalo paso a paso y propón una corrección mínima.
```

### Cuándo usar GitHub Copilot

Conviene usar GitHub Copilot cuando necesitas:

- Programar.
- Comprender código.
- Mejorar código existente.
- Crear tests.
- Documentar código.
- Automatizar tareas de desarrollo.
- Trabajar con repositorios.
- Revisar cambios técnicos.
- Crear workflows de CI/CD.

### Cuándo no es la mejor opción

No suele ser la mejor herramienta cuando necesitas:

- Redactar un informe empresarial largo.
- Resumir una reunión de Teams.
- Crear una presentación corporativa.
- Analizar una hoja de cálculo de negocio dentro de Excel.

Para esos casos, normalmente será más adecuado Microsoft 365 Copilot.

---

## 5. Microsoft 365 Copilot

**Microsoft 365 Copilot** es Copilot integrado en las aplicaciones de Microsoft 365.

Está pensado para trabajar con herramientas como:

- Word.
- Excel.
- PowerPoint.
- Outlook.
- Teams.
- OneNote.
- Loop.
- Otras aplicaciones del entorno Microsoft 365, según licencia y disponibilidad.

Su utilidad principal está en tareas de productividad y gestión de información.

### 5.1 Copilot en Word

Puede ayudar a:

- Crear borradores.
- Reescribir textos.
- Resumir documentos.
- Cambiar el tono.
- Transformar notas en documentos estructurados.
- Crear introducciones, conclusiones o esquemas.

Ejemplo de prompt:

```text
Reescribe este texto con un tono más profesional, manteniendo las ideas principales y reduciendo la extensión en un 30%.
```

### 5.2 Copilot en Excel

Puede ayudar a:

- Interpretar tablas.
- Crear fórmulas.
- Explicar datos.
- Detectar tendencias.
- Generar resúmenes.
- Proponer visualizaciones.
- Identificar valores atípicos.

Ejemplo de prompt:

```text
Analiza esta tabla de ventas y resume las principales tendencias por trimestre.
```

### 5.3 Copilot en PowerPoint

Puede ayudar a:

- Crear presentaciones a partir de un documento.
- Resumir contenido en diapositivas.
- Reorganizar una presentación.
- Crear notas del presentador.
- Proponer títulos y estructura.

Ejemplo de prompt:

```text
Crea una estructura de presentación de 8 diapositivas a partir de este documento. El público será técnico pero no experto.
```

### 5.4 Copilot en Outlook

Puede ayudar a:

- Redactar correos.
- Resumir hilos largos.
- Proponer respuestas.
- Cambiar el tono.
- Extraer tareas pendientes.

Ejemplo de prompt:

```text
Resume este hilo de correos e indica qué decisiones se han tomado y qué tareas quedan pendientes.
```

### 5.5 Copilot en Teams

Puede ayudar a:

- Resumir reuniones.
- Identificar decisiones tomadas.
- Extraer tareas asignadas.
- Recoger preguntas sin responder.
- Generar actas.
- Revisar puntos clave de una conversación.

Ejemplo de prompt:

```text
Resume la reunión en tres apartados: decisiones tomadas, tareas asignadas y temas que requieren seguimiento.
```

### Cuándo usar Microsoft 365 Copilot

Conviene usar Microsoft 365 Copilot cuando trabajas dentro de documentos, hojas de cálculo, correos, reuniones o presentaciones.

Es especialmente útil cuando la información ya está dentro del entorno Microsoft 365 y se necesita transformarla, resumirla, analizarla o reutilizarla.

---

## 6. Copilot Studio

**Copilot Studio** es una herramienta orientada a la creación, personalización y gestión de agentes de IA.

Un agente es un sistema que puede conversar con usuarios y, en algunos casos, ejecutar acciones o consultar fuentes de información conectadas.

Copilot Studio permite crear agentes con un enfoque de bajo código o low-code. Esto significa que muchas tareas pueden configurarse visualmente, sin necesidad de programar todo desde cero.

### Qué puede hacer un agente

Un agente creado con Copilot Studio puede servir para:

- Responder preguntas frecuentes.
- Ayudar a empleados con documentación interna.
- Atender solicitudes de soporte.
- Guiar a usuarios en un proceso.
- Consultar información de distintas fuentes.
- Activar flujos de trabajo.
- Conectarse con sistemas empresariales mediante conectores.

Ejemplo de caso de uso:

```text
Una empresa crea un agente interno para responder preguntas sobre vacaciones, permisos, teletrabajo y políticas de recursos humanos.
```

Otro ejemplo:

```text
Un equipo técnico crea un agente que consulta documentación interna y ayuda a resolver dudas sobre despliegues, ramas Git y entornos de desarrollo.
```

### Elementos básicos de un agente

Al diseñar un agente, conviene definir:

1. **Objetivo**: para qué existe el agente.
2. **Usuarios**: quién lo va a utilizar.
3. **Fuentes de información**: qué documentación o datos puede consultar.
4. **Instrucciones**: cómo debe responder.
5. **Acciones**: qué puede hacer, si tiene permisos para ejecutar tareas.
6. **Límites**: qué no debe responder o qué debe escalar a una persona.
7. **Canales**: dónde se publicará, por ejemplo Teams, web u otros canales.

### Cuándo usar Copilot Studio

Conviene usar Copilot Studio cuando necesitas crear una solución propia de IA para un proceso concreto.

Por ejemplo:

- Un asistente de soporte interno.
- Un agente para consultar documentación técnica.
- Un chatbot para atención al cliente.
- Un asistente para recursos humanos.
- Un agente para guiar procesos administrativos.
- Una automatización conversacional conectada a datos empresariales.

### Cuándo no es necesario usar Copilot Studio

No hace falta usar Copilot Studio para tareas individuales como:

- Pedir una explicación rápida.
- Generar una función sencilla.
- Resumir un documento aislado.
- Crear un correo puntual.

En esos casos, probablemente sea suficiente con Microsoft Copilot, Microsoft 365 Copilot o GitHub Copilot.

---

## 7. Comparativa general

| Herramienta           | Principal usuario                               | Contexto                                | Ejemplos de uso                                              |
| --------------------- | ----------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ |
| Microsoft Copilot     | Usuario general                                 | Web, Windows, Edge, app Copilot         | Preguntar, redactar, resumir, generar ideas                  |
| GitHub Copilot        | Desarrolladores                                 | IDE, GitHub, terminal, repositorios     | Código, tests, refactorización, documentación, pull requests |
| Microsoft 365 Copilot | Usuarios de Microsoft 365                       | Word, Excel, PowerPoint, Outlook, Teams | Documentos, correos, reuniones, datos, presentaciones        |
| Copilot Studio        | Equipos de negocio, tecnología y automatización | Plataforma de creación de agentes       | Agentes internos, chatbots, soporte, automatizaciones        |

---

## 8. Cómo elegir qué Copilot usar

Para elegir la herramienta adecuada, podemos seguir esta guía.

### Paso 1. Identifica el tipo de tarea

Pregúntate:

```text
¿Estoy trabajando con código, documentos, correos, reuniones, datos o agentes?
```

### Paso 2. Elige la herramienta según el contexto

| Necesito...                          | Herramienta recomendada                   |
| ------------------------------------ | ----------------------------------------- |
| Crear o revisar código               | GitHub Copilot                            |
| Explicar una función                 | GitHub Copilot                            |
| Generar tests                        | GitHub Copilot                            |
| Crear un workflow de GitHub Actions  | GitHub Copilot                            |
| Redactar un correo                   | Microsoft Copilot o Microsoft 365 Copilot |
| Resumir un documento de Word         | Microsoft 365 Copilot                     |
| Analizar una tabla de Excel          | Microsoft 365 Copilot                     |
| Resumir una reunión de Teams         | Microsoft 365 Copilot                     |
| Crear un agente para soporte interno | Copilot Studio                            |
| Hacer una consulta general           | Microsoft Copilot                         |

### Paso 3. Comprueba el contexto disponible

La herramienta será más útil si tiene acceso al contexto necesario.

Por ejemplo:

- GitHub Copilot funciona mejor cuando puede ver el código relevante.
- Microsoft 365 Copilot funciona mejor cuando el documento, correo o reunión están dentro del entorno Microsoft 365.
- Copilot Studio funciona mejor cuando el agente está conectado a fuentes de información bien organizadas.

### Paso 4. Revisa las condiciones de uso

Antes de usar una herramienta de Copilot en una empresa o clase, conviene comprobar:

- Tipo de cuenta.
- Licencia disponible.
- Políticas de privacidad.
- Permisos del usuario.
- Datos a los que puede acceder.
- Reglas internas sobre uso de IA.

---

## 9. Escenarios prácticos de decisión

### Escenario 1. Necesito crear una función en JavaScript

Herramienta recomendada: **GitHub Copilot**.

Prompt posible:

```text
Crea una función en JavaScript que reciba un array de usuarios y devuelva solo los usuarios activos. Usa nombres de variables en inglés y comentarios breves en español.
```

### Escenario 2. Necesito resumir un documento de 20 páginas

Herramienta recomendada: **Microsoft 365 Copilot**, si el documento está en Word o OneDrive.

Prompt posible:

```text
Resume este documento en una página. Mantén los conceptos principales y señala las conclusiones más importantes.
```

### Escenario 3. Necesito preparar una reunión

Herramienta recomendada: **Microsoft 365 Copilot**, especialmente en Outlook o Teams.

Prompt posible:

```text
Resume los correos relacionados con esta reunión e indica los temas que debería preparar antes de asistir.
```

### Escenario 4. Necesito crear un asistente interno para dudas frecuentes

Herramienta recomendada: **Copilot Studio**.

Prompt o instrucción inicial del agente:

```text
Eres un asistente interno para responder preguntas frecuentes sobre procesos de incorporación, vacaciones y herramientas corporativas. Responde de forma breve y, si no tienes información suficiente, indica que la consulta debe escalarse al equipo correspondiente.
```

### Escenario 5. Necesito entender un error en mi aplicación

Herramienta recomendada: **GitHub Copilot**.

Prompt posible:

```text
Analiza este error y dime qué puede estar provocándolo. Después propón una corrección paso a paso.
```

---

## 10. Errores habituales al empezar

### Error 1. Pensar que todos los Copilot son iguales

No todos los Copilot tienen el mismo contexto ni las mismas funciones. Usar la herramienta equivocada puede generar respuestas menos útiles.

### Error 2. Usar prompts demasiado generales

Un prompt como este es poco útil:

```text
Hazme un resumen.
```

Es mejor:

```text
Resume este documento en 10 líneas, destacando los objetivos, las conclusiones y las tareas pendientes.
```

### Error 3. No revisar la respuesta

Copilot puede equivocarse. Siempre hay que revisar, probar y validar.

### Error 4. Compartir información sensible sin comprobar el entorno

No se debe pegar código privado, datos personales, credenciales, contratos o información confidencial sin conocer las condiciones de privacidad y seguridad aplicables.

### Error 5. Pedir tareas demasiado grandes de una sola vez

Es mejor dividir un objetivo grande en pasos pequeños.

En lugar de:

```text
Créame una aplicación completa.
```

Es mejor empezar por:

```text
Propón la estructura de carpetas para una aplicación sencilla de gestión de tareas con frontend, backend y base de datos.
```

Después se puede continuar paso a paso.

---

## 11. Buenas prácticas para elegir y usar Copilot

1. **Define primero la tarea**.
2. **Elige la herramienta según el contexto**.
3. **Da instrucciones concretas**.
4. **No mezcles objetivos diferentes en un solo prompt**.
5. **Pide pasos intermedios cuando la tarea sea compleja**.
6. **Comprueba siempre el resultado**.
7. **No compartas datos sensibles sin autorización**.
8. **Ten en cuenta la licencia y la configuración disponible**.
9. **Usa Copilot como apoyo, no como sustituto del criterio profesional**.
10. **Documenta los cambios importantes que aceptes**.

---

## 12. Resumen del tema

El ecosistema Copilot está formado por varias herramientas que comparten una idea común: asistir al usuario mediante inteligencia artificial generativa. Sin embargo, cada una tiene un objetivo distinto.

Microsoft Copilot es útil para consultas generales y generación de contenido. GitHub Copilot está orientado al desarrollo de software. Microsoft 365 Copilot se integra en aplicaciones como Word, Excel, PowerPoint, Outlook y Teams. Copilot Studio permite crear y gestionar agentes de IA.

La clave es elegir la herramienta adecuada según la tarea, el contexto disponible y las condiciones de uso.

---

## 13. Checklist final

Antes de pasar al siguiente tema, asegúrate de que puedes responder a estas preguntas:

- ¿Qué diferencia hay entre Microsoft Copilot y GitHub Copilot?
- ¿Para qué sirve Microsoft 365 Copilot?
- ¿Qué tipo de herramienta es Copilot Studio?
- ¿Qué Copilot usarías para generar tests?
- ¿Qué Copilot usarías para resumir una reunión?
- ¿Qué Copilot usarías para crear un agente interno?
- ¿Por qué es importante tener en cuenta la licencia y el contexto?

---

## 14. Documentación oficial recomendada

- GitHub Copilot documentation: https://docs.github.com/copilot
- GitHub Copilot features: https://docs.github.com/en/copilot/get-started/features
- Microsoft 365 Copilot documentation: https://learn.microsoft.com/en-us/microsoft-365-copilot/
- Microsoft Copilot Studio documentation: https://learn.microsoft.com/en-us/microsoft-copilot-studio/
- What is Copilot Studio: https://learn.microsoft.com/en-us/microsoft-copilot-studio/fundamentals-what-is-copilot-studio
