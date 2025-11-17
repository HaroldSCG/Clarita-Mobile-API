// backend-movil/src/modules/pedidos/pedidos.service.js
import prisma from '../../core/prisma.js';

export async function listarPedidos() {
  const pedidos = await prisma.pedido.findMany({
    orderBy: { fechaPedido: 'desc' },
    include: {
      cliente: true,
      vendedor: true,
    },
  });

  return pedidos.map(p => ({
    id: p.id,
    cliente: p.clienteNombre ?? p.cliente?.nombre ?? 'Consumidor Final',
    estado: p.estado,
    total: p.total,
    fecha: p.fechaPedido,
    vendedor: p.vendedor?.nombre ?? null,
  }));
}

export async function obtenerPedido(id) {
  const pedido = await prisma.pedido.findUnique({
    where: { id: Number(id) },
    include: {
      cliente: true,
      vendedor: true,
      detalles: {
        include: { producto: true },
      },
    },
  });

  if (!pedido) return null;

  return {
    id: pedido.id,
    cliente: pedido.clienteNombre ?? pedido.cliente?.nombre ?? 'Consumidor Final',
    estado: pedido.estado,
    total: pedido.total,
    fecha: pedido.fechaPedido,
    vendedor: pedido.vendedor?.nombre ?? null,
    detalles: pedido.detalles.map(d => ({
      productoId: d.productoId,
      productoNombre: d.producto?.nombre ?? '',
      cantidad: d.cantidad,
      precioUnitario: d.precioUnitario,
      subtotal: d.subtotal,
    })),
  };
}
