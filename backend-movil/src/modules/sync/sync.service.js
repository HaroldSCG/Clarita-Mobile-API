import prisma from '../../core/prisma.js';

/**
 * PULL:
 * Devuelve registros modificados después de lastSync
 */
export async function pull({ lastSync }) {
  const updatedAt = lastSync ? new Date(lastSync) : new Date(0);

  const [productos, pedidos, combustible, entregas] = await Promise.all([
    prisma.producto.findMany({
      where: { actualizadoEn: { gt: updatedAt } },
      select: {
        id: true,
        nombre: true,
        stockActual: true,
        actualizadoEn: true,
      },
    }),

    prisma.pedido.findMany({
      where: { actualizadoEn: { gt: updatedAt } },
      select: {
        id: true,
        clienteNombre: true,
        total: true,
        estado: true,
        actualizadoEn: true,
      },
    }),

    prisma.registroCombustible.findMany({
      where: { actualizadoEn: { gt: updatedAt } },
      select: {
        id: true,
        litros: true,
        precio: true,
        gasolinera: true,
        fechaCarga: true,
        actualizadoEn: true,
      },
    }),

    prisma.entrega.findMany({
      where: { actualizadoEn: { gt: updatedAt } },
      select: {
        id: true,
        estadoEntrega: true,
        fechaSalida: true,
        fechaEntregaReal: true,
        observacionesEntrega: true,
        actualizadoEn: true,
      },
    }),
  ]);

  return {
    lastSync: new Date().toISOString(),
    productos,
    pedidos,
    combustible,
    entregas,
  };
}

/**
 * PUSH:
 * Sobrescribe o crea registros que Flutter generó offline
 * Flutter envía:
 *  - pedidosOffline[]
 *  - combustibleOffline[]
 *  - entregasOffline[]
 */
export async function push({
  pedidos = [],
  combustible = [],
  entregas = [],
}) {
  const results = {
    pedidos: 0,
    combustible: 0,
    entregas: 0,
  };

  // PUSH PEDIDOS OFFLINE
  for (const item of pedidos) {
    await prisma.pedido.upsert({
      where: { id: item.id },
      create: {
        id: item.id,
        clienteNombre: item.cliente,
        total: item.total,
        estado: item.estado,
        creadoEn: item.actualizadoEn
          ? new Date(item.actualizadoEn)
          : new Date(),
        actualizadoEn: new Date(),
      },
      update: {
        clienteNombre: item.cliente,
        total: item.total,
        estado: item.estado,
        actualizadoEn: new Date(),
      },
    });
    results.pedidos++;
  }

  // PUSH REGISTROS COMBUSTIBLE OFFLINE
  for (const item of combustible) {
    await prisma.registroCombustible.upsert({
      where: { id: item.id },
      create: {
        id: item.id,
        litros: item.litros,
        precio: item.precio,
        gasolinera: item.gasolinera,
        fechaCarga: new Date(item.fecha),
        creadoEn: new Date(),
        actualizadoEn: new Date(),
        camionId: item.camionId,
        conductorId: item.conductorId,
      },
      update: {
        litros: item.litros,
        precio: item.precio,
        gasolinera: item.gasolinera,
        fechaCarga: new Date(item.fecha),
        actualizadoEn: new Date(),
      },
    });
    results.combustible++;
  }

  // PUSH ENTREGAS OFFLINE
  for (const item of entregas) {
    await prisma.entrega.upsert({
      where: { id: item.id },
      create: {
        id: item.id,
        pedidoId: item.pedidoId,
        estadoEntrega: item.estadoEntrega,
        fechaSalida: item.fechaSalida ? new Date(item.fechaSalida) : null,
        fechaEntregaReal: item.fechaEntregaReal
          ? new Date(item.fechaEntregaReal)
          : null,
        observacionesEntrega: item.observacionesEntrega ?? null,
        actualizadoEn: new Date(),
      },
      update: {
        estadoEntrega: item.estadoEntrega,
        fechaSalida: item.fechaSalida ? new Date(item.fechaSalida) : null,
        fechaEntregaReal: item.fechaEntregaReal
          ? new Date(item.fechaEntregaReal)
          : null,
        observacionesEntrega: item.observacionesEntrega ?? null,
        actualizadoEn: new Date(),
      },
    });
    results.entregas++;
  }

  return {
    message: 'Sync complete',
    ...results,
  };
}
