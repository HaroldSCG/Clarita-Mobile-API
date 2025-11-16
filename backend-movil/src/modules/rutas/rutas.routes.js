import { Router } from 'express';
import * as rutasService from './rutas.service.js';

const router = Router();

/**
 * GET /api/mobile/rutas
 */
router.get('/', async (req, res, next) => {
  try {
    const rutas = await rutasService.list();
    res.json(rutas);
  } catch (error) {
    next(error);
  }
});

/**
 * GET /api/mobile/rutas/:id
 */
router.get('/:id', async (req, res, next) => {
  try {
    const ruta = await rutasService.findById(Number(req.params.id));
    if (!ruta) {
      return res.status(404).json({ message: 'Ruta no encontrada' });
    }
    res.json(ruta);
  } catch (error) {
    next(error);
  }
});

/**
 * POST /api/mobile/rutas
 */
router.post('/', async (req, res, next) => {
  try {
    const created = await rutasService.create(req.body);
    res.status(201).json(created);
  } catch (error) {
    next(error);
  }
});

export default router;
