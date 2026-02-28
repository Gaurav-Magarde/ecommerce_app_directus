class CategoryModel {
  final String id;
  final String name;
  final String description;
  final String image;

  CategoryModel({required this.name,required this.id,required this.image,required this.description});

  factory CategoryModel.fromMap(Map<String,dynamic> categoryMap){
    return CategoryModel(name: categoryMap['name'], id: categoryMap['id'], image: categoryMap['image'], description: categoryMap['description']);
  }
}