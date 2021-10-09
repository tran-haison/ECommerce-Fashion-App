import 'package:ecommerce_fashion/controllers/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final ProductsController productsController = Get.put(ProductsController());
  final List<String> categories = [
    "TShirt",
    "Pants",
    "Jeans",
    "Jacket",
    "Shirt",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTop(),
            _buildCategories(),
            Expanded(
              child: Obx(() {
                if (productsController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (productsController.products.isEmpty) {
                  return const Center(
                    child: Text("No product found!"),
                  );
                }
                if (productsController.showGrid.value) {
                  return _buildGridView();
                }
                return _buildListView();
              }),
            ),
          ],
        ),
      ),
    );
  }

  GridView _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: productsController.products.length,
      itemBuilder: (context, index) => Card(
        elevation: 0,
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      productsController.products[index]["image"],
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productsController.products[index]["title"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          productsController.products[index]["description"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "\$${productsController.products[index]["price"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: productsController.products.length,
      itemBuilder: (context, index) => Card(
        elevation: 0,
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      productsController.products[index]["image"],
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productsController.products[index]["title"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          productsController.products[index]["description"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "\$${productsController.products[index]["price"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const BackButton(),
      iconTheme: const IconThemeData(color: Colors.black),
      title: const Text(
        "Geek's Fashion",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
      ],
    );
  }

  Widget _buildTop() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Clothes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () => productsController.toggleGridView(),
          icon: const Icon(Icons.filter_list),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
            color: index == 0 ? Colors.black87 : Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16,
          ),
          child: Text(
            categories[index],
            style: TextStyle(
              color: index == 0 ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
