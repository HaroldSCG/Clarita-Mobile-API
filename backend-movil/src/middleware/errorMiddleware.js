// backend-movil/src/middleware/errorMiddleware.js
import { success } from '../core/response.js';

export function notFoundHandler(req, res, next) {
  // 404 genérico
  res.status(404).json({
    ok: false,
    message: 'Ruta no encontrada',
    data: null,
    timestamp: new Date().toISOString(),
  });
}

export function errorHandler(err, req, res, next) {
  const status = err.status || 500;
  const message = err.message || 'Error interno del servidor';

  if (process.env.NODE_ENV !== 'production') {
    console.error(err);
  }

  res.status(status).json({
    ok: false,
    message,
    data: err.extra ?? null,
    timestamp: new Date().toISOString(),
  });
}
