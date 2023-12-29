import 'dart:ffi';

import 'package:flutter_qa/features/authentication/data/auth_repository.dart';
import 'package:flutter_qa/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class AuthRepositoryMock extends Mock implements AuthRepository{}

void main() {
late AuthRepositoryMock authRepository;
late AccountScreenController controller;
  setUp(() {
authRepository=AuthRepositoryMock();
 controller =AccountScreenController(authRepository: authRepository);
  });
group("test controller",(){

  test("test async value controller",(){
expect(controller.debugState, AsyncData<void>(null));

  });


  test("sing out success",()async{

//set up
when(authRepository.signOut).thenAnswer((_) => Future.value());
//run
await controller.signOut();
//verify
verify(authRepository.signOut).called(1);
expect(controller.debugState, AsyncData<void>(null));

  });

test("sing out success whit stream",()async{
//set up
when(authRepository.signOut).thenAnswer((_) => Future.value());

expectLater(controller.stream, emitsInOrder([
  AsyncLoading<void>(),

  AsyncData<void>(null)
]));

//run
await controller.signOut();
//verify
verify(authRepository.signOut).called(1);


  });




  test("sing out failur",()async{
final exception="connect error";
when(authRepository.signOut).thenThrow(exception);
await controller.signOut();
verify(authRepository.signOut).called(1);
expect(controller.debugState.hasError,true);
expect(controller.debugState,isA<AsyncError>());

  });

test("sing out failur with stream",()async{
final exception="connect error";
when(authRepository.signOut).thenThrow(exception);
expectLater(
  controller.stream,emitsInOrder([
    AsyncLoading<void>(),
   predicate<AsyncValue<void>>((value) {
    expect(value.hasError, true);
    return true;
   })
  ]));

await controller.signOut();
verify(authRepository.signOut).called(1);

expect(controller.debugState,isA<AsyncError>());

  });

});
}