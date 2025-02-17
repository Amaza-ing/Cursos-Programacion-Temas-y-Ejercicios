# **Tema 11: Qué es el `README.md` y cómo trabajar con Markdown**

## **1. Introducción**
El archivo `README.md` es un documento fundamental en cualquier repositorio de Git. Se utiliza para describir el proyecto, proporcionar instrucciones de uso y facilitar la colaboración.

El formato **Markdown (`.md`)** es un lenguaje de marcado ligero que permite formatear texto de manera sencilla y legible, sin necesidad de código HTML complejo.

---

## **2. Importancia del `README.md`**
- Explica la finalidad y el uso del proyecto.
- Facilita la colaboración proporcionando guías de instalación y uso.
- Mejora la documentación con ejemplos y enlaces relevantes.
- Es lo primero que los visitantes ven en GitHub y otras plataformas de repositorios.

Un buen `README.md` debe incluir:
- Un **título claro**.
- Una **descripción** del proyecto.
- Instrucciones de instalación y uso.
- Información sobre cómo contribuir.
- Contacto o enlaces a documentación adicional.

---

## **3. Sintaxis básica de Markdown**
Markdown permite estructurar documentos de manera sencilla. Algunos de los elementos más utilizados son:

### **3.1. Encabezados**
```markdown
# Encabezado 1
## Encabezado 2
### Encabezado 3
```

### **3.2. Texto en negrita y cursiva**
```markdown
**Texto en negrita**
*Texto en cursiva*
```

### **3.3. Listas**
#### **Listas ordenadas**
```markdown
1. Primer elemento
2. Segundo elemento
3. Tercer elemento
```

#### **Listas desordenadas**
```markdown
- Elemento 1
- Elemento 2
- Elemento 3
```

### **3.4. Enlaces e imágenes**
```markdown
[Texto del enlace](https://ejemplo.com)

![Texto alternativo de la imagen](https://ejemplo.com/imagen.png)
```

### **3.5. Bloques de código**
Se pueden incluir fragmentos de código usando comillas invertidas (` ``` `):
````markdown
```python
print("Hola, mundo")
```
````

### **3.6. Citas y líneas separadoras**
```markdown
> Esto es una cita.

---
```

---

## **4. Creación de un `README.md` básico**
Para agregar un `README.md` a un repositorio hay que crear un fichero con exactamente ese nombre.
Luego, abrir el archivo y añadir la documentación necesaria.

Ejemplo de un `README.md` básico:
````markdown
# Mi Proyecto
Este es un proyecto de ejemplo en Git.

## Instalación
```bash
git clone https://github.com/usuario/repositorio.git
```

## Uso
Ejecutar el siguiente comando:
```bash
python main.py
```
````

---

## **5. Buenas prácticas al escribir un `README.md`**
- Mantener el archivo claro y estructurado.
- Usar títulos y subtítulos para organizar la información.
- Proporcionar ejemplos y comandos reales.
- Incluir capturas de pantalla o GIFs si es necesario.
- Agregar una sección de **contribuciones** para fomentar la colaboración.

---

En el próximo tema, exploraremos **cómo clonar todas las ramas de un repositorio remoto a la vez y cómo actualizar el README.md o cualquier otro fichero en todas las ramas a la vez**.
