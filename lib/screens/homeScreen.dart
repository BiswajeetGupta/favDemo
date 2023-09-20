import 'package:flutter/material.dart';
import 'package:listviewdemo/provider/favouriteProvider.dart';
import 'package:listviewdemo/repo/apiCall.dart';
import 'package:listviewdemo/screens/favouritescreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ApiCall().fetchUsers();

    Provider.of<FavouriteItem>(context,listen: false).fetchData();
  }

  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavouriteItem>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Fav"),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavouriteScreen(),
                    ));
              },
              child: const Icon(Icons.next_plan))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: favProvider.usersList.length,
              itemBuilder: (context, index) {
                return Consumer<FavouriteItem>(
                  builder: (context, value, child) => ListTile(
                    onTap: () {
                  
                      if (value.selectedItem.contains(value.usersList[index]['name'])) {
                        value.removeItem(value.usersList[index]['name']);
                      } else {
                        value.addItem(value.usersList[index]['name']);
                      }
                    },
                    title: Text(value.usersList[index]['name']),
                    trailing: Icon(value.selectedItem.contains(value.usersList[index]['name'])
                        ? Icons.favorite
                        : Icons.favorite_outline_outlined),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
