

import 'failure.dart';

class ValidationFailure implements Failure {
  late String message;
  ValidationFailure(this.message);

  @override
  String failureMessage() {
    return message;
  }
}

class CancelFailure implements Failure {
  @override
  String failureMessage() {
    return "request to server was cancelled";
  }
}

class ServerFailure implements Failure {
  @override
  String failureMessage() {
    return "something went wrong and your request could not be completed";
  }
}

class InternetFailure implements Failure {
  @override
  String failureMessage() {
    return "no internet connection";
  }
}

class BadResponseFailure implements Failure {
  final String? message;

  BadResponseFailure({this.message});

  @override
  String failureMessage() {
    return message ?? "Bad response from the server";
  }
}

class ConnectionTimeOutFailure implements Failure {
  @override
  String failureMessage() {
    return "connection timeout with server";
  }
}

class ReceivedTimeOutFailure implements Failure {
  @override
  String failureMessage() {
    return "";
  }
}

class SendTimeOutFailure implements Failure {
  @override
  String failureMessage() {
    return "send timeout in connection with server";
  }
}

class ConnectionFailure implements Failure {
  @override
  String failureMessage() {
    return "connection to server failed due to internet connection";
  }
}

class BadCertificateFailure implements Failure {
  @override
  String failureMessage() {
    return "Bad Certificate";
  }
}

class BadRequestFailure implements Failure {
  @override
  String failureMessage() {
    return "Bad request failure";
  }
}
