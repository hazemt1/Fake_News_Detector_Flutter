import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_news/models/Article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class NewsItem extends StatefulWidget {
  final Article article;
  // ignore: use_key_in_widget_constructors
  const NewsItem(this.article);

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  bool clicked = false;

  late DateTime date = DateTime.parse(widget.article.publishedAt);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              clicked = !clicked;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).shadowColor,
              borderRadius: BorderRadius.circular(16),
            ),
            width: 800,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: widget.article.urlToImage != ""
                          ? CachedNetworkImage(
                              imageUrl: widget.article.urlToImage,
                              // width: double.infinity,
                              // fit: BoxFit.fill,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              },
                            )
                          : Container(),
                    ),
                  ],
                ),
                Text(
                  widget.article.source.name,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.start,
                ),
                Text(
                  widget.article.title,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyText2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (clicked)
                  Text(
                    widget.article.description,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.start,
                  )
                else
                  Container(),
                if (clicked)
                  Wrap(
                    children: [
                      InkWell(
                        onTap: _launchUrl,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16, top: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 42, vertical: 12),
                          child: Text(
                            AppLocalizations.of(context)!.info,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Container(),
                Text(
                  date.day == DateTime.now().day
                      ? DateFormat.Hms().format(date) +
                          DateFormat.MMMMEEEEd().format(date)
                      : DateFormat.MMMMEEEEd().format(date),
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _launchUrl() async {
    if (!await launchUrl(Uri.parse(widget.article.url)))
      throw 'Could not launch ${widget.article.url}';
  }
}
