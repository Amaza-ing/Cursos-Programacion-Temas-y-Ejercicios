# Tema 13 — Buenas prácticas profesionales y estrategia de adopción de Copilot

## 1. Introducción

En los temas anteriores hemos visto cómo usar Copilot en distintos contextos:

- IA generativa y ecosistema Copilot;
- GitHub Copilot para desarrollo;
- prompting para programadores;
- Copilot Chat;
- testing, debugging y refactorización;
- agentes, CLI e instrucciones personalizadas;
- Docker, APIs y GitHub Actions;
- Microsoft 365 Copilot;
- Copilot Studio.

Este último tema tiene un objetivo diferente: aprender a integrar Copilot de forma profesional, sostenible y responsable en el trabajo diario.

Saber usar Copilot no significa pedirle cualquier cosa y aceptar la primera respuesta. Significa saber cuándo usarlo, cómo pedirle ayuda, cómo revisar lo que genera y cómo incorporarlo a un flujo de trabajo real.

---

## 2. Objetivos del tema

Al finalizar este tema deberías ser capaz de:

- Diseñar una forma profesional de trabajar con Copilot.
- Decidir qué tareas se pueden delegar parcialmente en IA.
- Saber qué tareas requieren revisión humana obligatoria.
- Crear checklists de validación.
- Definir normas básicas de uso para equipos.
- Integrar Copilot en flujos de desarrollo y productividad.
- Evitar dependencia excesiva de la IA.
- Evaluar la calidad de los resultados generados.

---

## 3. La idea principal: Copilot como asistente, no como sustituto

Copilot debe entenderse como un asistente.

Puede ayudar a:

- acelerar tareas;
- generar borradores;
- explicar conceptos;
- sugerir código;
- detectar problemas;
- resumir información;
- preparar documentación;
- automatizar partes repetitivas.

Pero no debe sustituir:

- el criterio profesional;
- la revisión humana;
- el conocimiento técnico;
- la responsabilidad sobre el resultado;
- la verificación de datos;
- las normas de seguridad;
- las políticas de la organización.

Una buena regla general es:

```text
Copilot puede proponer. La persona decide, revisa y se responsabiliza.
```

---

# Parte 1. Qué tareas delegar y cuáles no

## 4. Tareas adecuadas para Copilot

Copilot suele funcionar bien como apoyo en tareas como:

- generar primeras versiones;
- resumir documentos;
- explicar código;
- crear ejemplos;
- proponer estructuras;
- redactar documentación;
- sugerir tests;
- refactorizar código sencillo;
- detectar errores evidentes;
- convertir notas en texto organizado;
- preparar correos o presentaciones;
- generar ideas iniciales.

Estas tareas son adecuadas porque normalmente permiten revisión, corrección y mejora posterior.

---

## 5. Tareas que requieren especial revisión

Hay tareas donde Copilot puede ayudar, pero la revisión debe ser más estricta:

- código de producción;
- configuración de seguridad;
- consultas a bases de datos;
- scripts de despliegue;
- workflows de CI/CD;
- infraestructura como código;
- análisis de datos importantes;
- documentos legales o contractuales;
- comunicación externa con clientes;
- decisiones que afecten a usuarios reales.

En estos casos, Copilot puede ser útil para generar una propuesta inicial, pero no debe aceptarse sin pruebas y validación.

---

## 6. Tareas que no conviene delegar completamente

No conviene delegar completamente:

- decisiones estratégicas;
- decisiones legales;
- decisiones médicas;
- decisiones financieras;
- evaluación final de seguridad;
- revisión final de código crítico;
- gestión de datos confidenciales;
- aprobación de cambios en producción;
- comunicación sensible con clientes o empleados;
- interpretación definitiva de políticas internas.

Copilot puede ayudar a preparar información, pero no debe ser la autoridad final.

---

# Parte 2. Flujo profesional de trabajo con Copilot

## 7. Flujo recomendado

Un flujo profesional con Copilot puede seguir estos pasos:

1. Definir el objetivo.
2. Dar contexto.
3. Pedir una primera propuesta.
4. Revisar la respuesta.
5. Pedir mejoras.
6. Contrastar datos importantes.
7. Probar si es código o configuración.
8. Documentar los cambios.
9. Revisar con otra persona si es necesario.
10. Aceptar, modificar o descartar.

Este flujo evita el error más común: aceptar demasiado rápido lo primero que genera la IA.

---

## 8. Paso 1: definir el objetivo

