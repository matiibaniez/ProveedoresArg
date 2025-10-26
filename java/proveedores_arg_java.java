// Usuario.java
package com.proveedoresarg.model;

public abstract class Usuario {
    protected String nombre;
    protected String email;

    public Usuario(String nombre, String email) {
        this.nombre = nombre;
        this.email = email;
    }

    public abstract void mostrarInfo();

    public String getNombre() { return nombre; }
    public String getEmail() { return email; }
}

// Proveedor.java
package com.proveedoresarg.model;

public class Proveedor extends Usuario {
    private String rubro;
    private Membresia membresia;

    public Proveedor(String nombre, String email, String rubro) {
        super(nombre, email);
        this.rubro = rubro;
        this.membresia = new Membresia("Standard");
    }

    @Override
    public void mostrarInfo() {
        System.out.println("Proveedor: " + nombre + " | Rubro: " + rubro + " | Membresía: " + membresia.getTipo());
    }

    public void renovarMembresia() {
        membresia.renovar();
    }

    public Membresia getMembresia() { return membresia; }
}

// Administrador.java
package com.proveedoresarg.model;

public class Administrador extends Usuario {
    public Administrador(String nombre, String email) {
        super(nombre, email);
    }

    @Override
    public void mostrarInfo() {
        System.out.println("Administrador del sistema: " + nombre);
    }
}

// Membresia.java
package com.proveedoresarg.model;

public class Membresia {
    private String tipo;
    private boolean activa;

    public Membresia(String tipo) {
        this.tipo = tipo;
        this.activa = true;
    }

    public void renovar() {
        if (!activa) {
            activa = true;
            System.out.println("Membresía reactivada correctamente.");
        } else {
            System.out.println("La membresía ya estaba activa.");
        }
    }

    public String getTipo() { return tipo; }
    public boolean isActiva() { return activa; }
}

// Reporte.java
package com.proveedoresarg.model;

public class Reporte {
    private int vistas;
    private int clics;
    private String periodo;

    public Reporte(String periodo, int vistas, int clics) {
        this.periodo = periodo;
        this.vistas = vistas;
        this.clics = clics;
    }

    public void mostrarReporte() {
        System.out.println("Periodo: " + periodo);
        System.out.println("Vistas: " + vistas);
        System.out.println("Clics: " + clics);
    }
}

// ProveedorService.java
package com.proveedoresarg.service;

import com.proveedoresarg.model.Proveedor;
import com.proveedoresarg.model.Reporte;

public class ProveedorService {

    public void generarReporte(Proveedor proveedor) {
        Reporte reporte = new Reporte("2025-10", 150, 45);
        System.out.println("Generando reporte mensual...");
        reporte.mostrarReporte();
        System.out.println("Reporte generado para: " + proveedor.getNombre());
    }
}

// Main.java
package com.proveedoresarg.main;

import com.proveedoresarg.model.Proveedor;
import com.proveedoresarg.service.ProveedorService;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Proveedor proveedor = new Proveedor("iShopX", "ventas@ishopx.com", "Electrónica");
        ProveedorService service = new ProveedorService();

        int opcion;
        do {
            System.out.println("\n=== MENÚ PROVEEDORESARG ===");
            System.out.println("1. Mostrar información del proveedor");
            System.out.println("2. Renovar membresía");
            System.out.println("3. Generar reporte mensual");
            System.out.println("0. Salir");
            System.out.print("Seleccione una opción: ");
            opcion = sc.nextInt();

            switch (opcion) {
                case 1 -> proveedor.mostrarInfo();
                case 2 -> proveedor.renovarMembresia();
                case 3 -> service.generarReporte(proveedor);
                case 0 -> System.out.println("Saliendo...");
                default -> System.out.println("Opción inválida.");
            }
        } while (opcion != 0);

        sc.close();
    }
}
