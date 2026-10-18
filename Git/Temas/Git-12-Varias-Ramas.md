# **Topic 12: Clone all branches of a repository and update a file in all branches**

## **1. Introduction**

When working with multiple branches in a repository, we may need to clone all the branches or update a specific file, such as `README.md`, across all of them. Git offers commands to make both tasks easier.

---

## **2. Clone all the branches of a remote repository**

By default, when you clone a repository with `git clone`, you only get the default branch (`master`). To clone all the branches, we can clone the repository as usual and then run this script:

```bash
for branch in $(git branch --all | grep '^\s*remotes' | egrep --invert-match '(:?HEAD|master)$'); do
    git branch --track "${branch##*/}" "$branch"
done
```

This creates an exact clone of the repository, including all branches.

---

[![Clone all branches](https://img.youtube.com/vi/WxJ8JDsjy24/0.jpg)](https://www.youtube.com/watch?v=WxJ8JDsjy24&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. Update `README.md` (or any other file) in all branches**

If we want to make an update in every branch, we can automate the process with a Git script.

### **Update manually on one branch and apply it to all of them**

Suppose we want to update the README.md in all the branches. First, we'll have to open the file and modify it.

Then save the changes and commit:

```bash
git add README.md
git commit -m "Actualización del README.md"
```

Then, to apply the change to all the branches, we can run this script:

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

This loops through all the branches and applies the change from `master` to each of them.

---

[![Update a file in all branches](https://img.youtube.com/vi/Bn1h8oDIwGU/0.jpg)](https://www.youtube.com/watch?v=Bn1h8oDIwGU&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Best practices**

- Before applying changes to all branches, make sure there are no major conflicts.
- Try the changes on a test branch first before applying them everywhere.
- Keep the `README.md` up to date in `master` and propagate it regularly.

---

In the next topic, we'll explore **how to work with different workflows and branching strategies in Git**.
