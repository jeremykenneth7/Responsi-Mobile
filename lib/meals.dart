import 'package:flutter/material.dart';
import 'package:responsi/meals_model.dart';
import 'meals_data_source.dart';
import 'mealsdetail.dart';

class MealsPage extends StatefulWidget {
  final String namaMakanan;

  const MealsPage({Key? key, required this.namaMakanan}) : super(key: key);
  @override
  State<MealsPage> createState() => MealsPageState();
}

class MealsPageState extends State<MealsPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meals"),
        ),
        body: _buildListUsersBody());
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadMeals(widget.namaMakanan),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            MealsModel mealsModel =
                MealsModel.fromJson(snapshot.data);
            return _buildSuccessSection(mealsModel);
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

  Widget _buildSuccessSection(MealsModel meals) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 200,
      ),
        itemCount: meals.meals!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemUsers(meals.meals![index]);
        });
  }

  Widget _buildItemUsers(Meals mealsModel) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealsDetail(idDetails: mealsModel.idMeal!),
        ),
      ),
      child: Card(
        child: Column(
          children: [
            Container(
              width: 100,
              child: Image.network(mealsModel.strMealThumb!),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mealsModel.strMeal!),
              ],
            )
          ],
        ),
      ),
    );
  }
}
