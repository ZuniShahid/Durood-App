import 'dart:convert';

import 'package:durood_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/no_data_widget.dart';

class CountriesShownScreen extends StatefulWidget {
  @override
  _CountriesShownScreenState createState() => _CountriesShownScreenState();
}

class _CountriesShownScreenState extends State<CountriesShownScreen> {
  final AuthController _authController = Get.find<AuthController>();

  Future<Map<String, dynamic>> fetchData() async {
    var headers = {
      "Authorization": "Bearer ${_authController.accessToken.value}",
    };

    var response =
        await http.get(Uri.parse('https://eramsaeed.com/Durood-App/api/salawat/countries'), headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Durood',
          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Image.asset(
          //   Assets.imagesAfrica,
          //   height: 100.w,
          //   width: 100.w,
          //   fit: BoxFit.cover,
          // ),
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  Map<String, dynamic> data = snapshot.data!;

                  if (data['Error'] == false) {
                    Map<String, dynamic> countriesData = data['data'];

                    if (countriesData.isEmpty) {
                      return const Center(
                        child: NoDataWidget(
                          text: 'No data available.',
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(24.0),
                      itemCount: countriesData.length,
                      itemBuilder: (context, index) {
                        String countryName = countriesData.keys.elementAt(index);
                        int count = countriesData[countryName];

                        return ListTile(
                          dense: true,
                          leading: Text(
                            '${index + 1}.',
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                          title: Text(
                            '$countryName',
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                          trailing: Text(
                            '$count',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('API returned an error: ${data['Message']}'));
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
