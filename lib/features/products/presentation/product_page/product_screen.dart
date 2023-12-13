import 'package:flutter_qa/common_widgets/async_value_widget.dart';
import 'package:flutter_qa/constants/test_products.dart';
import 'package:flutter_qa/features/cart/presentation/add_to_cart/add_to_cart_widget.dart';
import 'package:flutter_qa/features/not_found/empty_placeholder_widget.dart';
import 'package:flutter_qa/features/products/data/products_repository.dart';
import 'package:flutter_qa/features/products/presentation/product_page/product_average_rating.dart';
import 'package:flutter_qa/features/review/presentation/product_reviews/product_reviews_list.dart';
import 'package:flutter_qa/localization/string_hardcoded.dart';
import 'package:flutter_qa/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qa/common_widgets/custom_image.dart';
import 'package:flutter_qa/common_widgets/responsive_center.dart';
import 'package:flutter_qa/common_widgets/responsive_two_column_layout.dart';
import 'package:flutter_qa/constants/app_sizes.dart';
import 'package:flutter_qa/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home_app_bar/home_app_bar.dart';
import 'leave_review_action.dart';

/// Shows the product page for a given product ID.
class ProductScreen extends ConsumerWidget {
  const ProductScreen({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productVal = ref.watch(productDetailsStreamProvider(productId));
    return Scaffold(
      appBar: const HomeAppBar(),
      body:
      AsyncValueWidget(
          value:productVal ,
          data: (Product product)=>  product == null
          ? EmptyPlaceholderWidget(
        message: 'Product not found'.hardcoded,
      )
          : CustomScrollView(
        slivers: [
          ResponsiveSliverCenter(
            padding: const EdgeInsets.all(Sizes.p16),
            child: ProductDetails(product: product),
          ),
          ProductReviewsList(productId: productId),
        ],
      ),)

    );
  }
}

/// Shows all the product details along with actions to:
/// - leave a review
/// - add to cart
class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final priceFormatted = kCurrencyFormatter.format(product.price);
    return ResponsiveTwoColumnLayout(
      startContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: CustomImage(imageUrl: product.imageUrl),
        ),
      ),
      spacing: Sizes.p16,
      endContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(product.title, style: Theme.of(context).textTheme.headline6),
              gapH8,
              Text(product.description),
              // Only show average if there is at least one rating
              if (product.numRatings >= 1) ...[
                gapH8,
                ProductAverageRating(product: product),
              ],
              gapH8,
              const Divider(),
              gapH8,
              Text(priceFormatted,
                  style: Theme.of(context).textTheme.headline5),
              gapH8,
              LeaveReviewAction(productId: product.id),
              const Divider(),
              gapH8,
              AddToCartWidget(product: product),
            ],
          ),
        ),
      ),
    );
  }
}
