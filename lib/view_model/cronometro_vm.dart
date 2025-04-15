import 'dart:async';
import 'package:flutter/material.dart';
import '../model/vuelta.dart';
import '../main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class CronometroVM extends ChangeNotifier {
  final Stopwatch _cronometro = Stopwatch();
  Timer? _temporizador;
  final List<Vuelta> _vueltas = [];

  bool get enMarcha => _cronometro.isRunning;
  Duration get tiempoActual => _cronometro.elapsed;
  List<Vuelta> get vueltas => List.unmodifiable(_vueltas);

  void iniciar() {
    _cronometro.start();
    _temporizador = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) => notifyListeners(),
    );

    _mostrarNotificacionPersistente(
      'Cronómetro en marcha',
      'El cronómetro está activo.',
    );

    notifyListeners();
  }

  void pausar() {
    _cronometro.stop();
    _temporizador?.cancel();
    _ocultarNotificacion();
    notifyListeners();
  }

  void reiniciar() {
    _cronometro.reset();
    _vueltas.clear();
    _temporizador?.cancel();
    _ocultarNotificacion();
    notifyListeners();
  }

  void agregarVuelta() {
    final total = _cronometro.elapsed;
    final anterior = _vueltas.isNotEmpty ? _vueltas.last.tiempoTotal : Duration.zero;
    final diferencia = total - anterior;

    _vueltas.add(Vuelta(
      tiempoVuelta: diferencia,
      tiempoTotal: total,
    ));

    _mostrarNotificacionUnaVez(
      'Vuelta registrada',
      'Vuelta: ${_formato(diferencia)} | Total: ${_formato(total)}',
    );

    notifyListeners();
  }

  void _mostrarNotificacionPersistente(String titulo, String cuerpo) async {
    const detalles = AndroidNotificationDetails(
      'cronometro_id',
      'Cronómetro',
      channelDescription: 'Notificaciones del cronómetro de vueltas',
      importance: Importance.high,
      priority: Priority.high,
      ongoing: true,
    );

    await notificaciones.show(
      0,
      titulo,
      cuerpo,
      const NotificationDetails(android: detalles),
    );
  }



  void _mostrarNotificacionUnaVez(String titulo, String cuerpo) async {
    const detalles = AndroidNotificationDetails(
      'vuelta_id',
      'Vueltas',
      channelDescription: 'Notificación de vuelta registrada',
      importance: Importance.high,
      priority: Priority.high,
    );

    await notificaciones.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      titulo,
      cuerpo,
      const NotificationDetails(android: detalles),
    );
  }


  

  void _ocultarNotificacion() async {
    await notificaciones.cancel(0);
  }

  String _formato(Duration d) {
    final min = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seg = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final mil = (d.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');
    return '$min:$seg:$mil';
  }
}
