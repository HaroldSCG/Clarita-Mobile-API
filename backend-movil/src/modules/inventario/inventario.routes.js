// backend-movil/src/modules/inventario/inventario.routes.js
import { Router } from 'express';
import { authMiddleware } from '../../middleware/authMiddleware.js';
import { success, fail } from '../../core/response.js';
import * as inventarioService from './inventario.service.js';

const router = Router();

router.use(authMiddleware);

// GET /api/mobile/inventario
router.get('/', async (req, res, next) => {
  try {
    const data = await inventarioService.listarProductos();
    res.json(success(data, 'Listado de inventario'));
  } catch (error) {
    next(error);
  }
});

// GET /api/mobile/inventario/:id
router.get('/:id', async (req, res, next) => {
  try {
    const producto = await inventarioService.obtenerProducto(req.params.id);
    if (!producto) {
      throw fail('Producto no encontrado', 404);
    }
    res.json(success(producto, 'Detalle de producto'));
  } catch (error) {
    next(error);
  }
});

export default router;
