import 'package:teslo_shop/features/products/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getProductsByPage({int limit = 10, offset = 0});
  Future<Product> getProductId(String id);
  Future<List<Product>> searchProductsByTerm(String term);
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}