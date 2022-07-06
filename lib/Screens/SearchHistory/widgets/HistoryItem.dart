import 'package:fake_news/Api/NewsAPI.dart';
import 'package:fake_news/bloc/setting/setting_bloc.dart';
import 'package:fake_news/bloc/user/user_bloc.dart';
import 'package:fake_news/models/News.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HistoryItem extends StatelessWidget {
  final News news;
  final bool inHistory;
  final Function? callback;
  HistoryItem({Key? key,required this.news,required this.inHistory,this.callback}) : super(key: key);
  late final DateTime dateTime = DateTime.parse(news.date);
  double result=0;
  bool tf =true;
  @override
  Widget build(BuildContext context) {
    if (news.acc < 0.5) {
      tf = false;
      result = (1 - news.acc) * 100;
    } else {
      tf = true;
      result = news.acc * 100;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: 1000,
      constraints: const BoxConstraints(
        minWidth: 500,
        maxWidth: 2000,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).shadowColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.news),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical:10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).colorScheme.primary)
            ),
            child: Text(
              news.description,
            ),
          ),
          const SizedBox(height: 20,),
          Row(children: [
            Container(
              padding:
              const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5),
              decoration: BoxDecoration(
                color: tf
                    ? Colors.greenAccent
                    : Colors.redAccent,
                borderRadius:
                BorderRadius.circular(8),
                border: Border.all(
                  color: tf
                      ? Colors.greenAccent
                      : Colors.redAccent,
                ),
              ),
              child: Text(
                tf
                    ? AppLocalizations.of(
                    context)!
                    .fact
                    : AppLocalizations.of(
                    context)!
                    .fake,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!
                    .confidence +
                    result.toStringAsFixed(2),

              ),
            ),
            if(inHistory)
            InkWell(
              onTap: (){
                NewsAPI.deleteNews(BlocProvider.of<UserBloc>(context).state.logInfo.token!,news.id!);
                callback!();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  AppLocalizations.of(context)!.delete,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ],),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Spacer(),
              Text(
                DateFormat.MMMMEEEEd(BlocProvider.of<SettingBloc>(context)
                    .state
                    .settings
                    .currentLocale)
                    .format(dateTime),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
