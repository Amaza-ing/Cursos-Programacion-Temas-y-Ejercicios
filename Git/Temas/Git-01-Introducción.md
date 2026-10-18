# **Topic 1: Introduction to Git and GitHub**

## **1. What is Git?**

Git is a **distributed version control system** that allows changes to a project's code to be managed efficiently. It was created by Linus Torvalds in 2005 and is widely used in software development.

### **Git Key Features:**

- Allows **tracking changes** to project files.
- Facilitates **collaboration** between developers.
- It is a **distributed** system, meaning that each user has a complete copy of the project history.
- Allows you to work with **branches** to develop new features without affecting the main version.
- Provides tools to resolve conflicts and merge changes.

---

## **2. What is GitHub?**

GitHub is a web-based platform that allows you to store, share, and collaborate on projects that use Git. Additionally, it provides additional tools such as:

- **Remote repositories**: Source code cloud storage.
- **Issues and Pull Requests**: They facilitate the management of tasks and code reviews.
- **Integrations with CI/CD**: Automation of application development and deployment.
- **GitHub Actions**: Allows you to automate workflows.

> **Note:** There are other similar platforms such as GitLab and Bitbucket, but GitHub is the most popular.

---

[![What is Git](https://img.youtube.com/vi/czwoCGLBv-s/0.jpg)](https://www.youtube.com/watch?v=czwoCGLBv-s&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. Git installation**

To start using Git, you need to install it on your system.

### **Installation on Windows**

1. Download Git from [git-scm.com](https://git-scm.com/downloads).
2. Run the installer and follow the instructions.
3. Verify the installation by running in the terminal:
   ```bash
   git --version
   ```

### **Installation on macOS**

1. Open the terminal and run:
   ```bash
   brew install git
   ```
2. Verify the installation with:
   ```bash
   git --version
   ```

### **Installation on Linux**

1. For Debian (Ubuntu) based distributions:
   ```bash
   sudo apt update
   sudo apt install git
   ```
2. For Red Hat (Fedora) based distributions:
   ```bash
   sudo dnf install git
   ```
3. Verify the installation with:
   ```bash
   git --version
   ```

---

[![Git installation](https://img.youtube.com/vi/h5Oe4nobYnY/0.jpg)](https://www.youtube.com/watch?v=h5Oe4nobYnY&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Initial Git setup**

Before starting to work with Git, it is important to configure it with user data.

### **Set up name and email**

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tuemail@example.com"
```

### **Verify settings**

```bash
git config --list
```

This will show the current Git configuration.

### **Set the default text editor**

If you want to change the text editor that Git uses by default. Although it is not necessary:

```bash
git config --global core.editor "code --wait"  # Para VS Code
git config --global core.editor "nano"         # Para Nano
git config --global core.editor "vim"          # Para Vim
```

---

[![Initial setting](https://img.youtube.com/vi/nL6asilgoes/0.jpg)](https://www.youtube.com/watch?v=nL6asilgoes&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Creating a Git repository**

A Git repository is a directory where project files are stored along with their change history.

### **Create a new repository**

```bash
# Crea una nueva carpeta o entra en una que ya exista y abre una terminal en ella
git init           # Inicializa un repositorio Git dentro de la carpeta
```

This will generate a hidden folder `.git` where the repository information will be saved.

---
[![Get started with Git](https://img.youtube.com/vi/U9o4_j3plCY/0.jpg)](https://www.youtube.com/watch?v=U9o4_j3plCY&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

### **Clone an existing repository**

If a repository already exists on GitHub, you can clone it to your local machine:

```bash
git clone https://github.com/usuario/repositorio.git
```

This will download all the files in the repository and their change history.

---

[![Clone a Repository](https://img.youtube.com/vi/keu_wKoTw4E/0.jpg)](https://www.youtube.com/watch?v=keu_wKoTw4E&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **6. Good practices in Git**

- Correctly configure user data with `git config`.
- Write **descriptive commit messages** to facilitate change tracking.
- Use branches (**branches**) to develop new features without affecting the main version.
- Make **frequent and small commits** instead of big changes.
- Ignore unnecessary files with `.gitignore`.
- Perform `pull` regularly to keep the local repository up to date with remote changes.

---

## **Basic Git Commands**

| Command | Description |
| ------------------------- | --------------------------------------------------- |
| `git init` | Initialize a new Git repository.                |
| `git clone <url>` | Clone an existing repository.                     |
| `git status` | Shows the current state of the repository.           |
| `git add <archivo>` | Add a file to the staging area.            |
| `git commit -m "mensaje"` | Save changes to the repository history. |
| `git log` | Shows the commit history.                    |
| `git branch` | List available branches.                        |
| `git checkout <rama>` | Switch to a specific branch.                       |
| `git checkout -b <rama>` | Create a new branch and switch to it.                |
| `git merge <rama>` | Merge a branch with the current branch.                |
| `git pull` | Download changes from a remote repository.       |
| `git push` | Push changes to the remote repository.                |

---

In the next topic, we will explore the **structure of a Git repository and its basic workflow**, including the use of `git add`, `git commit`, and `git push`.
