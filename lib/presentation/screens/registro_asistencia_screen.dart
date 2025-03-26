import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/use_case/registro_diario.dart';
import '../providers/use_case/ubicacion.dart';
import '../providers/use_case/trabajador.dart';
import '../widget/registro_diario_card.dart';
import '../widget/resumen_asistencia_card.dart';
import '../utils/notification_utils.dart';

class RegistroAsistenciaScreen extends ConsumerStatefulWidget {
  const RegistroAsistenciaScreen({super.key});

  @override
  ConsumerState<RegistroAsistenciaScreen> createState() =>
      _RegistroAsistenciaScreenState();
}

class _RegistroAsistenciaScreenState
    extends ConsumerState<RegistroAsistenciaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _fechaSeleccionada = DateTime.now();
  DateTime? _fechaInicio;
  DateTime? _fechaFin;
  bool _modoRangoFechas = false;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cargarRegistros();
      _cargarTrabajadores();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _cargarRegistros() {
    final ubicacionState = ref.read(ubicacionNotifierProvider);
    if (ubicacionState.ubicacion != null &&
        ubicacionState.ubicacion!.id != null) {
      if (_modoRangoFechas) {
        ref
            .read(registroDiarioNotifierProvider.notifier)
            .cargarRegistrosPorRango(
              ubicacionState.ubicacion!.id.toString(),
              fechaInicio: _fechaInicio,
              fechaFin: _fechaFin,
            );
      } else {
        ref
            .read(registroDiarioNotifierProvider.notifier)
            .cargarRegistros(
              ubicacionState.ubicacion!.id.toString(),
              fecha: _fechaSeleccionada,
            );
      }
    } else {
      NotificationUtils.showSnackBar(
        context: context,
        message: 'No se pudo obtener la ID de la ubicación',
        isError: true,
      );
    }
  }

  void _cargarTrabajadores() {
    final ubicacionState = ref.read(ubicacionNotifierProvider);
    if (ubicacionState.ubicacion != null &&
        ubicacionState.ubicacion!.id != null) {
      ref
          .read(trabajadorNotifierProvider.notifier)
          .cargarTrabajadores(ubicacionState.ubicacion!.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final registroDiarioState = ref.watch(registroDiarioNotifierProvider);
    final ubicacionState = ref.watch(ubicacionNotifierProvider);
    final trabajadorState = ref.watch(trabajadorNotifierProvider);

    // Mostrar notificación si hay error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (registroDiarioState.errorMessage != null) {
        NotificationUtils.showSnackBar(
          context: context,
          message: registroDiarioState.errorMessage!,
          isError: true,
        );
        // Limpiar el error después de mostrarlo
        ref.read(registroDiarioNotifierProvider.notifier).clearErrors();
      }
    });

    return Scaffold(
      appBar: _buildAppBar(context, ubicacionState),
      body: Column(
        children: [
          // Selector de fecha
          _buildDateSelector(context),

          // Pestañas
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Registros de Hoy'),
              Tab(text: 'Registrar Asistencia'),
            ],
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: Theme.of(context).colorScheme.primary,
          ),

          // Contenido de las pestañas
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Pestaña de registros
                _buildRegistrosTab(context, registroDiarioState),

                // Pestaña de registro de asistencia
                _buildRegistrarAsistenciaTab(context, trabajadorState),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _cargarRegistros,
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
            // Implementar búsqueda
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchController.clear();
            });
          },
        ),
      );
    }

    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Registro de Asistencia'),
          if (ubicacionState.ubicacion?.nombre != null)
            Text(
              ubicacionState.ubicacion!.nombre!,
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

  Widget _buildDateSelector(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 18),
                onPressed:
                    _modoRangoFechas
                        ? null
                        : () {
                          setState(() {
                            _fechaSeleccionada = _fechaSeleccionada.subtract(
                              const Duration(days: 1),
                            );
                          });
                          _cargarRegistros();
                        },
              ),
              GestureDetector(
                onTap:
                    () =>
                        _modoRangoFechas
                            ? _selectDateRange(context)
                            : _selectDate(context),
                child: Row(
                  children: [
                    Icon(
                      _modoRangoFechas
                          ? Icons.date_range
                          : Icons.calendar_today,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _modoRangoFechas
                          ? _formatDateRange()
                          : DateFormat(
                            'EEEE, d MMMM yyyy',
                            'es',
                          ).format(_fechaSeleccionada),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 18),
                onPressed:
                    _modoRangoFechas
                        ? null
                        : () {
                          setState(() {
                            _fechaSeleccionada = _fechaSeleccionada.add(
                              const Duration(days: 1),
                            );
                          });
                          _cargarRegistros();
                        },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: const Text('Día específico'),
                selected: !_modoRangoFechas,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _modoRangoFechas = false;
                      _fechaInicio = null;
                      _fechaFin = null;
                    });
                    _cargarRegistros();
                  }
                },
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Rango de fechas'),
                selected: _modoRangoFechas,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _modoRangoFechas = true;
                    });
                    _selectDateRange(context);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrosTab(BuildContext context, RegistroDiarioState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return _buildErrorView(state.errorMessage!);
    }

    if (state.registrosFiltrados.isEmpty) {
      return _buildEmptyView();
    }

    return RefreshIndicator(
      onRefresh: () async {
        _cargarRegistros();
      },
      child: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          // Mostrar resumen solo en modo rango de fechas o cuando hay múltiples registros
          if (_modoRangoFechas || state.registrosFiltrados.length > 1)
            ResumenAsistenciaCard(
              registros: state.registrosFiltrados,
              fechaInicio: _fechaInicio,
              fechaFin: _fechaFin,
            ),

          // Lista de registros
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Registros de Asistencia',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...state.registrosFiltrados
                    .map(
                      (registro) => RegistroDiarioCard(
                        registro: registro,
                        onTap: () => _mostrarDetallesRegistro(registro.id!),
                        onRegistrarSalida:
                            registro.tieneSalida
                                ? null
                                : () => _registrarSalida(registro.id!),
                        onCambiarEstado:
                            (value) =>
                                _cambiarEstadoRegistro(registro.id!, value),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrarAsistenciaTab(
    BuildContext context,
    TrabajadorState state,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Text(
          'Error al cargar trabajadores: ${state.errorMessage}',
          style: TextStyle(color: Colors.red[700]),
        ),
      );
    }

    if (state.trabajadores.isEmpty) {
      return const Center(child: Text('No hay trabajadores disponibles'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecciona un trabajador para registrar su asistencia:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Lista de trabajadores
          Expanded(
            child: ListView.builder(
              itemCount: state.trabajadores.length,
              itemBuilder: (context, index) {
                final trabajador = state.trabajadores[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: null,
                      child: Text(trabajador.nombre[0].toUpperCase()),
                    ),
                    title: Text(trabajador.nombre),
                    subtitle: Text('Sin cargo'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.login, color: Colors.blue),
                          onPressed:
                              () => _registrarEntrada(trabajador.id.toString()),
                          tooltip: 'Registrar entrada',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                            color: Colors.green,
                          ),
                          onPressed:
                              () => _escanearQR(trabajador.id.toString()),
                          tooltip: 'Escanear QR',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Botón para escanear QR
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => _escanearQRGeneral(),
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Escanear QR para registrar asistencia'),
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            _modoRangoFechas
                ? 'No hay registros en el rango seleccionado'
                : 'No hay registros para esta fecha',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _modoRangoFechas
                ? 'Intenta seleccionar otro rango de fechas o registrar una nueva asistencia'
                : 'Intenta cambiar la fecha o registrar una nueva asistencia',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              _tabController.animateTo(1);
            },
            icon: const Icon(Icons.add),
            label: const Text('Registrar asistencia'),
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
            'Error al cargar los registros',
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
            onPressed: _cargarRegistros,
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      locale: const Locale('es', 'ES'),
    );

    if (picked != null && picked != _fechaSeleccionada) {
      setState(() {
        _fechaSeleccionada = picked;
      });
      _cargarRegistros();
    }
  }

  void _mostrarDetallesRegistro(int id) {
    // Aquí implementarías la navegación a la pantalla de detalles
    // Por ahora, mostraremos un diálogo simple
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Detalles del Registro'),
            content: const Text(
              'Aquí se mostrarían los detalles completos del registro.',
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

  void _registrarEntrada(String trabajadorId) {
    // Convertir el ID de string a int
    final equipoId = int.tryParse(trabajadorId);
    if (equipoId == null) {
      NotificationUtils.showSnackBar(
        context: context,
        message: 'ID de trabajador inválido',
        isError: true,
      );
      return;
    }

    ref
        .read(registroDiarioNotifierProvider.notifier)
        .registrarEntrada(equipoId)
        .then((_) {
          NotificationUtils.showSnackBar(
            context: context,
            message: 'Entrada registrada correctamente',
            isError: false,
            icon: Icons.check_circle,
          );
          // Cambiar a la pestaña de registros
          _tabController.animateTo(0);
        });
  }

  void _registrarSalida(int registroId) {
    ref
        .read(registroDiarioNotifierProvider.notifier)
        .registrarSalida(registroId)
        .then((_) {
          NotificationUtils.showSnackBar(
            context: context,
            message: 'Salida registrada correctamente',
            isError: false,
            icon: Icons.check_circle,
          );
        });
  }

  void _cambiarEstadoRegistro(int registroId, bool estado) {
    ref
        .read(registroDiarioNotifierProvider.notifier)
        .cambiarEstadoRegistro(registroId, estado)
        .then((_) {
          NotificationUtils.showSnackBar(
            context: context,
            message:
                estado
                    ? 'Registro activado correctamente'
                    : 'Registro desactivado correctamente',
            isError: false,
            icon: Icons.check_circle,
          );
        });
  }

  void _escanearQR(String trabajadorId) {
    // Aquí implementarías la funcionalidad para escanear un QR
    // Por ahora, mostraremos un mensaje
    NotificationUtils.showSnackBar(
      context: context,
      message: 'Función de escaneo QR próximamente',
      isError: false,
      icon: Icons.qr_code_scanner,
    );
  }

  void _escanearQRGeneral() {
    // Aquí implementarías la funcionalidad para escanear un QR general
    // Por ahora, mostraremos un mensaje
    NotificationUtils.showSnackBar(
      context: context,
      message: 'Función de escaneo QR próximamente',
      isError: false,
      icon: Icons.qr_code_scanner,
    );
  }

  void _showFilterDialog(BuildContext context) {
    final state = ref.read(registroDiarioNotifierProvider);

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
                        'Filtrar Registros',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Filtro por tipo
                      const Text(
                        'Estado del Registro',
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
                                state.filterType == RegistroFilterType.todos,
                            onSelected: (selected) {
                              if (selected) {
                                ref
                                    .read(
                                      registroDiarioNotifierProvider.notifier,
                                    )
                                    .filtrarPorTipo(RegistroFilterType.todos);
                              }
                            },
                          ),
                          _buildFilterChip(
                            label: 'Solo Entrada',
                            selected:
                                state.filterType ==
                                RegistroFilterType.soloEntrada,
                            onSelected: (selected) {
                              if (selected) {
                                ref
                                    .read(
                                      registroDiarioNotifierProvider.notifier,
                                    )
                                    .filtrarPorTipo(
                                      RegistroFilterType.soloEntrada,
                                    );
                              }
                            },
                          ),
                          _buildFilterChip(
                            label: 'Con Salida',
                            selected:
                                state.filterType ==
                                RegistroFilterType.conSalida,
                            onSelected: (selected) {
                              if (selected) {
                                ref
                                    .read(
                                      registroDiarioNotifierProvider.notifier,
                                    )
                                    .filtrarPorTipo(
                                      RegistroFilterType.conSalida,
                                    );
                              }
                            },
                          ),
                          _buildFilterChip(
                            label: 'Inactivos',
                            selected:
                                state.filterType ==
                                RegistroFilterType.inactivos,
                            onSelected: (selected) {
                              if (selected) {
                                ref
                                    .read(
                                      registroDiarioNotifierProvider.notifier,
                                    )
                                    .filtrarPorTipo(
                                      RegistroFilterType.inactivos,
                                    );
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Filtro por trabajador
                      const Text(
                        'Trabajador',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          children: [
                            // Opción para mostrar todos los trabajadores
                            ListTile(
                              title: const Text('Todos los trabajadores'),
                              leading: Radio<int?>(
                                value: null,
                                groupValue: state.trabajadorSeleccionadoId,
                                onChanged: (value) {
                                  ref
                                      .read(
                                        registroDiarioNotifierProvider.notifier,
                                      )
                                      .filtrarPorTrabajador(null);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            // Lista de trabajadores
                            ...ref
                                .read(trabajadorNotifierProvider)
                                .trabajadores
                                .map((trabajador) {
                                  final trabajadorId = int.tryParse(
                                    trabajador.id.toString(),
                                  );
                                  return ListTile(
                                    title: Text(trabajador.nombre),
                                    subtitle: Text('Sin cargo'),
                                    leading: Radio<int?>(
                                      value: trabajadorId,
                                      groupValue:
                                          state.trabajadorSeleccionadoId,
                                      onChanged: (value) {
                                        if (value != null) {
                                          ref
                                              .read(
                                                registroDiarioNotifierProvider
                                                    .notifier,
                                              )
                                              .filtrarPorTrabajador(value);
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                  );
                                })
                                .toList(),
                          ],
                        ),
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

  String _formatDateRange() {
    if (_fechaInicio == null && _fechaFin == null) {
      return 'Seleccionar rango';
    }

    if (_fechaInicio != null && _fechaFin == null) {
      return 'Desde ${DateFormat('dd/MM/yyyy').format(_fechaInicio!)}';
    }

    if (_fechaInicio == null && _fechaFin != null) {
      return 'Hasta ${DateFormat('dd/MM/yyyy').format(_fechaFin!)}';
    }

    return '${DateFormat('dd/MM/yyyy').format(_fechaInicio!)} - ${DateFormat('dd/MM/yyyy').format(_fechaFin!)}';
  }

  Future<void> _selectDateRange(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(2020);
    DateTime lastDate = DateTime(2025, 1, 1); // Última fecha permitida

    // Si _fechaInicio o _fechaFin están fuera del rango, ajustarlas
    DateTime startDate = _fechaInicio ?? now.subtract(const Duration(days: 7));
    DateTime endDate = _fechaFin ?? now;

    if (startDate.isAfter(lastDate)) startDate = lastDate;
    if (endDate.isAfter(lastDate)) endDate = lastDate;
    if (startDate.isAfter(endDate))
      startDate = endDate; // Evita errores en el rango

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: startDate, end: endDate),
      firstDate: firstDate,
      lastDate: lastDate,
      locale: const Locale('es', 'ES'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _fechaInicio = picked.start;
        _fechaFin = picked.end;
      });

      final ubicacionState = ref.read(ubicacionNotifierProvider);
      if (ubicacionState.ubicacion != null &&
          ubicacionState.ubicacion!.id != null) {
        ref
            .read(registroDiarioNotifierProvider.notifier)
            .cargarRegistrosPorRango(
              ubicacionState.ubicacion!.id.toString(),
              fechaInicio: _fechaInicio,
              fechaFin: _fechaFin,
            );
      }
    }
  }
}
