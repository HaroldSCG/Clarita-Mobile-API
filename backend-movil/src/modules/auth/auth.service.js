// backend-movil/src/modules/auth/auth.service.js
import prisma from '../../core/prisma.js';
import bcrypt from 'bcryptjs';
import { signToken, verifyToken } from '../../core/auth.js';
import { fail } from '../../core/response.js';

export async function login(correo, password) {
  const user = await prisma.usuario.findFirst({
    where: {
      correo,
      estado: true,
    },
  });

  if (!user) {
    throw fail('Credenciales inválidas', 401);
  }

  const ok = await bcrypt.compare(password, user.passwordHash);
  if (!ok) {
    throw fail('Credenciales inválidas', 401);
  }

  const token = signToken({ id: user.id, correo: user.correo });

  return {
    token,
    user: {
      id: user.id,
      nombre: user.nombre,
      correo: user.correo,
      rol: user.rol,
      estado: user.estado,
    },
  };
}

export async function me(token) {
  if (!token) {
    throw fail('Token requerido', 401);
  }

  const payload = verifyToken(token);
  if (!payload) {
    throw fail('Token inválido o expirado', 401);
  }

  const user = await prisma.usuario.findUnique({
    where: { id: payload.id },
  });

  if (!user) {
    throw fail('Usuario no encontrado', 404);
  }

  return {
    id: user.id,
    nombre: user.nombre,
    apellido: user.apellido,
    correo: user.correo,
    rol: user.rol,
    estado: user.estado,
  };
}
