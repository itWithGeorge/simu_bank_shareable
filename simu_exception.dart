class SimuException implements Exception {
  SimuException(this.message);

  String message;

  @override
  String toString() {
    return message;
  }

  static const clientException = 'clientException';
  static const internetConnectivityError = 'internetConnectivityError';
  static const timeoutException = 'timeoutException';
  static const jsonParseErrorOrException = 'jsonErrorOrException';
  static const msgLookup = {
    clientException: 'Communication error',
    internetConnectivityError: 'Connection lost',
    timeoutException: 'Timeout error',
    jsonParseErrorOrException: 'Bad response'
  };
}
