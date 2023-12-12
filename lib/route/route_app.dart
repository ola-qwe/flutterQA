import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_qa/features/checkout/checkout_screen.dart';
import 'package:flutter_qa/features/leave_review_page/leave_review_screen.dart';
import 'package:flutter_qa/features/not_found/not_found_screen.dart';
import 'package:flutter_qa/features/product_page/product_screen.dart';
import 'package:flutter_qa/features/products_list/products_list_screen.dart';
import 'package:flutter_qa/features/shopping_cart/shopping_cart_screen.dart';
import 'package:flutter_qa/features/sign_in/email_password_sign_in_screen.dart';
import 'package:go_router/go_router.dart';

import '../features/account/account_screen.dart';
import '../features/orders_list/orders_list_screen.dart';
import '../features/sign_in/email_password_sign_in_state.dart';

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

final route =
    GoRouter(initialLocation: '/', debugLogDiagnostics: true, routes: [
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
    errorBuilder:(context,state)=>NotFoundScreen() );
