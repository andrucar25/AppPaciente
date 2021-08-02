import 'package:rxdart/rxdart.dart';

import 'package:applaluz/models/Teleconsulta.dart';
import 'package:applaluz/providers/teleconsulta_provider.dart';

class TeleconsultaBloc {
  final teleconsultaController = new BehaviorSubject<List<Teleconsulta>>();
  final _loadingController = new BehaviorSubject<bool>();
  final _teleconsultaProvider = new TeleconsultaProvider();

  Stream<List<Teleconsulta>> get teleconsultaStream => teleconsultaController.stream;
  Stream<bool> get loading => _loadingController.stream;

  Future getTeleconsultasPendientes() async {
    final teleconsultasPendientes = await _teleconsultaProvider.getTeleconsultaPendiente();
    teleconsultaController.sink.add(teleconsultasPendientes);
    return true;
  }
    Future getTeleconsultaHistorial() async {
    final teleconsultasHistorial = await _teleconsultaProvider.getTeleconsultaHistorial();
    teleconsultaController.sink.add(teleconsultasHistorial);
    return true;
  }
  Future addTeleconsulta(int idMedico, String fechaHora) async {
    _loadingController.sink.add(true);
    await _teleconsultaProvider.storeTeleconsulta(idMedico, fechaHora);
    _loadingController.sink.add(false);
  }

  dispose() {
    teleconsultaController?.close();
    _loadingController?.close();
  }
}
