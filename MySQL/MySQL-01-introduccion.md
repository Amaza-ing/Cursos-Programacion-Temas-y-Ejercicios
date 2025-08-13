# Tema 1: Introducción a MySQL

En este primer tema vamos a conocer qué es MySQL, para qué sirve y cómo se utiliza dentro del desarrollo de aplicaciones. Si partes de cero, no te preocupes: iremos paso a paso.

---

## **1. ¿Qué es MySQL?**

MySQL es un **sistema de gestión de bases de datos relacional (RDBMS)**. Permite almacenar, organizar y acceder a grandes cantidades de información de forma rápida y estructurada.

Está basado en el lenguaje **SQL (Structured Query Language)**, un lenguaje estándar utilizado para trabajar con bases de datos.

---

## **2. ¿Para qué se utiliza MySQL?**

MySQL se usa en muchos contextos:

· Sitios web que necesitan guardar usuarios, productos, pedidos, etc.  
· Aplicaciones móviles con registros y datos dinámicos.  
· Sistemas empresariales de gestión.  
· Proyectos de análisis de datos y ciencia de datos.

Al estar basado en SQL, es compatible con muchas tecnologías y lenguajes de programación (como PHP, Java, Python o Node.js).

---

## **3. Ventajas de MySQL**

· Es gratuito y de código abierto.  
· Tiene un alto rendimiento y escalabilidad.  
· Se utiliza ampliamente, por lo que hay mucha documentación y soporte.  
· Compatible con múltiples plataformas (Windows, Linux, macOS).

---

## **4.Diferencia entre MySQL y SQL**

| Concepto  | Descripción                                                                    |
| --------- | ------------------------------------------------------------------------------ |
| **SQL**   | Lenguaje de consulta estructurado. Es un estándar.                             |
| **MySQL** | Programa (software) que implementa ese lenguaje para gestionar bases de datos. |

---

## **5.¿Qué es una base de datos?**

Una base de datos es una colección organizada de datos. Por ejemplo, una tienda online podría tener:

· Una tabla `products` con la lista de productos.  
· Una tabla `users` con la información de los clientes.  
· Una tabla `orders` con los pedidos realizados.

Cada tabla contiene filas (registros) y columnas (campos).

---

[![Qué es SQL](https://img.youtube.com/vi/8LQUlshIdqw/0.jpg)](https://www.youtube.com/watch?v=8LQUlshIdqw&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **6. ¿Qué es una tabla?**

Una tabla es como una hoja de cálculo con filas y columnas.

Ejemplo de tabla `products`:

| id  | name     | price | stock |
| --- | -------- | ----- | ----- |
| 1   | T-shirt  | 19.99 | 50    |
| 2   | Sneakers | 49.99 | 20    |
| 3   | Jacket   | 89.99 | 15    |

- Cada **fila** es un producto.
- Cada **columna** es una característica del producto.

---

## **7. Instalación de MySQL**

### Opción 1: Instalar MySQL Server

1. Visita la página oficial: https://dev.mysql.com/downloads/
2. Descarga el instalador de MySQL para tu sistema operativo.
3. Durante la instalación, lo más sencillo es hacer la instalación completa, o elige:
   - MySQL Server.
   - Command Line Client.
   - MySQL Workbench (opcional pero muy útil para gestionar bases de datos visualmente).
   - Ejemplos (opcional pero útiles para empezar).
4. Crea una contraseña para el usuario `root`.

> Recuerda esta contraseña: la necesitarás más adelante.

Si queremos usar otra interfaz visual para gestionar bases de datos podemos instalar la que prefiramos. En los ejemplos en video se utilizará DBeaver en lugar de MySQL Workbench.

Para instalar DBeaver puedes acceder aquí: https://dbeaver.io/download/

---

[![Cómo instalar MySQL](https://img.youtube.com/vi/yHWJ3nc6Vk4/0.jpg)](https://www.youtube.com/watch?v=yHWJ3nc6Vk4&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

### Opción 2: Usar un servicio online

Si no puedes instalar nada, puedes usar servicios como:

· https://www.db-fiddle.com/  
· https://sqlize.online/  
· https://onecompiler.com/mysql

---

## **8. Verificar la instalación**

### **Usando la línea de comandos**

En la terminal o consola, escribe:

```sh
mysql -u root -p
```

Introduce la contraseña y deberías acceder al prompt de MySQL:

```sql
mysql>
```

### **Usando MySQL Workbench**

1. Abre MySQL Workbench.
2. Crea una nueva conexión con el usuario `root`.
3. Ingresa la contraseña que configuraste.
4. Haz clic en "Test Connection" para verificar que todo funcione.

### **Errores de Conexión**

Es posible que a veces ocurran algunos errores que impidan la conexión a la base de datos, estos son algunos de los más comunes y son facilmente solucionables:

- "Public Key Retrieval is not allowed"
- "Connection refused: getsockopt"

---

[![Error de Conexión](https://img.youtube.com/vi/5IYm-B2ptkI/0.jpg)](https://www.youtube.com/watch?v=5IYm-B2ptkI&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **9. Primer contacto con SQL**

Una vez tengas acceso a un entorno MySQL, puedes comenzar a ejecutar comandos.

```sql
SELECT 'Hello, world!';
```

---

## **10. Estructura de una base de datos MySQL**

Una base de datos MySQL está formada por:

- **Tablas**: Estructuras donde se almacenan los datos.
- **Filas (rows)**: Cada registro dentro de una tabla.
- **Columnas (columns)**: Cada campo dentro de una tabla.
- **Claves primarias**: Identificadores únicos para cada fila.
- **Claves foráneas**: Relacionan datos entre diferentes tablas.

Ejemplo:

```sql
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  product_name VARCHAR(100),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

---

## **11. Conclusión**

- MySQL es un sistema de bases de datos poderoso y ampliamente utilizado.
- SQL es el lenguaje que nos permite interactuar con bases de datos.

---

En el siguiente tema, aprenderemos a **crear y modificar tablas en MySQL** en profundidad, y a trabajar con los diferentes tipos de datos disponibles.
