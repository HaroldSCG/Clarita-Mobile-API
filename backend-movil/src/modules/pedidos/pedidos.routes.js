// backend-movil/src/modules/pedidos/pedidos.routes.js
import { Router } from 'express';
import { authMiddleware } from '../../middleware/authMiddleware.js';
import { success, fail } from '../../core/response.js';
import * as pedidosService from './pedidos.service.js';

const router = Router();

router.use(authMiddleware);

// GET /api/mobile/pedidos
router.get('/', async (req, res, next) => {
  try {
    const data = await pedidosService.listarPedidos();
    res.json(success(data, 'Listado de pedidos'));
  } catch (error) {
    next(error);
  }
});

// GET /api/mobile/pedidos/:id
router.get('/:id', async (req, res, next) => {
  try {
    const pedido = await pedidosService.obtenerPedido(req.params.id);
    if (!pedido) {
      throw fail('Pedido no encontrado', 404);
    }
    res.json(success(pedido, 'Detalle de pedido'));
  } catch (error) {
    next(error);
  }
});

export default router;
