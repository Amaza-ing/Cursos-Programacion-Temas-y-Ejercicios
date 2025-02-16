# **Tema 9: Dar marcha atrás a los cambios con `git restore` y `git revert`**

## **1. Introducción**
En Git, a veces es necesario deshacer cambios no deseados en los archivos o en el historial de commits. Para ello, existen dos comandos clave:

- `git restore`: Se usa para descartar cambios en archivos sin afectar el historial de commits.
- `git revert`: Se usa para deshacer un commit específico sin modificar el historial, creando un nuevo commit que anula los cambios previos.

---

## **2. Usar `git restore` para descartar cambios en archivos**
El comando `git restore` permite deshacer modificaciones en los archivos sin alterar el historial del repositorio.

### **Descartar cambios en un archivo antes de hacer commit**
```bash
git restore archivo.txt
```
Esto revierte `archivo.txt` a su última versión confirmada en Git.

### **Descartar cambios en todos los archivos modificados**
```bash
git restore .
```
Esto elimina cualquier cambio no confirmado en el área de trabajo.

### **Restaurar un archivo del área de staging**
Si un archivo ha sido agregado con `git add` pero aún no se ha hecho commit, se puede quitar del área de staging con:
```bash
git restore --staged archivo.txt
```
Esto mantiene los cambios en el área de trabajo pero los elimina del área de staging.

---

[![git status & git restore](https://img.youtube.com/vi/mf_wzDC9ouQ/0.jpg)](https://www.youtube.com/watch?v=mf_wzDC9ouQ&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. Usar `git revert` para deshacer un commit**
A diferencia de `git restore`, el comando `git revert` crea un nuevo commit que anula los cambios de un commit anterior, manteniendo el historial intacto.

### **Revertir un commit específico**
Para deshacer un commit sin perder su historial:
```bash
git revert <commit-hash>
```
Ejemplo:
```bash
git revert a1b2c3d
```
Esto creará un nuevo commit que revierte los cambios de `a1b2c3d`.

### **Revertir varios commits**
Se pueden revertir múltiples commits desde el más reciente hasta un punto específico:
```bash
git revert HEAD~2..HEAD
```
Esto revierte los dos últimos commits.

---

[![git revert](https://img.youtube.com/vi/TPnX7_nXkfw/0.jpg)](https://www.youtube.com/watch?v=TPnX7_nXkfw&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Diferencias entre `git restore`, `git revert` y `git reset`**
| Comando | Descripción |
|---------|-------------|
| `git restore` | Deshace cambios en el área de trabajo sin afectar commits. |
| `git revert` | Crea un nuevo commit que revierte un commit previo. |
| `git reset` | Mueve la referencia de la rama a un commit anterior, eliminando commits posteriores. |

> **Nota:** `git reset` es más agresivo y puede reescribir el historial, por lo que se recomienda usar `git revert` en entornos colaborativos.

---

## **5. Buenas prácticas al deshacer cambios**
- Usar `git restore` para descartar cambios locales sin alterar commits previos.
- Usar `git revert` para deshacer commits sin perder historial.
- Evitar `git reset` en repositorios compartidos, ya que puede reescribir el historial y causar problemas a otros colaboradores.
- Verificar el historial antes de hacer un `revert` con `git log --oneline`.

---

En el próximo tema, veremos **cuál es la diferencia entre repositorios públicos y privados y cómo borrar ramas y repositorios en local y en remoto**.
