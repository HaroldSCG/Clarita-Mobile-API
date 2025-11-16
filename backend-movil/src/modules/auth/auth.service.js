// backend-movil/src/modules/auth/auth.service.js

import prisma from '../../core/prisma.js';
import bcrypt from 'bcryptjs';
import { signToken, verifyToken } from '../../core/auth.js';

export async function login(correo, password) {
  const user = await prisma.Usuario.findFirst({
    where: {
      correo,
      estado: true,
    },
  });

  if (!user) {
    throw new Error('Credenciales inválidas');
  }

  const ok = await bcrypt.compare(password, user.passwordHash);
  if (!ok) {
    throw new Error('Credenciales inválidas');
  }

  const token = signToken({ id: user.id, correo: user.correo });

  return {
    ok: true,
    token,
    user: {
      id: user.id,
      nombre: user.nombre,
      correo: user.correo,
      rol: user.rol,
    },
  };
}

export async function me(token) {
  if (!token) {
    const error = new Error('Token requerido');
    error.status = 401;
    throw error;
  }

  const payload = verifyToken(token);

  const user = await prisma.Usuario.findUnique({
    where: { id: payload.id },
  });

  if (!user) {
    const error = new Error('Usuario no encontrado');
    error.status = 404;
    throw error;
  }

  return {
    id: user.id,
    nombre: user.nombre,
    apellido: user.apellido,
    correo: user.correo,
    rol: user.rol,
  };
}
