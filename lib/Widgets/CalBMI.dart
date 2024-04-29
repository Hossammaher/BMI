class CalBMI {

  String CalBMIAndShowSatus(double weight , double height) {
   late String status ;
   double BMI = weight / (height * height);

    if (BMI < 18.5) {
      status = "Underweight";
    } else if (18.5 < BMI && BMI <= 25) {
      status = "Normal";
    } else if (25 < BMI && BMI <= 30) {
      status = "Overweight";
    } else if (30 < BMI) {
      status = "Obesity";
    }
    return status ;
  }

}