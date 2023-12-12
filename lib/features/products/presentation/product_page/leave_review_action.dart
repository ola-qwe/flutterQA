import 'package:flutter_qa/localization/string_hardcoded.dart';
import 'package:flutter_qa/features/orders/domain/purchase.dart';
import 'package:flutter_qa/route/route_app.dart';
import 'package:flutter_qa/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qa/common_widgets/custom_text_button.dart';
import 'package:flutter_qa/common_widgets/responsive_two_column_layout.dart';
import 'package:flutter_qa/constants/app_sizes.dart';
import 'package:go_router/go_router.dart';

/// Simple widget to show the product purchase date along with a button to
/// leave a review.
class LeaveReviewAction extends StatelessWidget {
  const LeaveReviewAction({Key? key, required this.productId})
      : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source
    final purchase = Purchase(orderId: 'abc', orderDate: DateTime.now());
    if (purchase != null) {
      // TODO: Inject date formatter
      final dateFormatted = kDateFormatter.format(purchase.orderDate);
      return Column(
        children: [
          const Divider(),
          gapH8,
          ResponsiveTwoColumnLayout(
            spacing: Sizes.p16,
            breakpoint: 300,
            startFlex: 3,
            endFlex: 2,
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            rowCrossAxisAlignment: CrossAxisAlignment.center,
            columnCrossAxisAlignment: CrossAxisAlignment.center,
            startContent: Text('Purchased on $dateFormatted'.hardcoded),
            endContent: CustomTextButton(
                text: 'Leave a review'.hardcoded,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.green[700]),
                onPressed: () => context.goNamed(
                    RouteApp.leaveReviewScreen.name,
                    pathParameters: {"id": productId})),
          ),
          gapH8,
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}