import 'package:drag/customer.dart';
import 'package:flutter/material.dart';
import 'item.dart';

class OrderPage extends StatefulWidget {
  final String customerName;
  final List<Item> selectedFood;

  const OrderPage({
    Key? key,
    required this.customerName,
    required this.selectedFood,
  }) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Захиалгын хуудас ',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Color.fromARGB(255, 185, 185, 185),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Хэрэглэгчийн нэр: ${widget.customerName}',
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedFood.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  // key: Key(widget.selectedFood[index].uid.toString()),
                  onDismissed: (direction) {
                    setState(() {
                      widget.selectedFood.removeAt(index);
                    });

                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Хоол устлаа')));
                  },
                  background: Container(
                    color: Colors.red,
                  ),
                  child: ListTile(
                    title: Text(widget.selectedFood[index].name),
                    subtitle: Text(
                        'Price: \$${widget.selectedFood[index].formattedTotalItemPrice}'),
                    leading: CircleAvatar(
                      backgroundImage: widget.selectedFood[index].imageProvider,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (widget.selectedFood.isNotEmpty) {
                  String dismissedInfo = 'Захиалга: ';
                  for (Item item in widget.selectedFood) {
                    dismissedInfo += '${item.name}, ';
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(dismissedInfo)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Захиалга хоосон байна')),
                  );
                }
              },
              child: Text('Захиалга баталгаажуулах'),
            ),
          )
        ],
      ),
    );
  }
}
