import 'package:fake_news/Api/TrendingAPI.dart';
import 'package:fake_news/Screens/Trending/NewsFragment.dart';
import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:fake_news/Widgets/CustomDrawer.dart';
import 'package:fake_news/models/NewsResponse.dart';
import 'package:flutter/material.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  int page = 2;
  late Future<NewsResponse> newsSources;

  @override
  void initState() {
    newsSources = getTrending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(
        appBar: AppBar(),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/pattern.png"),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          color: Theme.of(context).primaryColor,
        ),
        child: FutureBuilder<NewsResponse>(
          future: newsSources,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return ListView.builder(

                itemCount: snapShot.data!.articles.length,

                itemBuilder: (context, index) {
                  return NewsItem(snapShot.data!.articles[index]);
                },
              );
            } else if (snapShot.hasError) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 210, bottom: 40),
                    child: const Text(
                      "Error Loading Data!\nTry A gain!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  // FloatingActionButton(
                  //   onPressed: _refreshData,
                  //   child: const Icon(Icons.refresh),
                  // ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
  // Future _refreshData() async {
  //   await Future.delayed(const Duration(milliseconds: 1));
  //   newsSources = getTrending(page: page++);
  //   setState(() {});
  // }
}
