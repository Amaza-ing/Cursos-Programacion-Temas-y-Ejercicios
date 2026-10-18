# **Topic 2: Workflow in Git**

## **1. Introduction**

Git follows a workflow based on change management using **commits**, **branches** and **remote repositories**. Understanding this flow is essential to taking full advantage of the capabilities of the version control system.

### **Key Concepts**

- **Work area**: Directory where the editable project files are located.
- **Staging area**: Space where changes are stored before being committed.
- **Commit**: Repository checkpoint.
- **Local repository**: Change history stored on the user's machine.
- **Remote repository**: Copy of the project on a server, such as GitHub, GitLab or Bitbucket.

---

## **2. Basic Git flow**

A typical workflow in Git follows these steps:

1. **Modify files** in the working directory.
2. **Add changes** to the staging area (`git add`).
3. **Commit changes** to history (`git commit`).
4. **Push changes to remote repository** (`git push`).
5. **Download changes from remote repository** (`git pull`).

### **Workflow diagram**

```
[Modificación] → git add → [Staging Area] → git commit → [Repositorio Local] → git push → [Repositorio Remoto]
```

---

## **3. Fundamental Workflow Commands**

| Command | Description |
| ------------------------- | ----------------------------------------------------------- |
| `git status` | Shows the current state of the repository.                      |
| `git add <archivo>` | Adds a specific file to the staging area.            |
| `git add .` | Add all modified files to the staging area.   |
| `git commit -m "mensaje"` | Save changes to history with a descriptive message. |
| `git log` | Shows the commit history of the repository.               |
| `git pull` | Download and merge changes from the remote repository.        |
| `git push` | Upload local changes to the remote repository.                |

---

## **4. Workflow example**

If you want to upload your changes to a remote repository like github, you need to create an account and link it to your computer.

### **1. Create and modify files**

- Create a folder. Ex: `mi_proyecto`.
- Add a file. Ex: `archivo.txt`.
- Make changes to the file and open a terminal.

### **2. Start a repository and make the first commit**

```bash
git init
git add archivo.txt
git commit -m "Primer commit"
```

### **3. Upload changes to GitHub**

```bash
git remote add origin https://github.com/usuario/mi_proyecto.git
git branch -M master
git push -u origin master
```

---

[![github & git push](https://img.youtube.com/vi/pp0aC7GvnB0/0.jpg)](https://www.youtube.com/watch?v=pp0aC7GvnB0&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

### **SSH Key**

Another way to link your local machine to Github is by creating an SSH key. [In the official ](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) documentation you can see how to do it easily.

---

[![SSH](https://img.youtube.com/vi/_vlrPpxs2Go/0.jpg) Key](https://www.youtube.com/watch?v=_vlrPpxs2Go&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Git Workflow Best Practices**

- Make **small and frequent commits** to facilitate the tracking of changes.
- Write **clear and descriptive** commit messages.
- Avoid doing `git commit -m "Cambios"`, as it is not informative.
- Use **branches** to develop new features without affecting the main branch.
- Sync changes with `git pull` before doing `git push` to avoid conflicts.
- Add an `.gitignore` file to avoid uploading unnecessary files.

---

In the next topic, we will learn about **branches in Git**, how to create them, merge them, and manage conflicts efficiently.
