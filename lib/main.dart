import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/cronometro_vm.dart';
import 'view/cronometro_pantalla.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CronometroVM(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: CronometroPantalla(),
      ),
    ),
  );
}
