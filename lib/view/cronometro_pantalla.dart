import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/cronometro_vm.dart';
import '../model/vuelta.dart';

class CronometroPantalla extends StatelessWidget {
  const CronometroPantalla({super.key});

  String formato(Duration d) {
    final min = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seg = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final mil = (d.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');
    return '$min:$seg:$mil';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronómetro de Vueltas'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Consumer<CronometroVM>(
        builder: (contexto, vm, _) {
          final tiempo = vm.tiempoActual;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Semantics(
                label: 'Imagen decorativa de un cronómetro',
                child: Image.network(
                  'https://static.vecteezy.com/system/resources/previews/024/096/373/non_2x/chronometer-timer-counter-free-png.png',
                  height: 120,
                  semanticLabel: 'Cronómetro decorativo',
                ),
              ),

              const SizedBox(height: 20),

              Semantics(
                label: 'Tiempo actual del cronómetro',
                value: formato(tiempo),
                child: Text(
                  formato(tiempo),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Semantics(
                    button: true,
                    label: 'Reiniciar cronómetro',
                    child: ElevatedButton(
                      onPressed: vm.reiniciar,
                      child: const Text('Reiniciar'),
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: vm.enMarcha ? 'Pausar cronómetro' : 'Iniciar cronómetro',
                    child: ElevatedButton(
                      onPressed: vm.enMarcha ? vm.pausar : vm.iniciar,
                      child: Text(vm.enMarcha ? 'Pausar' : 'Iniciar'),
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: 'Registrar vuelta',
                    child: ElevatedButton(
                      onPressed: vm.enMarcha ? vm.agregarVuelta : null,
                      child: const Text('Vuelta'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Semantics(
                  label: 'Lista de vueltas registradas',
                  child: ListView.builder(
                    itemCount: vm.vueltas.length,
                    itemBuilder: (contexto, i) {
                      final vueltasReversa = vm.vueltas.reversed.toList();
                      final vuelta = vueltasReversa[i];
                      final numero = vm.vueltas.length - i;

                      return ListTile(
                        title: Text(
                          'Vuelta $numero',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Tiempo: ${formato(vuelta.tiempoVuelta)} | Total: ${formato(vuelta.tiempoTotal)}',
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
