// backend-movil/src/modules/usuarios/usuarios.routes.js
import { Router } from 'express';
import * as usuariosService from './usuarios.service.js';

const router = Router();

/**
 * GET /api/mobile/usuarios
 */
router.get('/', async (req, res, next) => {
  try {
    const usuarios = await usuariosService.list();
    res.json(usuarios);
  } catch (error) {
    next(error);
  }
});

/**
 * GET /api/mobile/usuarios/:id
 */
router.get('/:id', async (req, res, next) => {
  try {
    const usuario = await usuariosService.findById(Number(req.params.id));
    if (!usuario) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }
    res.json(usuario);
  } catch (error) {
    next(error);
  }
});

export default router;
