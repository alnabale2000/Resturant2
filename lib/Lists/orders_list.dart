import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/constant.dart';
import 'package:resturant/firebase/firestore.dart';
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
    final _order = widget.order;
    final size = MediaQuery.of(context).size;

    return Dismissible(
      key: ValueKey<String>(_order.mealName),
      background: Container(
        color: Colors.red,
        child: Row(
          children: [
            kDismissibleIcon,
            Spacer(),
            kDismissibleIcon,
          ],
        ),
      ),
      onDismissed: (DismissDirection direction) {
        setState(() {
          FireStoreService()
              .deleteSingleOrderDocument(mealName: _order.mealName);
        });
      },
      child: Container(
        color: Colors.grey[200],
        width: double.infinity,
        height: size.height * 0.275,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: size.width * 0.45,
                  height: size.height * 0.275,
                  child: Image.network(
                    'https://i.ytimg.com/vi/IyOc_ksGCMk/maxresdefault.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 30,
                    width: size.width * 0.45,
                    color: Colors.black.withOpacity(0.45),
                    child: Center(
                      child: Text(
                        _order.mealName,
                        style: TextStyle(fontSize: 17.5, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_order.userName),
                Text('0798${_order.phoneNumber}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
