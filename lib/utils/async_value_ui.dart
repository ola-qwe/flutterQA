import 'package:flutter/cupertino.dart';
import 'package:flutter_qa/common_widgets/alert_dialogs.dart';
import 'package:flutter_qa/localization/string_hardcoded.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncDateUi on AsyncValue {
  void asyncValeUiWidget(BuildContext context) {
    // use !isLoading when sign out two time 
    if (!isLoading && hasError) {
      showExceptionAlertDialog(
          context: context, title: "Error".hardcoded, exception: hasError);
    }
  }
}