Antes de escribir un prompt, debemos saber qué queremos.

Mal enfoque:

```text
Hazme esto.
```

Mejor enfoque:

```text
Necesito crear una función que valide formularios de registro. Debe comprobar email, contraseña y nombre de usuario. Quiero que el código sea claro, fácil de testear y sin dependencias externas.
```

Cuanto más claro sea el objetivo, mejor será la respuesta.

---

## 9. Paso 2: dar contexto

El contexto permite que Copilot entienda el entorno de trabajo.

Ejemplo para desarrollo:

```text
Estoy trabajando en una aplicación React con Vite. Uso JavaScript, no TypeScript. Quiero crear un componente sencillo y mantener los estilos en CSS separado.
```

Ejemplo para productividad:

```text
Estoy preparando un correo para un cliente que ha pedido una actualización del proyecto. Quiero sonar profesional, transmitir tranquilidad y explicar que enviaremos avances el viernes.
```

---

## 10. Paso 3: pedir una primera propuesta

Una vez dado el contexto, pedimos una propuesta.

Ejemplo:

```text
Propón una primera versión de la función. Después explica brevemente cómo funciona y qué casos debería probar.
```

Es útil pedir siempre una explicación, no solo el resultado.

---

## 11. Paso 4: revisar

Hay que revisar:

- si cumple el objetivo;
- si respeta el contexto;
- si hay errores;
- si falta información;
- si introduce dependencias no deseadas;
- si el estilo encaja con el proyecto;
- si hay riesgos de seguridad;
- si hay partes inventadas.

---

## 12. Paso 5: pedir mejoras

La primera respuesta rara vez es la mejor.

Podemos pedir:

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

## 13. Paso 6: probar y verificar

Si se trata de código:

- ejecutar el proyecto;
- pasar tests;
- revisar errores;
- comprobar casos límite;
- hacer revisión manual;
- revisar seguridad.

Si se trata de texto:

- comprobar datos;
- revisar tono;
- verificar nombres y fechas;
- adaptar al público;
- eliminar repeticiones;
- confirmar que no hay información confidencial.

Si se trata de análisis de datos:

- revisar columnas;
- comprobar fórmulas;
- contrastar resultados;
- validar supuestos;
- revisar si hay datos faltantes o atípicos.

---

# Parte 3. Checklist de calidad

## 14. Checklist general para cualquier resultado de Copilot

Antes de usar una respuesta generada por Copilot, revisa:

- [ ] ¿Responde exactamente al objetivo?
- [ ] ¿Usa el contexto correcto?
- [ ] ¿El formato es adecuado?
- [ ] ¿Hay datos inventados?
- [ ] ¿Hay errores técnicos?
- [ ] ¿Se ha incluido información sensible?
- [ ] ¿El tono es apropiado?
- [ ] ¿Necesita verificación con fuentes externas?
- [ ] ¿Requiere revisión de otra persona?
- [ ] ¿La responsabilidad final está clara?

---

## 15. Checklist para código generado

Antes de aceptar código generado por Copilot:

- [ ] ¿Entiendo qué hace?
- [ ] ¿Compila o se ejecuta correctamente?
- [ ] ¿Respeta la arquitectura del proyecto?
- [ ] ¿Sigue el estilo del equipo?
- [ ] ¿Tiene nombres claros?
- [ ] ¿Evita duplicación innecesaria?
- [ ] ¿Tiene tests?
- [ ] ¿Controla errores?
- [ ] ¿Hay problemas de seguridad?
- [ ] ¿Introduce dependencias innecesarias?
- [ ] ¿Funciona en casos límite?
- [ ] ¿Está documentado si es necesario?

---

## 16. Checklist para documentación

Antes de publicar documentación generada con Copilot:

- [ ] ¿Está actualizada?
- [ ] ¿Es clara para el público objetivo?
- [ ] ¿Tiene ejemplos correctos?
- [ ] ¿No promete cosas que no son ciertas?
- [ ] ¿No contiene información interna no autorizada?
- [ ] ¿Está bien estructurada?
- [ ] ¿Evita repeticiones?
- [ ] ¿Distingue hechos de recomendaciones?

---

## 17. Checklist para presentaciones y correos

Antes de enviar o presentar contenido generado:

