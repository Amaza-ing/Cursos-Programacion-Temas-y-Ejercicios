# **Topic 13: Workflows and branch strategies in Git**

## **1. Introduction**

The use of workflows and branching strategies in Git is essential to organize software development in teams and maintain a clean and structured history. There are several methodologies that allow code development to be managed efficiently, depending on the size of the team and the complexity of the project.

---

## **2. Branching strategies in Git**

Branches in Git allow you to work on new features, fix bugs, and experiment without affecting the main version of the code. Some common strategies are:

### **2.1. Single branch strategy (`main` or `master` only)**

- All work is done directly in the `master` branch.
- Recommended for small or personal projects only.
- Does not allow a good separation between development and production.

### **2.2. Branches by functionality (Feature Branches)**

- Each new feature or improvement is developed in a separate branch.
- Once finished, it is merged with the main branch (`master`).
- Facilitates code review through Pull Requests.

Example:

```bash
git checkout -b feature/nueva-funcionalidad
git commit -m "Añadir nueva funcionalidad"
git push origin feature/nueva-funcionalidad
```

### **23. Git Flow**

- Use multiple branches to manage development, integration and deployment.
- Separates `master` (production) and `develop` (development), as well as auxiliary branches:
  - `feature/*`: To develop new functionalities.
  - `release/*`: To prepare versions before launch.
  - `hotfix/*`: To fix critical bugs in production.

Example flow with Git Flow:

```bash
git flow init
```

To start a new functionality:

```bash
git flow feature start nueva-funcionalidad
git commit -m "Desarrollando nueva funcionalidad"
git flow feature finish nueva-funcionalidad
```

### **2.4. GitHub Flow**

- Simpler than Git Flow, recommended for agile and continuous development.
- It works exclusively with `feature/*` and `master` branches.
- Does not use `develop`; each change is reviewed and merged with `master`.

Example:

```bash
git checkout -b feature/nueva-funcionalidad
git push origin feature/nueva-funcionalidad
# Crear un Pull Request y fusionarlo en GitHub
```

### **2.5. Trunk-Based Development**

- All development happens in a single branch (`master` or `trunk`).
- Small and frequent commits are made.
- Avoid long branches to minimize conflicts.

Example:

```bash
git checkout master
git pull origin master
git commit -m "Pequeño cambio incremental"
git push origin master
```

---

## **3. Comparison of branch strategies**

| Strategy | Advantages | Disadvantages |
| -------------------- | ------------------------------------------- | ------------------------------------------ |
| **Single Branch** | Simple, easy to maintain | Does not scale well, risk of conflicts |
| **Feature Branches** | Allows testing and revisions | Can generate many pending branches |
| **Git Flow** | Clear separation between development and production | Requires more maintenance |
| **GitHub Flow** | Fast and simple flow | Less control over releases |
| **Trunk-Based** | Fast continuous integration | Can generate instability if not controlled |

---

## **4. Choosing the right strategy**
The ideal strategy depends on the team and the type of project:

- **Small projects** → `master` only or GitHub Flow.
- **Medium Teams** → Feature Branches or Trunk-Based Development.
- **Companies and large projects** → Git Flow.

---

## **5. Good practices**

- Maintain descriptive names on branches (`feature/login-form`, `bugfix/api-error`).
- Delete branches once merged to avoid unnecessary accumulation.
- Do code reviews in Pull Requests before merging changes.
- Keep branches short and update them frequently with `master` or `develop`.

---

[![Git Workflows](https://img.youtube.com/vi/67fWC193sBc/0.jpg)](https://www.youtube.com/watch?v=67fWC193sBc&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---
