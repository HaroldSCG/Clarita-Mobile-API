// backend-movil/src/middleware/authMiddleware.js
import { verifyToken } from '../core/auth.js';
import prisma from '../core/prisma.js';

export async function authMiddleware(req, res, next) {
  const header = req.headers.authorization;

  if (!header || !header.startsWith('Bearer ')) {
    return res.status(401).json({
      ok: false,
      message: 'No autorizado: falta token',
      data: null,
      timestamp: new Date().toISOString(),
    });
  }

  const token = header.split(' ')[1];
  const decoded = verifyToken(token);

  if (!decoded) {
    return res.status(401).json({
      ok: false,
      message: 'Token inválido o expirado',
      data: null,
      timestamp: new Date().toISOString(),
    });
  }

  const user = await prisma.usuario.findUnique({
    where: { id: decoded.id },
  });

  if (!user || !user.estado) {
    return res.status(401).json({
      ok: false,
      message: 'Usuario no encontrado o inactivo',
      data: null,
      timestamp: new Date().toISOString(),
    });
  }

  req.user = user;
  next();
}
