import 'dart:ffi';

import 'package:flutter_qa/features/authentication/data/auth_repository.dart';
import 'package:flutter_qa/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:flutter_qa/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository{}

final testEmail="test@gmail.com";
final testPass="1234";
void main() {
 group("submit email and password ",(){
  test("submit email and password success",()async{
       //setup
final authMock=AuthRepositoryMock();
final controller =EmailPasswordSignInController(
  authRepository: authMock,
  formType: EmailPasswordSignInFormType.signIn
);
when(()=>authMock.signInWithEmailAndPassword(testEmail, testPass)).thenAnswer((_) => Future.value());

//run
final result=await controller.submit(testEmail, testPass);
expect(result, true);
  });

  test("submit email and password  signIn success",()async{
       //setup
final authMock=AuthRepositoryMock();
final controller =EmailPasswordSignInController(
  authRepository: authMock,
  formType: EmailPasswordSignInFormType.signIn
);
when(()=>authMock.signInWithEmailAndPassword(testEmail, testPass)).thenAnswer((_) => Future.value());

//run
final result=await controller.submit(testEmail, testPass);
expect(result, true);
  });



  test("submit email and password sign in failur",()async{
       //setup
final authMock=AuthRepositoryMock();
final controller =EmailPasswordSignInController(
  authRepository: authMock,
  formType: EmailPasswordSignInFormType.signIn
);
final exception="error";
when(()=>authMock.signInWithEmailAndPassword(testEmail, testPass)).thenThrow(exception);

expectLater(controller.stream,emitsInOrder([
  EmailPasswordSignInState(
    formType:EmailPasswordSignInFormType.signIn ,
    value: AsyncLoading()
  ),
    predicate<EmailPasswordSignInState>((state) {
         expect(state.formType, EmailPasswordSignInFormType.signIn);
    expect(state.value.hasError, true);
    return true;
   })
]));
//run
final result=await controller.submit(testEmail, testPass);
expect(result, false);
  });
 



  test("submit email and password  register success",()async{
       //setup
final authMock=AuthRepositoryMock();
final controller =EmailPasswordSignInController(
  authRepository: authMock,
  formType: EmailPasswordSignInFormType.register
);
when(()=>authMock.createAccountEmailAndPassword(testEmail, testPass)).thenAnswer((_) => Future.value());

//run
final result=await controller.submit(testEmail, testPass);
expect(result, true);
  });



  test("submit email and password register failur",()async{
       //setup
final authMock=AuthRepositoryMock();
final controller =EmailPasswordSignInController(
  authRepository: authMock,
  formType: EmailPasswordSignInFormType.register
);
final exception="error";
when(()=>authMock.createAccountEmailAndPassword(testEmail, testPass)).thenThrow(exception);

expectLater(controller.stream,emitsInOrder([
  EmailPasswordSignInState(
    formType:EmailPasswordSignInFormType.register ,
    value: AsyncLoading()
  ),
    predicate<EmailPasswordSignInState>((state) {
         expect(state.formType, EmailPasswordSignInFormType.register);
    expect(state.value.hasError, true);
    return true;
   })
]));
//run
final result=await controller.submit(testEmail, testPass);
expect(result, false);
  });
 


 });


group("change state ",(){

test("chane from signIn to register",(){

final authMock=AuthRepositoryMock();
final controller =EmailPasswordSignInController(
  authRepository: authMock,
  formType: EmailPasswordSignInFormType.signIn
);
controller.updateMethode(EmailPasswordSignInFormType.signIn);
expect(controller.debugState, 
 EmailPasswordSignInState(formType: EmailPasswordSignInFormType.signIn, value: AsyncData<void>(null))

);

});

test("chane from register to signIn",(){

final authMock=AuthRepositoryMock();
final controller =EmailPasswordSignInController(
  authRepository: authMock,
  formType: EmailPasswordSignInFormType.register
);
controller.updateMethode(EmailPasswordSignInFormType.register);
expect(controller.debugState, 
 EmailPasswordSignInState(formType: EmailPasswordSignInFormType.register, value: AsyncData<void>(null))

);

},timeout: const Timeout(Duration(microseconds: 1000)));

});

}