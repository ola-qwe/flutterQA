import 'package:flutter_qa/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends StateNotifier<AsyncValue> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncValue.data(null));

  final AuthRepository authRepository;

  Future<void> signOut() async {
    //this example and can use  AsyncValue.guard return data and error
    /*  try{
      state=const AsyncValue<void>.loading();
      await authRepository.signOut();
      state=const AsyncValue<void>.data(null);
      return true;
    }catch(e,str){
      state= AsyncValue<void>.error(e, str);
      return false;
    }*/
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => authRepository.signOut());
  }
}

final accountPageDataProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AccountScreenController(authRepository: authRepo);
});
