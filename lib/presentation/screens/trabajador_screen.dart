import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/use_case/trabajador.dart';
import '../providers/use_case/ubicacion.dart';
import '../widget/trabajador_card.dart';
import '../utils/notification_utils.dart';

class TrabajadoresScreen extends ConsumerStatefulWidget {
  const TrabajadoresScreen({super.key});

  @override
  ConsumerState<TrabajadoresScreen> createState() => _TrabajadoresScreenState();
}

class _TrabajadoresScreenState extends ConsumerState<TrabajadoresScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cargarTrabajadores();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _cargarTrabajadores() {
    final ubicacionState = ref.read(ubicacionNotifierProvider);
    if (ubicacionState.ubicacion != null &&
        ubicacionState.ubicacion!.ubicacionId != null) {
      ref
          .read(trabajadorNotifierProvider.notifier)
          .cargarTrabajadores(ubicacionState.ubicacion!.ubicacionId.toString());
    } else {
      NotificationUtils.showSnackBar(
        context: context,
        message: 'No se pudo obtener la ID de la ubicación',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final trabajadorState = ref.watch(trabajadorNotifierProvider);
    final ubicacionState = ref.watch(ubicacionNotifierProvider);

    return Scaffold(
      appBar: _buildAppBar(context, ubicacionState),
      body: Column(
        children: [
          // Filtros y búsqueda
          _buildFilters(context, trabajadorState),

          // Lista de trabajadores
          Expanded(
            child:
                trabajadorState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : trabajadorState.errorMessage != null
                    ? _buildErrorView(trabajadorState.errorMessage!)
                    : trabajadorState.trabajadoresFiltrados.isEmpty
                    ? _buildEmptyView()
                    : _buildTrabajadoresList(trabajadorState),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _cargarTrabajadores,
        tooltip: 'Actualizar',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, UbicacionState ubicacionState) {
    if (_isSearching) {
      return AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Buscar trabajador...',
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 16),
          onChanged: (value) {
            ref
                .read(trabajadorNotifierProvider.notifier)
                .buscarTrabajadores(value);
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchController.clear();
              ref
                  .read(trabajadorNotifierProvider.notifier)
                  .buscarTrabajadores('');
            });
          },
        ),
      );
    }

    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trabajadores'),
          if (ubicacionState.ubicacion?.nombre != null)
            Text(
              ubicacionState.ubicacion!.nombre,
              style: const TextStyle(fontSize: 14),
            ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () => _showFilterDialog(context),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context, TrabajadorState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chips de filtro por estado
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  label: 'Todos',
                  selected: state.filterType == TrabajadorFilterType.todos,
                  onSelected: (selected) {
                    if (selected) {
                      ref
                          .read(trabajadorNotifierProvider.notifier)
                          .filtrarPorEstado(TrabajadorFilterType.todos);
                    }
                  },
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Activos',
                  selected: state.filterType == TrabajadorFilterType.activos,
                  onSelected: (selected) {
                    if (selected) {
                      ref
                          .read(trabajadorNotifierProvider.notifier)
                          .filtrarPorEstado(TrabajadorFilterType.activos);
                    }
                  },
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Inactivos',
                  selected: state.filterType == TrabajadorFilterType.inactivos,
                  onSelected: (selected) {
                    if (selected) {
                      ref
                          .read(trabajadorNotifierProvider.notifier)
                          .filtrarPorEstado(TrabajadorFilterType.inactivos);
                    }
                  },
                ),
              ],
            ),
          ),

          // Mostrar contador de resultados
          const SizedBox(height: 8),
          Text(
            'Mostrando ${state.trabajadoresFiltrados.length} de ${state.trabajadores.length} trabajadores',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool selected,
    required Function(bool) onSelected,
  }) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      backgroundColor: Colors.grey[200],
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      checkmarkColor: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildTrabajadoresList(TrabajadorState state) {
    return RefreshIndicator(
      onRefresh: () async {
        _cargarTrabajadores();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.trabajadoresFiltrados.length,
        itemBuilder: (context, index) {
          final trabajador = state.trabajadoresFiltrados[index];
          return TrabajadorCard(
            trabajador: trabajador,
            onTap: () => _mostrarDetallesTrabajador(trabajador.id.toString()),
          );
        },
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No se encontraron trabajadores',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Intenta cambiar los filtros o realizar una nueva búsqueda',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _cargarTrabajadores,
            icon: const Icon(Icons.refresh),
            label: const Text('Actualizar'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            'Error al cargar los trabajadores',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red[700],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              errorMessage,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _cargarTrabajadores,
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDetallesTrabajador(String id) {
    // Aquí implementarías la navegación a la pantalla de detalles
    // Por ejemplo:
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) => TrabajadorDetailScreen(trabajadorId: id),
    //   ),
    // );

    // Por ahora, mostraremos un diálogo simple
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Detalles del Trabajador'),
            content: const Text(
              'Aquí se mostrarían los detalles completos del trabajador.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    final state = ref.read(trabajadorNotifierProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.4,
              maxChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Indicador de arrastre
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Título
                      const Text(
                        'Filtrar Trabajadores',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Filtro por estado
                      const Text(
                        'Estado',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          _buildFilterChip(
                            label: 'Todos',
                            selected:
                                state.filterType == TrabajadorFilterType.todos,
                            onSelected: (selected) {
                              if (selected) {
                                ref
                                    .read(trabajadorNotifierProvider.notifier)
                                    .filtrarPorEstado(
                                      TrabajadorFilterType.todos,
                                    );
                              }
                            },
                          ),
                          _buildFilterChip(
                            label: 'Activos',
                            selected:
                                state.filterType ==
                                TrabajadorFilterType.activos,
                            onSelected: (selected) {
                              if (selected) {
                                ref
                                    .read(trabajadorNotifierProvider.notifier)
                                    .filtrarPorEstado(
                                      TrabajadorFilterType.activos,
                                    );
                              }
                            },
                          ),
                          _buildFilterChip(
                            label: 'Inactivos',
                            selected:
                                state.filterType ==
                                TrabajadorFilterType.inactivos,
                            onSelected: (selected) {
                              if (selected) {
                                ref
                                    .read(trabajadorNotifierProvider.notifier)
                                    .filtrarPorEstado(
                                      TrabajadorFilterType.inactivos,
                                    );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
