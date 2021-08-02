import 'package:applaluz/bloc/comentario_bloc.dart';
import 'package:applaluz/bloc/horario_medico_bloc.dart';
import 'package:applaluz/bloc/paciente_bloc.dart';
import 'package:applaluz/bloc/medico_bloc.dart';
import 'package:applaluz/bloc/teleconsulta_bloc.dart';
import 'package:applaluz/bloc/laboratorio_bloc.dart';
import 'package:flutter/material.dart';

import 'login_bloc.dart';
export 'login_bloc.dart';

class MainProvider extends InheritedWidget {
  final loginBloc = LoginBloc();
  final _pacienteBloc = PacienteBloc();
  final _medicoBloc = MedicoBloc();
  final _horarioMedicoBloc = HorarioMedicoBloc();
  final _teleconsultaBloc = TeleconsultaBloc();
  final _laboratorioBloc = LaboratorioBloc();
  final _comentarioBloc = ComentarioBloc();

  static MainProvider _instancia;

  factory MainProvider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new MainProvider._internal(key: key, child: child);
    }

    return _instancia;
  }

  MainProvider._internal({Key key, Widget child})
      : super(key: key, child: child);

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainProvider>().loginBloc;
  }

  static PacienteBloc pacienteBloc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MainProvider>()
        ._pacienteBloc;
  }

  static MedicoBloc medicoBloc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MainProvider>()
        ._medicoBloc;
  }

  static TeleconsultaBloc teleconsultaBloc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MainProvider>()
        ._teleconsultaBloc;
  }

  static HorarioMedicoBloc horarioMedicoBLoc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MainProvider>()
        ._horarioMedicoBloc;
  }
    static LaboratorioBloc laboratorioBLoc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MainProvider>()
        ._laboratorioBloc;
  }

    static ComentarioBloc comentarioBLoc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MainProvider>()
        ._comentarioBloc;
  }
}
