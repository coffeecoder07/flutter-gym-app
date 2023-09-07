import 'package:flutter/material.dart';
import 'package:gymapp/Providers/DataProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchComponent extends StatefulWidget {

  const SearchComponent({super.key});

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  final controller = TextEditingController();
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) async{
      final query = prefs.getString('query');
      if(query!=null){
        print("$query/Hello");
        controller.value = TextEditingValue(text: query);
      }
    });
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: TextField(
        cursorColor: Theme.of(context).primaryColor,
        controller: controller,
        onChanged: (value){
          final dataProvider = Provider.of<DataProvider>(context,listen: false);
          dataProvider.search(value);
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,

            hintText: "Search by gym name",

            suffixIcon: Container(
              width: 55,
              height: 45,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(1000)),
              child: const Icon(
                Icons.search_rounded,
                color: Colors.white,
              ),
            ),

            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1000),
                borderSide: BorderSide.none),),
      ),
    );
  }
}
