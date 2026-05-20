# Tema 03 — Privacidad, seguridad, límites y uso responsable de la IA

## 1. Objetivo del tema

En los temas anteriores hemos visto qué es la IA generativa y cómo se organiza el ecosistema Copilot. En este tema vamos a trabajar una parte fundamental: cómo usar estas herramientas de forma segura, responsable y profesional.

Copilot puede acelerar mucho el trabajo, pero también puede generar errores, proponer soluciones inseguras o recibir información que no deberíamos compartir. Por eso, antes de profundizar en GitHub Copilot y Microsoft Copilot, es necesario establecer unas reglas básicas de uso.

Al terminar este tema deberías ser capaz de:

- Identificar qué información no debería compartirse con una herramienta de IA.
- Entender la diferencia entre prompt, contexto y datos sensibles.
- Reconocer los principales riesgos de las respuestas generadas por IA.
- Revisar código generado por Copilot con criterio técnico.
- Aplicar una checklist básica de seguridad, privacidad y calidad.
- Usar Copilot de forma responsable en un entorno profesional.

---

## 2. Por qué este tema es importante

La IA generativa puede dar una falsa sensación de seguridad. Muchas respuestas están bien redactadas, parecen lógicas y se presentan con confianza. Sin embargo, eso no garantiza que sean correctas.

En un entorno profesional, aceptar una respuesta sin revisarla puede provocar problemas como:

- Código que no funciona.
- Código inseguro.
- Pérdida de información confidencial.
- Uso de datos personales sin autorización.
- Documentos con información incorrecta.
- Automatizaciones mal diseñadas.
- Decisiones tomadas a partir de información inventada o incompleta.

Por eso, cualquier uso profesional de Copilot debe basarse en tres principios:

1. **Control humano**.
2. **Revisión del resultado**.
3. **Protección de la información**.

---

## 3. Prompt, contexto y datos

Para usar Copilot de forma segura, primero debemos diferenciar tres conceptos.

### 3.1 Prompt

El prompt es la instrucción que escribe el usuario.

Ejemplo:

```text
Resume este documento en cinco puntos principales.
```

O en desarrollo:

```text
Revisa esta función y dime si puede fallar cuando el array está vacío.
```

### 3.2 Contexto

El contexto es la información adicional que la herramienta puede utilizar para generar una respuesta.

En GitHub Copilot, el contexto puede incluir elementos como:

- Código cercano al cursor.
- Archivo abierto.
- Archivos relacionados.
- Selección de código.
- Nombre del archivo.
- Estructura del proyecto.
- Instrucciones personalizadas del repositorio, si existen.

En Microsoft 365 Copilot, el contexto puede estar relacionado con:

- Documentos.
- Correos.
- Reuniones.
- Chats.
- Archivos de OneDrive o SharePoint.
- Información disponible según permisos y configuración.

### 3.3 Datos sensibles

Los datos sensibles son aquellos que no deberían compartirse sin autorización o sin garantías suficientes.

Ejemplos:

- Contraseñas.
- Tokens.
- Claves API.
- Datos personales.
- Información médica.
- Información financiera.
- Datos de clientes.
- Contratos.
- Código propietario.
- Información interna de empresa.
- Credenciales de acceso.
- Datos sujetos a normativa legal o contractual.

Regla básica:

> Si no compartirías esa información en un chat público o con una persona externa, no la pegues en una herramienta de IA sin comprobar antes las condiciones de uso, licencia y privacidad.

---

## 4. Privacidad en el uso de Copilot

Las herramientas de Copilot pueden funcionar de manera distinta según el producto, la licencia y la configuración del entorno.

No es lo mismo usar:

- Una cuenta personal.
- Una cuenta educativa.
- Una cuenta empresarial.
- Un entorno gestionado por una organización.
- Una licencia individual.
- Una licencia corporativa.

Antes de usar Copilot con información real, conviene comprobar:

1. Qué datos puede utilizar como contexto.
2. Si la organización permite usar esa herramienta.
3. Qué información se puede introducir.
4. Si existe una política interna de uso de IA.
5. Si las respuestas pueden almacenarse o revisarse.
6. Si el proveedor usa o no los datos para entrenar modelos.
7. Qué medidas de protección ofrece la licencia concreta.

