# **Tema 6: Uso de `git stash` para gestionar cambios temporales**

## **1. Introducción**

Durante el desarrollo, es común realizar cambios en el código antes de estar listos para un commit. Sin embargo, a veces es necesario cambiar de rama o actualizar el código sin perder el trabajo en curso. En estos casos, Git proporciona el comando `git stash` para guardar temporalmente los cambios sin comprometerlos.

### **Beneficios de `git stash`**

- Permite guardar cambios temporalmente sin necesidad de un commit.
- Facilita el cambio entre ramas sin perder modificaciones no confirmadas.
- Evita la creación de commits innecesarios en la historia del repositorio.

---

## **2. Guardar cambios con `git stash`**

Para almacenar los cambios actuales en la pila de `stash`:

```bash
git stash
```

Esto guarda los archivos modificados y los restaura al último commit limpio.

Si se quiere añadir una descripción para recordar los cambios guardados:

```bash
git stash push -m "Descripción de los cambios"
```

Para verificar la lista de stashes almacenados:

```bash
git stash list
```

Ejemplo de salida:

```
stash@{0}: On master: Corrección de bug en la API
stash@{1}: On master: Inicio de nueva funcionalidad
```

---

## **3. Recuperar cambios de `git stash`**

### **Aplicar los últimos cambios guardados**

```bash
git stash apply
```

Esto recupera los cambios del último `stash`, pero no los elimina de la lista.

Para aplicar un `stash` específico:

```bash
git stash apply stash@{1}
```

### **Aplicar y eliminar un stash**

Si se desea recuperar los cambios y eliminarlos de la lista automáticamente:

```bash
git stash pop
```

Esto es equivalente a `apply` seguido de `drop`.

---

[![git stash](https://img.youtube.com/vi/_28_dZxpPQg/0.jpg)](https://www.youtube.com/watch?v=_28_dZxpPQg&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Eliminar un `stash` específico o todos los guardados**

Si un `stash` ya no es necesario, se puede eliminar con:

```bash
git stash drop stash@{0}
```

Para eliminar todos los stashes almacenados:

```bash
git stash clear
```

> **Nota:** Esta operación no se puede deshacer.

---

## **5. Crear una nueva rama a partir de un `stash`**

Si los cambios guardados necesitan una nueva rama:

```bash
git stash branch nueva-rama stash@{0}
```

Esto crea `nueva-rama` con los cambios almacenados en `stash@{0}` y cambia automáticamente a esta nueva rama.

---

## **6. Buenas prácticas al usar `git stash`**

- Usar `git stash push -m "Descripción"` para documentar los cambios guardados.
- Antes de aplicar un `stash`, verificar su contenido con `git stash show -p`.
- Evitar acumular demasiados `stash` sin gestionarlos adecuadamente.
- Usar `git stash pop` solo si se está seguro de que los cambios aplicados no generarán conflictos.

---

En el próximo tema, exploraremos **cómo usar `git rebase` para mantener un historial de commits limpio y organizado**.
