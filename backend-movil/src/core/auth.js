// backend-movil/src/core/auth.js
import jwt from 'jsonwebtoken';
import env from './env.js';   // 👈 ESTA ES LA ÚNICA CORRECCIÓN

export function signToken(payload) {
  return jwt.sign(payload, env.JWT_SECRET, {
    expiresIn: '7d',
  });
}

export function verifyToken(token) {
  try {
    return jwt.verify(token, env.JWT_SECRET);
  } catch {
    return null;
  }
}
