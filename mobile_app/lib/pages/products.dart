import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// services
import '../services/products_service.dart';

// widgets and pages
import '../widgets/product_card.dart';
import '../widgets/app_bar.dart';
import '../widgets/categories_widget.dart';
import '../widgets/search_bar.dart';

class ProductsPage extends StatefulWidget{
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsState();
}

class _ProductsState extends State<ProductsPage> {

  String searchText = '';
  String selectedCategory = 'All';
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductsService>().fetchProducts();
      context.read<ProductsService>().fetchCategories();

    });
  }
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBarWidget(title: 'Farm'),
          body: Consumer<ProductsService>(          
            builder: (context, productService, child){

                if(productService.isLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Filter products
                final products = productService.products.where((product){

                  final matchesSearch = 
                  product.name
                    .toLowerCase()
                    .contains(searchText.toLowerCase());

                    final matchesCategory = 
                      selectedCategory == 'All' ||
                      product.categoryName == selectedCategory;

                      return matchesSearch && matchesCategory;

                }).toList();
                return Column(
                children: [

                  // Search
                  Padding(
                    padding: const EdgeInsets.fromLTRB( 16, 8, 16, 12, ),
                    child: SearchBox(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                    ),
                  ),

                  // Categories
                  Padding(
                    padding: const EdgeInsets.only( left: 16, right: 16, bottom: 16, ),
                    child: CategoriesWidget(
                      selectedCategory: selectedCategory,
                      onCategorySelected: (category) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  ),

                  // Products
                  Expanded(
                    child: products.isEmpty
                        ? const Center( child: Text( 'No produce found', ), )
                        : GridView.builder(
                            padding: const EdgeInsets.fromLTRB( 16, 0, 16, 20, ),
                            itemCount: products.length,
                            gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.68,
                              ),
                              itemBuilder: (context, index) {

                                final product = products[index];

                                return ProductCard(
                                  product: product,
                                );
                              },
                          ),
                  ),
                ],
              );
            },
            )
        );

    
  }
}