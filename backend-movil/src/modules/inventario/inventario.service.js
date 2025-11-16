// backend-movil/src/modules/inventario/inventario.service.js
import prisma from '../../core/prisma.js';

/**
 * Lista todos los productos con campos seguros
 * Ordenados por nombre
 */
export function list() {
  return prisma.producto.findMany({
    orderBy: { nombre: 'asc' },
    select: {
      id: true,
      codigo: true,
      nombre: true,
      descripcion: true,
      precioVenta: true,
      stockActual: true,
      stockMinimo: true,
      unidadMedida: true,
      actualizadoEn: true,
      categoria: {
        select: {
          nombre: true,
        },
      },
      proveedor: {
        select: {
          nombre: true,
        },
      },
    },
  });
}

/**
 * Busca un producto por ID
 */
export function findById(id) {
  return prisma.producto.findUnique({
    where: { id },
    select: {
      id: true,
      codigo: true,
      nombre: true,
      descripcion: true,
      precioCompra: true,
      precioVenta: true,
      stockActual: true,
      stockMinimo: true,
      stockReservado: true,
      unidadMedida: true,
      categoria: {
        select: {
          id: true,
          nombre: true,
        },
      },
      proveedor: {
        select: {
          id: true,
          nombre: true,
        },
      },
      creadoEn: true,
      actualizadoEn: true,
    },
  });
}
