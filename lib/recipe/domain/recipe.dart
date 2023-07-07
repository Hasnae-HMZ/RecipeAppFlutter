class Recipe {
  late String id;
  late String title;
  late String photo;
  late List<String> ingredients;
  late double rate;



  Recipe({
    required this.id,
    required this.title,
    required this.photo,
    required this.ingredients,
    required this.rate,
  });


  Recipe.fromJson(Map<String, dynamic> map){
    id = map['id'];
    title = map['title'];
    photo = map['photo'];
    rate = map['rate'];
    _converUngredients(map["ingredients"]);
  }

  _converUngredients (List ingredientsList){
    ingredients = [];
    for (var item in ingredientsList){
      ingredients.add(item);
    }
  }


  toJson() {
    return {
      "id": id,
      "title": title,
      "photo": photo,
      "ingredients": ingredients,
      "rate": rate,
    };
  }
}
