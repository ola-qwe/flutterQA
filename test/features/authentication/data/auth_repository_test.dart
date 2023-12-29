import 'package:flutter_qa/features/authentication/data/auth_repository.dart';
import 'package:flutter_qa/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

 group("product Repo test", () {
final authRepo=AuthRepository();
final testEmail="";
final testPass="1234";
final user=AppUser(
uid:testEmail.split("").reversed.join(),
email: testEmail
);
test("get current user is null",(){
  expect(authRepo.currentUser, null);
});

test("get user after sign in",(){
  authRepo.signInWithEmailAndPassword(testEmail,testPass);

  expect(authRepo.currentUser,user);
  expect(authRepo.changeAuth(), emits(user));
});

test("get user after regester",(){
  authRepo.createAccountEmailAndPassword(testEmail,testPass);

  expect(authRepo.currentUser,user);
  expect(authRepo.changeAuth(), emits(user));
});
test("get user after signout",(){
  authRepo.createAccountEmailAndPassword(testEmail,testPass);

  expect(authRepo.currentUser,user);
  expect(authRepo.changeAuth(), emits(user));

    authRepo.signOut();

  expect(authRepo.currentUser,null);
  expect(authRepo.changeAuth(), emits(null));
});


test("signIn after dispose return exeption",(){
    authRepo.dispose();

  expect(()=> authRepo.createAccountEmailAndPassword(testEmail,testPass)
  ,throwsStateError);

});


});

}