En clase podemos trabajar con ejemplos ficticios, fragmentos de código sencillos y datos inventados. En un entorno profesional real, siempre se debe seguir la política de la organización.

---

## 5. Información que no debemos introducir sin autorización

No se debe introducir en Copilot información sensible si no existe autorización clara.

### 5.1 Credenciales y secretos

No pegues nunca:

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

Si necesitas ayuda con un error relacionado con credenciales, sustituye los valores reales por valores ficticios.

Ejemplo inseguro:

```text
Mi conexión falla. Este es mi usuario, contraseña y cadena de conexión real...
```

Ejemplo seguro:

```text
Mi conexión falla. He sustituido los datos reales por valores ficticios:
DATABASE_URL=postgres://user:password@host:5432/database
¿Qué partes debería revisar?
```

### 5.2 Datos personales

Evita introducir datos como:

- DNI.
- Direcciones.
- Teléfonos.
- Correos personales.
- Datos médicos.
- Información laboral sensible.
- Datos de clientes.

Ejemplo seguro:

```text
Tengo una tabla ficticia con columnas name, email y purchaseAmount. ¿Cómo podría anonimizar el campo email antes de analizar los datos?
```

### 5.3 Código propietario

En entornos profesionales, el código puede estar protegido por contratos, acuerdos de confidencialidad o políticas internas.

Antes de pegar código real en una herramienta de IA, comprueba si está permitido.

Si no puedes compartir el código, puedes describir el problema de forma abstracta.

Ejemplo:

```text
Tengo una función que recibe una lista de pedidos, agrupa por cliente y calcula el total. El problema es que algunos pedidos no tienen cliente asignado. ¿Qué estrategia de validación podría aplicar?
```

---

## 6. Riesgos habituales de las respuestas generadas por IA

### 6.1 Alucinaciones

Una alucinación ocurre cuando la IA genera información falsa o inventada con apariencia de verdad.

Puede inventar:

- Funciones que no existen.
- Parámetros incorrectos.
- Métodos de una librería.
- Referencias bibliográficas.
- Comandos.
- Opciones de configuración.
- Explicaciones incorrectas.

Ejemplo:

```text
Usa el método array.removeByCondition() para eliminar elementos.
```

Ese método no existe de forma nativa en JavaScript. La respuesta podría parecer razonable, pero sería incorrecta.

### 6.2 Código que funciona, pero no es adecuado

A veces el código generado se ejecuta, pero no es una buena solución.

Puede ser:

- Poco legible.
- Difícil de mantener.
- Ineficiente.
- Inseguro.
- Incompatible con el estilo del proyecto.
- Demasiado complejo para el problema.

### 6.3 Falta de contexto

Si Copilot no tiene suficiente contexto, puede proponer soluciones que no encajan.

Por ejemplo:

```text
Crea un sistema de autenticación.
```

Esta petición es demasiado amplia. Copilot no sabe:

- Qué stack se usa.
- Qué base de datos existe.
- Qué tipo de usuarios hay.
- Qué nivel de seguridad se requiere.
- Si se usan sesiones o tokens.
- Si ya hay una arquitectura definida.

Un prompt mejor sería:

```text
Estoy trabajando en una API REST con Node.js y Express. Ya tengo una tabla users con email y passwordHash. Quiero una propuesta para implementar login con JWT, explicando los pasos y señalando riesgos de seguridad. No escribas todavía el código completo.
```

### 6.4 Sesgos

La IA puede reproducir sesgos presentes en los datos con los que fue entrenada o en las instrucciones recibidas.

En contextos profesionales, esto es especialmente importante en tareas relacionadas con:

- Selección de personal.
- Evaluación de rendimiento.
- Recomendaciones personalizadas.
- Atención a clientes.
- Clasificación de usuarios.
- Análisis de datos sensibles.

### 6.5 Dependencia excesiva

Si una persona acepta todas las respuestas sin entenderlas, puede perder capacidad crítica y autonomía técnica.

Copilot debe ayudar a aprender, no impedir aprender.

Una buena práctica es pedir explicaciones:

