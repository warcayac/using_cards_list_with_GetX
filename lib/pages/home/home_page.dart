import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePage extends StatelessWidget {
  /* ---------------------------------------------------------------------------- */
  const HomePage({Key? key}) : super(key: key);
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    var _cards = Get.put(MyCardList());

    return Scaffold(
      appBar: AppBar(
        title: Text('Hi!'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Scrollbar(
                child: Obx(() => ListView.builder(
                    itemCount: _cards.cards.length,
                    itemBuilder: (context, index) => _cards.cards[index],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(2),
            height: 50,
            color: Colors.teal[100],
            child: Card(
              child: Row(
                children: [
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () => _cards.addCard(),
                    icon: Icon(Icons.add, color: Colors.red),
                  ),
                  SizedBox(width: 10),
                  Text('Add a card'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final int counter;

  const MyCard({Key? key, required this.counter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = Get.find<MyCardList>();
    var _index = _controller.cards.indexOf(this);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => _controller.delCard(_index), 
                  icon: Icon(Icons.delete_outline, color: Colors.pink[600])),
                SizedBox(width: 10),
                Expanded(child: Text('Any text you wanna see')),
                Text('Card # $_index', style: TextStyle(color: Colors.pink[600])),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton(
                    onPressed: () {}, 
                    child: Text(
                      'Counter: $counter', 
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(100, 45),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCardList extends GetxController {
  var cards = <MyCard>[].obs;
  var counter = 0;
  /* ---------------------------------------------------------------------------- */
  MyCardList();
  /* ---------------------------------------------------------------------------- */
  void addCard() => cards.add(MyCard(counter: ++counter));
  void delCard(int index) => cards.removeAt(index);
}
