import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:alercom/src/services/services.dart';
import 'package:alercom/src/models/models.dart';


class CategoryService extends ChangeNotifier {

  final List<Category> categories = [];
  late Category selectedCategory;

  bool isLoading = true;
  bool isSaving = false;

  CategoryService() {
    this.loadCategories();
  }

  Future<List<Category>> loadCategories() async {
    String endpoint = '/api/v1/categories/';
    this.isLoading = true;
    notifyListeners();
    RequestService service = new RequestService();

    http.Response response = await service.get(endpoint);
    List<dynamic> categoriesList = service.getCollection(response);

    categoriesList.forEach((category) {
      final categoryRow = Category.fromMap( category );
      this.categories.add( categoryRow );
      print(category);
    });

    this.isLoading = false;
    notifyListeners();

    return this.categories;

  }




}