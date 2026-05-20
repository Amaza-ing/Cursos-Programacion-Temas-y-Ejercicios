# Ejercicios - Tema 13: Buenas prácticas profesionales y estrategia de adopción de Copilot

A continuación, encontrarás ejercicios prácticos para aplicar Copilot de forma profesional, segura y útil. Intenta resolverlos antes de consultar la solución.

## Ejercicio 1: Clasificar tareas según el nivel de riesgo

Clasifica las siguientes tareas en tres grupos: bajo riesgo, riesgo medio o alto riesgo.

1. Pedir a Copilot que explique un concepto técnico general.
2. Pedir a Copilot que redacte un contrato legal definitivo.
3. Pedir a Copilot que genere una función sencilla para ordenar una lista.
4. Pedir a Copilot que analice datos personales de clientes.
5. Pedir a Copilot que proponga una estructura para una presentación interna.

<details>
<summary>Mostrar solución</summary>

Una posible clasificación sería:

**Bajo riesgo:**

- Explicar un concepto técnico general.
- Proponer una estructura para una presentación interna.

**Riesgo medio:**

- Generar una función sencilla para ordenar una lista.

Aunque sea una tarea técnica común, el código debe revisarse y probarse antes de usarlo.

**Alto riesgo:**

- Redactar un contrato legal definitivo.
- Analizar datos personales de clientes.

Estas tareas pueden implicar consecuencias legales, privacidad o decisiones sensibles. No deberían delegarse completamente en Copilot.

</details>

## Ejercicio 2: Crear una checklist de revisión

Imagina que Copilot ha generado una función para validar formularios en una aplicación web. Crea una checklist breve para revisar el código antes de aceptarlo.

<details>
<summary>Mostrar solución</summary>

Una posible checklist sería:

- ¿Entiendo qué hace cada parte del código?
- ¿Cumple exactamente con el objetivo pedido?
- ¿Respeta el estilo del proyecto?
- ¿Gestiona errores o casos límite?
- ¿Evita duplicación innecesaria?
- ¿No introduce datos sensibles ni valores secretos?
- ¿Es fácil de mantener?
- ¿Se han creado o actualizado tests?
- ¿Los tests pasan correctamente?
- ¿El código ha sido revisado por una persona si afecta a una parte importante del proyecto?

Esta checklist ayuda a recordar que Copilot puede acelerar el trabajo, pero no sustituye la revisión técnica.

</details>

## Ejercicio 3: Mejorar una política de uso demasiado vaga

Una empresa ha escrito esta norma:

```text
Se puede usar IA siempre que se use bien.
```

Reescribe la norma para que sea más clara y profesional.

<details>
<summary>Mostrar solución</summary>

Una versión más adecuada sería:

```text
Las herramientas de inteligencia artificial podrán utilizarse como apoyo en tareas de redacción, análisis, programación, documentación y productividad, siempre que estén autorizadas por la empresa. No se deberá introducir información confidencial, datos personales, credenciales, código privado sensible ni documentación interna restringida en herramientas no aprobadas. Todo resultado generado por IA deberá ser revisado por una persona antes de utilizarse, publicarse o compartirse.
```

Esta versión es mejor porque indica:

- Cuándo puede usarse la IA.
- Qué límites existen.
- Qué tipo de información no debe introducirse.
- Que la revisión humana es obligatoria.

</details>

## Ejercicio 4: Diseñar un flujo profesional de trabajo con Copilot

Describe un flujo de trabajo profesional para usar Copilot al crear una nueva funcionalidad en una aplicación.

<details>
<summary>Mostrar solución</summary>

Un flujo adecuado podría ser:

1. Definir claramente la funcionalidad que se quiere crear.
2. Revisar la arquitectura del proyecto antes de pedir código.
3. Escribir un prompt con contexto, objetivo, restricciones y formato esperado.
4. Pedir a Copilot una primera propuesta.
5. Revisar si la propuesta encaja con el proyecto.
6. Modificar manualmente lo necesario.
7. Pedir a Copilot que proponga tests.
8. Ejecutar los tests.
9. Revisar seguridad, legibilidad y mantenimiento.
10. Documentar los cambios importantes.
11. Crear un commit claro.
12. Solicitar revisión si el cambio es relevante.

