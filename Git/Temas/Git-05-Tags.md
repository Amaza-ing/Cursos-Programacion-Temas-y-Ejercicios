# **Topic 5: Using tags and releases in Git**

## **1. Introduction**

In Git, **tags** allow you to mark specific points in the project's history, such as stable versions or major releases. These tags are useful for identifying specific versions of code without disrupting the development flow.

Additionally, on platforms like **GitHub**, tags can be used to create **releases**, making it easier to distribute and document software releases.

### **Benefits of using tags and releases**

- They facilitate code version control.
- They allow important milestones in development to be marked.
- They facilitate the creation of stable versions for production.
- They help collaborators and users find specific versions.

---

## **2. Create tags in Git**

There are two types of tags in Git:

- **Light tags**: They are simply references to specific commits.
- **Annotated tags**: They include metadata such as the author, date and a descriptive message.

### **2.1. Create a light tag**

```bash
git tag nombre-de-la-etiqueta
```

This command creates a tag with no additional information in the current commit.

### **2.2. Create an annotated tag**

```bash
git tag -a v1.0 -m "Versión 1.0 estable"
```

This creates a tag with the message "Version 1.0 stable" and associates it with the current commit.

---

## **3. List and manage tags**

To view all tags created in the repository:

```bash
git tag
```

To view detailed information about an annotated tag:

```bash
git show v1.0
```

To remove a local tag:

```bash
git tag -d nombre-de-la-etiqueta
```

To remove a tag from the remote repository:

```bash
git push origin --delete nombre-de-la-etiqueta
```

---

## **4. Publish tags to a remote repository**

Locally created tags are not automatically uploaded to the remote repository. To do it:

```bash
git push origin nombre-de-la-etiqueta
```

To upload all created tags:

```bash
git push --tags
```

---

## **5. Create releases on GitHub**

On GitHub, tags can be used to generate **releases**, providing compressed files (`.zip`, `.tar.gz`) with the source code and documentation.

### **Steps to create a release on GitHub:**

1. Go to the repository on GitHub.
2. Navigate to the **Releases** tab.
3. Click **Draft a new release**.
4. Select an existing tag or create a new one.
5. Add a release title and description.
6. Attach files if necessary.
7. Publish the release.

---

## **6. Use tags to roll back to a specific version**

If you need to revert to a tagged version:

```bash
git checkout nombre-de-la-etiqueta
```

To create a new branch from a tag:

```bash
git checkout -b nueva-rama nombre-de-la-etiqueta
```

---

## **7. Good practices when using tags and releases**

- Use a clear versioning scheme (e.g. `v1.0`, `v1.1`, `v2.0`).
- Use annotated tags instead of light tags to maintain better documentation.
- Publish tags to the remote repository to facilitate access to previous versions.
- Create releases with clear descriptions on GitHub to improve code distribution.
- Avoid removing tags unless absolutely necessary.

---
In the next topic, we will explore **how to work with `git stash` to manage temporary changes without affecting the current branch**.
