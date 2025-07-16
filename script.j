document.addEventListener("DOMContentLoaded", () => {
  const ramos = document.querySelectorAll(".ramo");

  // Cargar estado desde localStorage
  ramos.forEach(ramo => {
    const id = ramo.dataset.id;
    const estado = localStorage.getItem(id);
    if (estado === "aprobado") {
      marcarAprobado(ramo);
    }
  });

  ramos.forEach(ramo => {
    ramo.addEventListener("click", () => {
      if (ramo.classList.contains("blocked")) return;

      const id = ramo.dataset.id;

      if (ramo.classList.contains("aprobado")) {
        ramo.classList.remove("aprobado");
        localStorage.removeItem(id);
      } else {
        marcarAprobado(ramo);
        localStorage.setItem(id, "aprobado");

        // Desbloquear los que dependían de este
        desbloquearDependientes(id);
      }
    });
  });

  function marcarAprobado(ramo) {
    ramo.classList.add("aprobado");
  }

  function desbloquearDependientes(aprobadoId) {
    const bloqueados = document.querySelectorAll(`.ramo.blocked[data-prereq='${aprobadoId}']`);
    bloqueados.forEach(ramo => {
      ramo.classList.remove("blocked");
      ramo.style.cursor = "pointer";
      ramo.style.backgroundColor = "#fbb6ce"; // vuelve a rosado
    });
  }
});
