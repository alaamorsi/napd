abstract class CalculateRate {
  static double calculateBayesianAverage({
  required double itemAverageRate, // R: متوسط تقييم العنصر (الدكتور)
  required int itemRatingsCount,   // v: عدد تقييمات العنصر
  required double globalAverageRate, // C: متوسط تقييم الكل
  required int minimumRatings,     // m: الحد الأدنى المقبول
}) {
  if (itemRatingsCount == 0) {
    return globalAverageRate;
  }
  
  double bayesianAverage = (
    (itemRatingsCount / (itemRatingsCount + minimumRatings)) * itemAverageRate
  ) + (
    (minimumRatings / (itemRatingsCount + minimumRatings)) * globalAverageRate
  );

  return bayesianAverage;
}
}