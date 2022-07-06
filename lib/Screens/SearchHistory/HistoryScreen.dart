import 'package:fake_news/Api/NewsAPI.dart';
import 'package:fake_news/Screens/SearchHistory/widgets/HistoryItem.dart';
import 'package:fake_news/bloc/user/user_bloc.dart';
import 'package:fake_news/models/News.dart';
import 'package:fake_news/utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late List<News> news;
  Future<List<News>> _getNews() async {
    news = await NewsAPI.getHistory(
        BlocProvider.of<UserBloc>(context).state.logInfo.token!);
    news = news.reversed.toList();
    // setState(() {});
    return news;
  }

  onDeleteNews() {
    _getNews();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    if (!BlocProvider.of<UserBloc>(context).state.logInfo.isLoggedIn) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(homeRoute);
      });
    } else {
      _getNews();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getNews(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.length == 0) {
            return Center( child: Text(AppLocalizations.of(context)!.noHistory),);
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Center(
                  child: HistoryItem(
                    news: snapshot.data![index],
                    inHistory: true,
                    callback: onDeleteNews,
                  ),
                );
              },
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
