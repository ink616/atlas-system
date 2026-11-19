// Pruebas funcionales automatizadas E2E sobre la interfaz de Atlas (http://localhost:3000)
// Datos de prueba sinteticos (seed): admin@atlas.cl / editor@atlas.cl - Password123!
// Cada caso llama a cy.evidencia(): toma la captura con URL + caso + fecha/hora de forma automatica.

describe('Atlas - Pruebas funcionales E2E', () => {

  it('CP-FUN-01: login valido redirige al panel de control', () => {
    cy.visit('/');
    cy.get('#email').type('admin@atlas.cl');
    cy.get('#password').type('Password123!');
    cy.contains('button', 'Ingresar al sistema').click();
    cy.contains('Panel de control').should('be.visible');
    cy.contains('ADMINISTRADOR').should('be.visible');
    cy.evidencia('CP-FUN-01_login_valido');
  });

  it('CP-FUN-02: login invalido muestra mensaje de error', () => {
    cy.visit('/');
    cy.get('#email').type('admin@atlas.cl');
    cy.get('#password').type('claveMala');
    cy.contains('button', 'Ingresar al sistema').click();
    cy.contains(/inv[aá]lid/i).should('be.visible');
    cy.contains('Panel de control').should('not.exist');
    cy.evidencia('CP-FUN-02_login_invalido');
  });

  it('CP-FUN-11: el administrador crea un cliente', () => {
    cy.visit('/');
    cy.get('#email').type('admin@atlas.cl');
    cy.get('#password').type('Password123!');
    cy.contains('button', 'Ingresar al sistema').click();
    cy.contains('button', 'Clientes').click();
    const razon = 'Cliente E2E ' + Date.now();
    cy.get('#customer-name').type(razon);
    cy.get('#customer-rut').type('22.222.222-2');
    cy.contains('button', 'Crear cliente').click();
    cy.contains(razon).should('be.visible');
    cy.evidencia('CP-FUN-11_crear_cliente');
  });

  it('CP-FUN-09/RBAC: el editor no puede eliminar (la API responde 403)', () => {
    cy.visit('/');
    cy.get('#email').type('editor@atlas.cl');
    cy.get('#password').type('Password123!');
    cy.contains('button', 'Ingresar al sistema').click();
    cy.contains('button', 'Clientes').click();
    cy.get('button[aria-label^="Intentar eliminar"]').first().click();
    cy.contains('403').should('be.visible');
    cy.evidencia('CP-FUN-09_rbac_editor_403');
  });

  it('CP-FUN-03: cerrar sesion vuelve al login', () => {
    cy.visit('/');
    cy.get('#email').type('admin@atlas.cl');
    cy.get('#password').type('Password123!');
    cy.contains('button', 'Ingresar al sistema').click();
    cy.contains('button', /Cerrar sesi/).click();
    cy.contains(/Iniciar sesi/).should('be.visible');
    cy.evidencia('CP-FUN-03_cerrar_sesion');
  });

});
