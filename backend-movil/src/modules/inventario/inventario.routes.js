// backend-movil/src/modules/inventario/inventario.routes.js
import { Router } from 'express';
import * as inventarioService from './inventario.service.js';

const router = Router();

/**
 * GET /api/mobile/inventario
 */
router.get('/', async (req, res, next) => {
  try {
    const productos = await inventarioService.list();
    res.json(productos);
  } catch (error) {
    next(error);
  }
});

/**
 * GET /api/mobile/inventario/:id
 */
router.get('/:id', async (req, res, next) => {
  try {
    const producto = await inventarioService.findById(Number(req.params.id));
    if (!producto) {
      return res.status(404).json({ message: 'Producto no encontrado' });
    }
    res.json(producto);
  } catch (error) {
    next(error);
  }
});

export default router;
