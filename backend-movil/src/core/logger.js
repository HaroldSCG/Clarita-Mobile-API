// backend-movil/src/core/logger.js

function info(...args) {
  console.log('[INFO]', ...args);
}

function log(...args) {
  console.log('[LOG]', ...args);
}

function warn(...args) {
  console.warn('[WARN]', ...args);
}

function error(...args) {
  console.error('[ERROR]', ...args);
}

const logger = {
  info,
  log,
  warn,
  error
};

export default logger;
