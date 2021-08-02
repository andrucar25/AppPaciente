import 'dart:async';

class Validators {
  final emailValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no es correcto');
    }
  });

  final passwordValidate = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Ingrese más de 6 caracteres por favor');
    }
  });

  final nonullValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.length >= 1) {
      sink.add(data);
    } else {
      sink.addError('Complete este campo por favor');
    }
  });
  final phoneValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    Pattern pattern = r'^[0-9]+$';
    RegExp regExp = new RegExp(pattern);
    if (data.length == 9 && regExp.hasMatch(data)) {
      sink.add(data);
    } else {
      sink.addError('Complete este campo porfavor');
    }
  });
}
