# **Topic 1: Introduction to Git and GitHub**

## **1. What is Git?**

Git is a **distributed version control system** that lets you manage changes to a project's code efficiently. It was created by Linus Torvalds in 2005 and is widely used in software development.

### **Key features of Git:**

- Lets you **track changes** to the project's files.
- Facilitates **collaboration** between developers.
- It is a **distributed** system, meaning that each user has a complete copy of the project history.
- Allows you to work with **branches** to develop new features without affecting the main version.
- Provides tools to resolve conflicts and **merge** changes.

---

## **2. What is GitHub?**

GitHub is a web-based platform that allows you to store, share, and collaborate on projects that use Git. It also provides additional tools, such as:

- **Remote repositories**: Cloud storage for source code.
- **Issues and Pull Requests**: Make it easier to manage tasks and code reviews.
- **CI/CD integrations**: Automating the development and deployment of applications.
- **GitHub Actions**: Allows you to automate workflows.

> **Note:** There are other similar platforms such as GitLab and Bitbucket, but GitHub is the most popular.

---

[![What is Git](https://img.youtube.com/vi/czwoCGLBv-s/0.jpg)](https://www.youtube.com/watch?v=czwoCGLBv-s&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. Installing Git**

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

1. For Debian-based distributions (Ubuntu):
   ```bash
   sudo apt update
   sudo apt install git
   ```
2. For Red Hat-based distributions (Fedora):
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

Before starting to work with Git, it's important to configure it with your user details.

### **Set your name and email**

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tuemail@example.com"
```

### **Check the configuration**

```bash
git config --list
```

This will show the current Git configuration.

### **Set the default text editor**

If you want, you can change the text editor Git uses by default, although it isn't necessary:

```bash
git config --global core.editor "code --wait"  # Para VS Code
git config --global core.editor "nano"         # Para Nano
git config --global core.editor "vim"          # Para Vim
```

---

[![Initial setup](https://img.youtube.com/vi/nL6asilgoes/0.jpg)](https://www.youtube.com/watch?v=nL6asilgoes&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Creating a Git repository**

A Git repository is a directory where project files are stored along with their change history.

### **Create a new repository**

```bash
# Crea una nueva carpeta o entra en una que ya exista y abre una terminal en ella
git init           # Inicializa un repositorio Git dentro de la carpeta
```

This will create a hidden `.git` folder where the repository's information will be stored.

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

## **6. Best practices in Git**

- Configure your user details correctly with `git config`.
- Write **descriptive commit messages** to make changes easier to track.
- Use **branches** to develop new features without affecting the main version.
- Make **small, frequent commits** instead of big changes.
- Ignore unnecessary files with `.gitignore`.
- Run `pull` regularly to keep your local repository up to date with the remote changes.

---

## **Basic Git commands**

| Command | Description |
| ------------------------- | --------------------------------------------------- |
| `git init` | Initializes a new Git repository.                |
| `git clone <url>` | Clones an existing repository.                     |
| `git status` | Shows the current state of the repository.           |
| `git add <archivo>` | Adds a file to the staging area.            |
| `git commit -m "mensaje"` | Saves the changes to the repository's history. |
| `git log` | Shows the commit history.                    |
| `git branch` | Lists the available branches.                        |
| `git checkout <rama>` | Switches to a specific branch.                       |
| `git checkout -b <rama>` | Creates a new branch and switches to it.                |
| `git merge <rama>` | Merges a branch into the current branch.                |
| `git pull` | Downloads changes from a remote repository.       |
| `git push` | Pushes changes to the remote repository.                |

---

In the next topic, we'll explore the **structure of a Git repository and its basic workflow**, including how to use `git add`, `git commit`, and `git push`.
