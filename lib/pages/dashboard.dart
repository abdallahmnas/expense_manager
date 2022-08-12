import 'dart:io';

import 'package:expense_management/components/custom_widgets.dart';
import 'package:expense_management/pages/profile.dart';
import 'package:expense_management/utils/temp_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/colors.dart';
import '../utils/colors.dart';
import '../utils/temp_merchant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  File? selectedImage;
  List myList = [];
  List<Map> exp_status = [
    {'status': 'New'},
    {'status': 'Refurbished'}
  ];
  String selectedMerchant = temp_merchant[0]['name'];
  String selectedStatus = '';
  String selectedDate = '';
  List<Map> filter_merchant = [];
  Map filter = {'min': null, 'max': null, 'merchant': '', 'status': ''};

  TextEditingController priceController = TextEditingController(text: '0');
  TextEditingController commentController = TextEditingController(text: '');
  TextEditingController filterMinController = TextEditingController(text: '0');
  TextEditingController filterMaxController = TextEditingController(text: '0');
  Map selectedExpesne = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      filter_merchant.add({'name': 'All'});
      temp_merchant.forEach((element) {
        filter_merchant.add(element);
      });
      selectedStatus = exp_status[0]['status'];
      myList = temp_expense;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Expense Manager',
          style: TextStyle(color: primary_color),
        ),
        backgroundColor: appBar_color,
        actions: [
          GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile())),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.person,
                  color: primary_color,
                ),
              ))
        ],
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Filter Expense'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () => {
                            filter['merchant'] = '',
                            PopDialog(
                                context: context,
                                widget: SizedBox(
                                    child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: MyField(
                                              hint: 'min',
                                              kType: 'number',
                                              controller: filterMinController),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: MyField(
                                              hint: 'max',
                                              kType: 'number',
                                              controller: filterMaxController),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // MyField(),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),
                                    DropdownButtonFormField(
                                      items: filter_merchant.map((Map loc) {
                                        return new DropdownMenuItem(
                                          value: loc['name'],
                                          child: Text(loc['name']),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        // do other stuff with _category
                                        print(newValue);
                                        setState(() {
                                          // selectedMerchant =
                                          //     newValue.toString();
                                          filter['merchant'] =
                                              newValue.toString();
                                        });
                                      },
                                      value: filter_merchant[0]['name'],
                                      decoration: InputDecoration(
                                        hintText: "Select Merchant",
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.greenAccent,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    InkBtn(
                                        context: context,
                                        text: 'Filter',
                                        onClick: () => setFilter())
                                  ],
                                )))
                          },
                      child: Icon(Icons.search)),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: myList.length,
              itemBuilder: (context, index) => Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () => updateDialog(index, myList[index]),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: primary_color, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          '${myList[index]['merchant']} - \$${myList[index]['total']}',
                                          style: TextStyle(
                                              color: primary_color,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        '${myList[index]['date']}',
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        'Comment: ${myList[index]['comment']}',
                                        textAlign: TextAlign.start,
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  '${myList[index]['status']}',
                                  style: TextStyle(
                                      color: myList[index]['status']
                                                  .toString()
                                                  .toLowerCase() ==
                                              'new'
                                          ? Colors.red
                                          : Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary_color,
        onPressed: () {
          priceController.text = '0';
          commentController.text = '';
          selectedStatus = exp_status[0]['status'];
          PopDialog(
              context: context,
              title: 'Add Expense',
              widget: ListView(
                shrinkWrap: true,
                children: [
                  DropdownButtonFormField(
                    items: temp_merchant.map((Map loc) {
                      return new DropdownMenuItem(
                        value: loc['name'],
                        child: Text(loc['name']),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      // do other stuff with _category
                      print(newValue);
                      setState(() {
                        selectedMerchant = newValue.toString();
                      });
                    },
                    value: selectedMerchant,
                    decoration: InputDecoration(
                      hintText: "Select Merchant",
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 1.0),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 1.0),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MyField(
                      hint: '\$', kType: 'number', controller: priceController),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(flex: 1, child: Text('Choose Date')),
                      GestureDetector(
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1990, 1, 1),
                              maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                            setState(() {
                              selectedDate = (date).toString().split(' ')[0];
                            });
                            print('change ${(date).toString().split(' ')[0]}');
                          }, onConfirm: (date) {
                            print('confirm $date');
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.date_range),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MyField(hint: 'Comment', controller: commentController),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField(
                    items: exp_status.map((Map sts) {
                      return new DropdownMenuItem(
                        value: sts['status'],
                        child: Text(sts['status']),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      // do other stuff with _category
                      print(newValue);
                      setState(() {
                        selectedStatus = newValue.toString();
                      });
                    },
                    value: selectedStatus,
                    decoration: InputDecoration(
                      hintText: "Select Status",
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 1.0),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 1.0),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text('Select Reciept')),
                        GestureDetector(
                          onTap: () => pickImage(),
                          child: CircleAvatar(
                            child: Icon(Icons.upload),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  // Image Not Updating
                  // Container(
                  //   child: selectedImage == null
                  //       ? Text('No Image')
                  //       : Image.file(selectedImage!),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  InkBtn(
                      context: context,
                      text: 'Submit',
                      onClick: () {
                        addToList();
                        Navigator.pop(context);
                      }),
                ],
              ));
        },
        tooltip: '-',
        child: const Icon(Icons.add),
      ),
    );
  }

// Set Filter
  void setFilter() {
    setState(() {
      myList = temp_expense;
    });
    List<Map> filterList = [];
    if (filterMinController.text != '' && filterMaxController.text != '') {
      for (var element in myList) {
        if (double.parse(element['total'].toString()) >=
                double.parse(filterMinController.text) &&
            double.parse(element['total'].toString()) <=
                double.parse(filterMaxController.text) &&
            double.parse(filterMaxController.text) != 0 &&
            ((filter['merchant'] != '' &&
                    filter['merchant'].toString().toLowerCase() != 'all')
                ? filter['merchant'] == element['merchant']
                : true)) {
          filterList.add(element);
        }
      }

      setState(() {
        print(filterList.toString());
        myList = filterList.length != 0 ? filterList : temp_expense;
      });
    }
    // myList.forEach((element) {

    // });
  }

  //My Dialog

  Future<void> MyDialog({widget, context, title = ''}) async {
    StateSetter _setState;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            // You need this, notice the parameters below:
            builder: (BuildContext context, StateSetter setState) {
              _setState = setState;
              return widget;
            },
          ),
        );
      },
    );
  }

  //Add
  void addToList() {
    setState(() {
      myList.add(
        {
          'date': selectedDate,
          'merchant': selectedMerchant,
          'total': priceController.text,
          'status': selectedStatus,
          'comment': commentController.text,
          'reciept': ''
        },
      );
      priceController.text = '0';
      commentController.text = '';
      print('Added');
    });
  }

  //Update
  void updateDialog(index, data) {
    setState(() {
      print(data);
      priceController.text = '${data['total']}';
      commentController.text = data['comment'];
      selectedStatus = data['status'];
    });
    PopDialog(
        context: context,
        title: 'Update Expense',
        widget: ListView(
          shrinkWrap: true,
          children: [
            DropdownButtonFormField(
              items: temp_merchant.map((Map loc) {
                return new DropdownMenuItem(
                  value: loc['name'],
                  child: Text(loc['name']),
                );
              }).toList(),
              onChanged: (newValue) {
                // do other stuff with _category
                print(newValue);
                setState(() {
                  selectedMerchant = newValue.toString();
                });
              },
              value: selectedMerchant,
              decoration: InputDecoration(
                hintText: data['status'],
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 1.0),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 1.0),
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            MyField(hint: '\$', kType: 'number', controller: priceController),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Text('Choose Date')),
                GestureDetector(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1990, 1, 1),
                        maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                      setState(() {
                        selectedDate = (date).toString().split(' ')[0];
                      });
                      print('change ${(date).toString().split(' ')[0]}');
                    }, onConfirm: (date) {
                      print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.date_range),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            MyField(hint: 'Comment', controller: commentController),
            SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
              items: exp_status.map((Map sts) {
                return new DropdownMenuItem(
                  value: sts['status'],
                  child: Text(sts['status']),
                );
              }).toList(),
              onChanged: (newValue) {
                // do other stuff with _category
                print(newValue);
                setState(() {
                  print(newValue);
                  selectedStatus = newValue.toString();
                });
              },
              // value: data['status'],
              decoration: InputDecoration(
                hintText: data['status'],
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 1.0),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 1.0),
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text('Select Reciept')),
                  GestureDetector(
                    onTap: () => pickImage(),
                    child: CircleAvatar(
                      child: Icon(Icons.upload),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Image Not Updating
            // Container(
            //   child: selectedImage == null
            //       ? Text('No Image')
            //       : Image.file(selectedImage!),
            // ),
            SizedBox(
              height: 15,
            ),
            InkBtn(
                context: context,
                text: 'Submit',
                onClick: () {
                  setState(() {
                    myList[index] = {
                      'date':
                          selectedDate != '' ? selectedDate : data['status'],
                      'merchant': selectedMerchant,
                      'total': priceController.text,
                      'status': selectedStatus != ''
                          ? selectedStatus
                          : data['status'],
                      'comment': commentController.text,
                      'reciept': ''
                    };
                  });
                  Navigator.pop(context);
                }),
          ],
        ));
  }

//  Upload Image

//  Image Picker
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.selectedImage = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Dialog
}
