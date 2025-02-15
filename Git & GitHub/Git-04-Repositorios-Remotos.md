# **Tema 4: Repositorios remotos, `git push`, `git pull` y colaboración en GitHub**

## **1. Introducción**
Git permite trabajar con **repositorios remotos**, lo que facilita la colaboración entre varios desarrolladores. Los repositorios remotos almacenan una copia del proyecto en la nube, permitiendo compartir y sincronizar cambios con otros colaboradores a través de comandos como `git push`, `git pull` y `git fetch`.

### **Beneficios de los repositorios remotos**
- Facilitan el trabajo en equipo y la colaboración en proyectos.
- Permiten mantener copias de seguridad del código en servidores remotos.
- Posibilitan el seguimiento de cambios y versiones en equipo.
- Ayudan a gestionar el código de manera eficiente con GitHub, GitLab o Bitbucket.

---

## **2. Agregar un repositorio remoto**
Para conectar un repositorio local con un remoto, se usa el comando `git remote add`.

### **Ejemplo:**
```bash
git remote add origin https://github.com/usuario/nombre-del-repo.git
```
- `origin` es el nombre por defecto que Git asigna al repositorio remoto.
- La URL indica la ubicación del repositorio en GitHub.

Para verificar que el repositorio remoto se ha agregado correctamente:
```bash
git remote -v
```

---

## **3. Subir cambios con `git push`**
Después de realizar cambios en el repositorio local, se pueden subir al repositorio remoto con `git push`.

### **Ejemplo de `git push`:**
```bash
git push origin master
```
Este comando sube los cambios de la rama `master` al repositorio remoto `origin`.

Si es la primera vez que se suben cambios a un repositorio remoto, se debe usar:
```bash
git push -u origin master
```
La opción `-u` establece la rama remota predeterminada, permitiendo que futuros `git push` no requieran especificar `origin master`.

---

[![github & git push](https://img.youtube.com/vi/pp0aC7GvnB0/0.jpg)](https://www.youtube.com/watch?v=pp0aC7GvnB0&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Descargar cambios con `git pull`**
Cuando otros colaboradores han subido cambios al repositorio remoto, es necesario sincronizar los archivos con el repositorio local usando `git pull`.

### **Ejemplo de `git pull`:**
```bash
git pull origin master
```
Esto descarga y fusiona los cambios de la rama `master` en el repositorio local.

Si hay conflictos, Git solicitará que se resuelvan antes de continuar.

---

[![git pull](https://img.youtube.com/vi/gTU_hWaER1k/0.jpg)](https://www.youtube.com/watch?v=gTU_hWaER1k&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Obtener información sin fusionar con `git fetch`**
A diferencia de `git pull`, el comando `git fetch` solo descarga los cambios del repositorio remoto sin fusionarlos en la rama actual.

### **Ejemplo de `git fetch`:**
```bash
git fetch origin
```
Esto permite revisar los cambios antes de integrarlos manualmente con `git merge`.

---

[![git fetch](https://img.youtube.com/vi/OI9BJgjNBuo/0.jpg)](https://www.youtube.com/watch?v=OI9BJgjNBuo&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **6. Clonar un repositorio con `git clone`**
Para obtener una copia de un repositorio remoto en la máquina local, se usa `git clone`.

### **Ejemplo de `git clone`:**
```bash
git clone https://github.com/usuario/nombre-del-repo.git
```
Esto descargará todo el historial del proyecto en una nueva carpeta con el nombre del repositorio.

---

[![git clone](https://img.youtube.com/vi/keu_wKoTw4E/0.jpg)](https://www.youtube.com/watch?v=keu_wKoTw4E&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **7. Trabajar en equipo con GitHub**
GitHub permite colaborar en proyectos mediante diversas herramientas como **forks**, **pull requests** y **issues**.

### **Fork y Pull Request**
- Un **fork** es una copia de un repositorio en una cuenta personal, que permite experimentar sin afectar el original.

---

[![Fork](https://img.youtube.com/vi/-n8Wildyg8s/0.jpg)](https://www.youtube.com/watch?v=-n8Wildyg8s&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

- Un **pull request (PR)** es una solicitud para fusionar cambios en el repositorio original.

---

[![Pull Request](https://img.youtube.com/vi/juBQosR7CIU/0.jpg)](https://www.youtube.com/watch?v=juBQosR7CIU&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

### **Cómo crear un Pull Request desde un Fork:**
1. Hacer un fork del repositorio en GitHub.
2. Clonar el fork en la máquina local.
3. Crear una nueva rama y hacer cambios.
4. Subir los cambios con `git push`.
5. En GitHub, abrir un Pull Request hacia el repositorio original.

## **8. Buenas prácticas en la colaboración con Git**
- Mantener la rama `master` siempre actualizada con `git pull` antes de hacer cambios.
- Usar ramas separadas para cada nueva funcionalidad o corrección.
- Escribir mensajes de commit descriptivos.
- Hacer revisiones de código en los Pull Requests antes de fusionarlos.
- Resolver conflictos con cuidado y verificar antes de hacer `git push`.

---

En el próximo tema, exploraremos **cómo trabajar con etiquetas (tags) y releases en Git para gestionar versiones del código de manera eficiente**.
