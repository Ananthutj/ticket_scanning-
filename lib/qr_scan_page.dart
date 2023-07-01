

// ignore_for_file: unnecessary_this

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/colors.dart';
import 'package:intl/intl.dart';
import 'package:my_app/qr_display.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';



class HomePage extends StatefulWidget {
  
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String currentDate;

   late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  Student? _student;
  String? _route;
  DateTime? _expiryDate;
  String? _daysRemaining;
  String? _status;

    
    void _onQRViewCreated(QRViewController controller) {
    this._controller = controller;
    controller.scannedDataStream.listen((scanData) {
      _parseQRCodeData(scanData.code!);
    });
  }

  void _parseQRCodeData(String data) {
    try {
      final jsonData = jsonDecode(data);

      final studentData = jsonData['student'];
      final routeData = jsonData['route'];
      

      _student = Student.fromJson(studentData);
      _route = routeData['name'];
      _expiryDate = DateTime.parse(routeData['expiry_date']);
      _daysRemaining = routeData['days_remaining'];
      _status = routeData['status'];



      
     

      setState(() {
        // Update the UI with the parsed data
      });
    } catch (error) {
      print('Error parsing QR code data: $error');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    currentDate = _getCurrentDate();
  }

  String _getCurrentDate(){
    final now = DateTime.now();
    final formatter = DateFormat('dd MMMM,yyyy');
    return formatter.format(now);
  }

  List _places = ['Aluva', 'Vyttila'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kGreenMainTheme,
        body: Column(
          children: [
            Expanded(
                //1
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  // height: double.infinity,
                  // width: double.infinity,
                  color: kGreenMainTheme,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(height: 10,),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Scan Ticket',
                                      style: kWhiteHeadingSize,
                                    ),
                                    
              if (_student != null) ...[
                Text('Name: ${_student!.name}'),
                Text('ID: ${_student!.id}'),
              ],
              if (_route != null) Text('Route: $_route'),
              if (_expiryDate != null) Text('Expiry Date: ${_expiryDate.toString()}'),
              if (_daysRemaining != null) Text('Days Remaining: $_daysRemaining'),
              if(_status!=null) Text("Status: $_status"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      currentDate,
                                      style: kGreyTextStyle,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),

                      //  SizedBox(height: 20,),
                      Expanded(
                        flex: 0,
                        child: Container(
                          //color: Color.fromARGB(255, 178, 95, 95),
                          child: Column(
                            children: [
                              Image(
                                  height: 100,
                                  image:
                                      AssetImage('assets/images/ticket.png')),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                      //SizedBox(height: 40,),
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Conductor ID: 1234",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text("Name: Ravi",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            // SizedBox(height: 10,),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 11),
                              child: const Text(
                                "ROUTE",
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              decoration: const InputDecoration.collapsed(
                                  hintText: 'Select a route',
                                  hintStyle: TextStyle(
                                    color: kGreyTextColor,
                                  )),
                              style: kWhiteHeadingSize.copyWith(
                                  color: Colors.black),
                              items: _places.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text(e,
                                          style: kWhiteHeadingSize.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600))),
                                );
                              }).toList(),
                              dropdownColor: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                              onChanged: (Object? value) {
                                print(value);
                              },
                            ),
                          )
                        ]))),
            const SizedBox(height: 5),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(top: 0),
              padding: const EdgeInsets.only(top: 5),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(45),
                      topLeft: Radius.circular(45))),
              //height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        "Scan Ticket",
                        style: kBlackHeadingSize,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 45,
                        width: 130,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kGreenMainTheme,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NextPage(context)));
                          },
                          child: SizedBox(
                            
                             
                              child:  Icon(Icons.qr_code_scanner, color: Colors.white),
                            ),
                          ),
                    
                      ),
                    ],
                  ),
                ],
              ),
            ),
           ),
          ],
        ),
      ),
    );
  }  
}


class Student {
  final String name;
  final String id;

  Student({required this.name, required this.id});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      id: json['id'],
    );
  }
}




