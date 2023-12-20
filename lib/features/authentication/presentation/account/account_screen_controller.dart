import 'package:flutter_qa/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  final AuthRepository authRepository;

  Future<bool> signOut()async {
    try{
      state=const AsyncValue<void>.loading();
      await authRepository.signOut();
      state=const AsyncValue<void>.data(null);
      return true;
    }catch(e,str){
      state= AsyncValue<void>.error(e, str);
      return false;
    }

  }
}

final accountPageDataProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AccountScreenController(authRepository:authRepo);
});
