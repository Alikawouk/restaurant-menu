import 'package:flutter/material.dart';
import 'package:selection/items.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _sum = 0;
  bool _showSelected = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      screenWidth = screenWidth * 0.8;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Total price is $_sum \$'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _showSelected = false;
                    _sum = 0;
                    for (var e in items) {
                      e.selected = false;
                    }
                  });
                },
                icon: const Icon(Icons.remove_shopping_cart_sharp)),
            IconButton(
                onPressed: () {
                  setState(() {
                    _showSelected = true;
                  });
                },
                icon: const Icon(Icons.shopping_cart)),
          ],
        ),
        body: _showSelected
            ? ShowSelectedItems(
                width: screenWidth,
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.2,
                          ),
                          Checkbox(
                              value: items[index].selected,
                              onChanged: (e) {
                                setState(() {
                                  items[index].selected = e as bool;
                                  if (items[index].selected == true) {
                                    _sum += items[index].price;
                                  } else {
                                    _sum -= items[index].price;
                                  }
                                });
                              }),
                          Text(items[index].toString())
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.network(
                        items[index].image,
                        height: screenWidth * 0.5,
                      )
                    ],
                  );
                },
              ));
  }
}

class ShowSelectedItems extends StatelessWidget {
  ShowSelectedItems({required this.width, super.key});
  double width;

  @override
  Widget build(BuildContext context) {
    List<Item> selectedItems = [];
    for (var e in items) {
      if (e.selected == true) {
        selectedItems.add(e);
      }
    }
    return ListView.builder(
      itemCount: selectedItems.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(selectedItems[index].toString()),
            const SizedBox(
              height: 10,
            ),
            Image.network(
              selectedItems[index].image,
              height: width * 0.5,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
