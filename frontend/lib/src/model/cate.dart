class Categories {
  int categoryId;
  String categoryName;
  String categoryDescription;
  String? categoryImage;
  List<dynamic>? children;
  int depth;
  String parentCategoryName;
  bool subscribed;

  Categories({
    required this.categoryId,
    required this.categoryName,
    required this.categoryDescription,
    this.categoryImage,
    this.children,
    required this.depth,
    required this.parentCategoryName,
    this.subscribed = false
  });

  factory Categories.fromJson(Map<String,dynamic> json){
    return Categories(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryDescription: json['categoryDescription'],
      children: json['children'],
      depth: json['depth'],
      parentCategoryName: json['parentCategoryName']
    );
  }

  factory Categories.initialState(){
    return Categories(
      categoryId: 0,
      categoryName: "",
      categoryDescription: "",
      children: [],
      depth: 0,
      parentCategoryName: ""
    );
  }
}