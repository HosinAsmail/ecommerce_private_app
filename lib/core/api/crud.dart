import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_private_app/core/api/status_request.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';

String _basicAuth =
    'Basic ${base64Encode(utf8.encode('housinasmail:0934341176Ho\$'))}';

Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  Future<Either<StatusFailureRequest, Map>> postData(
      String url, Map data) async {
    http.Response response = await http.post(Uri.parse(url), body: data);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map dataResponse = jsonDecode(response.body);
      if (dataResponse["status"] != "success") {
        return const Left(StatusFailureRequest.noData);
      } else {
        return Right(dataResponse);
      }
    } else {
      return const Left(StatusFailureRequest.severFailure);
    }
  }

  Future<Either<StatusFailureRequest, Map>> getData(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map dataResponse = jsonDecode(response.body);
      if (dataResponse["status"] != "success") {
        return const Left(StatusFailureRequest.noData);
      } else {
        return Right(dataResponse);
      }
    } else {
      return const Left(StatusFailureRequest.severFailure);
    }
  }

  Future<Either<StatusFailureRequest, Map>> postRequestWithFile(
      String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("files", stream, length,
        filename: basename(file.path));
    // request.headers.addAll(myheaders) ;
    request.files.add(multipartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();

    var response = await http.Response.fromStream(myRequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map dataResponse = jsonDecode(response.body);
      if (dataResponse["status"] != "success") {
        return const Left(StatusFailureRequest.noData);
      } else {
        return Right(dataResponse);
      }
    } else {
      return const Left(StatusFailureRequest.severFailure);
    }
  }
}
