import 'package:fake_news/Api/ReviewApi.dart';
import 'package:fake_news/bloc/user/user_bloc.dart';
import 'package:fake_news/models/Review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CreateNewReview extends StatefulWidget {
  final String? userReview;
  final int? userRating;
  final Function callback;
  const CreateNewReview({
    Key? key,
    this.userReview,
    this.userRating,
    required this.callback,
  }) : super(key: key);

  @override
  State<CreateNewReview> createState() => _CreateNewReviewState();
}

class _CreateNewReviewState extends State<CreateNewReview> {
  final formKey = GlobalKey<FormState>();
  late String review = widget.userReview ?? '';
  late int rating = widget.userRating ?? 5;
  bool errorFlag = false;
  String error = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      content: Form(
        key: formKey,
        child: Container(
          width: 950,
          constraints: const BoxConstraints(
            maxHeight: 900,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocalizations.of(context)!.addReview),
              const SizedBox(
                height: 20,
              ),
              if (errorFlag)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red)),
                  child: Text(error,style: Theme.of(context).textTheme.bodyText1,),
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.rating,
                  ),
                  RatingBar.builder(
                    initialRating: rating.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemSize: 30,
                    tapOnlyMode: true,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (r) => rating = r.toInt(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                constraints: const BoxConstraints(maxHeight: 700),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                ),
                child: TextFormField(
                  initialValue: review,
                  onChanged: (t) => review = t,
                  maxLines: null,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      errorFlag = false;
                      error = "";
                      String res='';
                      if(widget.userReview == null){
                        res = await ReviewApi.createReview(
                          BlocProvider.of<UserBloc>(context).state.logInfo.token!,
                          Review(review: review, rate: rating),
                        );
                      }else{
                        print(rating);
                        res = await ReviewApi.updateReview(
                          BlocProvider.of<UserBloc>(context).state.logInfo.token!,
                          Review(review: review, rate: rating),
                        );
                      }

                      if(res!=''){
                        setState((){
                          errorFlag=true;
                          error=res;
                        });
                      }else{
                        widget.callback();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.submit,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (widget.userReview != null)
                    InkWell(
                      onTap: (){
                        ReviewApi.deleteReview(BlocProvider.of<UserBloc>(context).state.logInfo.token!,);
                        widget.callback();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.deleteReview,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
