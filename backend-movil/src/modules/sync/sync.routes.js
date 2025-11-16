import { Router } from 'express';
import * as syncService from './sync.service.js';

const router = Router();

/**
 * Descarga cambios desde el backend hacia Flutter
 */
router.post('/pull', async (req, res, next) => {
  try {
    const data = await syncService.pull(req.body);
    res.json(data);
  } catch (error) {
    next(error);
  }
});

/**
 * Sube cambios desde Flutter hacia el backend
 */
router.post('/push', async (req, res, next) => {
  try {
    const result = await syncService.push(req.body);
    res.json(result);
  } catch (error) {
    next(error);
  }
});

export default router;
