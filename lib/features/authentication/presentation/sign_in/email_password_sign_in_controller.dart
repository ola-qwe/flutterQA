import 'package:flutter_qa/features/authentication/data/auth_repository.dart';
import 'package:flutter_qa/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailPasswordSignInController
    extends StateNotifier<EmailPasswordSignInState> {
  //formType sign in /creat account page
  EmailPasswordSignInController({
    required EmailPasswordSignInFormType formType,
    required this.authRepository,
  }) : super(EmailPasswordSignInState());
  final AuthRepository authRepository;

  Future<bool> submit(String email, String password) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(() => _authRepo(email, password));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  Future<void> _authRepo(String email, String password) async {
    switch (state.formType) {
      case EmailPasswordSignInFormType.signIn:
        return authRepository.signInWithEmailAndPassword(email, password);
      case EmailPasswordSignInFormType.register:
        return authRepository.createAccountEmailAndPassword(email, password);
    }
  }

  void updateMethode(EmailPasswordSignInFormType formType) {
    state = state.copyWith(formType: formType);

//we can use thie or use .select()
  /*  state = state.copyWith(
      value: AsyncValue.data(null),
        formType: formType);*/
  }
}

final emailPasswordSignInControllerProvider = StateNotifierProvider.autoDispose
    .family<EmailPasswordSignInController, EmailPasswordSignInState,
        EmailPasswordSignInFormType>((ref, formType) {
  final authRepo = ref.watch(authRepoProvider);
  return EmailPasswordSignInController(
      authRepository: authRepo, formType: formType);
});
