import { Router } from 'express';
import * as combustibleService from './combustible.service.js';

const router = Router();

/**
 * GET /api/mobile/combustible
 * Listado seguro para app móvil
 */
router.get('/', async (req, res, next) => {
  try {
    const registros = await combustibleService.list();
    res.json(registros);
  } catch (error) {
    next(error);
  }
});

/**
 * POST /api/mobile/combustible
 * Nuevo registro de combustible
 */
router.post('/', async (req, res, next) => {
  try {
    const created = await combustibleService.create(req.body);
    res.status(201).json(created);
  } catch (error) {
    next(error);
  }
});

export default router;
