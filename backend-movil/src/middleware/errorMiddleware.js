// backend-movil/src/middleware/errorMiddleware.js

export function notFoundHandler(req, res, next) {
  res.status(404).json({ message: 'Ruta no encontrada' });
}

export function errorHandler(err, req, res, next) {
  const status = err.status || 500;
  const message = err.message || 'Error interno del servidor';

  if (process.env.NODE_ENV !== 'production') {
    console.error(err);
  }

  res.status(status).json({ message });
}
