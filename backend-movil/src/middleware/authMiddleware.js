// backend-movil/src/middleware/authMiddleware.js
import { verifyToken } from '../core/auth.js';
import { prisma } from '../core/prisma.js';

export async function authMiddleware(req, res, next) {
  const header = req.headers.authorization;

  if (!header || !header.startsWith('Bearer ')) {
    return res.status(401).json({ message: 'No autorizado: falta token' });
  }

  const token = header.split(' ')[1];
  const decoded = verifyToken(token);

  if (!decoded) {
    return res.status(401).json({ message: 'Token inválido o expirado' });
  }

  // Verifica que el usuario exista y esté activo
  const user = await prisma.usuario.findUnique({
    where: { id: decoded.id, estado: true },
  });

  if (!user) {
    return res.status(401).json({ message: 'Usuario no encontrado o inactivo' });
  }

  req.user = user;
  next();
}
