import 'dart:convert';

import 'package:card_walet/Utility/enums.dart';
import 'package:card_walet/Utility/utils.dart';
import 'package:http/http.dart' as http;

class ConnectHelper {
  final String _baseUrl = 'http://3.108.157.65:3000/';

  Future<http.Response> makeRequest(
    String url,
    Request request,
    dynamic data,
    bool isLoading,
    Map<String, String> headers,
  ) async {
    /// To see whether the network is available or not
    if (await Utility.isNetworkAvailable()) {
      switch (request) {

        /// Method to make the Get type request
        case Request.GET:
          {
            var uri = _baseUrl + url;

            if (isLoading) Utility.showLoader();
            var response;

            try {
              response = await http.get(
                Uri.parse(uri),
                headers: headers,
              );
            } catch (e) {
              print(e);
            }

            Utility.closeDialog();

            return response;
          }
        case Request.POST:

          /// Method to make the Post type request
          {
            var uri = _baseUrl + url;

            if (isLoading) Utility.showLoader();

            final response = await http.post(
              Uri.parse(uri),
              body: jsonEncode(data),
              headers: headers,
            );

            Utility.closeDialog();

            // Utility.printILog(uri);

            return response;
          }
        case Request.PUT:

          /// Method to make the Put type request
          {
            var uri = _baseUrl + url;

            if (isLoading) Utility.showLoader();

            final response = await http.put(
              Uri.parse(uri),
              body: data,
              headers: headers,
            );

            Utility.closeDialog();

            // Utility.printILog(uri);

            return response;
          }

        case Request.PATCH:

          /// Method to make the Patch type request
          {
            var uri = _baseUrl + url;

            if (isLoading) Utility.showLoader();

            final response = await http.patch(
              Uri.parse(uri),
              body: jsonEncode(data),
              headers: headers,
            );

            Utility.closeDialog();

            // Utility.printILog(uri);

            return response;
          }
        case Request.DELETE:

          /// Method to make the Delete type request
          {
            var uri = _baseUrl + url;

            if (isLoading) Utility.showLoader();

            final response = await http.delete(
              Uri.parse(uri),
              body: data,
            );

            Utility.closeDialog();

            // Utility.printILog(uri);
            return response;
          }
      }
    }

    /// If there is not network available then instead of print can show the no internet widget too
    else {
      throw Exception('No Internet');
    }
  }
}
