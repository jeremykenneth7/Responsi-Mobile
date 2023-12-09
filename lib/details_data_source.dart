import '/base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadMealsDetail(String idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("lookup.php?i=$id");
  }
}
