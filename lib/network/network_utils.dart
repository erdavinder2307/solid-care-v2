import 'dart:convert';
import 'dart:io';
import 'dart:developer' as dev;

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:solidcare/config.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/base_response.dart';
import 'package:solidcare/network/auth_repository.dart';
import 'package:solidcare/utils/common.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

Map<String, String> buildHeaderTokens({Map? extraKeys}) {
  if (extraKeys == null) {
    extraKeys = {};
    extraKeys.putIfAbsent('isStripePayment', () => false);
  }
  Map<String, String> header = {
    HttpHeaders.cacheControlHeader: 'max-age=604800',
  };

  ///Todo Add Constant Keys
  if (appStore.isLoggedIn &&
      extraKeys.containsKey('isStripePayment') &&
      extraKeys['isStripePayment']) {
    header.putIfAbsent(HttpHeaders.contentTypeHeader,
        () => 'application/x-www-form-urlencoded');
    header.putIfAbsent(HttpHeaders.authorizationHeader,
        () => 'Bearer ${extraKeys!['stripeKeyPayment']}');
  } else {
    header.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json; charset=utf-8');
    header.putIfAbsent(
        HttpHeaders.acceptHeader, () => 'application/json; charset=utf-8');
    if (appStore.isLoggedIn) {
      header.putIfAbsent(HttpHeaders.authorizationHeader,
          () => 'Bearer ${getStringAsync(TOKEN)}');
    }
  }

  return header;
}

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http'))
    url = Uri.parse('${appStore.tempBaseUrl}$endPoint');

  return url;
}

Future<Response> buildHttpResponse(String endPoint,
    {HttpMethod method = HttpMethod.GET, Map? request}) async {
  if (await isNetworkAvailable()) {
    var headers = buildHeaderTokens();

    Uri url = buildBaseUrl(endPoint);

    Response response;

    if (method == HttpMethod.POST) {
      response =
          await http.post(url, body: jsonEncode(request), headers: headers);
    } else if (method == HttpMethod.DELETE) {
      response = await delete(url, headers: headers);
    } else if (method == HttpMethod.PUT) {
      response = await put(url, body: jsonEncode(request), headers: headers);
    } else if (method == HttpMethod.PATCH) {
      response = await put(url, body: jsonEncode(request), headers: headers);
    } else {
      response = await get(url, headers: headers);
    }

    apiPrint(
      url: url.toString(),
      endPoint: endPoint,
      headers: jsonEncode(headers),
      hasRequest: method == HttpMethod.POST || method == HttpMethod.PUT,
      request: jsonEncode(request),
      statusCode: response.statusCode,
      responseBody: response.body,
      methodtype: method.name,
    );

    return response;
  } else {
    toast(locale.lblNoInternetMsg);
    throw errorInternetNotAvailable;
  }
}

Future handleResponse(Response response) async {
  if (!await isNetworkAvailable()) {
    throw errorInternetNotAvailable;
  }
  if (response.statusCode == 403) {
    BaseResponses responses = BaseResponses.fromJson(jsonDecode(response.body));
    if (responses.code == '[jwt_auth] incorrect_password') {
      toast(locale.lblIncorrectPwd);
    } else if (responses.code == 'rest_forbidden') {
      toast(responses.message);
    } else {
      toast(responses.message);
      logout(isTokenExpired: true);
    }
  }

  if (response.statusCode == 500 || response.statusCode == 404) {
    if (appStore.isLoggedIn) {
      if (appStore.tempBaseUrl != BASE_URL) {
        appStore.setBaseUrl(BASE_URL, initialize: true);
        appStore.setDemoDoctor("", initialize: true);
        appStore.setDemoPatient("", initialize: true);
        appStore.setDemoReceptionist("", initialize: true);
        logout().catchError((e) {
          appStore.setLoading(false);

          throw e;
        });
      }
    } else {
      appStore.setBaseUrl(BASE_URL, initialize: true);
    }
  }

  if (response.statusCode.isSuccessful()) {
    return jsonDecode(response.body);
  } else {
    try {
      var body = jsonDecode(response.body);
      log('==>>>>${jsonDecode(response.body)}');
      if (body['message'].toString().validate().isNotEmpty) {
        throw parseHtmlString(body['message']);
      } else {
        log(response.body);
        throw errorSomethingWentWrong;
      }
    } on Exception {
      toast(errorSomethingWentWrong);
      throw errorSomethingWentWrong;
    }
  }
}

//region Common
enum HttpMethod { GET, POST, DELETE, PUT, PATCH }

class TokenException implements Exception {
  final String message;

  const TokenException([this.message = ""]);

  String toString() => "FormatException: $message";
}
//endregion