- [ ] ¿El tono es adecuado?
- [ ] ¿El mensaje es claro?
- [ ] ¿Hay información sensible?
- [ ] ¿Los nombres y fechas son correctos?
- [ ] ¿El contenido es demasiado genérico?
- [ ] ¿Falta contexto?
- [ ] ¿Puede malinterpretarse?
- [ ] ¿Necesita una versión más breve?
- [ ] ¿Representa bien la postura de la persona o empresa?

---

# Parte 4. Uso en equipos

## 18. Por qué los equipos necesitan normas

Cuando una persona usa Copilot de forma individual, puede revisar sus propios resultados.

Pero cuando lo usa un equipo completo, aparecen nuevas preguntas:

- ¿Qué datos se pueden introducir?
- ¿Qué herramientas están permitidas?
- ¿Se puede usar con código privado?
- ¿Quién revisa el código generado?
- ¿Cómo se documenta el uso de IA?
- ¿Qué ocurre si Copilot genera algo incorrecto?
- ¿Hay tareas prohibidas?
- ¿Qué criterios de calidad se aplican?

Por eso conviene definir normas internas.

---

## 19. Política básica de uso de Copilot para equipos

Una política sencilla podría incluir:

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

## 20. Roles en un flujo con Copilot

En un equipo puede haber distintos roles:

| Rol                      | Responsabilidad                                      |
| ------------------------ | ---------------------------------------------------- |
| Persona usuaria          | Formula prompts, revisa resultados y decide qué usar |
| Revisor técnico          | Revisa código, arquitectura y seguridad              |
| Responsable de datos     | Define qué información puede usarse                  |
| Responsable de seguridad | Evalúa riesgos y permisos                            |
| Responsable de equipo    | Define normas y buenas prácticas                     |

No siempre serán personas distintas, pero las responsabilidades deben estar claras.

---

## 21. Integración con Git y GitHub

En proyectos de desarrollo, un flujo recomendable sería:

1. Crear una rama para el cambio.
2. Usar Copilot para generar o mejorar partes concretas.
3. Revisar manualmente el resultado.
4. Ejecutar tests.
5. Crear commits claros.
6. Abrir una pull request.
7. Revisar con otra persona.
8. Usar GitHub Actions para validar.
9. Corregir problemas.
10. Fusionar solo cuando esté aprobado.

Copilot puede participar en varias partes del proceso, pero no debe saltarse los controles del equipo.

---

# Parte 5. Estrategia de adopción

## 22. Cómo introducir Copilot en una organización

Una adopción razonable puede hacerse en fases.

### Fase 1. Exploración

Objetivo: entender posibilidades y límites.

Acciones:

- probar casos sencillos;
- identificar tareas repetitivas;
- formar a un grupo pequeño;
- recopilar dudas y riesgos.

### Fase 2. Piloto

Objetivo: probar Copilot en un entorno controlado.

Acciones:

- elegir un equipo o proyecto;
- definir normas básicas;
- medir ahorro de tiempo;
- revisar calidad;
- documentar errores frecuentes.

### Fase 3. Estandarización

Objetivo: crear prácticas comunes.

Acciones:

- definir prompts recomendados;
- crear checklists;
- documentar buenas prácticas;
- formar a más personas;
- revisar políticas de seguridad.

### Fase 4. Escalado

Objetivo: ampliar el uso de forma segura.

Acciones:

- extender a más equipos;
- integrar con flujos de trabajo;
- crear agentes si procede;
- medir impacto;
- revisar periódicamente la política.

---

## 23. Métricas para evaluar Copilot

Para saber si Copilot está aportando valor, se pueden medir indicadores como:

- reducción de tiempo en tareas repetitivas;
- mejora en documentación;
- número de tests generados;
- reducción de errores simples;
- satisfacción del equipo;
- calidad de los prompts;
- cantidad de resultados descartados;
- incidencias relacionadas con uso incorrecto;
- tiempo de revisión;
- impacto en onboarding de nuevos miembros.

No basta con medir cuánto se usa Copilot. Hay que medir si mejora el trabajo.

---

## 24. Riesgos de una mala adopción

Una adopción mal gestionada puede provocar:

- dependencia excesiva;
- pérdida de criterio técnico;
- código no revisado;
- errores en producción;
- documentación incorrecta;
- fuga de información;
- decisiones basadas en respuestas no verificadas;
- falsa sensación de productividad;
- reducción de aprendizaje real;
- conflictos sobre responsabilidad.

---

## 25. Buenas prácticas para aprender con Copilot

Copilot también puede ser una herramienta de aprendizaje.

