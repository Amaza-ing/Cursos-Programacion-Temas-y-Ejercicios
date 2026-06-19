# Ejecutar un proyecto Spring MVC con Tomcat usando IntelliJ gratuito

Este anexo explica cómo ejecutar un proyecto **Spring MVC clásico** empaquetado como archivo `.war` usando **Apache Tomcat** y la versión gratuita de IntelliJ IDEA.

En este ejemplo vamos a suponer que el proyecto se llama:

```text
my-project
```

Por tanto, la URL final esperada será:

```text
http://localhost:8080/my-project/
```

o, si existe un controlador para `/home`:

```text
http://localhost:8080/my-project/home
```

---

## 1. Requisitos previos

Antes de empezar, necesitamos tener:

- IntelliJ IDEA instalado.
- Un proyecto Maven de Spring MVC.
- Un JDK instalado, por ejemplo Java 21 o Java 25.
- Apache Tomcat descargado y descomprimido.

En este curso se usará Tomcat de forma manual porque la integración directa de Tomcat dentro de IntelliJ solo está disponible en la versión Ultimate.

---

[![Tomcat](https://img.youtube.com/vi/r2sz9hEyDgs/0.jpg)](https://www.youtube.com/watch?v=r2sz9hEyDgs&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 2. Descargar y descomprimir Tomcat

Descarga Apache Tomcat desde su página oficial:

```text
https://tomcat.apache.org/
```

Para un proyecto moderno con Jakarta y Spring MVC actual, usaremos Tomcat 11.

Después de descargarlo, descomprime el archivo en una carpeta sencilla, por ejemplo:

```text
C:\apache-tomcat-11
```

La estructura debería ser parecida a esta:

```text
apache-tomcat-11
├── bin
├── conf
├── lib
├── logs
├── temp
├── webapps
└── work
```

La carpeta más importante para nosotros será:

```text
apache-tomcat-11\webapps
```

Ahí copiaremos el archivo `.war` generado por Maven.

---

## 3. Comprobar el nombre final del WAR

En el archivo `pom.xml`, el proyecto debe tener empaquetado tipo `war`:

```xml
<packaging>war</packaging>
```

Si queremos que el archivo final se llame exactamente:

```text
my-project.war
```

podemos añadir este bloque al `pom.xml`:

```xml
<build>
    <finalName>my-project</finalName>
</build>
```

Ejemplo:

```xml
<project>
    ...

    <artifactId>my-project</artifactId>
    <packaging>war</packaging>

    ...

    <build>
        <finalName>my-project</finalName>
    </build>

</project>
```

Esto es importante porque Tomcat usa normalmente el nombre del archivo `.war` como nombre de la aplicación.

Si el archivo se llama:

```text
my-project.war
```

la ruta será:

```text
http://localhost:8080/my-project/
```

Si el archivo se llama:

```text
my-project-1.0-SNAPSHOT.war
```

la ruta será:

```text
http://localhost:8080/my-project-1.0-SNAPSHOT/
```

---

## 4. Generar el WAR desde IntelliJ gratuito

Como no estamos usando la integración de Tomcat de IntelliJ Ultimate, generaremos el `.war` desde el panel de Maven.

En IntelliJ:

```text
View > Tool Windows > Maven
```

Si no aparece el panel de Maven, haz clic derecho sobre el archivo `pom.xml` y selecciona:

```text
Add as Maven Project
```

Después, en el panel de Maven:

```text
my-project > Lifecycle
```

Ejecuta primero:

```text
clean
```

y después:

```text
package
```

También puede aparecer como:

```text
clean package
```

Al terminar, Maven generará una carpeta llamada:

```text
target
```

Dentro debería aparecer el archivo:

```text
target\my-project.war
```

---

## 5. Copiar el WAR a Tomcat

Ahora copia el archivo:

```text
target\my-project.war
```

y pégalo dentro de la carpeta `webapps` de Tomcat:

```text
C:\apache-tomcat-11\webapps
```

La estructura quedaría así:

```text
apache-tomcat-11
└── webapps
    └── my-project.war
```

Cuando Tomcat arranque, desplegará automáticamente el `.war` y creará una carpeta:

```text
apache-tomcat-11\webapps\my-project
```

---

## 6. Iniciar Tomcat

Abre una terminal en la carpeta raíz de Tomcat.

Por ejemplo:

```text
C:\apache-tomcat-11
```

Ejecuta:

```bat
bin\startup.bat
```

También puedes entrar directamente en la carpeta `bin` y ejecutar:

```bat
startup.bat
```

Si estás usando PowerShell desde la carpeta raíz de Tomcat, puedes usar:

```powershell
.\bin\startup.bat
```

Si todo va bien, se abrirá una ventana de consola de Tomcat.

---

## 7. Abrir la aplicación en el navegador

Abre el navegador y entra en:

```text
http://localhost:8080/my-project/
```

Si tienes un controlador que responde a `/home`, entra en:

```text
http://localhost:8080/my-project/home
```

Por ejemplo, si tienes un controlador como este:

```java
@Controller
public class HomeController {

    @GetMapping("/home")
    public String home() {
        return "home";
    }
}
```

la ruta esperada será:

```text
http://localhost:8080/my-project/home
```

Si además tienes un mapeo para `/`, también funcionará:

```text
http://localhost:8080/my-project/
```

---

## 8. Parar Tomcat

Para detener Tomcat, desde la carpeta raíz ejecuta:

```bat
bin\shutdown.bat
```

O desde PowerShell:

```powershell
.\bin\shutdown.bat
```

También puedes cerrar la ventana de Tomcat, aunque es mejor usar `shutdown.bat`.

---

## 9. Qué hacer cuando se cambia el código

Si haces cambios en el proyecto, por ejemplo en:

- un controlador Java,
- una vista JSP,
- un archivo XML,
- el `pom.xml`,
- el CSS,

hay que volver a generar y desplegar el `.war`.

Pasos recomendados:

1. Parar Tomcat:

```bat
bin\shutdown.bat
```

2. En IntelliJ, ejecutar desde Maven:

```text
clean
package
```

3. Borrar de Tomcat el `.war` antiguo:

```text
C:\apache-tomcat-11\webapps\my-project.war
```

4. Borrar también la carpeta desplegada antigua:

```text
C:\apache-tomcat-11\webapps\my-project
```

5. Copiar el nuevo archivo:

```text
target\my-project.war
```

a:

```text
C:\apache-tomcat-11\webapps
```

6. Arrancar Tomcat otra vez:

```bat
bin\startup.bat
```

7. Volver a abrir:

```text
http://localhost:8080/my-project/
```

---

# Errores frecuentes y soluciones

---

## Error 1: `mvn: command not found`

Este error aparece si intentamos ejecutar Maven desde la terminal y Maven no está instalado o no está en el `PATH`.

Ejemplo del error:

```text
bash: mvn: command not found
```

Solución en este curso:

No hace falta usar `mvn` desde la terminal. Podemos usar Maven directamente desde IntelliJ:

```text
View > Tool Windows > Maven
```

Después:

```text
Lifecycle > clean
Lifecycle > package
```

---

## Error 2: No aparece Tomcat en `Run > Edit Configurations`

En IntelliJ gratuito puede no aparecer la opción:

```text
Tomcat Server > Local
```

Esto es normal. La integración directa con servidores como Tomcat pertenece a IntelliJ Ultimate.

Solución:

Usaremos Tomcat manualmente:

1. Generar el `.war` con Maven.
2. Copiar el `.war` a la carpeta `webapps` de Tomcat.
3. Arrancar Tomcat con `bin/startup.bat`.
4. Abrir la aplicación desde el navegador.

---

## Error 3: Java del proyecto y Java de Tomcat no coinciden

Puede aparecer un error como este:

```text
UnsupportedClassVersionError
has been compiled by a more recent version of the Java Runtime
```

Por ejemplo:

```text
HomeController has been compiled by a more recent version of the Java Runtime
class file version 69.0
this version of the Java Runtime only recognizes class file versions up to 65.0
```

Esto significa que el proyecto se ha compilado con una versión de Java más nueva que la versión con la que Tomcat se está ejecutando.

Por ejemplo:

```text
Proyecto compilado con Java 25
Tomcat arrancando con Java 21
```

Solución:

Hay que hacer que Tomcat use la misma versión de Java que el proyecto.

### Ver qué JDK usa IntelliJ

En IntelliJ:

```text
File > Project Structure > Project
```

Ahí puedes ver el SDK del proyecto.

También puedes ir a:

```text
File > Project Structure > SDKs
```

Desde ahí puedes copiar la ruta del JDK.

Ejemplo de ruta:

```text
C:\Users\tu_usuario\.jdks\openjdk-25
```

o:

```text
C:\Program Files\Java\jdk-25
```

### Configurar Tomcat para usar ese JDK

Dentro de la carpeta de Tomcat, entra en:

```text
C:\apache-tomcat-11\bin
```

Crea un archivo llamado:

```text
setenv.bat
```

Dentro escribe:

```bat
set "JAVA_HOME=C:\Program Files\Java\jdk-25"
set "JRE_HOME=C:\Program Files\Java\jdk-25"
```

Cambia la ruta por la ruta real de tu JDK.

Después:

1. Para Tomcat.
2. Vuelve a arrancarlo.
3. Vuelve a desplegar el `.war`.

---

## Error 4: La aplicación sigue mostrando una versión antigua

A veces Tomcat mantiene desplegada una versión anterior del proyecto.

Solución:

Antes de copiar el nuevo `.war`, borra:

```text
C:\apache-tomcat-11\webapps\my-project.war
```

y también:

```text
C:\apache-tomcat-11\webapps\my-project
```

Después copia el `.war` nuevo y arranca Tomcat otra vez.

---

## Error 5: HTTP 404 al entrar en la URL

Si aparece un error 404, puede deberse a varias causas.

### Causa 1: La URL no coincide con el nombre del WAR

Si el archivo se llama:

```text
my-project.war
```

la URL será:

```text
http://localhost:8080/my-project/
```

Pero si el archivo se llama:

```text
my-project-1.0-SNAPSHOT.war
```

la URL será:

```text
http://localhost:8080/my-project-1.0-SNAPSHOT/
```

Solución:

Revisa el nombre del `.war` dentro de:

```text
C:\apache-tomcat-11\webapps
```

O añade en el `pom.xml`:

```xml
<build>
    <finalName>my-project</finalName>
</build>
```

### Causa 2: No existe un controlador para esa ruta

Si entras en:

```text
http://localhost:8080/my-project/home
```

debe existir un controlador parecido a este:

```java
@Controller
public class HomeController {

    @GetMapping("/home")
    public String home() {
        return "home";
    }
}
```

Si quieres entrar directamente en:

```text
http://localhost:8080/my-project/
```

debes tener también un mapeo para `/`:

```java
@GetMapping("/")
public String index() {
    return "home";
}
```

---

## Error 6: Error en la primera línea de una JSP

Si aparece un error como:

```text
page cannot be resolved to a type
pageEncoding cannot be resolved to a variable
```

revisa la primera línea de la JSP.

Incorrecto:

```jsp
<% page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
```

Correcto:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
```

La diferencia está en la arroba:

```jsp
<%@
```

Esa línea es una directiva JSP. Sin la arroba, Tomcat intenta interpretarla como código Java y falla.

---

## Error 7: El CSS no se carga

Si la vista JSP se abre pero el CSS no aparece, revisa la configuración de recursos estáticos.

En `app-servlet.xml` debería existir algo parecido a:

```xml
<mvc:resources mapping="/resources/**" location="/resources/" />
```

Y el CSS debería estar en una ruta como esta:

```text
src/main/webapp/resources/css/styles.css
```

En la JSP, se puede enlazar así:

```html
<link
  rel="stylesheet"
  href="${pageContext.request.contextPath}/resources/css/styles.css"
/>
```

La expresión:

```jsp
${pageContext.request.contextPath}
```

añade automáticamente el contexto de la aplicación, por ejemplo:

```text
/my-project
```

Así evitamos escribir rutas incorrectas.

---

## Error 8: El puerto 8080 ya está ocupado

Si Tomcat no arranca porque el puerto 8080 ya está en uso, puede que haya otro Tomcat u otra aplicación usando ese puerto.

Soluciones posibles:

1. Cerrar la aplicación que usa el puerto 8080.
2. Reiniciar Tomcat.
3. Cambiar el puerto de Tomcat.

Para cambiar el puerto, abre:

```text
C:\apache-tomcat-11\conf\server.xml
```

Busca:

```xml
<Connector port="8080" protocol="HTTP/1.1"
```

y cambia `8080` por otro puerto, por ejemplo:

```xml
<Connector port="8081" protocol="HTTP/1.1"
```

Entonces la URL sería:

```text
http://localhost:8081/my-project/
```

---

## Error 9: El WAR no se genera

Si no aparece la carpeta `target` o no se genera el `.war`, revisa que el `pom.xml` tenga:

```xml
<packaging>war</packaging>
```

También revisa que no haya errores de compilación en el proyecto.

Desde IntelliJ:

```text
View > Tool Windows > Maven > Lifecycle > package
```

Si Maven muestra errores, hay que corregirlos antes de desplegar el proyecto en Tomcat.

---

## Resumen rápido

Cada vez que queramos ejecutar el proyecto:

1. Generar el `.war` desde IntelliJ:

```text
Maven > Lifecycle > clean
Maven > Lifecycle > package
```

2. Copiar:

```text
target\my-project.war
```

a:

```text
C:\apache-tomcat-11\webapps
```

3. Arrancar Tomcat:

```bat
bin\startup.bat
```

4. Abrir en el navegador:

```text
http://localhost:8080/my-project/
```

o:

```text
http://localhost:8080/my-project/home
```

---

## Estructura esperada del proyecto

Una estructura típica sería:

```text
my-project
├── pom.xml
└── src
    └── main
        ├── java
        │   └── com
        │       └── amazaing
        │           └── myproject
        │               └── controller
        │                   └── HomeController.java
        └── webapp
            ├── resources
            │   └── css
            │       └── styles.css
            └── WEB-INF
                ├── web.xml
                ├── spring
                │   └── app-servlet.xml
                └── views
                    └── home.jsp
```

---

## Nota final

En la versión gratuita de IntelliJ, el proceso puede parecer más manual, pero ayuda a entender mejor cómo funciona una aplicación web Java:

```text
Maven construye el WAR
Tomcat despliega el WAR
El navegador accede a la aplicación
Spring MVC dirige la petición al controlador
El controlador devuelve una vista JSP
```
