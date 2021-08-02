import 'package:flutter/material.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:applaluz/screens/home_screen/home_screen.dart';

List<MenuItem> items = [
  new MenuItem<int>(id: 0, title: 'Inicio', prefix: Icon(Icons.home)),
  new MenuItem<int>(
      id: 1, title: 'Mi Usuario', prefix: Icon(Icons.person), data: HomeScreen),
  new MenuItem<int>(
      id: 2, title: 'Preguntas Frecuentes', prefix: Icon(Icons.help)),
  new MenuItem<int>(id: 3, title: 'Politicas', prefix: Icon(Icons.gavel)),
  new MenuItem<int>(id: 4, title: 'Reclamos', prefix: Icon(Icons.menu_book)),
  new MenuItem<int>(id: 5, title: 'Cerrar Sesion', prefix: Icon(Icons.logout)),
];
final menu = Menu(
  items: items.map((e) => e.copyWith(prefix: null)).toList(),
);

final menuWithIcon = Menu(
  items: items,
);
