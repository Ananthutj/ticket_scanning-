import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/qr_scan_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  NextPage(BuildContext context);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  Student? _student;
  String? _route;
  String? _daysRemaining;
  DateTime? _expiryDate;
  String? _status;

 

  void startScanning() {
    if (_controller != null) {
      _controller.resumeCamera();
      _controller.scannedDataStream.listen((scanData) {
        _parseQRCodeData(scanData.code!);
      });
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this._controller = controller;
    startScanning();
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Display(_student,_route,_expiryDate,_daysRemaining,_status)));
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
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Student Bus Pass'),
    ),
    body: Container(
      child: 
        Center(
          
          child: QRView(
            key: _qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.green,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
        ),
        
        
        )
        
        );
}
}

       

class Display extends StatelessWidget {
final Student? _student;
  final String? _route;
  final DateTime? _expiryDate;
  final String? _daysRemaining;
  final String? _status;

  const Display(this._student, this._route, this._expiryDate, this._daysRemaining,this._status);


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: kGreenMainTheme,
      //ackgroundColor: kGreenMainTheme,
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 1,
            child: Container(
                color: kGreenMainTheme,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: const Text(
                          "Ticket Details",
                          style: kWhiteHeadingSize,
                        )),
                    Container(),
                  ],
                )),
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: Center(
                child: Container(
                  // color: Colors.white,
                  margin: const EdgeInsets.all(34),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: kGreyTextColor.withOpacity(1),
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                      child: Container(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_student != null) ...[
                      Text('Name: ${_student!.name}',style: kGreyTextTicketStyle,),
                       Text('ID: ${_student!.id}',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                       ],
                      const SizedBox(height: 40),
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Route: ",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                           Text(_route!,style: kBlackTicketTextSize,),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // const Text(
                            //   "Stop: ",
                            //   style: TextStyle(
                            //       fontSize: 18,
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.w700),
                            // ),
                            // Text(
                            //   " ${widget.stop}",
                            //   style: kBlackTicketTextSize,
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          
                            if(_daysRemaining != null) Text('Days Remaining: ',style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),),
                                  Text(_daysRemaining!,style: kBlackTicketTextSize,),                           
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // const Text(
                            //   "Issue Date: ",
                            //   style: TextStyle(
                            //       fontSize: 18,
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.w700),
                            // ),
                            // Text(
                            //   " ${issueDate.getFormattedDate()}",
                            //   style: kBlackTicketTextSize,
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            
                            if (_expiryDate != null) Text('Expiry Date: ',style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                                ),
                                Text(_expiryDate.toString().split(' ')[0],style: kBlackTicketTextSize,),
                            ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text("Status", style: kGreyTextTicketStyle),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            Text(_status!,
                                style: TextStyle(
                                    color: kStatusColor,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ],
                    
                  ),
                 )
                ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40),
          ),
          Expanded(
            flex: 1,
            child: FractionallySizedBox(
              heightFactor: 1.3,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(45),
                        topLeft: Radius.circular(45))),
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: const BorderSide(
                                          width: 1, color: kGreenMainTheme))),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(100, 50))),
                          child: const Text("Home",
                              style: TextStyle(
                                  color: kGreyTextColor, fontSize: 18))),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kGreenMainTheme),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: const BorderSide(
                                        width: 1, color: kGreenMainTheme))),
                            fixedSize:
                                MaterialStateProperty.all(const Size(110, 50))),
                        onPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>NextPage(context)));  
                        },
                        label: const Text(
                          'Next',
                          style: TextStyle(fontSize: 17),
                        ),
                        icon: Container(
                          width: 33,
                          height: 35,
                          child: Image.asset(
                            'assets/images/scan_icon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

      // body:Center(
          
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text('Student Details'),
      //         if (_student != null) ...[
      //           Text('Name: ${_student!.name}'),
      //           Text('ID: ${_student!.id}'),
      //         ],
      //         if (_route != null) Text('Route: $_route'),
      //         if (_expiryDate != null) Text('Expiry Date: ${_expiryDate.toString()}'),
      //         if (_daysRemaining != null) Text('Days Remaining: $_daysRemaining'),
      //         ElevatedButton(onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage())); }, child: Text("Back")),
      //       ],
      //     ),
      //   ),
    