
class DateUtil {
  static String formatDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      String formattedDate =
          "${dateTime.day} ${_getMonthName(dateTime.month)} ${dateTime.year}";
      return formattedDate;
    } catch (e) {
      return date; // Return original string if parsing fails
    }
  }

  static String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }
}
