import 'dart:async';
import 'package:flutter/material.dart';
import '../model/vuelta.dart';

class CronometroVM extends ChangeNotifier {
  final Stopwatch _cronometro = Stopwatch();
  Timer? _temporizador;
  final List<Vuelta> _vueltas = [];

  List<Vuelta> get vueltas => List.unmodifiable(_vueltas);
  Duration get tiempoActual => _cronometro.elapsed;
  bool get enMarcha => _cronometro.isRunning;

  void iniciar() {
    _cronometro.start();
    _temporizador = Timer.periodic(Duration(milliseconds: 100), (_) => notifyListeners());
    notifyListeners();
  }

  void pausar() {
    _cronometro.stop();
    _temporizador?.cancel();
    notifyListeners();
  }

  void reiniciar() {
    _cronometro.reset();
    _vueltas.clear();
    _temporizador?.cancel();
    notifyListeners();
  }

  void agregarVuelta() {
    final total = _cronometro.elapsed;
    final anterior = _vueltas.isNotEmpty ? _vueltas.last.tiempoTotal : Duration.zero;
    final diferencia = total - anterior;
    _vueltas.add(Vuelta(tiempoVuelta: diferencia, tiempoTotal: total));
    notifyListeners();
  }
}