// backend-movil/src/core/response.js

export function success(data, message = 'OK') {
  return {
    ok: true,
    message,
    data,
    timestamp: new Date().toISOString(),
  };
}

export function fail(message = 'Error', status = 400, extra = {}) {
  const err = new Error(message);
  err.status = status;
  err.extra = extra;
  return err;
}
