import prisma from '../../core/prisma.js';

/**
 * Listado flexible según filtros
 */
export function list({ rutaId, conductorId }) {
  return prisma.entrega.findMany({
    where: {
      ...(rutaId && { rutaId }),
      ...(conductorId && { conductorId }),
    },
    orderBy: { ordenRuta: 'asc' },
    select: {
      id: true,
      estadoEntrega: true,
      ordenRuta: true,
      fechaSalida: true,
      fechaEntregaReal: true,
      actualizadoEn: true,
      pedido: {
        select: {
          id: true,
          clienteNombre: true,
          clienteNit: true,
          total: true,
        },
      },
    },
  });
}

/**
 * Entrega completa con detalles del pedido
 */
export function findById(id) {
  return prisma.entrega.findUnique({
    where: { id },
    select: {
      id: true,
      estadoEntrega: true,
      fechaAsignacion: true,
      fechaSalida: true,
      fechaEntregaReal: true,
      latitudDestino: true,
      longitudDestino: true,
      latitudEntrega: true,
      longitudEntrega: true,
      observacionesEntrega: true,
      motivoFallo: true,
      calificacionCliente: true,
      comentarioCliente: true,
      pedido: {
        select: {
          id: true,
          clienteNombre: true,
          clienteNit: true,
          telefonoEntrega: true,
          direccionEntrega: true,
          total: true,
        },
      },
    },
  });
}

/**
 * Actualizar cualquier campo permitido
 */
export function update(id, data) {
  return prisma.entrega.update({
    where: { id },
    data,
    select: {
      id: true,
      estadoEntrega: true,
      actualizadoEn: true,
    },
  });
}

/**
 * Marcar salida: cambia estado + registra hora
 */
export function marcarSalida(id) {
  return prisma.entrega.update({
    where: { id },
    data: {
      estadoEntrega: 'en_ruta',
      fechaSalida: new Date(),
    },
    select: {
      id: true,
      estadoEntrega: true,
      fechaSalida: true,
    },
  });
}

/**
 * Marcar entrega finalizada
 */
export function marcarEntrega(id, payload) {
  return prisma.entrega.update({
    where: { id },
    data: {
      estadoEntrega: 'entregado',
      fechaEntregaReal: new Date(),
      latitudEntrega: payload.latitudEntrega,
      longitudEntrega: payload.longitudEntrega,
      firmaCliente: payload.firmaCliente ?? null,
      fotoEntrega: payload.fotoEntrega ?? null,
      observacionesEntrega: payload.observacionesEntrega ?? null,
    },
    select: {
      id: true,
      estadoEntrega: true,
      fechaEntregaReal: true,
    },
  });
}
