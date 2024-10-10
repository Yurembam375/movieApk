// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geeksynergy/controllor/controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class HomeScreen extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());

  HomeScreen({super.key}); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Movie List')),
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'company_info') {
                _showCompanyInfo(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'company_info',
                  child: Text('Company Info'),
                ),
              ];
            },
          ),
        ],
      ),

      body: Obx(() {
        if (movieController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator()); // Show loading indicator
        }

        if (movieController.movie.isEmpty) {
          return const Center(
              child: Text("No movies found.")); // Handle empty state
        }

        return ListView.builder(
          itemCount: movieController.movie.length,
          itemBuilder: (context, index) {
            final movie = movieController.movie[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                height: 210,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, // Set the color of the bottom border
                      width: 1.0, // Set the width of the bottom border
                    ),
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 150,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 15),
                                    const Icon(
                                      CupertinoIcons.arrowtriangle_up_fill,
                                      size: 35,
                                    ),
                                    Text(
                                      movie["voting"].toString(),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                      CupertinoIcons.arrowtriangle_down_fill,
                                      size: 35,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    const Text(
                                      "Votes",
                                      style: TextStyle(fontSize: 17),
                                    )
                                  ]),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 130,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.2), // Color and opacity of the shadow
                                    spreadRadius:
                                        1, // How wide the shadow will spread
                                    blurRadius: 5, // How soft the shadow is
                                    offset: const Offset(
                                        3, 3), // The position of the shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                // Optional: Use ClipRRect to apply rounded corners to the image
                                borderRadius: BorderRadius.circular(
                                    4), // Adjust as needed
                                child: Image.network(
                                  movie["poster"],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: SizedBox(
                              height: 150,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            movie["title"],
                                            style:
                                                const TextStyle(fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("Genre: ${movie["genre"]}"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Director: ${movie["director"][0]}"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            // Use Expanded to constrain the width of the text
                                            child: Text(
                                              "Starting: ${movie["stars"][0]}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Convert the releasedDate timestamp to a readable format
                                          Text(
                                              "Mins | English | ${_formatReleaseDate(movie["releasedDate"])}"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Convert the releasedDate timestamp to a readable format
                                          Text(
                                            "${movie["pageViews"]} views| "
                                            "Voted by ${movie["totalVoted"]} People",
                                            style: const TextStyle(
                                                color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius
                                    .zero, // Set borderRadius to zero
                              ),
                            ),
                          ),
                          child: const Text(
                            "Watch Trailer",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ]),
              ),
            );
          },
        );
      }),
    );
  }

  // Function to format the release date
  String _formatReleaseDate(int timestamp) {
    // Convert the timestamp to DateTime
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
        timestamp * 1000); // Multiply by 1000 if it's in seconds

    // Format the DateTime to the desired format (e.g., 'MMM dd, yyyy' for 'Mar 12, 2020')
    return DateFormat('MMM dd, yyyy').format(date);
  }
}


void _showCompanyInfo(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Company Info', textAlign: TextAlign.center),
        content: const SizedBox(
          // Set a fixed width for better alignment
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Company: Geeksynergy Technologies Pvt Ltd',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Address: Sanjayanagar, Bengaluru-56',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Phone: XXXXXXXXX09',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Email: XXXXXX@gmail.com',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
