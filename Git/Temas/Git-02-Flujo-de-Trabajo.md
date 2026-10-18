# **Topic 2: Workflow in Git**

## **1. Introduction**

Git follows a workflow based on managing changes through **commits**, **branches** and **remote repositories**. Understanding this flow is essential to making the most of what the version control system can do.

### **Key concepts**

- **Working directory**: The directory where the project's editable files are located.
- **Staging area**: The area where changes are stored before being committed.
- **Commit**: A checkpoint in the repository.
- **Local repository**: The change history stored on the user's machine.
- **Remote repository**: A copy of the project on a server, such as GitHub, GitLab or Bitbucket.

---

## **2. Basic Git workflow**

A typical workflow in Git follows these steps:

1. **Modify files** in the working directory.
2. **Add changes** to the staging area (`git add`).
3. **Commit the changes** to the history (`git commit`).
4. **Push the changes to the remote repository** (`git push`).
5. **Download changes from the remote repository** (`git pull`).

### **Workflow diagram**

```
[Modificación] → git add → [Staging Area] → git commit → [Repositorio Local] → git push → [Repositorio Remoto]
```

---

## **3. Essential workflow commands**

| Command | Description |
| ------------------------- | ----------------------------------------------------------- |
| `git status` | Shows the current state of the repository.                      |
| `git add <archivo>` | Adds a specific file to the staging area.            |
| `git add .` | Adds all modified files to the staging area.   |
| `git commit -m "mensaje"` | Saves the changes to the history with a descriptive message. |
| `git log` | Shows the commit history of the repository.               |
| `git pull` | Downloads and merges changes from the remote repository.        |
| `git push` | Uploads local changes to the remote repository.                |

---

## **4. Workflow example**

If you want to upload your changes to a remote repository like GitHub, you need to create an account and link it to your computer.

### **1. Create and modify files**

- Create a folder, e.g. `mi_proyecto`.
- Add a file, e.g. `archivo.txt`.
- Make changes to the file and open a terminal.

### **2. Initialize a repository and make the first commit**

```bash
git init
git add archivo.txt
git commit -m "Primer commit"
```

### **3. Upload the changes to GitHub**

```bash
git remote add origin https://github.com/usuario/mi_proyecto.git
git branch -M master
git push -u origin master
```

---

[![github & git push](https://img.youtube.com/vi/pp0aC7GvnB0/0.jpg)](https://www.youtube.com/watch?v=pp0aC7GvnB0&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

### **SSH key**

Another way to link your local machine to GitHub is by creating an SSH key. You can see how to do it easily [in the official documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

---

[![SSH key](https://img.youtube.com/vi/_vlrPpxs2Go/0.jpg)](https://www.youtube.com/watch?v=_vlrPpxs2Go&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Best practices for the Git workflow**

- Make **small, frequent commits** to make changes easier to track.
- Write **clear and descriptive** commit messages.
- Avoid messages like `git commit -m "Cambios"`, as they aren't informative.
- Use **branches** to develop new features without affecting the main branch.
- Sync changes with `git pull` before running `git push` to avoid conflicts.
- Add a `.gitignore` file to avoid uploading unnecessary files.

---

In the next topic, we'll learn about **branches in Git**: how to create them, merge them and handle conflicts efficiently.
