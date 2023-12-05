import 'package:flutter_qa/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qa/features/not_found/empty_placeholder_widget.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EmptyPlaceholderWidget(
        message: '404 - Page not found!'.hardcoded,
      ),
    );
  }
}