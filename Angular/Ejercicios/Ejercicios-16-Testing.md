# **Ejercicios - Tema 16: Realización de Tests Unitarios con Jasmine y Karma**

## **Instrucciones:**

A continuación, encontrarás ejercicios sobre cómo realizar pruebas unitarias en Angular usando Jasmine y Karma.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Probar una Función Simple**

Escribe un test para una función que sume dos números.

<details><summary>Mostrar solución</summary>

#### **Archivo: `math.util.ts`**

```ts
export function sumar(a: number, b: number): number {
  return a + b;
}
```

#### **Archivo: `math.util.spec.ts`**

```ts
describe("sumar", () => {
  it("debería sumar dos números correctamente", () => {
    expect(sumar(2, 3)).toBe(5);
  });

  it("debería manejar números negativos", () => {
    expect(sumar(-2, 3)).toBe(1);
  });
});
```

</details>

---

### **Ejercicio 2: Probar un Componente Angular**

Crea un test para un componente simple que muestra un mensaje.

<details><summary>Mostrar solución</summary>

#### **Archivo: `mensaje.component.ts`**

```ts
import { Component } from "@angular/core";

@Component({
  selector: "app-mensaje",
  template: "<p>{{ mensaje }}</p>",
})
export class MensajeComponent {
  mensaje = "Hola Mundo";
}
```

#### **Archivo: `mensaje.component.spec.ts`**

```ts
import { ComponentFixture, TestBed } from "@angular/core/testing";
import { MensajeComponent } from "./mensaje.component";

describe("MensajeComponent", () => {
  let component: MensajeComponent;
  let fixture: ComponentFixture<MensajeComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [MensajeComponent],
    });

    fixture = TestBed.createComponent(MensajeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('debería mostrar el mensaje "Hola Mundo"', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector("p")?.textContent).toContain("Hola Mundo");
  });
});
```

</details>

---

### **Ejercicio 3: Probar un Servicio Angular**

Escribe un test para un servicio que devuelve un saludo.

<details><summary>Mostrar solución</summary>

#### **Archivo: `saludo.service.ts`**

```ts
import { Injectable } from "@angular/core";

@Injectable({ providedIn: "root" })
export class SaludoService {
  obtenerSaludo(nombre: string): string {
    return `Hola, ${nombre}`;
  }
}
```

#### **Archivo: `saludo.service.spec.ts`**

```ts
import { TestBed } from "@angular/core/testing";
import { SaludoService } from "./saludo.service";

describe("SaludoService", () => {
  let service: SaludoService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(SaludoService);
  });

  it("debería devolver un saludo", () => {
    expect(service.obtenerSaludo("Carlos")).toBe("Hola, Carlos");
  });
});
```

</details>

---

### **Ejercicio 4: Simular un Servicio con Spy**

Simula un servicio usando `spyOn` para un componente que depende de un servicio.

<details><summary>Mostrar solución</summary>

#### **Archivo: `usuario.service.ts`**

```ts
import { Injectable } from "@angular/core";

@Injectable({ providedIn: "root" })
export class UsuarioService {
  obtenerNombre(): string {
    return "Juan";
  }
}
```

#### **Archivo: `usuario.component.ts`**

```ts
import { Component } from "@angular/core";
import { UsuarioService } from "./usuario.service";

@Component({
  selector: "app-usuario",
  template: "<p>{{ nombre }}</p>",
})
export class UsuarioComponent {
  nombre = "";

  constructor(private usuarioService: UsuarioService) {
    this.nombre = this.usuarioService.obtenerNombre();
  }
}
```

#### **Archivo: `usuario.component.spec.ts`**

```ts
import { ComponentFixture, TestBed } from "@angular/core/testing";
import { UsuarioComponent } from "./usuario.component";
import { UsuarioService } from "./usuario.service";

describe("UsuarioComponent", () => {
  let component: UsuarioComponent;
  let fixture: ComponentFixture<UsuarioComponent>;
  let usuarioServiceSpy: jasmine.SpyObj<UsuarioService>;

  beforeEach(() => {
    const spy = jasmine.createSpyObj("UsuarioService", ["obtenerNombre"]);

    TestBed.configureTestingModule({
      declarations: [UsuarioComponent],
      providers: [{ provide: UsuarioService, useValue: spy }],
    });

    fixture = TestBed.createComponent(UsuarioComponent);
    component = fixture.componentInstance;
    usuarioServiceSpy = TestBed.inject(
      UsuarioService,
    ) as jasmine.SpyObj<UsuarioService>;
  });

  it("debería mostrar el nombre del usuario", () => {
    usuarioServiceSpy.obtenerNombre.and.returnValue("María");
    fixture.detectChanges();
    expect(component.nombre).toBe("María");
  });
});
```

</details>

---

### **Ejercicio 5: Probar un Método Asíncrono**

Escribe un test para un método que devuelve un observable.

<details><summary>Mostrar solución</summary>

#### **Archivo: `datos.service.ts`**

```ts
import { Injectable } from "@angular/core";
import { of, Observable } from "rxjs";

@Injectable({ providedIn: "root" })
export class DatosService {
  obtenerDatos(): Observable<string[]> {
    return of(["dato1", "dato2", "dato3"]);
  }
}
```

#### **Archivo: `datos.service.spec.ts`**

```ts
import { TestBed } from "@angular/core/testing";
import { DatosService } from "./datos.service";

describe("DatosService", () => {
  let service: DatosService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DatosService);
  });

  it("debería devolver un array de datos", (done) => {
    service.obtenerDatos().subscribe((datos) => {
      expect(datos.length).toBe(3);
      expect(datos).toContain("dato1");
      done();
    });
  });
});
```

</details>
