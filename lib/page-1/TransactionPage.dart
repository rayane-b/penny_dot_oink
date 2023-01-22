import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/database/tblModel.dart';
import 'package:myapp/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'EditTransaction.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  TransactionPageState createState() => TransactionPageState();
}

class TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top:20,bottom: 20,right: 10,left: 10),

      width: double.infinity,
        decoration: const BoxDecoration (
                 color: Color(0xff252525),
               ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left:10, bottom:10, top: 20),
            child: Text("Transactions", style: TextStyle(color: Color(0xffffffff), fontSize: 26,),textAlign: TextAlign.left,),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 5,right: 5),
              //width: double.infinity,
              decoration: const BoxDecoration (
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xff2f2f2f),
              ),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                child: Column(
                  children: List.generate(tblModel.list.length, (index) => Padding(
                    padding: const EdgeInsets.only(top:10,bottom: 10),
                    child:
                    Slidable(
                      key: const ValueKey(0),

                      endActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: null,


                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(

                            onPressed: (BuildContext context) {
                              setState(() {
                                tblModel.list.removeAt(index);
                              });
                            },

                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                          ),
                          SlidableAction(
                            onPressed: (BuildContext context) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const EditTransaction()),
                              );
                            },
                            backgroundColor: Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                          ),
                        ],
                      ), child:
                    Padding(
                      padding: const EdgeInsets.only(top:10,bottom: 10),
                      child: Row(
                        children: [
                          const Spacer(),
                          Text(tblModel.list.elementAt(index).name, style:TextStyle(color: Color(0xffffffff,), fontSize: 18)),
                          const Spacer(flex: 2,),
                          Text("${tblModel.list.elementAt(index).date.day}-${tblModel.list.elementAt(index).date.month}-${tblModel.list.elementAt(index).date.year}", style:TextStyle(color: Color(0xff878787), fontSize: 18)),
                          const Spacer(flex: 2,),
                          Text(tblModel.list.elementAt(index).price.toString(), style:TextStyle(color: Color(0xffffffff), fontSize: 18)),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  ),
                ),
              ),
              );},
            ),
            ),
          ),
        ],
      ),
    );
  }

  getTransactionHistory() {
    //return null;
  }

  Widget getCategories() {
    List<Widget> listChildren = [],
        rowChildren = [];
    for (int i = 0; i < tblModel.list.length; i++) {
      if ((rowChildren.length <= 1)) {
        rowChildren.add(rowChild(tblModel.list[i]));
        if (rowChildren.length == 2) {
          listChildren.add(Row(children: rowChildren));
          rowChildren = [];
        }
      }
    }
    return Column(
    );
  }
  Widget rowChild(tblModel model) {
    return Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          model.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}