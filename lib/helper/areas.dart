class Areas {
  Areas({
    this.title = '',
    this.imagePath = '',
    this.responsable = '',
    this.area = 0,
  });

  String title;
  String imagePath;
  String responsable;
  int area;

  static List<Areas> areasList = <Areas>[
    Areas(
        imagePath: 'assets/images/areas/biometria.png',
        title: 'Biometría Hemática',
        area: 0,
        responsable: 'Carlos Paredes'),
    Areas(
        imagePath: 'assets/images/areas/orina.png',
        title: 'Examen general de orina',
        area: 1,
        responsable: 'Armando Cuadros'),
    Areas(
        imagePath: 'assets/images/areas/gruposanguineo.png',
        title: 'Grupo sanguíneo',
        area: 2,
        responsable: 'Mariana Zeballos'),
    Areas(
        imagePath: 'assets/images/areas/embarazo.png',
        title: 'Prueba de embarazo',
        area: 3,
        responsable: 'Manuel Ramirez'),
    Areas(
        imagePath: 'assets/images/areas/reumatico.png',
        title: 'Perfil reumático',
        area: 4,
        responsable: 'David Robles'),
    Areas(
        imagePath: 'assets/images/areas/hepatologia.png',
        title: 'Pruebas de funcionamiento hepático',
        area: 5,
        responsable: 'Andrea Flores'),
  ];
}
