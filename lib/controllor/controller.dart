
import 'dart:convert'; // For jsonEncode
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart'; // Import GetX

class MovieController extends GetxController {
  var alldata = [].obs; // Observable list for all data
  final _movie = [].obs; // Make _movie an observable list

  List get movie => _movie; // Getter for movie

  var isLoading = true.obs; // Observable for loading state
  
  @override
  void onInit() {
    super.onInit();
    fetchMovieList(); // Fetch the movie list when the controller is initialized
  }

  Future<void> fetchMovieList() async {
    // Create the request body
    final Map<String, String> requestBody = {
      'category': 'movies',
      'language': 'kannada',
      'genre': 'all',
      'sort': 'voting',
    };

    try {
      isLoading.value = true; // Set loading to true
      final response = await http.post(
        Uri.parse("https://hoblist.com/api/movieList"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Parse the response body
        final data = jsonDecode(response.body);
        log(data.toString());
        
        if (data["result"] != null) {
          alldata.value = data["result"]; // Store the entire result
          _movie.value = List.from(data["result"]); // Populate _movie directly
        }

        log("Movies Loaded: ${_movie.length}"); // Log the number of movies loaded
      } else {
        log("Failed to load movies. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error: $e"); // Log any errors
    } finally {
      isLoading.value = false; // Set loading to false
    }
  }
}
