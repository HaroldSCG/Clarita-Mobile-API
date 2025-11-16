import { Router } from 'express';
import * as entregasService from './entregas.service.js';

const router = Router();

/**
 * GET /api/mobile/entregas
 * Opcional: ?rutaId=  |  ?conductorId=
 */
router.get('/', async (req, res, next) => {
  try {
    const rutaId = req.query.rutaId ? Number(req.query.rutaId) : undefined;
    const conductorId = req.query.conductorId ? Number(req.query.conductorId) : undefined;

    const entregas = await entregasService.list({ rutaId, conductorId });
    res.json(entregas);
  } catch (error) {
    next(error);
  }
});

/**
 * GET /api/mobile/entregas/:id
 */
router.get('/:id', async (req, res, next) => {
  try {
    const entrega = await entregasService.findById(Number(req.params.id));
    if (!entrega) return res.status(404).json({ message: 'Entrega no encontrada' });
    res.json(entrega);
  } catch (error) {
    next(error);
  }
});

/**
 * PATCH /api/mobile/entregas/:id
 */
router.patch('/:id', async (req, res, next) => {
  try {
    const updated = await entregasService.update(Number(req.params.id), req.body);
    res.json(updated);
  } catch (error) {
    next(error);
  }
});

/**
 * POST /api/mobile/entregas/salir/:id
 */
router.post('/salir/:id', async (req, res, next) => {
  try {
    const updated = await entregasService.marcarSalida(Number(req.params.id));
    res.json(updated);
  } catch (error) {
    next(error);
  }
});

/**
 * POST /api/mobile/entregas/entregar/:id
 */
router.post('/entregar/:id', async (req, res, next) => {
  try {
    const updated = await entregasService.marcarEntrega(Number(req.params.id), req.body);
    res.json(updated);
  } catch (error) {
    next(error);
  }
});

export default router;
