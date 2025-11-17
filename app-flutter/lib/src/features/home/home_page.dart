import 'dart:async';

import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../core/widgets/app_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  String _horaActual = '';

  @override
  void initState() {
    super.initState();
    _actualizarHora();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      _actualizarHora();
    });
  }

  void _actualizarHora() {
    final ahora = DateTime.now();
    final hora = ahora.hour.toString().padLeft(2, '0');
    final min = ahora.minute.toString().padLeft(2, '0');
    setState(() {
      _horaActual = '$hora:$min';
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Distribuidora Clarita',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== TARJETAS SUPERIORES (ESTILO DASHBOARD WEB) ======
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _SummaryCard(
                  title: _horaActual.isEmpty ? '--:--' : _horaActual,
                  subtitle: 'Sesión iniciada',
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEC407A), Color(0xFFAB47BC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                const _SummaryCard(
                  title: 'Activo',
                  subtitle: 'Estado',
                  gradient: LinearGradient(
                    colors: [Color(0xFF00C853), Color(0xFF26A69A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                const _SummaryCard(
                  title: 'Conductor,\nVendedor',
                  subtitle: 'Permisos',
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF7043), Color(0xFFFF5252)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                const _SummaryCard(
                  title: 'Dark',
                  subtitle: 'Tema actual',
                  gradient: LinearGradient(
                    colors: [Color(0xFF7E57C2), Color(0xFFE91E63)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ====== TÍTULO MÓDULOS ======
            const Text(
              'Módulos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            // ====== GRID DE MÓDULOS ======
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.9,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _ModuleCard(
                  label: 'Inventario',
                  icon: Icons.inventory_2_rounded,
                  color: AppColors.green,
                  onTap: () => Navigator.pushNamed(context, '/inventario'),
                ),
                _ModuleCard(
                  label: 'Combustible',
                  icon: Icons.local_gas_station,
                  color: AppColors.orange,
                  onTap: () => Navigator.pushNamed(context, '/combustible'),
                ),
                _ModuleCard(
                  label: 'Pedidos',
                  icon: Icons.receipt_long,
                  color: AppColors.purple,
                  onTap: () => Navigator.pushNamed(context, '/pedidos'),
                ),
                _ModuleCard(
                  label: 'Rutas',
                  icon: Icons.route,
                  color: AppColors.pink,
                  onTap: () => Navigator.pushNamed(context, '/rutas'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =================== WIDGETS PRIVADOS ===================

class _SummaryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final LinearGradient gradient;

  const _SummaryCard({
    required this.title,
    required this.subtitle,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 16),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}