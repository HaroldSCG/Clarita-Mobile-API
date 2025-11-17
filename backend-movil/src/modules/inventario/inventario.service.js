// backend-movil/src/modules/inventario/inventario.service.js
import prisma from '../../core/prisma.js';

export async function listarProductos() {
  const productos = await prisma.producto.findMany({
    orderBy: { nombre: 'asc' },
    include: {
      categoria: true,
      proveedor: true,
    },
  });

  // Adaptamos mínimamente la forma para que Flutter tenga campos útiles
  return productos.map(p => ({
    id: p.id,
    codigo: p.codigo,
    nombre: p.nombre,
    descripcion: p.descripcion,
    precioVenta: p.precioVenta,
    stockActual: p.stockActual,
    stockMinimo: p.stockMinimo,
    unidadMedida: p.unidadMedida,
    categoria: p.categoria?.nombre ?? null,
    proveedor: p.proveedor?.nombre ?? null,
    actualizadoEn: p.actualizadoEn,
  }));
}

export async function obtenerProducto(id) {
  const p = await prisma.producto.findUnique({
    where: { id: Number(id) },
    include: {
      categoria: true,
      proveedor: true,
    },
  });

  if (!p) return null;

  return {
    id: p.id,
    codigo: p.codigo,
    nombre: p.nombre,
    descripcion: p.descripcion,
    precioVenta: p.precioVenta,
    stockActual: p.stockActual,
    stockMinimo: p.stockMinimo,
    unidadMedida: p.unidadMedida,
    categoria: p.categoria?.nombre ?? null,
    proveedor: p.proveedor?.nombre ?? null,
    actualizadoEn: p.actualizadoEn,
  };
}
