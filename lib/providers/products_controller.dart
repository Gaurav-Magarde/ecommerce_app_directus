import 'dart:async';

import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_service.dart';

final productControllerProvider =
    AsyncNotifierProvider<ProductsController, List<Product>>(() {
      return ProductsController();
    });

class ProductsController extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    final api = ref.read(apiServiceProvider);

    // watches category and search and fetch products instant
    final category = ref.watch(
      homeControllerProvider.select((s) => s.selectedCategory),
    );
    final searchFilter = ref.watch(
      homeControllerProvider.select((s) => s.searchFilter),
    );

    final Map<String, dynamic> filter = {};
    List<Map<String, dynamic>> conditions = [];

    // selected category filter
    if (category != 'All') {
      conditions.add({
        'categories': {
          "name": {"_eq": category},
        },
      });
    }

    //Search filter
    if (searchFilter.isNotEmpty) {
      conditions.add({
        "_or": [
          {
            "categories": {
              "name": {"_icontains": searchFilter},
            },
          },
          {
            "name": {"_icontains": searchFilter},
          },
        ],
      });
    }

    // Applying filters and getting products accordingly
    if (conditions.isNotEmpty) filter['_and'] = conditions;
    final List<Map> productMap = await api.getProducts(filter: filter);
    final products = productMap.map((map) => Product.fromMap(map)).toList();
    return products;
  }
}


// category provider
final categoriesProvider = FutureProvider<List<String>>((ref) async {

  //Fetch category from the database
  final api = ref.read(apiServiceProvider);
  final List<CategoryModel> categories = await api.getCategories();

  return categories.map((cat) => cat.name).toList();
});

//home controller provider
final homeControllerProvider = NotifierProvider<HomeController, HomeState>(
  () => HomeController(),
);


//Home state controller
class HomeController extends Notifier<HomeState> {


  //update search
  void updateSearch(String searchController) {
    state = state.copyWith(searchFilter: searchController);
  }

  //update selected category
  void updateCategory(String selectedCategory) {
    state = state.copyWith(selectedCategory: selectedCategory);
  }

  @override
  HomeState build() {
    return HomeState(selectedCategory: 'All', searchFilter: '');
  }
}

// Home screen state/filters
class HomeState {
  final String selectedCategory;
  final String searchFilter;
  HomeState({required this.selectedCategory, required this.searchFilter});
  HomeState copyWith({String? selectedCategory, String? searchFilter}) {
    return HomeState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchFilter: searchFilter ?? this.searchFilter,
    );
  }
}
