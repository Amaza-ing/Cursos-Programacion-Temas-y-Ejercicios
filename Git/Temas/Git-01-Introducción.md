# **Tema 1: Introducción a Git y GitHub**

## **1. ¿Qué es Git?**

Git es un **sistema de control de versiones distribuido** que permite gestionar los cambios en el código de un proyecto de manera eficiente. Fue creado por Linus Torvalds en 2005 y es ampliamente utilizado en el desarrollo de software.

### **Características clave de Git:**

- Permite el **seguimiento de cambios** en los archivos del proyecto.
- Facilita la **colaboración** entre desarrolladores.
- Es un sistema **distribuido**, lo que significa que cada usuario tiene una copia completa del historial del proyecto.
- Permite trabajar con **ramas (branches)** para desarrollar nuevas funcionalidades sin afectar la versión principal.
- Proporciona herramientas para resolver conflictos y fusionar cambios (**merge**).

---

## **2. ¿Qué es GitHub?**

GitHub es una plataforma basada en la web que permite almacenar, compartir y colaborar en proyectos que utilizan Git. Además, proporciona herramientas adicionales como:

- **Repositorios remotos**: Almacenamiento en la nube de código fuente.
- **Issues y Pull Requests**: Facilitan la gestión de tareas y revisiones de código.
- **Integraciones con CI/CD**: Automatización del desarrollo y despliegue de aplicaciones.
- **GitHub Actions**: Permite automatizar flujos de trabajo.

> **Nota:** Existen otras plataformas similares como GitLab y Bitbucket, pero GitHub es la más popular.

---

[![Qué es Git](https://img.youtube.com/vi/czwoCGLBv-s/0.jpg)](https://www.youtube.com/watch?v=czwoCGLBv-s&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. Instalación de Git**

Para comenzar a utilizar Git, es necesario instalarlo en el sistema.

### **Instalación en Windows**

1. Descarga Git desde [git-scm.com](https://git-scm.com/downloads).
2. Ejecuta el instalador y sigue las instrucciones.
3. Verifica la instalación ejecutando en la terminal:
   ```bash
   git --version
   ```

### **Instalación en macOS**

1. Abre la terminal y ejecuta:
   ```bash
   brew install git
   ```
2. Verifica la instalación con:
   ```bash
   git --version
   ```

### **Instalación en Linux**

1. Para distribuciones basadas en Debian (Ubuntu):
   ```bash
   sudo apt update
   sudo apt install git
   ```
2. Para distribuciones basadas en Red Hat (Fedora):
   ```bash
   sudo dnf install git
   ```
3. Verifica la instalación con:
   ```bash
   git --version
   ```

---

[![Instalación de Git](https://img.youtube.com/vi/h5Oe4nobYnY/0.jpg)](https://www.youtube.com/watch?v=h5Oe4nobYnY&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Configuración inicial de Git**

Antes de empezar a trabajar con Git, es importante configurarlo con los datos del usuario.

### **Configurar el nombre y el correo**

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tuemail@example.com"
```

### **Verificar la configuración**

```bash
git config --list
```

Esto mostrará la configuración actual de Git.

### **Configurar el editor de texto predeterminado**

Si deseas cambiar el editor de texto que Git usa por defecto. Aunque no es necesario:

```bash
git config --global core.editor "code --wait"  # Para VS Code
git config --global core.editor "nano"         # Para Nano
git config --global core.editor "vim"          # Para Vim
```

---

[![Configuración inicial](https://img.youtube.com/vi/nL6asilgoes/0.jpg)](https://www.youtube.com/watch?v=nL6asilgoes&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Creación de un repositorio Git**

Un repositorio Git es un directorio donde se almacenan los archivos del proyecto junto con su historial de cambios.

### **Crear un nuevo repositorio**

```bash
# Crea una nueva carpeta o entra en una que ya exista y abre una terminal en ella
git init           # Inicializa un repositorio Git dentro de la carpeta
```

Esto generará una carpeta oculta `.git` donde se guardará la información del repositorio.

---

[![Empezar con Git](https://img.youtube.com/vi/U9o4_j3plCY/0.jpg)](https://www.youtube.com/watch?v=U9o4_j3plCY&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

### **Clonar un repositorio existente**

Si ya existe un repositorio en GitHub, puedes clonarlo en tu máquina local:

```bash
git clone https://github.com/usuario/repositorio.git
```

Esto descargará todos los archivos del repositorio y su historial de cambios.

---

[![Clonar un Repositorio](https://img.youtube.com/vi/keu_wKoTw4E/0.jpg)](https://www.youtube.com/watch?v=keu_wKoTw4E&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **6. Buenas prácticas en Git**

- Configurar correctamente los datos del usuario con `git config`.
- Escribir **mensajes de commit descriptivos** para facilitar el seguimiento de cambios.
- Usar ramas (**branches**) para desarrollar nuevas funcionalidades sin afectar la versión principal.
- Hacer **commits frecuentes y pequeños** en lugar de grandes cambios.
- Ignorar archivos innecesarios con `.gitignore`.
- Realizar `pull` regularmente para mantener el repositorio local actualizado con los cambios remotos.

---

## **Comandos básicos de Git**

| Comando                   | Descripción                                         |
| ------------------------- | --------------------------------------------------- |
| `git init`                | Inicializa un nuevo repositorio Git.                |
| `git clone <url>`         | Clona un repositorio existente.                     |
| `git status`              | Muestra el estado actual del repositorio.           |
| `git add <archivo>`       | Añade un archivo al área de preparación.            |
| `git commit -m "mensaje"` | Guarda los cambios en el historial del repositorio. |
| `git log`                 | Muestra el historial de commits.                    |
| `git branch`              | Lista las ramas disponibles.                        |
| `git checkout <rama>`     | Cambia a una rama específica.                       |
| `git checkout -b <rama>`  | Crea una nueva rama y cambia a ella.                |
| `git merge <rama>`        | Fusiona una rama con la rama actual.                |
| `git pull`                | Descarga cambios desde un repositorio remoto.       |
| `git push`                | Envía cambios al repositorio remoto.                |

---

En el próximo tema, exploraremos la **estructura de un repositorio Git y su flujo de trabajo básico**, incluyendo el uso de `git add`, `git commit` y `git push`.
