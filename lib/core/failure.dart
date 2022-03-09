class Failure {
  String messageToDisplay;
  String? actualMessage;
  dynamic errorObject;

  Failure({required this.messageToDisplay, this.actualMessage, this.errorObject});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          messageToDisplay == other.messageToDisplay &&
          actualMessage == other.actualMessage &&
          errorObject == other.errorObject;

  @override
  int get hashCode => messageToDisplay.hashCode ^ actualMessage.hashCode ^ errorObject.hashCode;
}
