# **Exercises - Topic 16: Writing Unit Tests with Jasmine and Karma**

## **Instructions:**

Below you will find exercises on how to write unit tests in Angular using Jasmine and Karma.

Try to solve them before looking at the solution.

---

### **Exercise 1: Test a simple function**

Write a test for a function that adds two numbers.

<details><summary>Show solution</summary>

#### **File: `math.util.ts`**

```ts
export function sumar(a: number, b: number): number {
  return a + b;
}
```


#### **File: `math.util.spec.ts`**

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

### **Exercise 2: Test an Angular component**

Create a test for a simple component that displays a message.

<details><summary>Show solution</summary>

#### **File: `mensaje.component.ts`**

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


#### **File: `mensaje.component.spec.ts`**

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

### **Exercise 3: Test an Angular service**

Write a test for a service that returns a greeting.

<details><summary>Show solution</summary>

#### **File: `saludo.service.ts`**

```ts
import { Injectable } from "@angular/core";

@Injectable({ providedIn: "root" })
export class SaludoService {
  obtenerSaludo(nombre: string): string {
    return `Hola, ${nombre}`;
  }
}
```


#### **File: `saludo.service.spec.ts`**

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

### **Exercise 4: Mock a service with a spy**

Mock a service using `spyOn` for a component that depends on a service.

<details><summary>Show solution</summary>

#### **File: `usuario.service.ts`**

```ts
import { Injectable } from "@angular/core";

@Injectable({ providedIn: "root" })
export class UsuarioService {
  obtenerNombre(): string {
    return "Juan";
  }
}
```


#### **File: `usuario.component.ts`**

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


#### **File: `usuario.component.spec.ts`**

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

### **Exercise 5: Test an asynchronous method**

Write a test for a method that returns an observable.

<details><summary>Show solution</summary>

#### **File: `datos.service.ts`**

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


#### **File: `datos.service.spec.ts`**

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
