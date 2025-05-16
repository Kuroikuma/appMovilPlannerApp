import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/injection_container.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'presentation/providers/auto_refresher_provider.dart';
import 'presentation/providers/use_case/internet_status_provider.dart';
import 'presentation/routes/app_routes.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies(); // 👈 Inicializa las dependencias
  await initializeDateFormatting('es_ES', null);

  // Configuración adicional si es necesaria
  // getIt<SyncManager>().startSyncInterval(Duration(minutes: 15));
  runApp(
    ProviderScope(
      // Envuelve toda la app con ProviderScope
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // Iniciar el refresco automático de trabajadores
    Future.microtask(() {
      ref.read(autoRefresherProvider);
      ref.read(internetStatusProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 63, 125),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'),
        Locale('en', ''),
      ],
      locale: const Locale('es', 'ES'),
      initialRoute: AppRoutes.main,
      routes: AppRoutes.getRoutes(),
      builder: (context, child) {
        return ScaffoldMessenger(child: child ?? Container());
      },
    );
  }
}
