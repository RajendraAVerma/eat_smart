abstract class ApiRepository {
  Future<List<String>> getLabelsFromImageLink(String imageLink);
  Future<List<Map<String, dynamic>>> searchFoodFromName(String name);
  Future<String> generateResponseFromOpenAI(String prompt);
}
