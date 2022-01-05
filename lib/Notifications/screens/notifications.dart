import 'package:flutter/material.dart';
import 'package:tmc/constants/colors.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _scrollController = ScrollController(initialScrollOffset: 50.0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryAccent,
      child: Column(
        children: [
          // top search row
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 18, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // search bar
                Container(
                  width: 200,
                  height: 42,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: Icon(
                        Icons.search,
                        color: grey,
                        size: 18,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Search Transaction',
                      hintText: 'Search Transactions',
                    ),
                  ),
                ),

                // date field
                Container(
                  width: 200,
                  height: 42,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.zero,
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: grey,
                        size: 28,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: '   Date ',
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
              child: Scrollbar(
            isAlwaysShown: true,
            showTrackOnHover: true,
            controller: _scrollController,
            hoverThickness: 10.0,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 20,
                itemBuilder: (context, index) => Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: index % 2 == 0 ? tableDarkColor : white,
                          border:
                              Border.symmetric(horizontal: BorderSide(color: grey, width: 0.5))),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Center(
                                  child: Container(
                                      height: 7,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: notifierColor)),
                                ),
                              )),
                          Expanded(
                              flex: 12,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Note - Transaction Status Updated',
                                        style: TextStyle(
                                          color: notifierColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        )),
                                    Row(
                                      children: [
                                        Text(
                                            'Status for transaction ID D2696969 has been updated so you can go and check',
                                            style: TextStyle(
                                              fontSize: 12,
                                            )),
                                        Text(' View transaction Details...',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 3,
                              child: Container(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 14),
                                      child: Text(
                                        '22/03/2000',
                                        style: TextStyle(
                                            color: bgColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    )),
                              )),
                        ],
                      ),
                    )),
          ))
        ],
      ),
    );
  }
}
