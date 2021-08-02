class Especialidades {
  Especialidades({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;

  static List<Especialidades> categoryList = <Especialidades>[
    Especialidades(
      imagePath: 'assets/images/especialidades/interFace1.png',
      title: 'Reumatología',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Especialidades(
      imagePath: 'assets/images/especialidades/interFace2.png',
      title: 'Gastroenterología',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
    Especialidades(
      imagePath: 'assets/images/especialidades/interFace3.png',
      title: 'Fisiatría y Rehabilitación',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Especialidades(
      imagePath: 'assets/images/especialidades/interFace4.png',
      title: 'Oftalmología',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
    Especialidades(
      imagePath: 'assets/images/especialidades/interFace5.png',
      title: 'Neumología',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
    Especialidades(
      imagePath: 'assets/images/especialidades/interFace6.png',
      title: 'Cardiologia',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
  ];
}