Copilot debe integrarse en el flujo de desarrollo, no reemplazarlo.

</details>

## Ejercicio 5: Detectar un mal uso de Copilot

Lee el siguiente caso:

> Un desarrollador copia una función generada por Copilot directamente en producción. No la revisa, no la prueba y tampoco entiende completamente cómo funciona. La función procesa pagos de clientes.

Explica qué errores se están cometiendo.

<details>
<summary>Mostrar solución</summary>

Los principales errores son:

- Usar código generado sin revisión.
- No ejecutar pruebas.
- No entender el código antes de incorporarlo.
- Aplicarlo directamente en producción.
- Usarlo en una parte crítica del sistema.
- No revisar posibles problemas de seguridad.
- No comprobar casos límite.
- No seguir un proceso de revisión por pares.

Este es un mal uso de Copilot porque se está delegando una decisión crítica en una herramienta que puede equivocarse.

</details>

## Ejercicio 6: Elegir tareas adecuadas para Copilot

Indica cuáles de estas tareas son adecuadas para Copilot y cuáles requieren mucha supervisión humana:

1. Generar ideas para nombres de variables.
2. Explicar un error de consola.
3. Decidir si se despide a un empleado.
4. Crear un primer borrador de documentación técnica.
5. Revisar una cláusula legal compleja.
6. Proponer tests unitarios para una función.

<details>
<summary>Mostrar solución</summary>

**Adecuadas para Copilot:**

- Generar ideas para nombres de variables.
- Explicar un error de consola.
- Crear un primer borrador de documentación técnica.
- Proponer tests unitarios para una función.

Estas tareas siguen necesitando revisión, pero son usos razonables de Copilot.

**Requieren mucha supervisión humana o no deberían delegarse:**

- Decidir si se despide a un empleado.
- Revisar una cláusula legal compleja.

Estas tareas tienen implicaciones personales, legales o éticas importantes.

</details>

## Ejercicio 7: Crear una guía breve para un equipo

Redacta una guía de 5 normas para que un equipo empiece a usar Copilot de forma responsable.

<details>
<summary>Mostrar solución</summary>

Una posible guía sería:

1. Usa Copilot como apoyo, no como sustituto de tu criterio profesional.
2. No introduzcas datos personales, credenciales, secretos, información de clientes ni documentación confidencial en herramientas no autorizadas.
3. Revisa siempre el contenido generado antes de usarlo.
4. Comprueba el código con pruebas y revisiones antes de incorporarlo al proyecto.
5. Si una respuesta afecta a decisiones legales, económicas, médicas, laborales o de seguridad, consulta con una persona responsable.

Estas normas son sencillas y pueden servir como punto de partida para una política interna más completa.

</details>

## Ejercicio 8: Evaluar la calidad de una respuesta de Copilot

Imagina que Copilot responde a una pregunta técnica con una explicación aparentemente correcta, pero no cita fuentes, no indica limitaciones y propone un comando que no entiendes. ¿Qué deberías hacer antes de usar esa respuesta?

<details>
<summary>Mostrar solución</summary>

Antes de usar la respuesta deberías:

- Leer con calma la explicación.
- No ejecutar comandos que no entiendas.
- Pedir a Copilot que explique el comando paso a paso.
- Consultar documentación oficial.
- Probar primero en un entorno seguro.
- Comprobar si el comando puede modificar, borrar o exponer información.
- Pedir revisión a otra persona si afecta a un sistema importante.

Un prompt útil sería:

```text
Explica este comando paso a paso. Indica qué modifica, qué riesgos tiene, si puede borrar datos y cómo podría probarlo de forma segura antes de ejecutarlo en un entorno real.
```

</details>
