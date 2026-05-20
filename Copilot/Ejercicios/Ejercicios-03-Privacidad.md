# Ejercicios - Tema 03: Privacidad, seguridad, límites y uso responsable de la IA

A continuación, encontrarás ejercicios prácticos para aprender a usar Copilot de forma segura, crítica y responsable.

## Ejercicio 1: Clasificar información sensible

Indica si sería apropiado introducir directamente la siguiente información en un prompt de Copilot. Justifica brevemente cada caso.

1. Un fragmento de código sin datos reales.
2. Una contraseña de acceso a una base de datos.
3. Un listado con nombres, correos y teléfonos de clientes.
4. Un error genérico de consola sin datos privados.
5. Un contrato interno completo de una empresa.

<details>
<summary><strong>Mostrar solución</strong></summary>

1. **Sí, en principio puede ser apropiado**, siempre que no contenga secretos, credenciales ni información privada.
2. **No**, nunca se deben introducir contraseñas, tokens ni claves privadas.
3. **No**, contiene datos personales de clientes.
4. **Sí, normalmente puede ser apropiado**, siempre que no incluya rutas privadas, claves, tokens o datos personales.
5. **No directamente**, porque puede contener información confidencial. Se debería resumir, anonimizar o usar solo fragmentos necesarios si la política de la empresa lo permite.

</details>

## Ejercicio 2: Reformular un prompt inseguro

Observa este prompt:

```text
Te paso el archivo completo de clientes con nombres, emails, teléfonos y compras. Analízalo y dime a quién deberíamos enviar una campaña.
```

Reescríbelo para que sea más seguro.

<details>
<summary><strong>Mostrar solución</strong></summary>

Una versión más segura podría ser:

```text
Quiero analizar una base de clientes para preparar una campaña, pero no voy a compartir datos personales.
Indícame qué variables agregadas debería revisar, por ejemplo frecuencia de compra, importe medio, categoría de producto e inactividad.
Propón un método general para segmentar clientes sin usar nombres, emails ni teléfonos.
```

Esta versión evita compartir datos personales y pide una orientación metodológica general.

</details>

## Ejercicio 3: Revisar código generado por IA

Copilot genera este código para iniciar sesión en una aplicación:

```javascript
function login(username, password) {
  if (username === "admin" && password === "1234") {
    return "Access granted";
  }
  return "Access denied";
}
```

Indica al menos tres problemas de seguridad o calidad.

<details>
<summary><strong>Mostrar solución</strong></summary>

Problemas posibles:

1. La contraseña está escrita directamente en el código.
2. La contraseña es muy débil.
3. No hay cifrado ni hash de contraseñas.
4. No hay conexión con un sistema real de autenticación.
5. No hay control de intentos fallidos.
6. El mensaje de respuesta es demasiado simple para un sistema real.
7. No se valida ni se sanitiza la entrada.

Una versión real debería usar un sistema de autenticación seguro, contraseñas almacenadas con hash, variables de entorno y controles adicionales.

</details>

## Ejercicio 4: Decidir si se debe usar Copilot

Lee los siguientes casos e indica si Copilot puede utilizarse como apoyo, si debe evitarse o si debe usarse con mucha supervisión.

1. Crear una primera versión de documentación técnica.
2. Generar una decisión automática sobre la concesión de una beca.
3. Explicar un error de programación.
4. Escribir código que maneja pagos online.
5. Resumir notas personales que contienen datos médicos.

<details>
<summary><strong>Mostrar solución</strong></summary>

1. **Puede utilizarse como apoyo**, revisando el contenido.
2. **Debe evitarse como decisión automática**, porque afecta directamente a una persona.
3. **Puede utilizarse como apoyo**, verificando la explicación.
4. **Puede utilizarse con mucha supervisión**, porque implica seguridad, dinero y posibles datos sensibles.
5. **Debe evitarse o anonimizarse cuidadosamente**, porque contiene información médica personal.

</details>

## Ejercicio 5: Crear una checklist de revisión

Antes de aceptar una respuesta generada por Copilot, ¿qué comprobarías? Escribe una checklist con al menos seis puntos.

<details>
<summary><strong>Mostrar solución</strong></summary>

Una checklist adecuada podría ser:

- Comprobar que la respuesta realmente resuelve el problema planteado.
- Revisar si hay errores técnicos.
- Verificar datos importantes en fuentes fiables.
- Comprobar que no se han incluido datos privados o sensibles.
- Revisar si el código contiene credenciales, tokens o rutas privadas.
- Probar el código antes de usarlo.
- Revisar licencias o dependencias si se ha generado código externo.
- Comprobar que el resultado sigue las normas del proyecto o de la empresa.
- Asegurarse de que una persona toma la decisión final.

</details>

## Ejercicio 6: Identificar una alucinación

Una IA responde:

```text
No necesitas revisar el código generado por Copilot, porque todo el código que produce está comprobado automáticamente y siempre es seguro.
```

Explica por qué esta respuesta es incorrecta.

<details>
<summary><strong>Mostrar solución</strong></summary>

La respuesta es incorrecta porque el código generado por IA puede contener errores, malas prácticas, vulnerabilidades o soluciones que no encajan con el proyecto. Copilot puede ser una herramienta muy útil, pero sus sugerencias deben revisarse, probarse y adaptarse.

Una respuesta más correcta sería:

```text
Copilot puede ayudar a generar código, pero la persona desarrolladora debe revisar, probar y validar el resultado antes de usarlo en un proyecto real.
```

</details>
