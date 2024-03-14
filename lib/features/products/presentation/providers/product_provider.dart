import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';
import '../../domain/domain.dart';

final productProvider = 
StateNotifierProvider.autoDispose.family<ProductNotifier, ProductState, String>(
  (ref, productId) {

    final productsRepository = ref.watch(productsRepositoryProvider);

    return ProductNotifier(
      productsRepository: productsRepository,
      productId: productId
    );
  }
);

class ProductNotifier extends StateNotifier<ProductState> {

  final ProductsRepository productsRepository;

  ProductNotifier({
    required this.productsRepository,
    required String productId,
  }): super(ProductState(id: productId)) {
    loadProduct();
  }

  Future<void> loadProduct() async {
    try {
      final product = await productsRepository.getProductId(state.id);

      state = state.copyWith(
        product: product,
        isLoading: false
      );

    } catch (e) {
      print(e.toString());
    }
  }
}

class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving
  }) => ProductState(
    id: id ?? this.id,
    product: product ?? this.product,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );
  
}