import 'package:rxdart/rxdart.dart';

import 'package:applaluz/models/Laboratorio.dart';
import 'package:applaluz/providers/laboratorio_provider.dart';

class LaboratorioBloc {
  final laboratorioController = new BehaviorSubject<List<Laboratorio>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _laboratorioProvider = new LaboratorioProvider();

  Stream<List<Laboratorio>> get laboratorioStream => laboratorioController.stream;
  Stream<bool> get loading => _loadingController.stream;

  Future getLaboratoriosData() async {
    final laboratorio = await _laboratorioProvider.getLaboratorio();
    laboratorioController.sink.add(laboratorio);
    return true;
  }

  dispose() {
    laboratorioController?.close();
    _loadingController?.close();
  }
}
