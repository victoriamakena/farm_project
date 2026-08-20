import 'package:flutter/material.dart';
import '../models/products_model.dart';
import 'api_service.dart';


//services
class ProductsService extends ChangeNotifier{
  final ApiService apiService = ApiService();

  List<ProductsModel> products = [];

  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try{
      final response = await apiService.get("/fetchAllProducts");

      products = (response as List)
          .map((product) => ProductsModel.fromJson(product))
          .toList();

    }catch(e){
      print("Error fetching products: $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> fetchProductsPerCategory(int id) async {
    isLoading = true;
    notifyListeners();

    try{
      final response = await apiService.get("/fetchProductsPerCategory/$id");

      products = (response as List)
          .map((product) => ProductsModel.fromJson(product))
          .toList();

    }catch(e){
      print("Error fetching products: $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}


//model
