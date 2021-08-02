class NewslistData {
  NewslistData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int perNight;

  static NewslistData newsData = NewslistData(
    imagePath: 'assets/images/news/news_1.png',
    titleTxt: 'SECUELAS DEL COVID-19 EN EL CORAZÓN',
    subTxt: 'Febrero 03, 2021',
    dist: 2.0,
    reviews: 80,
    rating: 4.4,
    perNight: 180,
  );
}
