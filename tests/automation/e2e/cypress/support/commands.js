// Comando de evidencia automatica: estampa URL + caso + fecha/hora en la pantalla
// y toma la captura. Asi cada imagen cumple la "regla de evidencia" sin trabajo manual.
Cypress.Commands.add('evidencia', (nombre, estado = 'PASSED') => {
  const ts = new Date().toLocaleString('es-CL', { hour12: false });
  cy.url().then((u) => {
    cy.document().then((doc) => {
      let b = doc.getElementById('__evidencia');
      if (!b) {
        b = doc.createElement('div');
        b.id = '__evidencia';
        doc.body.appendChild(b);
      }
      b.style.cssText =
        'position:fixed;top:0;left:0;right:0;z-index:2147483647;' +
        'background:#101010;color:#39FF14;font:bold 15px Consolas,monospace;' +
        'padding:7px 12px;letter-spacing:.3px;';
      b.textContent = `[EVIDENCIA] ${nombre} | ${estado} | ${u} | ${ts}`;
    });
    // nombre de archivo con el id del caso -> queda ordenado en /screenshots
    cy.screenshot(nombre, { overwrite: true, capture: 'viewport' });
  });
});
