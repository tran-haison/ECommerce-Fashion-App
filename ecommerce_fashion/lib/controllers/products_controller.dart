import 'package:ecommerce_fashion/controllers/products_repository.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {

  ProductsRepository productsRepository = ProductsRepository();

  List products = [].obs;
  RxBool isLoading = false.obs;
  var showGrid = false.obs;

  ProductsController() {
    loadProductsFromRepo();
  }

  loadProductsFromRepo() async {
    isLoading(true);
    products = await productsRepository.loadProductsFromApi();
    print(products);
    isLoading(false);
  }

  toggleGridView() {
    showGrid(!showGrid.value);
  }
}