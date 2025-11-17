// backend-movil/src/routes.js
import { Router } from 'express';

// módulos
import authRoutes from './modules/auth/auth.routes.js';
import usuariosRoutes from './modules/usuarios/usuarios.routes.js';
import inventarioRoutes from './modules/inventario/inventario.routes.js';
import combustibleRoutes from './modules/combustible/combustible.routes.js';
import pedidosRoutes from './modules/pedidos/pedidos.routes.js';
import rutasRoutes from './modules/rutas/rutas.routes.js';
import entregasRoutes from './modules/entregas/entregas.routes.js';
import syncRoutes from './modules/sync/sync.routes.js';

const router = Router();

router.use('/auth', authRoutes);
router.use('/usuarios', usuariosRoutes);
router.use('/inventario', inventarioRoutes);
router.use('/combustible', combustibleRoutes);
router.use('/pedidos', pedidosRoutes);
router.use('/rutas', rutasRoutes);
router.use('/entregas', entregasRoutes);
router.use('/sync', syncRoutes);

export default router;