Future<MultipartRequest> getMultiPartRequest(String endPoint) async {
  log('Url $BASE_URL$endPoint');
  return MultipartRequest('POST', Uri.parse('$BASE_URL$endPoint'));
}

Future<dynamic> sendMultiPartRequest(MultipartRequest multiPartRequest,
    {Function(dynamic)? onSuccess, Function(dynamic)? onError}) async {
  http.Response response =
      await http.Response.fromStream(await multiPartRequest.send());

  apiPrint(
    url: multiPartRequest.url.toString(),
    headers: jsonEncode(multiPartRequest.headers),
    request: jsonEncode(multiPartRequest.fields),
    hasRequest: true,
    statusCode: response.statusCode,
    responseBody: response.body,
    methodtype: "MultiPart",
  );

  if (response.statusCode.isSuccessful()) {
    if (response.body.isJson()) {
      onSuccess?.call(jsonDecode(response.body));
    } else {
      onSuccess?.call(response.body);
    }
  } else {
    onError?.call(jsonDecode(response.body)['message'].toString().isNotEmpty
        ? jsonDecode(response.body)['message']
        : errorSomethingWentWrong);
  }
}

Future<dynamic> sendMultiPartRequestNew(
    MultipartRequest multiPartRequest) async {
  http.Response response =
      await http.Response.fromStream(await multiPartRequest.send());

  apiPrint(
    url: multiPartRequest.url.toString(),
    headers: jsonEncode(multiPartRequest.headers),
    request: jsonEncode(multiPartRequest.fields),
    hasRequest: true,
    statusCode: response.statusCode,
    responseBody: response.body,
    methodtype: "MultiPart",
  );

  if (response.statusCode.isSuccessful()) {
    if (response.body.isJson()) {
      return jsonDecode(response.body);
    } else {
      return response.body;
    }
  } else {
    throw jsonDecode(response.body)['message'].toString().isNotEmpty
        ? jsonDecode(response.body)['message']
        : errorSomethingWentWrong;
  }
}

void apiPrint({
  String url = "",
  String endPoint = "",
  String headers = "",
  String request = "",
  int statusCode = 0,
  String responseBody = "",
  String methodtype = "",
  bool hasRequest = false,
  bool fullLog = false,
}) {
  // fullLog = statusCode.isSuccessful();
  if (fullLog) {
    dev.log(
        "┌───────────────────────────────────────────────────────────────────────────────────────────────────────");
    dev.log("\u001b[93m Url: \u001B[39m $url");
    dev.log("\u001b[93m endPoint: \u001B[39m \u001B[1m$endPoint\u001B[22m");
    dev.log("\u001b[93m header: \u001B[39m \u001b[96m$headers\u001B[39m");
    if (hasRequest) {
      dev.log('\u001b[93m Request: \u001B[39m \u001b[95m$request\u001B[39m');
    }
    dev.log(statusCode.isSuccessful() ? "\u001b[32m" : "\u001b[31m");
    dev.log('MethodType ($methodtype) | StatusCode ($statusCode)');
    dev.log('\x1B[32m${formatJson(responseBody)}\x1B[0m', name: 'Response');
    //dev.log('Response ($methodtype) : statusCode:{$responseBody}');
    dev.log("\u001B[0m");
    dev.log(
        "└───────────────────────────────────────────────────────────────────────────────────────────────────────");
  } else {
    log("┌───────────────────────────────────────────────────────────────────────────────────────────────────────");
    log("\u001b[93m Url: \u001B[39m $url");
    log("\u001b[93m endPoint: \u001B[39m \u001B[1m$endPoint\u001B[22m");
    log("\u001b[93m header: \u001B[39m \u001b[96m${headers.split(',').join(',\n')}\u001B[39m");
    if (hasRequest) {
      log('\u001b[93m Request: \u001B[39m \u001b[95m$request\u001B[39m');
    }
    log(statusCode.isSuccessful() ? "\u001b[32m" : "\u001b[31m");
    log('MethodType ($methodtype) | statusCode: ($statusCode)');
    log('Response : ');
    log('${formatJson(responseBody)}');
    log("\u001B[0m");
    log("└───────────────────────────────────────────────────────────────────────────────────────────────────────");
  }
}

String formatJson(String jsonStr) {
  try {
    final dynamic parsedJson = jsonDecode(jsonStr);
    const formatter = JsonEncoder.withIndent('  ');
    return formatter.convert(parsedJson);
  } on Exception catch (e) {
    dev.log("\x1b[31m formatJson error ::-> ${e.toString()} \x1b[0m");
    return jsonStr;
  }
}

String parseStripeError(String response) {
  try {
    var body = jsonDecode(response);
    return parseHtmlString(body['error']['message']);
  } on Exception catch (e) {
    log(e);
    throw errorSomethingWentWrong;
  }
}
