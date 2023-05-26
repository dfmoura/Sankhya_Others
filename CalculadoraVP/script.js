function calculatePresentValue() {
  var futureValue = parseFloat(document.getElementById('future-value').value);
  var interestRate = parseFloat(document.getElementById('interest-rate').value) / 100;
  var years = parseInt(document.getElementById('years').value);

  var presentValue = futureValue / Math.pow(1 + interestRate, years);
  
  document.getElementById('present-value').value = presentValue.toFixed(2);
}
