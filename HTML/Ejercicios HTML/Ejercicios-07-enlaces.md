# **Ejercicios - Tema 7: Enlaces en HTML**

## **Instrucciones:**
A continuación, encontrarás 5 ejercicios prácticos sobre enlaces en HTML. Realiza cada uno en un editor de código y visualiza los resultados en tu navegador.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Enlace básico**
Crea un documento HTML que incluya un enlace a un sitio web externo como Google o Wikipedia.
<details><summary>Mostrar solución</summary>

```html
<a href="https://www.google.com">Visitar Google</a>
```

</details>

---

### **Ejercicio 2: Enlace que se abre en una nueva pestaña**
Modifica el enlace del ejercicio anterior para que se abra en una nueva pestaña utilizando el atributo `target` de manera segura con `rel="noopener noreferrer"`.
<details><summary>Mostrar solución</summary>

```html
<a href="https://www.google.com" target="_blank" rel="noopener noreferrer">Abrir Google en nueva pestaña</a>
```

</details>

---

### **Ejercicio 3: Enlace interno dentro de una página**
Crea una página HTML con dos secciones. Agrega un enlace en la parte superior que al hacer clic lleve al usuario a la segunda sección usando un `id`.
<details><summary>Mostrar solución</summary>

```html
<a href="#seccion2">Ir a la Sección 2</a>

<h2 id="seccion2">Sección 2</h2>
<p>Este es el contenido de la segunda sección.</p>
```

</details>

---

### **Ejercicio 4: Enlace relativo a otra página interna**
Crea un enlace que dirija al usuario a otra página HTML dentro del mismo proyecto.
<details><summary>Mostrar solución</summary>

```html
<a href="contacto.html">Ir a la página de contacto</a>
```

</details>

---

### **Ejercicio 5: Enlace de correo electrónico y teléfono**
Crea enlaces que permitan enviar un correo electrónico y realizar una llamada telefónica desde la página web.
<details><summary>Mostrar solución</summary>

```html
<a href="mailto:correo@ejemplo.com">Enviar un correo</a>
<a href="tel:+123456789">Llamar al 123456789</a>
```

</details>

