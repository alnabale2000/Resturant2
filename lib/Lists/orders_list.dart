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
      child: Column(
        children: [
          Card(
            color: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Container(
              //   color: Colors.grey[200],
              // color: Colors.green,
              width: double.infinity,
              height: size.height * 0.350,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Text(
                          _order.userName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        ": الاسم ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Text(
                          "0798${_order.phoneNumber}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        " :  الرقم ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    " : الموقع ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Container(
                          width: size.width * 0.45,
                          height: size.height * 0.130,
                          child: Image.network(
                            'https://i.ytimg.com/vi/IyOc_ksGCMk/maxresdefault.jpg',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 30,
                            width: size.width * 0.45,
                            // color: Colors.black.withOpacity(0.45),
                            child: Center(
                              child: Text(
                                _order.mealName,
                                style: TextStyle(
                                    fontSize: 24.5, color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              " : العدد",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 24.5, color: Colors.white),
                            ),
                          ),
                          Container(
                            child: Text(
                              " : الاضافات",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 24.5, color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
