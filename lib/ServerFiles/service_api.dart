import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../CommonFiles/common.dart';
import 'dart:convert';
import '../ServerFiles/service_api.dart';

List<int> httpErrorStatuses = [
  204,
  400,
  401,
  403,
  500,
];

Future<dynamic> CallApi(
    String httpType, dynamic params, String url, BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    var jsonError = {
      "message": "No Internet Connection. Please check your Connection",
      "code": "401"
    };
    Timer(const Duration(microseconds: 500), () {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(50),
            child: Container(
                height: 100,
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: const Text(
                  "Your device does not have a internet connection. Stormboard requires an active internet connection",
                  style: TextStyle(
                      fontSize: 16,
                      color: labelColor,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                )),
          ));
        },
      );
    });
    return jsonError;
  }

  var body = json.encode(params);
  var response;
  String? key = await GetSharedPreference(kDataKey);
  try {
    if (httpType == "GET") {
      String queryString = Uri(queryParameters: json.decode(body)).query;

      if (url == "$baseUrl/users/auth") {
        response = await http.get(Uri.parse(url), headers: {
          "Content-Type": "application/json",
          "Php-Auth-Pw": params["password"],
          "Php-Auth-User": params["username"]
        });
      } else if (key == null) {
        response = await http.get(Uri.parse(url + "?" + queryString), headers: {
          "Authorization": 'Token 4d693ba551b14da66d37d7c02df548794426b0a8'
        });
      } else {
        response = await http.get(Uri.parse(url + "?" + queryString),
            headers: {"X-API-Key": key, "X-STORMBOARD-MOBILEFLUTTER": "true"});
      }
    } else if (httpType == "PUT") {
      if (key == null) {
        response = await http.put(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "X-STORMBOARD-MOBILEFLUTTER": "true"
            },
            body: body);
      } else {
        response = await http.put(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              "X-API-Key": key,
              "X-STORMBOARD-MOBILEFLUTTER": "true",
              "enctype": "multipart/form-data"
            },
            body: body);
      }
    } else if (httpType == "DELETE") {
      if (key == null) {
        response = await http.delete(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-STORMBOARD-MOBILEFLUTTER": "true"
          },
        );
      } else {
        response = await http.delete(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "X-API-Key": key,
            "X-STORMBOARD-MOBILEFLUTTER": "true",
            "enctype": "multipart/form-data"
          },
        );
      }
    } else {
      if (key == null) {
        response = await http.post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "X-STORMBOARD-MOBILEFLUTTER": "true"
            },
            body: body);
      } else {
        response = await http.post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              "X-API-Key": key,
              "X-STORMBOARD-MOBILEFLUTTER": "true",
              "enctype": "multipart/form-data"
            },
            body: body);
      }
    }
  } on HandshakeException catch (_) {
    var jsonError = {
      "message": "Server not responding. Please try again later",
      "error": "Something went wrong. Please try again later.",
      "code": "500"
    };
    return jsonError;
  } on TimeoutException catch (_) {
    // A timeout occurred.
    var jsonError = {
      "message": "Server not responding. Please try again later",
      "error": "Something went wrong. Please try again later.",
      "code": "500"
    };
    return jsonError;
  } on SocketException catch (_) {
    // Other exception
    var jsonError = {
      "error": "Something went wrong. Please try again later.",
      "message": "Server not responding. Please try again later",
      "code": "500"
    };
    return jsonError;
  }
  var jsonResponse = {};
  jsonResponse[kDataResult] = convert.jsonDecode(response.body);

  if (response.statusCode == 200) {
    jsonResponse[kDataCode] = "200";
    return jsonResponse;
  } else if (httpErrorStatuses.contains(response.statusCode)) {
    var jsonError = {
      "code": response.statusCode.toString(),
      "error": jsonResponse[kDataError],
      "message": jsonResponse[kDataMessage] ??
          jsonResponse[kDataError] ??
          "Something went wrong. Please try again later.",
    };
    return jsonError;
  } else {
    print("Request failed with status: ${response.statusCode}.");
    var jsonError = {
      "code": "404",
      "error": "Something went wrong. Please try again later.",
      "message": "Something went wrong. Please try again later.",
    };
    return jsonError;
  }
}

void makePostRequest(String httpType, dynamic params, String url) async {
  // set up POST request arguments

  Map<String, String> headers = {
    "Content-type": "application/x-www-form-urlencoded"
  };

  Response response =
      await http.post(Uri.parse(url), headers: headers, body: params);
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  String body = response.body;
  print("Output is : $body");
}
