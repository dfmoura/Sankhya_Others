let currentPage = 1;
const cardsPerPage = 10;
const totalCards = 100; // Example total number of cards

function goToNextPage() {
  const totalPages = Math.ceil(totalCards / cardsPerPage);
  currentPage = (currentPage % totalPages) + 1;
  loadCards();
}

function loadCards() {
  const cards = document.getElementsByClassName('card');
  for (let i = 0; i < cards.length; i++) {
    const card = cards[i];
    const cardIndex = (currentPage - 1) * cardsPerPage + i + 1;
    card.style.display = cardIndex <= totalCards ? 'block' : 'none';
    card.querySelector('h3').textContent = `Card ${cardIndex}`;
  }
}

// Initial load
loadCards();
