
import 'package:flutter_qa/constants/app_strings.dart';
import 'package:flutter_qa/models/product.dart';

/// Test products to be used until a data source is implemented
const kTestProducts = [
  Product(
    id: '1',
    imageUrl: AppStrings.imageBruschetta,
    title: 'Bruschetta plate',
    description: 'Lorem ipsum',
    price: 15,
    availableQuantity: 5,
    avgRating: 4.5,
    numRatings: 2,
  ),
  Product(
    id: '2',
    imageUrl:AppStrings.imageMozzarella,
    title: 'Mozzarella plate',
    description: 'Lorem ipsum',
    price: 13,
    availableQuantity: 5,
    avgRating: 4,
    numRatings: 2,
  ),
  Product(
    id: '3',
    imageUrl: AppStrings.imagePizza,
    title: 'Pasta plate',
    description: 'Lorem ipsum',
    price: 17,
    availableQuantity: 5,
    avgRating: 5,
    numRatings: 2,
  ),
  Product(
    id: '4',
    imageUrl: AppStrings.imagePriggyBlue,
    title: 'Piggy Bank Blue',
    description: 'Lorem ipsum',
    price: 12,
    availableQuantity: 5,
  ),
  Product(
    id: '5',
    imageUrl: AppStrings.imagePriggyGreen,
    title: 'Piggy Bank Green',
    description: 'Lorem ipsum',
    price: 12,
    availableQuantity: 10,
  ),
  Product(
    id: '6',
    imageUrl: AppStrings.imagePriggyPink,
    title: 'Piggy Bank Pink',
    description: 'Lorem ipsum',
    price: 12,
    availableQuantity: 10,
  ),
  Product(
    id: '7',
    imageUrl: AppStrings.imageBruschetta,
    title: 'Pizza plate',
    description: 'Lorem ipsum',
    price: 18,
    availableQuantity: 10,
  ),
  Product(
    id: '8',
    imageUrl: 'assets/products/plate-and-bowl.jpg',
    title: 'Plate and Bowl',
    description: 'Lorem ipsum',
    price: 21,
    availableQuantity: 10,
  ),
  Product(
    id: '9',
    imageUrl: 'assets/products/salt-pepper-lemon.jpg',
    title: 'Salt and pepper lemon',
    description: 'Lorem ipsum',
    price: 11,
    availableQuantity: 10,
  ),
  Product(
    id: '10',
    imageUrl: 'assets/products/salt-pepper-olives.jpg',
    title: 'Salt and pepper olives',
    description: 'Lorem ipsum',
    price: 11,
    availableQuantity: 10,
  ),
  Product(
    id: '11',
    imageUrl: 'assets/products/snacks-plate.jpg',
    title: 'Snacks plate',
    description: 'Lorem ipsum',
    price: 24,
    availableQuantity: 10,
  ),
  Product(
    id: '12',
    imageUrl: 'assets/products/flowers-plate.jpg',
    title: 'Flowers plate',
    description: 'Lorem ipsum',
    price: 22,
    availableQuantity: 10,
  ),
  Product(
    id: '13',
    imageUrl: 'assets/products/juicer-citrus-fruits.jpg',
    title: 'Juicer for citrus fruits',
    description: 'Lorem ipsum',
    price: 14,
    availableQuantity: 10,
  ),
  Product(
    id: '14',
    imageUrl: 'assets/products/honey-pot.jpg',
    title: 'Honey pot',
    description: 'Lorem ipsum',
    price: 16,
    availableQuantity: 10,
  ),
];