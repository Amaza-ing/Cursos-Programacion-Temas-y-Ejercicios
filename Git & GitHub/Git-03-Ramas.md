# **Tema 3: Ramas en Git - Creación, fusión y resolución de conflictos**

## **1. Introducción**

Las ramas (**branches**) en Git permiten trabajar en diferentes versiones de un proyecto sin afectar la rama principal. Esto facilita la colaboración, el desarrollo de nuevas características y la corrección de errores sin alterar el código estable.

### **Beneficios de usar ramas en Git**

- Permiten trabajar en nuevas funcionalidades sin afectar la versión estable.
- Facilitan la colaboración entre desarrolladores.
- Ayudan a mantener un historial de cambios organizado.
- Permiten gestionar diferentes versiones de un proyecto de forma eficiente.

---

## **2. Creación y gestión de ramas**

### **Listar las ramas disponibles**

```bash
git branch
```

Este comando muestra todas las ramas en el repositorio local.

### **Crear una nueva rama**

```bash
git branch nombre-de-la-rama
```

Esto crea una nueva rama basada en la rama actual.

### **Cambiar a una rama específica**

```bash
git checkout nombre-de-la-rama
```

Otra opción más moderna es usar:

```bash
git switch nombre-de-la-rama
```

Esto mueve el trabajo a la rama indicada.

### **Crear y cambiar a una nueva rama en un solo paso**

```bash
git checkout -b nombre-de-la-rama
```

O con el nuevo comando:

```bash
git switch -c nombre-de-la-rama
```

---

[![Ramas](https://img.youtube.com/vi/VgSUKBJE16Q/0.jpg)](https://www.youtube.com/watch?v=VgSUKBJE16Q&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. Fusionar ramas (Merge)**

Para unir los cambios de una rama con otra, se usa el comando `merge`.

### **Pasos para fusionar una rama en `master`**

1. Cambiar a la rama principal:
   ```bash
   git checkout master  # O bien: git switch master
   ```
2. Descargar los cambios más recientes del repositorio remoto:
   ```bash
   git pull origin master
   ```
3. Fusionar la rama secundaria:
   ```bash
   git merge nombre-de-la-rama
   ```
4. Eliminar la rama después de la fusión:
   ```bash
   git branch -d nombre-de-la-rama
   ```

Si la rama ha sido enviada a un repositorio remoto y se quiere eliminar allí también:

```bash
git push origin --delete nombre-de-la-rama
```

---

[![Fusionar Ramas - git merge](https://img.youtube.com/vi/vtT6gb1tpz8/0.jpg)](https://www.youtube.com/watch?v=vtT6gb1tpz8&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

### **Pull Request para fusionar una rama en Github**

Otra manera de volcar los cambios en una rama es hacer un Pull Request en Github. Esto es especialmente útil en ambientes colaborativos, donde tus compañeros deben ver los cambios que se han realizado antes de fusionar las ramas.

---

[![Pull Request](https://img.youtube.com/vi/juBQosR7CIU/0.jpg)](https://www.youtube.com/watch?v=juBQosR7CIU&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Gestión de conflictos en Git**

Durante una fusión (`merge`), pueden surgir conflictos si dos ramas han modificado la misma parte de un archivo.

### **Cómo resolver un conflicto en Git**

1. Git marcará los archivos en conflicto.
   ```bash
   git status
   ```
2. Editar los archivos afectados, buscando las secciones marcadas por `<<<<<<<`, `=======` y `>>>>>>>`.
3. Mantener el código correcto y eliminar las marcas de conflicto.
4. Añadir los archivos corregidos al área de preparación:
   ```bash
   git add archivo-afectado
   ```
5. Finalizar la fusión con un commit:
   ```bash
   git commit -m "Resolviendo conflicto en archivo-afectado"
   ```

Para evitar conflictos, se recomienda hacer `git pull` antes de realizar cambios y coordinar con el equipo de desarrollo.

---

[![Resolver Conflictos](https://img.youtube.com/vi/G2NjhA_ofck/0.jpg)](https://www.youtube.com/watch?v=G2NjhA_ofck&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Rebase: Alternativa a Merge**

Otra forma de integrar cambios entre ramas es usando `rebase`. En lugar de crear un commit de fusión, `rebase` reescribe el historial.

```bash
git checkout nombre-de-la-rama
git rebase master
```

Esto mueve los commits de `nombre-de-la-rama` sobre la versión más reciente de `master`.

Para resolver conflictos durante un `rebase`, se deben corregir los archivos y continuar con:

```bash
git rebase --continue
```

Si es necesario cancelar el proceso:

```bash
git rebase --abort
```

---

[![Rebase](https://img.youtube.com/vi/UpRMbhWjqHc/0.jpg)](https://www.youtube.com/watch?v=UpRMbhWjqHc&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **6. Buenas prácticas con ramas en Git**

- Usar **nombres descriptivos** para las ramas (ej. `feature/nueva-funcionalidad`, `bugfix/error-login`).
- Mantener la rama `master` siempre estable y libre de errores.
- Actualizar la rama `master` antes de iniciar una nueva rama con `git pull origin master`.
- Eliminar ramas obsoletas para mantener el repositorio limpio.
- Resolver conflictos con calma y revisar bien antes de confirmar cambios.

---

En el próximo tema, aprenderemos sobre **repositorios remotos, `git push`, `git pull` y la colaboración en GitHub**.
