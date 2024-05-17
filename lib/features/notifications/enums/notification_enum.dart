enum NotificationEnum {
  onTime('On time', 0),
  tenMinsBefore('10 mins Before', 10),
  thirtyMinsBefore('30 mins Before', 30),
  oneHourBefore('1 hr Before', 60),
  twoHoursBefore('2 hrs Before', 120),
  oneDayBefore('1 day Before', 1440);

  final String description;
  final int durationInMinutes;

  const NotificationEnum(
    this.description,
    this.durationInMinutes,
  );

  @override
  String toString() => description;

  String durationInHoursAndMinutes() {
    final hours = durationInMinutes ~/ 60;
    final minutes = durationInMinutes % 60;
    return '${hours > 0 ? '$hours hr ' : ''}${minutes > 0 ? '$minutes mins' : ''}'
        .trim();
  }

  //! Turn String into Enum
  static NotificationEnum fromStringToEnum(String notificationSchedule) {
    switch (notificationSchedule) {
      case 'onTime':
        return NotificationEnum.onTime;
      case 'tenMinsBefore':
        return NotificationEnum.tenMinsBefore;
      case 'thirtyMinsBefore':
        return NotificationEnum.thirtyMinsBefore;
      case 'oneHourBefore':
        return NotificationEnum.oneHourBefore;
      case 'twoHoursBefore':
        return NotificationEnum.twoHoursBefore;
      case 'oneDayBefore':
        return NotificationEnum.oneDayBefore;

      default:
        return NotificationEnum.onTime;
    }
  }
}
