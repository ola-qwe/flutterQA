import 'package:flutter/material.dart';
import 'package:flutter_qa/features/authentication/data/auth_repository.dart';
import 'package:flutter_qa/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:flutter_qa/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_qa/features/cart/presentation/shopping_cart/shopping_cart_screen.dart';
import 'package:flutter_qa/features/checkout/checkout_screen.dart';
import 'package:flutter_qa/features/orders/presentation/orders_list/orders_list_screen.dart';
import 'package:flutter_qa/features/review/presentation/leave_review_screen.dart';
import 'package:flutter_qa/features/not_found/not_found_screen.dart';
import 'package:flutter_qa/features/products/presentation/product_page/product_screen.dart';
import 'package:flutter_qa/route/go_route_refresh_stream.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/presentation/account/account_screen.dart';
import '../features/products/presentation/products_list/products_list_screen.dart';

enum RouteApp {
  cart,
  order,
  signIn,
  accountScreen,
  products,
  checkout,
  productsList,
  leaveReviewScreen
}

final route = Provider<GoRouter>(
  (ref) {
    final authRepo = ref.watch(authRepoProvider);
    return GoRouter(
        initialLocation: '/',
        debugLogDiagnostics: true,
        redirect: (context, state) {
          final isSuccess=authRepo.currentUser!=null;
          if(isSuccess)
            {
              if (state.name == "/signIn") {
                return '/';
              } else {
                if (state.name == "/orderList" || state.name == "/accountScreen") {
                  return '/';
                }
              }
            }

        },
        refreshListenable: GoRouterRefreshStream(authRepo.changeAuth()),
        routes: [
          GoRoute(
              path: "/",
              name: RouteApp.productsList.name,
              builder: (context, state) => const ProductsListScreen(),
              routes: [
                GoRoute(
                    path: "cart",
                    name: RouteApp.cart.name,
                    pageBuilder: (context, state) => const MaterialPage(
                          fullscreenDialog: true,
                          child: ShoppingCartScreen(),
                        ),
                    routes: [
                      GoRoute(
                        path: "checkOut",
                        name: RouteApp.checkout.name,
                        pageBuilder: (context, state) => const MaterialPage(
                          fullscreenDialog: true,
                          child: CheckoutScreen(),
                        ),
                      ),
                    ]),
                GoRoute(
                  path: "orderList",
                  name: RouteApp.order.name,
                  pageBuilder: (context, state) => const MaterialPage(
                    fullscreenDialog: true,
                    child: OrdersListScreen(),
                  ),
                ),
                GoRoute(
                  path: "accountScreen",
                  name: RouteApp.accountScreen.name,
                  pageBuilder: (context, state) => const MaterialPage(
                    fullscreenDialog: true,
                    child: AccountScreen(),
                  ),
                ),
                GoRoute(
                  path: "signIn",
                  name: RouteApp.signIn.name,
                  pageBuilder: (context, state) => const MaterialPage(
                    fullscreenDialog: true,
                    child: EmailPasswordSignInScreen(
                      formType: EmailPasswordSignInFormType.signIn,
                    ),
                  ),
                ),
                GoRoute(
                    path: "products/:id",
                    name: RouteApp.products.name,
                    pageBuilder: (context, state) {
                      final productId = state.pathParameters['id']!;
                      return MaterialPage(
                        fullscreenDialog: true,
                        child: ProductScreen(
                          productId: productId,
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: "leaveReviewScreen",
                        name: RouteApp.leaveReviewScreen.name,
                        pageBuilder: (context, state) {
                          final productId = state.pathParameters['id']!;
                          return MaterialPage(
                            fullscreenDialog: true,
                            child: LeaveReviewScreen(
                              productId: productId,
                            ),
                          );
                        },
                      ),
                    ]),
              ])
        ],
        errorBuilder: (context, state) => NotFoundScreen());
  },
);
