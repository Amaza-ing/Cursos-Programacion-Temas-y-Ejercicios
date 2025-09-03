# **Tema 12: Clonar todas las ramas de un repositorio y actualizar un archivo en todas las ramas**

## **1. Introducción**

Cuando trabajamos con múltiples ramas en un repositorio, es posible que necesitemos clonar todas las ramas o realizar actualizaciones en un archivo específico, como el `README.md`, en todas ellas. Git ofrece comandos para facilitar ambas tareas.

---

## **2. Clonar todas las ramas de un repositorio remoto**

Por defecto, cuando se clona un repositorio con `git clone`, solo se obtiene la rama predeterminada (`master`). Para clonar todas las ramas podemos clonar normalmente y después ejecutar este script:

```bash
for branch in $(git branch --all | grep '^\s*remotes' | egrep --invert-match '(:?HEAD|master)$'); do
    git branch --track "${branch##*/}" "$branch"
done
```

Esto crea un clon exacto del repositorio, incluyendo todas las ramas.

---

[![Clonar todas las Ramas](https://img.youtube.com/vi/WxJ8JDsjy24/0.jpg)](https://www.youtube.com/watch?v=WxJ8JDsjy24&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. Actualizar el `README.md` (o cualquier otro archivo) en todas las ramas**

Si queremos realizar una actualización en todas las ramas, podemos automatizar el proceso con un script de Git.

### **Actualizar manualmente en una rama y aplicar a todas**

Supongamos que queremos actualizar el README.md en todas las ramas, primero tendremos que abrir el fichero y modificarlo.

Despues guardar los cambios y hacer commit:

```bash
git add README.md
git commit -m "Actualización del README.md"
```

Luego, para aplicar el cambio en todas las ramas podemos ejecutar este script:

```bash
# Asegúrate de estar en la rama master con el README.md actualizado
git checkout master
git pull origin master  # Si estás trabajando con un repositorio remoto

# Itera sobre cada rama, excluyendo master
for branch in $(git branch --format='%(refname:short)' | grep -v 'master'); do
    # Cambia a la rama
    git checkout $branch

    # Copia el archivo README.md desde master a la rama actual
    git checkout master -- README.md

    # Añade y confirma el cambio en la rama actual
    git add README.md
    git commit -m "Update README.md from master"

    # Opcional: Sube los cambios al remoto
    git push origin $branch
done

# Vuelve a la rama master al final
git checkout master
```

Esto recorre todas las ramas y aplica el cambio de `master` en ellas.

---

[![Actualizar un archivo en Todas las Ramas](https://img.youtube.com/vi/Bn1h8oDIwGU/0.jpg)](https://www.youtube.com/watch?v=Bn1h8oDIwGU&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Buenas prácticas**

- Antes de aplicar cambios en todas las ramas, asegurarse de que no hay conflictos importantes.
- Probar los cambios primero en una rama de prueba antes de aplicarlos globalmente.
- Mantener el `README.md` actualizado en `master` y propagarlo regularmente.

---

En el próximo tema, exploraremos **cómo trabajar con diferentes workflows y estrategias de ramas en Git**.
