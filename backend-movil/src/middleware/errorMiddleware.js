// backend-movil/src/middleware/errorMiddleware.js
export function errorMiddleware(err, req, res, next) {
  console.error('[ERROR MIDDLEWARE]', err);

  const status = err.status || 500;

  res.status(status).json({
    message: err.message || 'Error interno del servidor',
    status,
  });
}
