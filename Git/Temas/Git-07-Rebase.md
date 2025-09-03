# **Tema 7: Uso de `git rebase` para un historial de commits limpio y organizado**

## **1. Introducción**

El comando `git rebase` permite reescribir el historial de commits para mantenerlo más limpio y lineal. Se usa para reorganizar, modificar o combinar commits, evitando ramas innecesarias y facilitando la revisión del código.

### **Beneficios de `git rebase`**

- Mantiene un historial más limpio y fácil de entender.
- Evita merges innecesarios al integrar cambios de una rama principal.
- Permite modificar commits anteriores sin afectar el contenido del código.

---

## **2. Tipos de `rebase` en Git**

### **2.1. Rebase interactivo**

Permite modificar commits específicos, reordenarlos, combinarlos o eliminarlos.

```bash
git rebase -i HEAD~3
```

Este comando abre un editor de texto con los últimos 3 commits listados, donde se pueden aplicar cambios como:

- `pick` → Mantener el commit.
- `reword` → Modificar el mensaje del commit.
- `edit` → Cambiar el contenido del commit.
- `squash` → Combinar varios commits en uno solo.
- `drop` → Eliminar un commit.

### **2.2. Rebase de una rama sobre otra**

Se usa para actualizar una rama con los cambios de otra sin crear un commit de merge.

```bash
git checkout feature-branch
git rebase master
```

Esto mueve todos los commits de `feature-branch` sobre la versión más reciente de `master`.

---

## **3. Resolver conflictos durante un rebase**

Si hay conflictos, Git pausará el proceso para permitir su resolución.

1. Identificar los archivos en conflicto con:
   ```bash
   git status
   ```
2. Editar los archivos y resolver los conflictos manualmente.
3. Añadir los cambios resueltos:
   ```bash
   git add archivo-resuelto
   ```
4. Continuar el rebase:
   ```bash
   git rebase --continue
   ```
5. Si es necesario cancelar el proceso:
   ```bash
   git rebase --abort
   ```

---

## **4. Diferencias entre `git rebase` y `git merge`**

| Comando      | Descripción                                                             |
| ------------ | ----------------------------------------------------------------------- |
| `git merge`  | Fusiona ramas, creando commits adicionales para los cambios combinados. |
| `git rebase` | Mueve commits de una rama sobre otra, manteniendo un historial lineal.  |

---

[![git rebase](https://img.youtube.com/vi/UpRMbhWjqHc/0.jpg)](https://www.youtube.com/watch?v=UpRMbhWjqHc&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Uso de `git rebase` con `git pull`**

Para evitar commits de merge innecesarios al actualizar la rama actual, se puede usar:

```bash
git pull --rebase origin master
```

Esto descarga los cambios remotos y los aplica antes de los commits locales.

---

## **6. Buenas prácticas al usar `git rebase`**

- Usar `git rebase -i` para limpiar el historial antes de enviar commits a un repositorio remoto.
- Evitar `git rebase` en ramas compartidas para no reescribir el historial de otros colaboradores.
- Siempre hacer un respaldo (`git branch backup`) antes de un rebase importante.
- Usar `git rebase --continue` y `git rebase --abort` con cuidado para manejar errores sin perder trabajo.

---

En el próximo tema, exploraremos **cómo trabajar con `git cherry-pick` para seleccionar commits específicos y aplicarlos en otras ramas**.
