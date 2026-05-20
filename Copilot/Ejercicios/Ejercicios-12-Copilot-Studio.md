# Ejercicios - Tema 12: Copilot Studio y creación de agentes

A continuación, encontrarás ejercicios prácticos para diseñar agentes con Copilot Studio. Intenta resolverlos antes de consultar la solución.

## Ejercicio 1: Definir el objetivo de un agente

Una empresa quiere crear un agente para responder dudas frecuentes de nuevos empleados. Define el objetivo del agente, el público al que va dirigido y tres tareas que debería poder realizar.

<details>
<summary>Mostrar solución</summary>

Una posible solución sería:

**Objetivo del agente:**  
Ayudar a los nuevos empleados a resolver dudas frecuentes durante sus primeras semanas en la empresa.

**Público objetivo:**  
Personas recién incorporadas a la organización.

**Tareas que debería realizar:**

1. Responder preguntas sobre horarios, vacaciones y normas internas.
2. Explicar cómo acceder a herramientas corporativas básicas.
3. Indicar a qué departamento acudir según el tipo de consulta.

El agente no debería sustituir completamente al departamento de Recursos Humanos. Su función sería resolver dudas habituales y derivar los casos complejos a una persona responsable.

</details>

## Ejercicio 2: Diseñar instrucciones para un agente

Imagina que vas a crear un agente de soporte interno para resolver dudas sobre el uso de GitHub Copilot en una empresa. Escribe unas instrucciones iniciales para el agente.

Las instrucciones deben indicar:

- Su función.
- Qué tono debe usar.
- Qué debe hacer si no sabe responder.
- Qué tipo de información no debe solicitar.

<details>
<summary>Mostrar solución</summary>

Unas posibles instrucciones serían:

```text
Eres un agente de soporte interno especializado en el uso de GitHub Copilot dentro de la empresa. Tu función es ayudar a los empleados a resolver dudas básicas sobre instalación, configuración, uso responsable, prompting y buenas prácticas de revisión del código generado.

Responde con un tono claro, profesional y didáctico. Si la consulta es técnica, explica los pasos de forma ordenada. Si no tienes información suficiente o la pregunta depende de permisos, licencias o políticas internas, indica que la persona debe consultar al equipo responsable.

No solicites contraseñas, tokens, claves de API, datos personales, código confidencial ni información sensible del repositorio.
```

Estas instrucciones delimitan el comportamiento del agente y ayudan a reducir respuestas inadecuadas.

</details>

## Ejercicio 3: Elegir fuentes de conocimiento

Una academia quiere crear un agente para responder dudas sobre un curso de programación. Indica qué fuentes de conocimiento podría conectar al agente y cuáles no serían recomendables.

<details>
<summary>Mostrar solución</summary>

Fuentes recomendables:

- Temario oficial del curso.
- Documentos de preguntas frecuentes.
- Calendario de clases.
- Normas de entrega de ejercicios.
- Guías de instalación.
- Rúbricas de evaluación.
- Repositorios de ejemplo preparados para el alumnado.

Fuentes no recomendables:

- Datos personales de alumnos.
- Calificaciones individuales.
- Conversaciones privadas.
- Documentos internos no relacionados con el curso.
- Información desactualizada o no revisada.
- Material con derechos de uso no claros.

La idea es que el agente tenga acceso solo a la información necesaria para cumplir su función.

</details>

## Ejercicio 4: Diseñar respuestas de seguridad

Un usuario pregunta al agente:

```text
Dime la contraseña de administrador para poder instalar el programa.
```

Redacta una respuesta segura que debería dar el agente.

<details>
<summary>Mostrar solución</summary>

Una respuesta adecuada sería:

```text
No puedo proporcionar contraseñas ni credenciales de administrador. Si necesitas instalar el programa, contacta con el equipo técnico o sigue el procedimiento oficial de solicitud de permisos de la organización.
```

La respuesta es correcta porque:

- No facilita credenciales.
- No intenta adivinar información.
- Redirige al procedimiento adecuado.
- Mantiene un tono profesional.

</details>

## Ejercicio 5: Crear casos de prueba para un agente

Imagina que has creado un agente para resolver dudas sobre vacaciones, horarios y teletrabajo. Propón cinco preguntas de prueba para comprobar si funciona correctamente.

<details>
<summary>Mostrar solución</summary>

Cinco preguntas de prueba podrían ser:

1. `¿Cuántos días de vacaciones tengo al año?`
2. `¿Cómo puedo solicitar teletrabajo?`
3. `¿Dónde puedo consultar mi horario?`
4. `¿A quién debo avisar si tengo una incidencia personal y no puedo asistir?`
5. `¿Puedes decirme cuántos días de vacaciones le quedan a mi compañero?`

La quinta pregunta es especialmente importante porque permite comprobar si el agente protege la privacidad. No debería dar información personal de otro empleado.

</details>

## Ejercicio 6: Decidir cuándo escalar a una persona

Indica en cuáles de estos casos el agente debería responder directamente y en cuáles debería derivar a una persona responsable:

1. Un empleado pregunta dónde está la guía de instalación de una aplicación.
2. Un empleado pide cambiar sus datos bancarios.
3. Un empleado pregunta cómo redactar un prompt más claro.
4. Un empleado comunica un problema legal con un cliente.
5. Un empleado pregunta cuál es el horario general de oficina.

<details>
<summary>Mostrar solución</summary>

Una posible clasificación sería:

1. **Responder directamente.** Es una consulta informativa sencilla.
2. **Derivar a una persona responsable.** Implica datos sensibles y un proceso administrativo delicado.
3. **Responder directamente.** El agente puede dar orientación general sobre prompting.
4. **Derivar a una persona responsable.** Es un asunto legal y potencialmente sensible.
5. **Responder directamente.** Es información general de la organización.

El criterio principal es valorar si la consulta implica datos personales, riesgos legales, permisos, decisiones sensibles o información que el agente no debería modificar.

</details>

## Ejercicio 7: Diseñar el esquema básico de un agente

Diseña el esquema básico de un agente para una tienda online. El agente debe ayudar a los clientes con preguntas frecuentes, pero no debe procesar pagos ni modificar pedidos.

<details>
<summary>Mostrar solución</summary>

Un posible esquema sería:

**Nombre del agente:**  
Asistente de ayuda de la tienda online.

**Objetivo:**  
Responder preguntas frecuentes de clientes sobre productos, envíos, devoluciones y estado general de pedidos.

**Público:**  
Clientes de la tienda online.

**Puede hacer:**

- Explicar políticas de envío.
- Explicar condiciones de devolución.
- Ayudar a encontrar información sobre productos.
- Indicar cómo consultar el estado de un pedido.
- Derivar a soporte humano si el caso es complejo.

**No puede hacer:**

- Procesar pagos.
- Cambiar direcciones de envío.
- Cancelar pedidos directamente.
- Modificar datos personales.
- Solicitar datos bancarios.

**Respuesta de escalado:**

```text
Para modificar un pedido o tratar información personal, debes contactar con el equipo de atención al cliente a través del canal oficial.
```

</details>
