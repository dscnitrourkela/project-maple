import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// Takes an ISO String as an argument and returns a map of formatted data
/// (date in the format of 'dd/MM/yy', time in the format of hh:mm)
Map<String, String> formatDateTime(String isoString) {
  initializeDateFormatting();
  final DateTime dateTime = DateTime.parse(isoString).toLocal();

  final DateFormat newFormat = DateFormat('dd/MM/yy');

  final String formattedDate = newFormat.format(dateTime);

  final String formattedTime = '${dateTime.hour}:${dateTime.minute}';

  final Map<String, String> formattedData = <String, String>{
    'date': formattedDate,
    'time': formattedTime
  };

  return formattedData;
}

/// Takes startTime and endTime and calculates the duration between them.
int calcuateTestDuration(String startTime, String endTime) {
  final DateTime formattedStartTime = DateTime.parse(startTime);
  final DateTime formattedEndTime = DateTime.parse(endTime);

  final int timeDifference =
      formattedEndTime.difference(formattedStartTime).inMinutes;

  return timeDifference;
}
