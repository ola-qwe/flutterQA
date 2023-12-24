import 'package:flutter_qa/features/authentication/domain/app_user.dart';
import 'package:flutter_qa/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  final _authRepo=InMemoryStore<AppUser?>(null);
  Stream<AppUser?> changeAuth() => _authRepo.stream;
  AppUser? get currentUser => _authRepo.value;

  Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    if(currentUser!=null)
      {
        _creatNewAccount(email);
      }
  }

  Future<void> createAccountEmailAndPassword(
      String email, String password) async {
    if(currentUser!=null)
    {
      _creatNewAccount(email);
    }
  }

  Future<void> signOut() async {
    Future.delayed(const Duration(seconds: 3));
    //throw exeption to test error msg
    //throw Exception();
    _authRepo.value=null;
  }
  void dispose(){
    _authRepo.close();
  }

  void _creatNewAccount(String email){
    _authRepo.value=AppUser(uid: email.split("").reversed.join(),email: email);
  }
}

final authRepoProvider = Provider<AuthRepository>(
  (ref) {
    final auth= AuthRepository();
    ref.onDispose(() {auth.dispose();});
    return auth;

  },
);

final chaneUserStreamProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final repo = ref.watch(authRepoProvider);
  return repo.changeAuth();
});
