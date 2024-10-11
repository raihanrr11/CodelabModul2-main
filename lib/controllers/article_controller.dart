import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/article_model.dart';

class ArticleController extends GetxController {
  final Dio _dio = Dio();
  final apiUrl = 'https://my-json-server.typicode.com/Fallid/codelab-api/db';

  var isLoading = false.obs;
  var articles = Rx<Articles?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        articles.value = Articles.fromJson(response.data);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch articles: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
