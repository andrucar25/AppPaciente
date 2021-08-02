import 'package:rxdart/rxdart.dart';

import 'package:applaluz/models/Paciente.dart';
import 'package:applaluz/providers/paciente_provider.dart';

class PacienteBloc {
  final pacienteController = new BehaviorSubject<Paciente>();
  final _loadingController = new BehaviorSubject<bool>();

  final _pacienteProvider = new PacienteProvider();

  Stream<Paciente> get customerStream => pacienteController.stream;
  Stream<bool> get loading => _loadingController.stream;

  Future getPacienteData() async {
    final paciente = await _pacienteProvider.getPacienteData();
    pacienteController.sink.add(paciente);
    return true;
  }

  dispose() {
    pacienteController?.close();
    _loadingController?.close();
  }
}
