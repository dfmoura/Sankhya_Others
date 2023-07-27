// Get the current date
let currentDate = new Date();

// Display the calendar for the current month
displayCalendar(currentDate);

// Function to display the calendar for a specific month
function displayCalendar(date) {
  const monthDays = document.getElementById("calendarDays");
  const currentMonth = document.getElementById("currentMonth");

  // Clear the previous month's content
  monthDays.innerHTML = "";

  // Set the current month and year in the header
  const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  currentMonth.textContent = monthNames[date.getMonth()] + " " + date.getFullYear();

  // Get the first day and last day of the month
  const firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
  const lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);

  // Calculate the number of days to display from the previous month
  const startOffset = firstDay.getDay(); // 0 for Sunday, 1 for Monday, etc.

  // Calculate the total number of days to display in the calendar
  const totalDays = lastDay.getDate();

  // Create the cells for the days
  for (let i = 1; i <= totalDays + startOffset; i++) {
    const dayCell = document.createElement("div");
    if (i > startOffset) {
      dayCell.textContent = i - startOffset;
      dayCell.addEventListener("click", () => {
        alert(`You clicked on ${dayCell.textContent} ${monthNames[date.getMonth()]} ${date.getFullYear()}`);
      });
    }
    monthDays.appendChild(dayCell);
  }
}

// Previous and Next buttons functionality
const prevBtn = document.getElementById("prevBtn");
const nextBtn = document.getElementById("nextBtn");

prevBtn.addEventListener("click", () => {
  currentDate.setMonth(currentDate.getMonth() - 1);
  displayCalendar(currentDate);
});

nextBtn.addEventListener("click", () => {
  currentDate.setMonth(currentDate.getMonth() + 1);
  displayCalendar(currentDate);
});
