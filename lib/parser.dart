
class SMSParser {

  List<String> spamKeywords = [
    'bonus',
    'win'
  ];

  bool checkIfTransactionIsFromPaytm(String text){
    RegExp paytmRegExp = RegExp(
      "Paid Rs.*"
    );
    if(paytmRegExp.hasMatch(text)){
      return true;
    } else {
      return false;
    }
  }

  bool checkIfTransactionIsFromSBI(String text){
    RegExp sbiCreditedRegExp = RegExp(
      "Rs.* credited"
    );
    RegExp sbiDebitedRegExp = RegExp(
      "Rs.* debited"
    );
    if(sbiCreditedRegExp.hasMatch(text) || sbiDebitedRegExp.hasMatch(text)){
      return true;
    } else {
      return false;
    }
  }

  bool checkIfMessageIsSpam(String text){
    bool checkStatus = false;
    for (String keyword in spamKeywords) {
      if(text.toLowerCase().contains(keyword)){
        checkStatus = true;
        break;
      }
    }
    return checkStatus;
  }
}