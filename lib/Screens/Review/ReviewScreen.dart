import 'package:fake_news/Api/ReviewApi.dart';
import 'package:fake_news/Screens/Review/widgets/CreateNewReview.dart';
import 'package:fake_news/Screens/Review/widgets/ReviewItem.dart';
import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:fake_news/Widgets/CustomDrawer.dart';
import 'package:fake_news/bloc/user/user_bloc.dart';
import 'package:fake_news/models/Review.dart';
import 'package:fake_news/utils/Routes.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late Review? review;
  late List<Review> reviews;
  Future<List<Review>> _getReviews() async {
    reviews = await ReviewApi.getAllReviews(
        BlocProvider.of<UserBloc>(context).state.logInfo.token!);
    // setState(() {});
    return reviews;
  }

  _getReview() async {
    review = await ReviewApi.getReview(
        BlocProvider.of<UserBloc>(context).state.logInfo.token!);
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
      _getReviews();
      _getReview();
    }
  }

  onAddReview()async {
    _getReview();
    _getReviews();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(
        appBar: AppBar(),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context){
              return CreateNewReview(
                userRating: review?.rate,
                userReview: review?.review,
                callback: onAddReview,
              );
            });

        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(AppLocalizations.of(context)!.addReview),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
        child: FutureBuilder(
          future: _getReviews(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: ReviewItem(
                      date: snapshot.data![index].date!,
                      name: snapshot.data![index].userName ?? '',
                      rate: snapshot.data![index].rate,
                      review: snapshot.data![index].review,
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
