import prisma from '../../core/prisma.js';

/**
 * Listado seguro para móvil: pedidos resumidos
 */
export function list() {
  return prisma.pedido.findMany({
    orderBy: { fechaPedido: 'desc' },
    select: {
      id: true,
      clienteNombre: true,
      clienteNit: true,
      total: true,
      estado: true,
      fechaPedido: true,
      actualizadoEn: true,
      vendedor: {
        select: {
          id: true,
          nombre: true,
          apellido: true,
        },
      },
    },
  });
}

/**
 * Pedido detallado
 */
export function findById(id) {
  return prisma.pedido.findUnique({
    where: { id },
    select: {
      id: true,
      clienteNombre: true,
      clienteNit: true,
      direccionEntrega: true,
      telefonoEntrega: true,
      observaciones: true,
      fechaPedido: true,
      fechaEntrega: true,
      estado: true,
      total: true,
      vendedor: {
        select: {
          id: true,
          nombre: true,
          apellido: true,
        },
      },
      detalles: {
        select: {
          id: true,
          cantidad: true,
          precioUnitario: true,
          subtotal: true,
          producto: {
            select: {
              id: true,
              nombre: true,
              unidadMedida: true,
            },
          },
        },
      },
      actualizadoEn: true,
    },
  });
}

/**
 * Crear pedido y detalles
 */
export async function create(payload) {
  const {
    vendedorId,
    clienteId,
    clienteNombre,
    clienteNit,
    subtotal,
    descuento,
    impuestos,
    total,
    detalles = [],
  } = payload;

  return prisma.pedido.create({
    data: {
      vendedorId,
      clienteId,
      clienteNombre,
      clienteNit,
      subtotal,
      descuento: descuento ?? 0,
      impuestos: impuestos ?? 0,
      total,
      detalles: {
        createMany: {
          data: detalles.map((d) => ({
            productoId: d.productoId,
            cantidad: d.cantidad,
            precioUnitario: d.precioUnitario,
            subtotal: d.subtotal,
          })),
        },
      },
    },
    select: {
      id: true,
      total: true,
      estado: true,
      fechaPedido: true,
    },
  });
}
