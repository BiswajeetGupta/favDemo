import 'package:flutter/material.dart';
import 'package:listviewdemo/provider/favouriteProvider.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
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
              itemCount: favProvider.selectedItem.length,
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
