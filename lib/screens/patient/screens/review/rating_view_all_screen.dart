import 'package:flutter/material.dart';
import 'package:solidcare/components/internet_connectivity_widget.dart';
import 'package:solidcare/components/no_data_found_widget.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/rating_model.dart';
import 'package:solidcare/network/review_repository.dart';
import 'package:solidcare/screens/patient/screens/review/component/review_widget.dart';
import 'package:solidcare/screens/shimmer/screen/review_rating_shimmer_screen.dart';
import 'package:solidcare/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

class RatingViewAllScreen extends StatefulWidget {
  final int doctorId;

  RatingViewAllScreen({required this.doctorId});

  @override
  State<RatingViewAllScreen> createState() => _RatingViewAllScreenState();
}

class _RatingViewAllScreenState extends State<RatingViewAllScreen> {
  Future<List<RatingData>>? future;

  int page = 1;
  bool isLastPage = false;

  List<RatingData> ratingList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = doctorReviewsListAPI(
      ratingList: ratingList,
      doctorId: widget.doctorId.validate(),
      page: page,
      lastPageCallback: (b) => isLastPage = b,
    ).then((value) {
      appStore.setLoading(false);
      return value;
    }).catchError((e) {
      appStore.setLoading(false);
      throw e;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        locale.lblRatingsAndReviews,
        textColor: Colors.white,
        systemUiOverlayStyle: defaultSystemUiOverlayStyle(context),
      ),
      body: InternetConnectivityWidget(
        retryCallback: () {
          init();
        },
        child: SnapHelperWidget<List<RatingData>>(
          future: future,
          loadingWidget: ReviewRatingShimmerScreen(),
          onSuccess: (data) {
            if (data.isNotEmpty) {
              return AnimatedListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(16),
                itemCount: data.length,
                itemBuilder: (context, index) =>
                    ReviewWidget(data: data[index]),
              );
            } else {
              return NoDataFoundWidget(
                text: locale.lblNoReviewsFound,
              ).center();
            }
          },
        ),
      ),
    );
  }
}
