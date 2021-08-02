import 'package:applaluz/models/HorarioMedico.dart';
import 'package:rxdart/rxdart.dart';

import 'package:applaluz/providers/medico_provider.dart';

class HorarioMedicoBloc {
  final horarioMedicoController = new BehaviorSubject<List<HorarioMedico>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _medicoProvider = new MedicoProvider();

  Stream<List<HorarioMedico>> get horarioMedicoStream =>
      horarioMedicoController.stream;
  Stream<bool> get loading => _loadingController.stream;

  Future getHorarioMedicoData(int mes, int idMedico) async {
    _loadingController.sink.add(true);
    final medico = await _medicoProvider.getHorarioMedicos(mes, idMedico);
    horarioMedicoController.sink.add(medico);
    _loadingController.sink.add(false);
    return true;
  }

  dispose() {
    horarioMedicoController?.close();
    _loadingController?.close();
  }
}
