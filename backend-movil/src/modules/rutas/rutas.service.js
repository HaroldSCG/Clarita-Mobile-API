import prisma from '../../core/prisma.js';

/**
 * Listado seguro para móvil (dashboard)
 */
export function list() {
  return prisma.ruta.findMany({
    orderBy: { fecha: 'desc' },
    select: {
      id: true,
      nombre: true,
      fecha: true,
      estado: true,
      numeroEntregas: true,
      entregasCompletadas: true,
      actualizadoEn: true,
      camion: {
        select: {
          id: true,
          placa: true,
        },
      },
      conductor: {
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
 * Ruta completa con entregas
 */
export function findById(id) {
  return prisma.ruta.findUnique({
    where: { id },
    select: {
      id: true,
      nombre: true,
      fecha: true,
      estado: true,
      kilometrajeInicial: true,
      kilometrajeFinal: true,
      combustibleInicial: true,
      combustibleFinal: true,
      distanciaTotal: true,
      tiempoTotal: true,
      observaciones: true,
      actualizadoEn: true,
      camion: {
        select: {
          id: true,
          placa: true,
          marca: true,
          modelo: true,
        },
      },
      conductor: {
        select: {
          id: true,
          nombre: true,
          apellido: true,
        },
      },
      entregas: {
        orderBy: { ordenRuta: 'asc' },
        select: {
          id: true,
          estadoEntrega: true,
          fechaSalida: true,
          fechaEntregaReal: true,
          latitudDestino: true,
          longitudDestino: true,
          latitudEntrega: true,
          longitudEntrega: true,
          motivoFallo: true,
          ordenRuta: true,
          pedido: {
            select: {
              id: true,
              clienteNombre: true,
              clienteNit: true,
              total: true,
            },
          },
        },
      },
    },
  });
}

/**
 * Crear ruta
 */
export function create(data) {
  return prisma.ruta.create({
    data: {
      nombre: data.nombre,
      fecha: new Date(),
      camionId: data.camionId,
      conductorId: data.conductorId,
      numeroEntregas: data.entregas?.length ?? 0,
      entregas: data.entregas
        ? {
            createMany: {
              data: data.entregas.map((e, index) => ({
                pedidoId: e.pedidoId,
                ordenRuta: index + 1,
              })),
            },
          }
        : undefined,
    },
    select: {
      id: true,
      nombre: true,
      estado: true,
    },
  });
}