```text
Explícame esta solución paso a paso y dime qué conceptos necesito entender para mantener este código en el futuro.
```

---

## 7. Uso responsable en desarrollo de software

Cuando usamos GitHub Copilot para programar, debemos revisar sus propuestas con los mismos criterios que revisaríamos el código de otra persona.

### 7.1 Checklist de revisión de código generado

Antes de aceptar código generado por Copilot, revisa:

- ¿Entiendo lo que hace?
- ¿Resuelve realmente el problema?
- ¿Compila o se ejecuta?
- ¿Está probado?
- ¿Maneja errores?
- ¿Valida los datos de entrada?
- ¿Respeta el estilo del proyecto?
- ¿Introduce dependencias innecesarias?
- ¿Usa funciones o APIs existentes?
- ¿Puede tener problemas de seguridad?
- ¿Puede romper otra parte de la aplicación?

### 7.2 Ejemplo de revisión

Supongamos que Copilot genera esta función:

```javascript
function getUserByEmail(users, email) {
  return users.find((user) => user.email === email);
}
```

La función puede parecer correcta, pero deberíamos preguntarnos:

- ¿Qué ocurre si users es null?
- ¿Qué ocurre si email viene vacío?
- ¿Debe ignorar mayúsculas y minúsculas?
- ¿Debe lanzar un error o devolver undefined?
- ¿Hay que validar el formato del email?

Podemos pedir una mejora:

```text
Mejora esta función para que valide entradas nulas, compare el email sin distinguir mayúsculas y minúsculas, y mantenga el código simple.
```

Una posible versión mejorada sería:

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

Esta versión no es automáticamente perfecta, pero muestra un proceso de revisión más responsable.

---

## 8. Uso responsable en documentos y productividad

Cuando usamos Microsoft Copilot o Microsoft 365 Copilot para trabajar con texto, documentos, correos o reuniones, también debemos revisar el resultado.

### 8.1 Riesgos frecuentes

- Resúmenes incompletos.
- Tono inadecuado.
- Pérdida de matices importantes.
- Interpretación incorrecta de una reunión.
- Omisión de tareas pendientes.
- Inclusión de información no confirmada.
- Redacción demasiado genérica.

### 8.2 Checklist para revisar textos generados

Antes de enviar o usar un texto generado, revisa:

- ¿El contenido es correcto?
- ¿El tono es adecuado?
- ¿Falta información importante?
- ¿Hay datos inventados?
- ¿El texto representa bien mi intención?
- ¿Se han respetado las instrucciones?
- ¿Hay información sensible que no debería aparecer?
- ¿El texto necesita adaptación al destinatario?

### 8.3 Ejemplo de prompt responsable

En lugar de pedir:

```text
Escribe un correo para mi jefe.
```

Es mejor pedir:

```text
Redacta un correo profesional y breve para informar de que el informe estará listo mañana. Mantén un tono claro, responsable y sin dar excusas excesivas. No inventes detalles que no te haya dado.
```

---

## 9. Uso responsable en automatización y agentes

Cuando se crean agentes o automatizaciones, los riesgos son mayores porque el sistema puede interactuar con usuarios o ejecutar acciones.

Un agente mal diseñado puede:

- Dar respuestas incorrectas a muchas personas.
- Acceder a información que no debería.
- Ejecutar acciones sin suficiente control.
- No saber cuándo escalar a una persona.
- Generar una mala experiencia de usuario.

### 9.1 Checklist para diseñar agentes

Antes de publicar un agente, revisa:

- ¿Cuál es su objetivo exacto?
- ¿A qué usuarios va dirigido?
- ¿Qué fuentes de información puede consultar?
- ¿Qué datos no debe mostrar?
- ¿Qué acciones puede ejecutar?
- ¿Cuándo debe decir que no sabe?
- ¿Cuándo debe escalar a una persona?
- ¿Se ha probado con casos reales?
- ¿Se han probado casos límite?
- ¿Existe una forma de supervisar su funcionamiento?

### 9.2 Ejemplo de instrucción segura para un agente

