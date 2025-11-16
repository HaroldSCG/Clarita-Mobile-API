// backend-movil/src/modules/auth/auth.service.js
import bcrypt from 'bcryptjs';
import prisma from '../../core/prisma.js';
import { signToken, verifyToken } from '../../core/auth.js';

export async function login(correo, password) {
  const user = await prisma.usuario.findUnique({
    where: { correo },
  });

  if (!user) {
    const error = new Error('Credenciales inválidas');
    error.status = 401;
    throw error;
  }

  if (!user.estado) {
    const error = new Error('Usuario deshabilitado');
    error.status = 403;
    throw error;
  }

  const isValid = await bcrypt.compare(password, user.passwordHash);
  if (!isValid) {
    const error = new Error('Credenciales inválidas');
    error.status = 401;
    throw error;
  }

  const token = signToken({
    id: user.id,
    rol: user.rol,
    correo: user.correo,
  });

  return {
    token,
    user: {
      id: user.id,
      nombre: user.nombre,
      apellido: user.apellido,
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

  const user = await prisma.usuario.findUnique({
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
