import 'package:flutter/material.dart';
import 'package:responsi/meals_model.dart';
import 'details_data_source.dart';
import 'package:url_launcher/url_launcher.dart';

class MealsDetail extends StatefulWidget {
  final String idDetails;

  const MealsDetail({Key? key, required this.idDetails}) : super(key: key);
  @override
  State<MealsDetail> createState() => MealsDetailState();
}

class MealsDetailState extends State<MealsDetail> {
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
        future: ApiDataSource.instance.loadMealsDetail(widget.idDetails),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            MealsModel mealsModel = MealsModel.fromJson(snapshot.data);
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
    return ListView.builder(
        itemCount: meals.meals!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemUsers(meals.meals![index]);
        });
  }

  Widget _buildItemUsers(Meals mealsModel) {
    return InkWell(
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
                    Text(mealsModel.strCategory!),
                    Text(mealsModel.strArea!),
                    Text(mealsModel.strInstructions!),
                    Text(mealsModel.strYoutube!),
                  ],
                )
        ],
      ),
    );
  }
}
