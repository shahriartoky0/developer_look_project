import 'dart:convert';
import 'package:developper_look/model/airport_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utilities/app_url.dart';

class CardController extends GetxController {
  final RxDouble updatedRating = 3.0.obs;
  final RxBool showAllComments = false.obs;
  final RxList<AirportDetails> airports = <AirportDetails>[].obs; // Store airports reactively

  @override
  void onInit() {
    fetchAirport();
    super.onInit();
  }

  // Method to fetch airport data from the API
  Future<void> fetchAirport() async {
    try {
      // Make the HTTP GET request
      final response = await http.get(Uri.parse(AppUrl.airportJson));

      if (response.statusCode == 200) {
        // Decode the response body
        final dynamic jsonResponse = jsonDecode(response.body);

        // Check if the response is a List
        if (jsonResponse is List) {
          final List<dynamic> airportsJson = jsonResponse;
          // Parse the List into AirportData objects
          airports.value = airportsJson
              .map((airportJson) => AirportDetails.fromJson(airportJson as Map<String, dynamic>))
              .toList();
          debugPrint('Parsed airports: ${airports.length}');
        } else {
          debugPrint('Unexpected response format: ${jsonResponse.runtimeType}');
        }
      } else {
        debugPrint('Failed to fetch airport data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching or parsing data: $e');
    }
  }
}

