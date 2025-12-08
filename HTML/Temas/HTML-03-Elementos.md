# **Tema 3: Elementos en línea y elementos en bloque**

## **1. Introducción**

En HTML, los elementos se dividen en dos grandes categorías según su comportamiento en la página web:

- **Elementos en bloque**: Ocupan todo el ancho disponible y comienzan en una nueva línea.
- **Elementos en línea**: Solo ocupan el espacio necesario y no fuerzan un salto de línea.

Comprender esta diferencia es esencial para estructurar correctamente una página web y mejorar su diseño.

---

## **2. Elementos en bloque**

Los elementos en bloque generan un nuevo bloque de contenido en la página. Por defecto, ocupan todo el ancho disponible y comienzan en una nueva línea.

### **Características de los elementos en bloque:**

- Se expanden a lo largo del ancho de su contenedor.
- Inician en una nueva línea.
- Pueden contener otros elementos en bloque y en línea.

### **Ejemplos comunes:**

- **Encabezados:** `h1`, `h2`, `h3`, `h4`, `h5`, `h6`
- **Párrafos:** `p`
- **Listas:** `ul`, `ol`, `li`
- **Divisiones o contenedores:** `div`
- **Cajas de contenido estructurado:** `section`, `article`, `aside`, `header`, `footer`

### **Ejemplo práctico:**

Imagina que estás estructurando un artículo en un blog. Usarás elementos en bloque para separar las secciones.

```HTML
<article>
    <h1>Cómo mejorar tu código HTML</h1>
    <p>Es importante seguir buenas prácticas al escribir HTML para mejorar la accesibilidad y el SEO.</p>
</article>
```

En este caso:

- `h1` ocupa toda la línea.
- `p` también genera un bloque independiente.

---

## **3. Elementos en línea**

Los elementos en línea no generan un nuevo bloque de contenido, sino que se mantienen en la misma línea junto con otros elementos.

### **Características de los elementos en línea:**

- Solo ocupan el espacio necesario.
- No generan un salto de línea.
- Solo pueden contener texto o elementos en línea (no pueden contener elementos en bloque).

### **Ejemplos comunes:**

- **Enlaces:** `a`
- **Negrita y cursiva:** `strong`, `em`
- **Formato de texto:** `span`, `mark`, `code`
- **Imágenes:** `img`
- **Botones pequeños dentro de un texto:** `button`

### **Ejemplo práctico:**

Supongamos que en un artículo de un blog queremos resaltar una palabra en negrita y enlazar un término importante.

```HTML
<p>Para aprender más sobre HTML, visita <a href="https://developer.mozilla.org/">Mozilla Developer Network</a> y revisa los elementos <strong>semánticos</strong>.</p>
```

En este caso:

- `a` es un enlace que se mantiene en la misma línea.
- `strong` enfatiza la palabra sin afectar la disposición del texto.

---

## **4. Diferencias clave entre elementos en bloque y en línea**

| Característica                           | Elementos en bloque | Elementos en línea          |
| ---------------------------------------- | ------------------- | --------------------------- |
| Ocupa toda la línea                      | Sí                  | No                          |
| Inicia en nueva línea                    | Sí                  | No                          |
| Puede contener otros elementos en bloque | Sí                  | No                          |
| Uso común                                | Estructura y diseño | Formateo de texto y enlaces |

---

## **5. Combinación de elementos en bloque e inline**

Es posible combinar ambos tipos de elementos en un diseño web. Por ejemplo, dentro de un `div` (bloque), se pueden incluir `span` (inline) para resaltar ciertas palabras.

```HTML
<div>
    <p>En este artículo explicamos la diferencia entre <span style="color:blue;">elementos en línea</span> y <span style="color:red;">elementos en bloque</span>.</p>
</div>
```

En este caso:

- `div` es un elemento en bloque que envuelve todo el contenido.
- `span` es un elemento en línea que permite aplicar estilos sin alterar la estructura.

---

[![Texto y Elementos en Linea y en Bloque](https://img.youtube.com/vi/KBw2fd5BbCU/0.jpg)](https://www.youtube.com/watch?v=KBw2fd5BbCU&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **6. Buenas prácticas**

- Usa **elementos en bloque** para definir la estructura de la página.
- Usa **elementos en línea** para aplicar estilos o agregar interactividad sin modificar la disposición del contenido.
- Evita encerrar elementos en bloque dentro de elementos en línea, ya que esto puede causar errores en la visualización.
- Aprovecha las etiquetas semánticas de HTML5 (`section`, `article`, `aside`, etc.) para mejorar la accesibilidad y la optimización de motores de búsqueda (**SEO**).

---

En el próximo tema, aprenderemos sobre **las etiquetas de texto en HTML** y su impacto en la estructura de una página web.
