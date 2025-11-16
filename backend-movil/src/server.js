// backend-movil/src/server.js
import http from 'http';
import app from './app.js';
import env from './core/env.js';
import logger from './core/logger.js';

const port = env.port || 4000;
const server = http.createServer(app);

server.listen(port, () => {
  logger.info(`Backend móvil escuchando en http://localhost:${port}`);
});
