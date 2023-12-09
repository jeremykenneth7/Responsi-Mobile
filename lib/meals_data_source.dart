import '/base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadMeals(String idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("filter.php?c=$id");
  }
}
