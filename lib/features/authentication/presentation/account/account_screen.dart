import 'package:flutter_qa/common_widgets/alert_dialogs.dart';
import 'package:flutter_qa/features/authentication/data/auth_repository.dart';
import 'package:flutter_qa/features/authentication/domain/app_user.dart';
import 'package:flutter_qa/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_qa/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qa/common_widgets/action_text_button.dart';
import 'package:flutter_qa/common_widgets/responsive_center.dart';
import 'package:flutter_qa/constants/app_sizes.dart';
import 'package:flutter_qa/utils/async_value_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Simple account screen showing some user info and a logout button.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final state=ref.watch(accountPageDataProvider);
   // if(state.hasError) return text()
    ref.listen<AsyncValue>(accountPageDataProvider, (previous, next) {
      state.asyncValeUiWidget(context);
  /*    if(!state.isLoading&&state.hasError){
        showExceptionAlertDialog(context: context,
            title: "error",
            exception: state.hasError);
      }*/
    });
    return Scaffold(
      appBar: AppBar(
        title:
        state.isLoading
          ? const CircularProgressIndicator()
            :
        Text('Account'.hardcoded),
        actions: [
          ActionTextButton(
            text: 'Logout'.hardcoded,
            onPressed: () async {
             final success= ref.read(accountPageDataProvider.notifier).signOut();

            },
          ),
        ],
      ),
      body: const ResponsiveCenter(
        padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: UserDataTable(),
      ),
    );
  }
}

/// Simple user data table showing the uid and email
class UserDataTable extends ConsumerWidget {
  const UserDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final style = Theme.of(context).textTheme.subtitle2!;
    final user = ref.watch(chaneUserStreamProvider).value;
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            'Field'.hardcoded,
            style: style,
          ),
        ),
        DataColumn(
          label: Text(
            'Value'.hardcoded,
            style: style,
          ),
        ),
      ],
      rows: [
        _makeDataRow(
          'uid'.hardcoded,
          user?.uid??"",
          style,
        ),
        _makeDataRow(
          'email'.hardcoded,
          user?.email ?? '',
          style,
        ),
      ],
    );
  }

  DataRow _makeDataRow(String name, String value, TextStyle style) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            name,
            style: style,
          ),
        ),
        DataCell(
          Text(
            value,
            style: style,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
