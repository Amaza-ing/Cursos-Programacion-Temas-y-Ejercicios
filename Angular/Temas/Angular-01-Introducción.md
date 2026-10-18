# **Topic 1: Introduction to Angular and Environment Setup**

## **1. What is Angular?**

Angular is a web development framework created by Google, based on TypeScript. It allows you to build scalable, modular and maintainable web applications.

### **Key features of Angular:**

- Based on **TypeScript**, a superset of JavaScript.
- Uses a system of **components** to build interfaces.
- Offers **two-way data binding**.
- Supports **routing** and **state management**.
- It has a modular architecture based on **modules and services**.

---

## **2. Installing Angular CLI**

Angular CLI (Command Line Interface) is the official tool for managing projects in Angular.

### **Step 1: Install Angular CLI**

To install Angular CLI globally on your system, run the following command in the terminal:

```sh
npm install -g @angular/cli
```


> Note: You need to have Node.js and npm installed. You can download them from [nodejs.org](https://nodejs.org/).

## **3. Verifying the installation**

Once Angular CLI is installed, verify that the installation was successful by running the following command in the terminal:

```sh
ng version
```


This command will display the installed version of Angular CLI, along with other system dependencies.

---

## **4. Creating a new Angular project**

To create a new project in Angular, use the following command:

```sh
ng new my-project
```


### **Command options:**

- `my-project`: Project name (you can change it to whatever you prefer).
- During creation, you will be asked:
  - Which style format to use (**CSS, SCSS, SASS, LESS**): you can select `CSS` to start.
  - Whether you want to include **SSR** (choose `No` unless you want Server-Side Rendering).

This command will generate the base structure of an Angular project in the `my-project` folder.

---

## **5. Starting the development server**

Once the project is created, go into the project folder and run:

```sh
cd my-project
ng serve
```


This will start a local server and you can access the application in your browser at the following address:

```
http://localhost:4200/
```


Every change you make to the code will automatically be reflected in the browser.

---

[![How to get started with Angular](https://img.youtube.com/vi/K8BqmCUqrME/0.jpg)](https://www.youtube.com/watch?v=K8BqmCUqrME&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **6. File and folder structure in an Angular project**

An Angular project generated with `ng new` has the following file structure:

```
my-project/
│── node_modules/        # Dependencias del proyecto
│── public/              # Assets del proyecto
│── src/                 # Código fuente del proyecto
│   ├── app/             # Componentes y módulos principales
│   ├── index.html       # Archivo HTML principal
│   ├── main.ts          # Punto de entrada de la aplicación
│   ├── styles.css       # Archivo global de estilos
│── angular.json         # Configuración global de Angular
│── package.json         # Dependencias y scripts del proyecto
│── tsconfig.json        # Configuración de TypeScript
│── Otros ficheros       # Otros ficheros de configuración
```


### **A brief explanation of the key files:**

- **`src/app/`**: Contains the components, modules and services of the application.
- **`main.ts`**: Application startup file.
- **`index.html`**: Main page where the Angular application is mounted.
- **`styles.css`**: Global stylesheet.
- **`angular.json`**: Angular project configuration file.

---

[![File and Folder Structure](https://img.youtube.com/vi/jwCiqmOKKKo/0.jpg)](https://www.youtube.com/watch?v=jwCiqmOKKKo&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **7. The Angular Language Service extension**

Add the Angular Language Service extension to Visual Studio Code to make developing applications in Angular easier.

---
[![Angular Language Service Extension](https://img.youtube.com/vi/llHGjwLP7-4/0.jpg)](https://www.youtube.com/watch?v=llHGjwLP7-4&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## Important commands

Install Angular

```sh
npm install -g @angular/cli
```


Create a new project

```sh
ng new my-project
```


Start the project

```sh
ng serve
```


---

In the next topic, we will explore **components in Angular** in depth and how to structure our application properly.
