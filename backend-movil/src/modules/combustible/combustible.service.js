// backend-movil/src/modules/combustible/combustible.service.js
import prisma from '../../core/prisma.js';

export async function listarRegistros() {
  const registros = await prisma.registroCombustible.findMany({
    orderBy: { fechaCarga: 'desc' },
  });

  // No cambiamos nombres de campos, solo devolvemos tal cual.
  return registros;
}

export async function obtenerRegistro(id) {
  const registro = await prisma.registroCombustible.findUnique({
    where: { id: Number(id) },
  });
  return registro;
}
