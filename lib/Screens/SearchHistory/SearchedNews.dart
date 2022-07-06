import 'package:fake_news/Api/NewsAPI.dart';
import 'package:fake_news/Screens/SearchHistory/widgets/HistoryItem.dart';
import 'package:fake_news/models/News.dart';
import 'package:flutter/material.dart';

class SearchedNews extends StatefulWidget {
  const SearchedNews({Key? key}) : super(key: key);

  @override
  State<SearchedNews> createState() => _SearchedNewsState();
}

class _SearchedNewsState extends State<SearchedNews> {
  late List<News> news;
  Future<List<News>> _getNews() async {
    news = await NewsAPI.getSearchedNews();
    // setState(() {});
    news = news.reversed.toList();
    return news;
  }

  @override
  initState() {
    super.initState();
      _getNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getNews(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Center(
                child: HistoryItem(news: snapshot.data![index],inHistory: false,),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
