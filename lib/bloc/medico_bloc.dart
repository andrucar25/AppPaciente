import 'package:rxdart/rxdart.dart';

import 'package:applaluz/models/Medico.dart';
import 'package:applaluz/providers/medico_provider.dart';

class MedicoBloc {
  final medicoController = new BehaviorSubject<List<Medico>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _medicoProvider = new MedicoProvider();

  Stream<List<Medico>> get medicoStream => medicoController.stream;
  Stream<bool> get loading => _loadingController.stream;

  Future getMedicosData() async {
    final medico = await _medicoProvider.getMedicos();
    medicoController.sink.add(medico);
    return true;
  }

  dispose() {
    medicoController?.close();
    _loadingController?.close();
  }
}
