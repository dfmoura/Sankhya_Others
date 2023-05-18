document.getElementById('filter-form').addEventListener('submit', function(event) {
  event.preventDefault(); // Prevent form submission

  var selectedCategory = document.getElementById('category').value;
  
  // Make an AJAX request to fetch filtered data from the server
  // Replace the URL with your own API endpoint or server-side script
  var url = '/api/filter?category=' + encodeURIComponent(selectedCategory);
  fetch(url)
    .then(function(response) {
      return response.json();
    })
    .then(function(data) {
      renderFilteredData(data);
    })
    .catch(function(error) {
      console.error('Error:', error);
    });
});

function renderFilteredData(data) {
  var cardContainer = document.getElementById('card-container');
  cardContainer.innerHTML = ''; // Clear previous results
  
  data.forEach(function(item) {
    var card = document.createElement('div');
    card.classList.add('card');
    card.innerHTML = `
      <h2>${item.title}</h2>
      <p>${item.description}</p>
    `;
    cardContainer.appendChild(card);
  });
}
