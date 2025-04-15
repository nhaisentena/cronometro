import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/cronometro_vm.dart';

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
      appBar: AppBar(title: Text('Cronómetro')),
      body: Consumer<CronometroVM>(
        builder: (contexto, vm, _) {
          final tiempo = vm.tiempoActual;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formato(tiempo),
                style: TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: vm.reiniciar,
                    child: Text('Reiniciar'),
                  ),
                  ElevatedButton(
                    onPressed: vm.enMarcha ? vm.pausar : vm.iniciar,
                    child: Text(vm.enMarcha ? 'Pausar' : 'Iniciar'),
                  ),
                  ElevatedButton(
                    onPressed: vm.enMarcha ? vm.agregarVuelta : null,
                    child: Text('Vuelta'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: vm.vueltas.length,
                  itemBuilder: (contexto, i) {
                    final vuelta = vm.vueltas.reversed.toList()[i];
                    final numero = vm.vueltas.length - i;
                    return ListTile(
                      title: Text('Vuelta $numero'),
                      subtitle: Text(
                        'Tiempo: ${formato(vuelta.tiempoVuelta)}  |  Total: ${formato(vuelta.tiempoTotal)}',
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}