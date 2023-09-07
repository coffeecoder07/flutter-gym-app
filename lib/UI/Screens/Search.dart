import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymapp/UI/Components/SuggestionListTile.dart';

class SearchView extends SearchDelegate<String> {
  final List list;

  SearchView({required this.list});

  @override
  // TODO: implement textInputAction
  TextInputAction get textInputAction => super.textInputAction;

  @override
  // TODO: implement keyboardType
  TextInputType? get keyboardType => super.keyboardType;

  @override
  void showResults(BuildContext context) {}

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          titleSpacing: 0,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.grey.shade700.withOpacity(.8)),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            enabledBorder: InputBorder.none));
  }

  @override
  String get searchFieldLabel => "Search Location";

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      const Row(
        children: [
          Text(
            "Noida",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          )
        ],
      ),
      // IconButton(
      //   icon: Icon(
      //     Icons.clear,
      //     color: Colors.black,
      //   ),
      //   onPressed: () {
      //     query = "";
      //   },
      // )
    ];
  }

  // Future<List<ArticleModel>?> searchArticle(String query) async {
  //   return await ApiFunctions.getData(url: ApiConfig.searchPost(query))
  //       .then((response) async {
  //     if (response['status'] == true) {
  //       final sitesData = response['data']['posts'] as List;
  //       final posts = sitesData.map((e) => ArticleModel.fromMap(e)).toList();
  //       return Future.value(posts);
  //     }
  //     return Future.error("Error Occur");
  //   }).onError((error, stackTrace) {
  //     return Future.error('$error');
  //   });
  // }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: const Icon(
        Icons.arrow_circle_left_outlined,
        color: Colors.black,
        size: 24,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    close(context, "");
    return Container();
  }

  @override
  PreferredSizeWidget buildBottom(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    const Icon(
                      Icons.my_location_rounded,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Around Your Location",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    const Expanded(child: SizedBox()),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                      size: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              )),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(
                  Icons.edit_location_alt_rounded,
                  size: 20,
                ),
              )
            ],
          ),
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        itemBuilder: (_, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text.rich(
                style: const TextStyle(fontSize: 20),
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'AREA ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    const TextSpan(
                      text: '( No of gyms )',
                      style: TextStyle(color: Colors.black,fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SuggestionListTile();
        },
        separatorBuilder: (_, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 10);
    // TODO: implement buildSuggestions
    // final List articles = await WpApis.searchPost(keyword: query);
    // final searchList = list.where((element) => element.name.toString().toLowerCase().startsWith(query)||element.number.toString().toLowerCase().startsWith(query) ).toList();
    // return FutureBuilder(
    //     future: searchArticle(query),
    //     builder: (_, AsyncSnapshot<List<ArticleModel>?> snapShot) {
    //       final articles = snapShot.data;
    //       if (snapShot.hasData && articles != null) {
    //         return ListView.separated(
    //           padding: const EdgeInsets.symmetric(vertical: 10),
    //           separatorBuilder: (context, index) {
    //             return const SizedBox(
    //               height: 10,
    //             );
    //           },
    //           itemCount: articles.length,
    //           itemBuilder: (context, index) {
    //             return SmallTile(
    //               article: articles[index],
    //               index: index,
    //               onTap: () {
    //                 Navigator.pushNamed(context, '/readSingleArticle', arguments:articles[index]);
    //               },
    //             );
    //           },
    //         );
    //       } else if (snapShot.hasError) {
    //         return Center(
    //           child: Text("Error Hai" + snapShot.error.toString()),
    //         );
    //       } else if (snapShot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: Text("Connecting..."),
    //         );
    //       } else if (snapShot.data == null) {
    //         return const Center(
    //           child: Text("No data Found"),
    //         );
    //       } else {
    //         return const Center(
    //           child: Text("Initial"),
    //         );
    //       }
    //     });
  }
}
