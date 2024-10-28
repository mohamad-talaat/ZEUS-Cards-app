// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
 
// class CurrencyDropdown extends StatefulWidget {
//   final Function(String) onCurrencySelected;  

//   const CurrencyDropdown({super.key, required this.onCurrencySelected});

//   @override
//   _CurrencyDropdownState createState() => _CurrencyDropdownState();
// }

// class _CurrencyDropdownState extends State<CurrencyDropdown> {
//   List<DropdownMenuItem<String>> currencyItems = [];
//   String? selectedCurrencyCode;

//   Future<void> fetchCurrencies() async {
//     final response = await http.get(Uri.parse('https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/get-all-currencies'));

//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       if (jsonData['success'] == true) {
//         final currencies = jsonData['data'] as List;
//         setState(() {
//           currencyItems = currencies.map((currency) {
//             return DropdownMenuItem<String>(
//               value: currency['code'] as String,
//               child: Text(currency['name'] as String),
//             );
//           }).toList();
//         });
//       } else {
//         ('Error fetching currencies: ${jsonData['msg']}');
//       }
//     } else {
//       ('Network error fetching currencies.');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchCurrencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: selectedCurrencyCode,
//       hint: const Text('Select Currency'),
//       onChanged: (value) {
//         setState(() {
//           selectedCurrencyCode = value;
//         });
//         widget.onCurrencySelected(value!); // Notify parent
//       },
//       items: currencyItems,
//     );
//   }
// }