// backend-movil/src/modules/usuarios/usuarios.service.js
import prisma from '../../core/prisma.js';

/**
 * Devuelve lista de usuarios con datos seguros (sin passwordHash)
 */
export async function list() {
  const users = await prisma.usuario.findMany({
    orderBy: { nombre: 'asc' },
    select: {
      id: true,
      nombre: true,
      apellido: true,
      correo: true,
      rol: true,
      estado: true,
      telefono: true,
      foto: true,
      creadoEn: true,
    },
  });

  return users;
}

/**
 * Busca un usuario por ID
 */
export async function findById(id) {
  return prisma.usuario.findUnique({
    where: { id },
    select: {
      id: true,
      nombre: true,
      apellido: true,
      correo: true,
      telefono: true,
      foto: true,
      rol: true,
      estado: true,
      creadoEn: true,
      actualizadoEn: true,
    },
  });
}
