import 'package:flutter_qa/constants/breakpoints.dart';
import 'package:flutter_qa/features/authentication/data/auth_repository.dart';
import 'package:flutter_qa/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:flutter_qa/features/products/presentation/home_app_bar/shopping_cart_icon.dart';
import 'package:flutter_qa/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qa/common_widgets/action_text_button.dart';
import 'package:flutter_qa/route/route_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final user = ref.watch(chaneUserStreamProvider).value;
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < Breakpoint.tablet) {
      return AppBar(
        title: Text('My Shop'.hardcoded),
        actions:  [
          const ShoppingCartIcon(),
          MoreMenuButton(user: user),
        ],
      );
    } else {
      return AppBar(
        title: Text('My Shop'.hardcoded),
        actions: [
          const ShoppingCartIcon(),
          if (user != null) ...[
            ActionTextButton(
              key: MoreMenuButton.ordersKey,
              text: 'Orders'.hardcoded,
              onPressed: () =>context.goNamed(RouteApp.order.name)
            ),
            ActionTextButton(
              key: MoreMenuButton.accountKey,
              text: 'Account'.hardcoded,
              onPressed: () => context.goNamed(RouteApp.accountScreen.name)
            ),
          ] else
            ActionTextButton(
              key: MoreMenuButton.signInKey,
              text: 'Sign In'.hardcoded,
              onPressed: () => context.goNamed(RouteApp.signIn.name)
            )
        ],
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