```text
Eres un agente de soporte interno. Responde únicamente usando la documentación proporcionada. Si no encuentras una respuesta clara, indica que no tienes información suficiente y recomienda contactar con el equipo responsable. No inventes políticas internas ni proporciones datos personales.
```

Esta instrucción es más segura que una instrucción genérica como:

```text
Responde a cualquier pregunta de los empleados.
```

---

## 10. Principios éticos básicos

El uso de Copilot debe respetar ciertos principios éticos.

### 10.1 Transparencia

En algunos contextos puede ser necesario indicar que se ha utilizado IA como apoyo.

Por ejemplo:

- Documentos académicos.
- Informes corporativos.
- Procesos regulados.
- Producción de contenido público.

### 10.2 Responsabilidad

La responsabilidad final no es de Copilot, sino de la persona o equipo que decide usar el resultado.

Si Copilot genera un error y lo aceptamos sin revisar, el problema no desaparece por haberlo generado una IA.

### 10.3 Protección de datos

Los datos personales y confidenciales deben tratarse con cuidado.

No se deben introducir datos reales si no es necesario o si no existe autorización.

### 10.4 No discriminación

Hay que vigilar posibles sesgos, especialmente cuando se trabaja con personas, perfiles, evaluaciones o decisiones sensibles.

### 10.5 Supervisión humana

La IA debe apoyar la toma de decisiones, no sustituirla por completo en contextos importantes.

---

## 11. Guía paso a paso para usar Copilot de forma segura

### Paso 1. Identifica la tarea

Antes de usar Copilot, define qué quieres hacer.

Ejemplo:

```text
Quiero refactorizar una función.
```

```text
Quiero resumir un documento.
```

```text
Quiero crear un correo.
```

### Paso 2. Decide si puedes compartir el contexto

Pregúntate:

- ¿Hay datos personales?
- ¿Hay credenciales?
- ¿Hay información confidencial?
- ¿Hay código propietario?
- ¿Tengo permiso para usar esta información?

Si la respuesta genera dudas, no pegues la información real.

### Paso 3. Anonimiza o simplifica

Sustituye datos reales por datos ficticios.

Ejemplo:

```text
Cliente real: Empresa XYZ S.L.
```

Puede convertirse en:

```text
Cliente ficticio: Company A
```

### Paso 4. Escribe un prompt claro

Incluye objetivo, contexto, restricciones y formato.

```text
Analiza esta función ficticia y señala posibles problemas de seguridad. No propongas una solución completa todavía; primero enumera los riesgos principales.
```

### Paso 5. Revisa la respuesta

No aceptes el resultado automáticamente.

Comprueba:

- Exactitud.
- Seguridad.
- Coherencia.
- Adecuación al contexto.
- Posibles omisiones.

### Paso 6. Pide aclaraciones

Si algo no queda claro, pregunta.

```text
Explícame por qué esa solución sería más segura.
```

```text
¿Qué riesgos seguirían existiendo incluso después de aplicar esa corrección?
```

### Paso 7. Prueba antes de usar

En código, ejecuta tests.

En documentos, revisa el contenido.

En automatizaciones, prueba con casos controlados.

### Paso 8. Documenta decisiones importantes

Si una propuesta de Copilot afecta al proyecto, conviene documentar qué se ha cambiado y por qué.

---

## 12. Ejemplos de prompts seguros

### Para revisar código

```text
Revisa esta función y señala posibles problemas de seguridad, rendimiento y legibilidad. No modifiques el código todavía. Primero dame una lista priorizada de problemas.
```

### Para refactorizar

```text
Refactoriza esta función manteniendo exactamente el mismo comportamiento. No añadas nuevas dependencias y explica brevemente cada cambio realizado.
```

### Para generar tests

```text
Genera tests unitarios para esta función. Incluye casos normales, casos límite y entradas inválidas. No supongas requisitos que no aparezcan en el código.
```

### Para resumir documentación

```text
Resume este documento en lenguaje claro. No añadas información externa y separa el resultado en: ideas principales, dudas abiertas y tareas pendientes.
```

### Para trabajar con datos ficticios

```text
Usa estos datos ficticios para mostrar cómo se calcularía el promedio de ventas por mes. No asumas que representan datos reales.
```

---

