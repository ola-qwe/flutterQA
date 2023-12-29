import 'package:flutter_qa/constants/test_products.dart';
import 'package:flutter_qa/features/products/data/products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("product repository", () { 
     final productsRepository=ProductsRepository(isDelay: false);
 test('test get product',(){
  expect(
    productsRepository.getProducts(),
    kTestProducts
  );
 });

 test('get product (1) by id',(){
  expect(
    productsRepository.getProductById("1"),
    kTestProducts[0]
  );
 });

 test("get productById 100 return null",(){
   expect(productsRepository.getProductById("100"), 
   null);
 });


  test('get products Future',()async{
  expect(
   await productsRepository.getFutureProducts(),
    kTestProducts
  );
 });


   test('get products stream',(){
  expect(
    productsRepository.getStreamProducts(),
    emits(kTestProducts)
  );
 });

    test('get productById stream',(){
  expect(
    productsRepository.getStreamProductById("1"),
    emits(kTestProducts[0])
  );
 });

  });




}