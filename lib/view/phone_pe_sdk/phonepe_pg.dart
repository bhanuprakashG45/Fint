import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonepePg {
  final String environment;
  final bool enableLogging;
  final String appSchema;
  final String packageName;

  final String merchantId;
  final String saltKey;
  final String saltIndex;
  final String flowId;

  String? _lastTransactionId;
  Object? _lastResult;

  PhonepePg({
    this.environment = 'SANDBOX',
    this.enableLogging = true,
    this.appSchema = "com.example.fint",
    this.packageName = "com.phonepe.simulator",
    this.merchantId = "PGTESTPAYUAT",
    this.saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399",
    this.saltIndex = "1",
    this.flowId = "PGSTK",
  });
  Future<bool> initialize() async {
    try {
      final initialized = await PhonePePaymentSdk.init(
        environment,
        merchantId,
        flowId,
        enableLogging,
      );
      _lastResult = 'SDK Initialized: $initialized';
      print(1);
      return initialized;
    } catch (e) {
      _handleError(e);
      return false;
    }
  }

  Future<Map?> startPayment({
    required int amountInRupees,
    required String mobileNumber,
    String? description,
  }) async {
    try {
      _lastTransactionId = 'TXN${DateTime.now().millisecondsSinceEpoch}';

      final payload = {
        "merchantId": "MERCHANTUAT",

        "merchantTransactionId": "transaction_123",
        "merchantUserId": "902232501",
        "amount": 1000,
        "mobileNumber": "9999999999",
        "callbackUrl": "https://webhook.site/callback-url",
        "paymentInstrument": {
          "type": "UPI_INTENT",
          "targetApp": "com.phonepe.app",
        },
        "deviceContext": {"deviceOS": "ANDROID"},
      };

      final requestJson = jsonEncode(payload);
      print(2.1);

      final result = await PhonePePaymentSdk.startTransaction(
        requestJson,
        appSchema,
      );
      print(2);

      _lastResult = result;
      return result;
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<List<String>> getInstalledUpiApps() async {
    print(3);
    try {
      if (Platform.isAndroid) {
        print(4);
        final appsJson = await PhonePePaymentSdk.getUpiAppsForAndroid();
        if (appsJson == null) return [];

        final apps = jsonDecode(appsJson) as List;
        return apps.map((app) => app['com.example.fint'].toString()).toList();
      } else if (Platform.isIOS) {
        final apps = await PhonePePaymentSdk.getInstalledUpiAppsForiOS();
        return apps?.whereType<String>().toList() ?? [];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  void _handleError(dynamic error) {
    _lastResult = error.toString();
    debugPrint('PhonePe Error: $_lastResult');
  }

  String? get lastTransactionId => _lastTransactionId;

  Object? get lastResult => _lastResult;
}






// class PhonepePg extends StatefulWidget {
//   const PhonepePg({super.key});

//   @override
//   State<PhonepePg> createState() => _PhonepePgState();
// }

// class _PhonepePgState extends State<PhonepePg> {
//   String request = "";
//   String appSchema = "flutterDemoApp";

//   Map<String, String> headers = {};
//   List<String> environmentList = <String>['SANDBOX', 'PRODUCTION'];
//   bool enableLogs = true;
//   Object? result;
//   String environmentValue = 'SANDBOX';
//   String merchantId = "";
//   String flowId = "";
//   String packageName = "com.phonepe.simulator";

//   void initPhonePeSdk() {
//     PhonePePaymentSdk.init(environmentValue, merchantId, flowId, enableLogs)
//         .then(
//           (isInitialized) => {
//             setState(() {
//               result = 'PhonePe SDK Initialized - $isInitialized';
//             }),
//           },
//         )
//         .catchError((error) {
//           handleError(error);
//           return <dynamic>{};
//         });
//   }

//   void startTransaction() async {
//     try {
//       PhonePePaymentSdk.startTransaction(request, appSchema)
//           .then(
//             (response) => {
//               setState(() {
//                 if (response != null) {
//                   String status = response['status'].toString();
//                   String error = response['error'].toString();
//                   if (status == 'SUCCESS') {
//                     result = "Flow Completed - Status: Success!";
//                   } else {
//                     result =
//                         "Flow Completed - Status: $status and Error: $error";
//                   }
//                 } else {
//                   result = "Flow Incomplete";
//                 }
//               }),
//             },
//           )
//           .catchError((error) {
//             handleError(error);
//             return <dynamic>{};
//           });
//     } catch (error) {
//       handleError(error);
//     }
//   }

//   void getInstalledUpiAppsForiOS() {
//     PhonePePaymentSdk.getInstalledUpiAppsForiOS()
//         .then(
//           (apps) => {
//             setState(() {
//               result = 'getUPIAppsInstalledForIOS - $apps';

//               // For Usage
//               List<String> stringList =
//                   apps
//                       ?.whereType<
//                         String
//                       >() // Filters out null and non-String elements
//                       .toList() ??
//                   [];

//               // Check if the string value 'Orange' exists in the filtered list
//               String searchString = 'PHONEPE';
//               bool isStringExist = stringList.contains(searchString);

//               if (isStringExist) {
//                 print('$searchString app exist in the device.');
//               } else {
//                 print('$searchString app does not exist in the list.');
//               }
//             }),
//           },
//         )
//         .catchError((error) {
//           handleError(error);
//           return <dynamic>{};
//         });
//   }

//   void getInstalledApps() {
//     if (Platform.isAndroid) {
//       getInstalledUpiAppsForAndroid();
//     } else {
//       getInstalledUpiAppsForiOS();
//     }
//   }

//   void getInstalledUpiAppsForAndroid() {
//     PhonePePaymentSdk.getUpiAppsForAndroid()
//         .then(
//           (apps) => {
//             setState(() {
//               if (apps != null) {
//                 Iterable l = json.decode(apps);
//                 List<UPIApp> upiApps = List<UPIApp>.from(
//                   l.map((model) => UPIApp.fromJson(model)),
//                 );
//                 String appString = '';
//                 for (var element in upiApps) {
//                   appString +=
//                       "${element.applicationName} ${element.version} ${element.packageName}";
//                 }
//                 result = 'Installed Upi Apps - $appString';
//               } else {
//                 result = 'Installed Upi Apps - 0';
//               }
//             }),
//           },
//         )
//         .catchError((error) {
//           handleError(error);
//           return <dynamic>{};
//         });
//   }

//   void handleError(error) {
//     setState(() {
//       if (error is Exception) {
//         result = error.toString();
//       } else {
//         result = {"error": error};
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             margin: EdgeInsets.all(7),
//             child: Column(
//               children: <Widget>[
//                 TextField(
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Merchant Id',
//                   ),
//                   onChanged: (text) {
//                     merchantId = text;
//                   },
//                 ),
//                 TextField(
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Flow Id',
//                   ),
//                   onChanged: (text) {
//                     flowId = text;
//                   },
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     const Text('Select the environment'),
//                     DropdownButton<String>(
//                       value: environmentValue,
//                       icon: const Icon(Icons.arrow_downward),
//                       elevation: 16,
//                       underline: Container(height: 2, color: Colors.black),
//                       onChanged: (String? value) {
//                         setState(() {
//                           environmentValue = value!;
//                           if (environmentValue == 'PRODUCTION') {
//                             packageName = "com.phonepe.app";
//                           } else if (environmentValue == 'SANDBOX') {
//                             packageName = "com.phonepe.simulator";
//                           }
//                         });
//                       },
//                       items: environmentList.map<DropdownMenuItem<String>>((
//                         String value,
//                       ) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//                 Visibility(
//                   maintainSize: false,
//                   maintainAnimation: false,
//                   maintainState: false,
//                   visible: Platform.isAndroid,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       const SizedBox(height: 10),
//                       Text("Package Name: $packageName"),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   children: <Widget>[
//                     Checkbox(
//                       value: enableLogs,
//                       onChanged: (state) {
//                         setState(() {
//                           enableLogs = state!;
//                         });
//                       },
//                     ),
//                     const Text("Enable Logs"),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'Warning: Init SDK is Mandatory to use all the functionalities*',
//                   style: TextStyle(color: Colors.red),
//                 ),
//                 ElevatedButton(
//                   onPressed: initPhonePeSdk,
//                   child: const Text('INIT SDK'),
//                 ),
//                 const SizedBox(width: 5.0),
//                 TextField(
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'request',
//                   ),
//                   onChanged: (text) {
//                     request = text;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: startTransaction,
//                         child: const Text('Start Transaction'),
//                       ),
//                     ),
//                     const SizedBox(width: 5.0),
//                   ],
//                 ),
//                 ElevatedButton(
//                   onPressed: getInstalledUpiApps,
//                   child: const Text('Get Installed Apps'),
//                 ),
//                 Text("Result: \n $result"),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }