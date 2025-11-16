// backend-movil/src/app.js
import express from 'express';
import cors from 'cors';
import morgan from 'morgan';
import env from './core/env.js';
import routes from './routes.js';
import { notFoundHandler, errorHandler } from './middleware/errorMiddleware.js';

const app = express();

// Procesar JSON
app.use(express.json({ limit: '3mb' }));

// CORS (permite tráfico desde el APK y desde tu dominio si lo deseas)
const allowedOrigins = env.CORS_ORIGIN?.split(',').map(o => o.trim());

app.use(
  cors({
    origin: allowedOrigins?.length ? allowedOrigins : '*',
    credentials: true,
  })
);

// Logger de desarrollo
app.use(morgan('dev'));

// Health check
app.get('/health', (req, res) =>
  res.json({ status: 'ok', version: '1.0', timestamp: new Date().toISOString() })
);

// Monta rutas del backend móvil
app.use('/api/mobile', routes);

// Manejo centralizado de errores
app.use(notFoundHandler);
app.use(errorHandler);

export default app;
