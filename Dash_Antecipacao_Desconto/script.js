document.getElementById('calcForm').addEventListener('submit', function(e) {
  e.preventDefault();
  
  // Get input values
  var futureValue = parseFloat(document.getElementById('futureValue').value.replace(',', '.'));
  var interestRate = parseFloat(document.getElementById('interestRate').value.replace(',', '.'));
  
	var interestRateDay = interestRate / 30;
	document.getElementById("interestRateDay").textContent = interestRateDay.toFixed(6);
  
  var startDate = new Date(document.getElementById('startDate').value);
  var endDate = new Date(document.getElementById('endDate').value);
  
  // Calculate the number of days between the two dates
  var days = Math.round((endDate - startDate) / (1000 * 60 * 60 * 24));
  document.getElementById("days").textContent = days;
  
  // Calculate present value
  var presentValue = futureValue / Math.pow((1 + interestRateDay), days);
  
  // Display the result
  document.getElementById('presentValue').textContent = presentValue.toFixed(2);
  document.getElementById('result').classList.remove('hidden');
});
