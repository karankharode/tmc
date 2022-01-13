import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tmc/constants/colors.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _scrollController = ScrollController(initialScrollOffset: 50.0);
  DateTime selectedDate = DateTime.now();
  String tempStatus = 'Failed';
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  final double alertIconBoxheight = 40;

  showTransactionDetails() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              // scrollable: true,
              content: Container(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: alertIconBoxheight / 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: Color(0xff0481B3), width: 8),
                        borderRadius: BorderRadius.all(Radius.circular(53)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('TRANSACTION DETAILS'),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon: Icon(Icons.cancel_outlined, color: Colors.black),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, right: 18),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    dataColumn(heading: "Transaction ID", value: 'A113459'),
                                    dataColumn(heading: "Service", value: 'Mobicare'),
                                    dataColumn(heading: "Timestamp", value: '2022/01/15 14:11:13'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    dataColumn(heading: "Amount", value: 'RM110.00'),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 18, 8, 18),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Status",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                                width: 132,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color(0xff8492A6), width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(Radius.circular(5))),
                                                child: DropdownButton<String>(
                                                  focusColor: Colors.red,
                                                  value: tempStatus,
                                                  //elevation: 5,
                                                  isExpanded: true,
                                                  style: TextStyle(color: Colors.white),
                                                  iconEnabledColor: Colors.black,
                                                  underline: Container(),
                                                  items: <String>[
                                                    "Success",
                                                    "Failed",
                                                    "Pending",
                                                    "Cancelled",
                                                  ].map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Container(
                                                        child: Text(
                                                          value,
                                                          style:
                                                              TextStyle(color: Color(0xff8492A6)),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  hint: Text(
                                                    "Select Service",
                                                    style: TextStyle(
                                                        color: Color(0xff8492A6),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  onChanged: (String? val) {
                                                    if (val != null) {
                                                      setState(() {
                                                        tempStatus = val;
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    dataColumn(
                                        heading: "Failure reason", value: 'Connection Timeout'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    dataColumn(heading: "Name", value: 'Ranushah Rajah'),
                                    dataColumn(heading: "Payment Method", value: 'Online Banking'),
                                    dataColumn(heading: "Bank/Card Name", value: 'Maybank'),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
    );
  }

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
                  width: 220,
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
                      enabled: true,
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.only(left: 16),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: selectedDate.toString(),
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
                                        InkWell(
                                          onTap: () {
                                            showTransactionDetails();
                                          },
                                          child: Text(' View transaction Details...',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              )),
                                        ),
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

class dataColumn extends StatelessWidget {
  const dataColumn({Key? key, required this.heading, required this.value}) : super(key: key);
  final String heading;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 18, 8, 18),
          child: Column(
            children: [
              Text(
                heading,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                value,
                style: TextStyle(
                  color: Color(0xaa47525E),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
