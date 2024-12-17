class ErrorMapper{
  static bool isServiceDefinedError(String message){
    if (serviceErrorMsg.contains(message)) return true;
    return false;
  }


  static final serviceErrorMsg = [
    "Send timeout in connection with API server",
    "Unexpected error occurred trying to connect with server",
    "Unexpected error occurred trying to access local storage",
    "Not acceptable",
    "Error due to a conflict",
    "Method Allowed",
    "Bad request",
    "Request Cancelled",
    "Service unavailable",
    "Not Implemented",
    "Argument Error",
    "Unexpected error occurred",
    "Internal Server Error",
    "Unable to process the data"
  ];
}