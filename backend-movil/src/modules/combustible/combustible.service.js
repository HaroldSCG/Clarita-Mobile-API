import prisma from '../../core/prisma.js';

/**
 * Lista registros de combustible (solo campos necesarios para móvil)
 */
export function list() {
  return prisma.registroCombustible.findMany({
    orderBy: { fecha: 'desc' },
    select: {
      id: true,
      camionId: true,
      conductorId: true,
      fecha: true,
      fechaCarga: true,
      litros: true,
      precio: true,
      precioPorLitro: true,
      gasolinera: true,
      kilometrajeInicial: true,
      kilometrajeFinal: true,
      estado: true,
      comentarios: true,
      actualizadoEn: true,
      camion: {
        select: {
          placa: true,
        },
      },
      conductor: {
        select: {
          nombre: true,
          apellido: true,
        },
      },
    },
  });
}

/**
 * Crear registro de combustible
 * (validación mínima; luego agregamos reglas reales)
 */
export function create(data) {
  return prisma.registroCombustible.create({
    data: {
      camionId: data.camionId,
      conductorId: data.conductorId,
      fechaCarga: new Date(data.fechaCarga),
      litros: data.litros,
      precio: data.precio,
      precioPorLitro: data.precio / data.litros,
      gasolinera: data.gasolinera,
      ubicacion: data.ubicacion ?? null,
      kilometrajeInicial: data.kilometrajeInicial,
      kilometrajeFinal: data.kilometrajeFinal,
      horasUso: data.horasUso ?? null,
      facturaFoto: data.facturaFoto ?? null,
      facturaNumero: data.facturaNumero ?? null,
      comentarios: data.comentarios ?? null,
    },
    select: {
      id: true,
      camionId: true,
      conductorId: true,
      litros: true,
      precio: true,
      precioPorLitro: true,
      fechaCarga: true,
      gasolinera: true,
      kilometrajeInicial: true,
      kilometrajeFinal: true,
      comentarios: true,
    },
  });
}
