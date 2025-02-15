# **Tema 5: Uso de etiquetas (tags) y releases en Git**

## **1. Introducción**
En Git, las **etiquetas (tags)** permiten marcar puntos específicos en la historia del proyecto, como versiones estables o lanzamientos importantes. Estas etiquetas son útiles para identificar versiones concretas del código sin alterar el flujo de desarrollo.

Además, en plataformas como **GitHub**, las etiquetas se pueden utilizar para crear **releases**, facilitando la distribución y documentación de versiones de software.

### **Beneficios de usar etiquetas y releases**
- Facilitan el control de versiones del código.
- Permiten marcar hitos importantes en el desarrollo.
- Facilitan la creación de versiones estables para producción.
- Ayudan a los colaboradores y usuarios a encontrar versiones específicas.

---

## **2. Crear etiquetas en Git**
Existen dos tipos de etiquetas en Git:

- **Etiquetas ligeras**: Son simplemente referencias a commits específicos.
- **Etiquetas anotadas**: Incluyen metadatos como el autor, fecha y un mensaje descriptivo.

### **2.1. Crear una etiqueta ligera**
```bash
git tag nombre-de-la-etiqueta
```
Este comando crea una etiqueta sin información adicional en el commit actual.

### **2.2. Crear una etiqueta anotada**
```bash
git tag -a v1.0 -m "Versión 1.0 estable"
```
Esto crea una etiqueta con el mensaje "Versión 1.0 estable" y la asocia al commit actual.

---

## **3. Listar y gestionar etiquetas**
Para ver todas las etiquetas creadas en el repositorio:
```bash
git tag
```
Para ver información detallada sobre una etiqueta anotada:
```bash
git show v1.0
```
Para eliminar una etiqueta local:
```bash
git tag -d nombre-de-la-etiqueta
```
Para eliminar una etiqueta del repositorio remoto:
```bash
git push origin --delete nombre-de-la-etiqueta
```

---

## **4. Publicar etiquetas en un repositorio remoto**
Las etiquetas creadas localmente no se suben automáticamente al repositorio remoto. Para hacerlo:
```bash
git push origin nombre-de-la-etiqueta
```
Para subir todas las etiquetas creadas:
```bash
git push --tags
```

---

## **5. Crear releases en GitHub**
En GitHub, se pueden utilizar las etiquetas para generar **releases**, proporcionando archivos comprimidos (`.zip`, `.tar.gz`) con el código fuente y documentación.

### **Pasos para crear un release en GitHub:**
1. Ir al repositorio en GitHub.
2. Navegar a la pestaña **Releases**.
3. Hacer clic en **Draft a new release**.
4. Seleccionar una etiqueta existente o crear una nueva.
5. Agregar un título y una descripción del release.
6. Adjuntar archivos si es necesario.
7. Publicar el release.

---

## **6. Usar etiquetas para retroceder a una versión específica**
Si se necesita regresar a una versión etiquetada:
```bash
git checkout nombre-de-la-etiqueta
```
Para crear una nueva rama desde una etiqueta:
```bash
git checkout -b nueva-rama nombre-de-la-etiqueta
```

---

## **7. Buenas prácticas al usar etiquetas y releases**
- Utilizar un esquema de versionado claro (ej. `v1.0`, `v1.1`, `v2.0`).
- Usar etiquetas anotadas en lugar de etiquetas ligeras para mantener mejor documentación.
- Publicar etiquetas en el repositorio remoto para facilitar el acceso a versiones anteriores.
- Crear releases con descripciones claras en GitHub para mejorar la distribución del código.
- Evitar eliminar etiquetas a menos que sea absolutamente necesario.

---

En el próximo tema, exploraremos **cómo trabajar con `git stash` para gestionar cambios temporales sin afectar la rama actual**.