Pero para aprender de verdad, conviene:

- pedir explicaciones, no solo soluciones;
- comparar alternativas;
- intentar resolver primero una parte;
- preguntar por errores;
- pedir ejemplos progresivos;
- modificar el código generado;
- comprobar si se entiende cada línea;
- crear resúmenes propios;
- no copiar sin comprender.

Un buen prompt de aprendizaje sería:

```text
Explícame esta solución paso a paso. Después hazme tres preguntas para comprobar si la he entendido.
```

Otro ejemplo:

```text
Dame dos formas de resolver este problema, compara ventajas e inconvenientes y recomiéndame una para un proyecto pequeño.
```

---

# Parte 6. Plantillas finales

## 26. Plantilla de prompt profesional

```text
Necesito [objetivo].
Estoy trabajando en [contexto].
El resultado debe servir para [uso final].
Debes tener en cuenta [restricciones].
Quiero la respuesta en formato [formato].
Antes de dar la respuesta final, señala posibles problemas o riesgos.
```

Ejemplo:

```text
Necesito refactorizar esta función.
Estoy trabajando en una aplicación JavaScript sencilla para alumnos principiantes.
El resultado debe servir para explicar buenas prácticas de legibilidad.
Debes mantener el mismo comportamiento y no añadir librerías externas.
Quiero la respuesta en formato: código refactorizado, explicación y posibles tests.
Antes de dar la respuesta final, señala posibles problemas o riesgos.
```

---

## 27. Plantilla para revisar una respuesta de Copilot

```text
Revisa la respuesta anterior.
Comprueba si cumple el objetivo inicial.
Señala errores, ambigüedades, riesgos o partes inventadas.
Propón una versión mejorada.
No añadas información que no puedas justificar.
```

---

## 28. Plantilla para pedir alternativas

```text
Dame tres alternativas para resolver este problema.
Para cada alternativa, indica ventajas, inconvenientes, nivel de dificultad y cuándo conviene usarla.
Termina recomendando una opción para mi caso concreto.
```

---

## 29. Plantilla para documentación

```text
Genera documentación para este código.
Incluye: propósito, parámetros, valor devuelto, ejemplo de uso, posibles errores y notas importantes.
Usa un lenguaje claro para personas con nivel principiante/intermedio.
```

---

## 30. Plantilla para reuniones y productividad

```text
Convierte estas notas en un resumen profesional.
Organiza la información en: contexto, decisiones tomadas, tareas pendientes, responsables, fechas y dudas abiertas.
Usa un tono claro y directo.
```

---

## 31. Conclusión del curso

Copilot y GitHub Copilot son herramientas muy potentes, pero su valor depende de cómo se utilicen.

Durante el curso hemos visto que Copilot puede ayudar a:

- escribir y revisar código;
- documentar;
- generar tests;
- detectar errores;
- automatizar workflows;
- trabajar con APIs;
- preparar documentos;
- analizar datos;
- crear presentaciones;
- resumir reuniones;
- diseñar agentes.

Pero también hemos visto que existen límites:

- puede equivocarse;
- puede inventar;
- puede proponer código inseguro;
- puede no entender el contexto;
- puede generar resultados demasiado genéricos;
- puede crear dependencia si se usa mal.

La competencia profesional no consiste en usar Copilot para evitar pensar, sino en usarlo para pensar mejor, trabajar más rápido y revisar con más criterio.

---

## 32. Resumen del tema

Las ideas principales son:

- Copilot debe usarse como asistente, no como sustituto.
- El flujo profesional incluye contexto, revisión, pruebas y validación.
- No todas las tareas son igual de adecuadas para IA.
- Los equipos necesitan normas claras de uso.
- La adopción debe ser gradual y medible.
- La revisión humana sigue siendo imprescindible.
- Un buen uso de Copilot combina productividad, criterio técnico y responsabilidad.

---

## 33. Documentación recomendada

- Microsoft Learn — Microsoft Copilot documentation: https://learn.microsoft.com/en-us/copilot/
- Microsoft Learn — Microsoft 365 Copilot documentation: https://learn.microsoft.com/en-us/microsoft-365/copilot/
- Microsoft Learn — Copilot Studio documentation: https://learn.microsoft.com/en-us/microsoft-copilot-studio/
- GitHub Docs — GitHub Copilot documentation: https://docs.github.com/copilot
- GitHub Docs — Responsible use of GitHub Copilot: https://docs.github.com/en/copilot/responsible-use
