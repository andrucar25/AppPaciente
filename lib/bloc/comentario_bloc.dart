import 'package:rxdart/rxdart.dart';

import 'package:applaluz/models/Comentario.dart';
import 'package:applaluz/providers/commentary_provider.dart';

class ComentarioBloc {
  final comentarioController = new BehaviorSubject<List<Comentario>>();
  final _loadingController = new BehaviorSubject<bool>();
  final _comentarioProvider = new CommentaryProvider();

  Stream<List<Comentario>> get comentarioStream => comentarioController.stream;
  Stream<bool> get loading => _loadingController.stream;

  Future getComentariosMedico(int idMedico) async {
    final comentariosMedico = await _comentarioProvider.getCommentaryMedic(idMedico);
    comentarioController.sink.add(comentariosMedico);
    return true;
  }

  dispose() {
    comentarioController?.close();
    _loadingController?.close();
  }
}
