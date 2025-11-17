// backend-movil/src/modules/combustible/combustible.routes.js
import { Router } from 'express';
import { authMiddleware } from '../../middleware/authMiddleware.js';
import { success, fail } from '../../core/response.js';
import * as combustibleService from './combustible.service.js';

const router = Router();

// Todas protegidas por token
router.use(authMiddleware);

// GET /api/mobile/combustible
router.get('/', async (req, res, next) => {
  try {
    const data = await combustibleService.listarRegistros();
    res.json(success(data, 'Registros de combustible'));
  } catch (error) {
    next(error);
  }
});

// GET /api/mobile/combustible/:id
router.get('/:id', async (req, res, next) => {
  try {
    const registro = await combustibleService.obtenerRegistro(req.params.id);
    if (!registro) {
      throw fail('Registro no encontrado', 404);
    }
    res.json(success(registro, 'Detalle de combustible'));
  } catch (error) {
    next(error);
  }
});

export default router;
