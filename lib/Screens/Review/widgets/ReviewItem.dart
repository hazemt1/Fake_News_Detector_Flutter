import 'package:fake_news/bloc/setting/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ReviewItem extends StatelessWidget {
  final String name;
  final String review;
  final int rate;
  final String date;
  ReviewItem(
      {Key? key,
        required this.name,
        required this.rate,
        required this.review,
        required this.date})
      : super(key: key);
  late DateTime dateTime = DateTime.parse(date);

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primary, width: 2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.rating,
              ),
              RatingBar.builder(
                initialRating: rate.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                itemSize: 30,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                ignoreGestures: true,
                onRatingUpdate: (_){},
              ),
            ],
          ),
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
              review,
            ),
          ),
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
