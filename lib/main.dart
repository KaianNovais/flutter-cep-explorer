import 'package:flutter/material.dart';
import 'package:flutter_cep/views/home_view.dart';
import 'package:provider/provider.dart';

import 'controllers/cep_controller.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CepController(),
      child: MaterialApp(
        title: 'Consulta CEP',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeView(),
      ),
    );
  }
}