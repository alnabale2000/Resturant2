import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/models/order.dart';

class OrdersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context);
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 1,
        color: Colors.green,
      ),
      itemCount: orders?.length ?? 0,
      itemBuilder: (context, index) {
        return OrderCard(
          order: orders[index],
        );
      },
    );
  }
}

class OrderCard extends StatefulWidget {
  final Order order;

  OrderCard({this.order});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          'https://i.ytimg.com/vi/IyOc_ksGCMk/maxresdefault.jpg',
          fit: BoxFit.fill,
        ),
        title: Text(
          widget.order.mealName,
        ),
      ),
    );
  }
}
