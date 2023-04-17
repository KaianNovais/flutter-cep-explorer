import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/cep_model.dart';

class CepController with ChangeNotifier {
  CepModel? _cepModel;
  bool _isLoading = false;

  CepModel? get cepModel => _cepModel;
  bool get isLoading => _isLoading;

  Future<void> fetchCep(String cep) async {
    _setIsLoading(true);

    final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    if (response.statusCode == 200) {
      _cepModel = CepModel.fromJson(json.decode(response.body));
    } else {
      _cepModel = null;
    }

    _setIsLoading(false);
  }

  void _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
