// backend-movil/src/modules/auth/auth.routes.js
import { Router } from 'express';
import * as authService from './auth.service.js';

const router = Router();

/**
 * POST /api/mobile/auth/login
 */
router.post('/login', async (req, res, next) => {
  try {
    const { correo, password } = req.body;
    const result = await authService.login(correo, password);
    res.json(result);
  } catch (error) {
    next(error);
  }
});

/**
 * GET /api/mobile/auth/me
 */
router.get('/me', async (req, res, next) => {
  try {
    const token = req.headers.authorization?.replace('Bearer ', '');
    const user = await authService.me(token);
    res.json(user);
  } catch (error) {
    next(error);
  }
});

export default router;
