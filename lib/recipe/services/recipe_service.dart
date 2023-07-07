import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import '../domain/recipe.dart';

class RecipeService {
  Dio _dio = Dio();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Recipe>> Get() async {
    List<Recipe> recipes = [];
    var response = await _dio.get("");
    var data = response.data;
    for (var item in data) {
      recipes.add(Recipe.fromJson(item));
    }
    return  recipes;
  }

// souvgarder
  Future <List<Recipe>> GetSaved ({required String userId}) async {
    List<Recipe> recipes = [];
    var response = await _firestore.collection("users").doc(userId).collection("saved").get();
    var docs = response.docs;
    for(var doc in docs){
      recipes.add(Recipe.fromJson(doc.data()));
    }
    return recipes;
  }

  Future Save ({required Recipe recipe, required String userId}) async {
    _firestore.collection("users").doc(userId).collection("saved").doc(recipe.id).set(recipe.toJson());
  }

  Future Unsave ({required String recipeId, required String userId }) async {
    _firestore.collection("users").doc(userId).collection("saved").doc(recipeId).delete();
  }

// FavoriseRecipe
  Future<void> favoriser({required Recipe recipe, required String userId}) async {
  try {
    // Vérifier si la recette est déjà sauvegardée
    var savedRecipe = await _firestore.collection("users")
        .doc(userId).collection("saved").doc(recipe.id).get();

    if (savedRecipe.exists) {  // La recette est déjà sauvegardée, vous pouvez prendre une action appropriée
      print("La recette est déjà sauvegardée.");
    } else {
      // Sauvegarder la recette
      await _firestore.collection("users").doc(userId).collection("saved").doc(recipe.id).set(recipe.toJson());
      print("La recette a été sauvegardée avec succès !");
    }
  } catch (error) {// Gérer les erreurs lors de la sauvegarde de la recette
    print("Une erreur s'est produite lors de la sauvegarde de la recette : $error");
  }
}

}
