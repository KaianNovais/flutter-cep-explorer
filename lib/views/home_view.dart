import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cep_controller.dart';
import '../models/cep_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _cepController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consulta CEP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _cepController,
                decoration: const InputDecoration(labelText: 'CEP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um CEP válido';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await Provider.of<CepController>(context, listen: false)
                        .fetchCep(_cepController.text);
                  }
                  _cepController.clear();
                },
                child: const Text('Consultar'),
              ),
              Consumer<CepController>(
                builder: (context, cepController, child) {
                  if (cepController.isLoading) {
                    return const CircularProgressIndicator();
                  } else if (cepController.cepModel != null) {
                    return _buildCepCard(cepController.cepModel!);
                  } else {
                    return const Text('Nenhum resultado encontrado');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCepCard(CepModel cepModel) {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CEP: ${cepModel.cep}'),
            Text('Logradouro: ${cepModel.logradouro}'),
            Text('Complemento: ${cepModel.complemento}'),
            Text('Bairro: ${cepModel.bairro}'),
            Text('Localidade: ${cepModel.localidade}'),
            Text('UF: ${cepModel.uf}'),
          ],
        ),
      ),
    );
  }
}
