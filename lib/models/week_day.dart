enum WeekDay {
  monday(urlValue: 'mon'),
  tuesday(urlValue: 'tue'),
  wednesday(urlValue: 'wed'),
  thursday(urlValue: 'thu'),
  friday(urlValue: 'fri'),
  saturday(urlValue: 'sat'),
  sunday(urlValue: 'sun'),
  ;
  const WeekDay({
    required this.urlValue,
  });

  final String urlValue;

}
