import 'package:flutter/material.dart';
import 'categories_data_source.dart';
import 'categories_model.dart';
import 'meals.dart';

class MealCategories extends StatefulWidget {
  const MealCategories({super.key});

  @override
  State<MealCategories> createState() => MealCategoriesState();
}

class MealCategoriesState extends State<MealCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Categories"),
        ),
        body: _buildListUsersBody());
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CategoriesModel categoriesModel = CategoriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(categoriesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text("Error"),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(CategoriesModel categories) {
    return ListView.builder(
        itemCount: categories.categories!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemUsers(categories.categories![index]);
        });
  }

  Widget _buildItemUsers(Categories categoriesModel) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealsPage(namaMakanan: categoriesModel.strCategory!),
        ),
      ),
      child: Card(
        child: Row(
          children: [
            Container(
              width: 100,
              child: Image.network(categoriesModel.strCategoryThumb!),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(categoriesModel.strCategory!),
                Text(categoriesModel.strCategoryDescription!),
              ],
            )
          ],
        ),
      ),
    );
  }
}
