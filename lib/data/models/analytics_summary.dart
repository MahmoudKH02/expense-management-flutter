
class AnalyticsSummary {
  final Map<DateTime, double> summationPerDay;
  final double total;
  final double average;
  final double min;
  final double max;

  const AnalyticsSummary(
    this.summationPerDay,
    this.total,
    this.average,
    this.max,
    this.min,
  );
}
