import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'view/cronometro_pantalla.dart';
import 'view_model/cronometro_vm.dart';

final FlutterLocalNotificationsPlugin notificaciones = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initSettings = InitializationSettings(android: androidInit);
  await notificaciones.initialize(initSettings);

  runApp(const CronometroApp());
}

class CronometroApp extends StatelessWidget {
  const CronometroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CronometroVM(),
      child: MaterialApp(
        title: 'Cronómetro de Vueltas',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFE0F7FA), // celeste claro
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            primary: const Color(0xFF424242), // gris oscuro
            onPrimary: Colors.white, // texto blanco en botones
            onSurface: Colors.black, // texto general negro
          ),
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF424242),
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
            bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        home: const CronometroPantalla(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
