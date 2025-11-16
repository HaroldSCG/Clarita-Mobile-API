import { Router } from 'express';
import * as pedidosService from './pedidos.service.js';

const router = Router();

/**
 * GET /api/mobile/pedidos
 * Pedidos resumidos para listado
 */
router.get('/', async (req, res, next) => {
  try {
    const pedidos = await pedidosService.list();
    res.json(pedidos);
  } catch (error) {
    next(error);
  }
});

/**
 * GET /api/mobile/pedidos/:id
 * Pedido completo con detalles
 */
router.get('/:id', async (req, res, next) => {
  try {
    const pedido = await pedidosService.findById(Number(req.params.id));
    if (!pedido) {
      return res.status(404).json({ message: 'Pedido no encontrado' });
    }
    res.json(pedido);
  } catch (error) {
    next(error);
  }
});

/**
 * POST /api/mobile/pedidos
 * Crear pedido + detalles
 */
router.post('/', async (req, res, next) => {
  try {
    const created = await pedidosService.create(req.body);
    res.status(201).json(created);
  } catch (error) {
    next(error);
  }
});

export default router;
