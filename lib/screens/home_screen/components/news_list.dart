import 'package:applaluz/helper/news.dart';

import 'news_list_view.dart';

newsList() {
  return NewsListView(
    callback: () {},
    newsData: NewslistData.newsData,
  );
}