## 13. Ejemplos de prompts poco seguros

### Prompt poco seguro 1

```text
Aquí está mi archivo .env completo. Dime por qué falla la conexión.
```

Problema: puede incluir credenciales reales.

Versión más segura:

```text
He sustituido los valores reales de mi archivo .env por valores ficticios. Dime qué partes debería revisar si falla la conexión a la base de datos.
```

### Prompt poco seguro 2

```text
Te paso los datos reales de mis clientes para que los analices.
```

Problema: puede incluir datos personales o confidenciales.

Versión más segura:

```text
Te paso una muestra ficticia con la misma estructura que mis datos reales. Ayúdame a diseñar un análisis sin usar información personal.
```

### Prompt poco seguro 3

```text
Crea una política interna sobre permisos laborales aunque no tengas más información.
```

Problema: puede inventar normas.

Versión más segura:

```text
Ayúdame a estructurar una política interna sobre permisos laborales. No inventes normas concretas; deja marcados los apartados que deben completarse con información oficial de la empresa.
```

---

## 14. Checklist general de uso responsable

Antes de usar una respuesta de Copilot, revisa esta lista:

### Privacidad

- ¿He introducido datos personales?
- ¿He introducido credenciales?
- ¿He compartido información confidencial?
- ¿Tengo permiso para usar esta información?
- ¿Puedo anonimizar el contenido?

### Seguridad

- ¿El código valida entradas?
- ¿Maneja errores?
- ¿Evita exponer secretos?
- ¿Introduce dependencias innecesarias?
- ¿Respeta prácticas seguras?

### Calidad

- ¿La respuesta resuelve el problema?
- ¿Es comprensible?
- ¿Está adaptada al contexto?
- ¿Es mantenible?
- ¿Necesita simplificación?

### Verificación

- ¿He probado el código?
- ¿He revisado el texto?
- ¿He comprobado las fuentes si hay datos externos?
- ¿He pedido aclaraciones si algo no está claro?

### Responsabilidad

- ¿Puedo explicar el resultado con mis propias palabras?
- ¿Estoy dispuesto a asumir este cambio como propio?
- ¿He documentado lo importante?

---

## 15. Resumen del tema

Copilot puede ser una herramienta muy potente, pero debe utilizarse con responsabilidad. Las respuestas generadas pueden contener errores, sesgos, información inventada o soluciones inseguras. Además, el uso de datos personales, credenciales o información confidencial exige especial cuidado.

La idea principal de este tema es que Copilot debe utilizarse como asistente, no como autoridad final. El usuario debe revisar, probar, adaptar y validar cualquier resultado antes de incorporarlo a un proyecto, documento o proceso profesional.

Usar Copilot bien no consiste solo en pedirle cosas. Consiste en saber qué pedir, qué no compartir, cómo revisar la respuesta y cuándo no aceptar una propuesta.

---

## 16. Checklist final

Antes de pasar al siguiente tema, asegúrate de que puedes responder a estas preguntas:

- ¿Qué diferencia hay entre prompt y contexto?
- ¿Qué tipos de datos no deberían compartirse sin autorización?
- ¿Qué es una alucinación en IA generativa?
- ¿Por qué no debemos aceptar código generado sin revisarlo?
- ¿Qué riesgos existen al crear agentes o automatizaciones?
- ¿Qué pasos seguirías para usar Copilot de forma segura?
- ¿Qué debe incluir una checklist de revisión de código generado?

---

## 17. Documentación oficial recomendada

- GitHub Copilot documentation: https://docs.github.com/copilot
- Responsible use of GitHub Copilot Chat in your IDE: https://docs.github.com/en/copilot/responsible-use/chat-in-your-ide
- GitHub Copilot Business Privacy Statement: https://docs.github.com/en/site-policy/privacy-policies/github-copilot-business-privacy-statement
- GitHub Privacy Statement: https://docs.github.com/site-policy/privacy-policies/github-privacy-statement
- GitHub Copilot model hosting: https://docs.github.com/en/copilot/reference/ai-models/model-hosting
- Microsoft Copilot Studio documentation: https://learn.microsoft.com/en-us/microsoft-copilot-studio/
