// Set initial values on page load
window.addEventListener('load', function() {
    // Get initially active buttons
    const activeDate = document.querySelector('.date-button.active');
    
    // Set initial values if buttons are active
    if (activeDate) {
        selectedDate = activeDate.value;
        document.getElementById('selected_date').value = selectedDate;
        document.getElementById('selected-date').textContent = activeDate.textContent;
        console.log('Initial date set:', selectedDate); // Debug log
    }
});

// Track selections
let selectedDate = null;
let selectedMovie = null;
let selectedTime = null;
let selectedCinema = null;
let selectedSeats = null;

// Date selection
const dateButtons = document.querySelectorAll('.date-button');
dateButtons.forEach(button => {
    button.addEventListener('click', () => {
        dateButtons.forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');
        selectedDate = button.value;
        document.getElementById('selected_date').value = selectedDate;
        document.getElementById('selected-date').textContent = button.textContent;
        console.log('Date selected:', selectedDate); // Debug log
    });
});

// Movie selection
const movieButtons = document.querySelectorAll('.movie-button');
movieButtons.forEach(button => {
    button.addEventListener('click', () => {
        movieButtons.forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');
        selectedMovie = button.value;
        document.getElementById('selected_movie').value = selectedMovie;
        document.getElementById('selected-movie').textContent = button.textContent;
        console.log('Movie selected:', selectedMovie); // Debug log
    });
});

// Time selection
const timeButtons = document.querySelectorAll('.time-button');
timeButtons.forEach(button => {
    button.addEventListener('click', () => {
        timeButtons.forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');
        selectedTime = button.value;
        document.getElementById('selected_time').value = selectedTime;
        document.getElementById('selected-time').textContent = button.textContent;
        console.log('Time selected:', selectedTime); // Debug log
    });
});

// Cinema selection
const cinemaButtons = document.querySelectorAll('.cinema-button');
cinemaButtons.forEach(button => {
    button.addEventListener('click', () => {
        cinemaButtons.forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');
        selectedCinema = button.value;
        document.getElementById('selected_cinema').value = selectedCinema;
        document.getElementById('selected-cinema').textContent = button.textContent;
        console.log('Cinema selected:', selectedCinema); // Debug log
    });
});

// Seat Selection
const seatsContainer = document.getElementById('seats');
const selectedSeatsArray = [];

function createSeats() {
    const rows = 5;  // 5 rows
    const seatsPerRow = 8;  // 8 seats per row
    const rowLabels = ['A', 'B', 'C', 'D', 'E'];

    for (let i = 0; i < rows; i++) {
        const row = document.createElement('div');
        row.classList.add('seat-row');

        // Add row label
        const rowLabel = document.createElement('div');
        rowLabel.classList.add('row-label');
        rowLabel.textContent = rowLabels[i];
        row.appendChild(rowLabel);

        for (let j = 1; j <= seatsPerRow; j++) {
            const seat = document.createElement('div');
            seat.classList.add('seat');
            const seatNumber = rowLabels[i] + j;
            seat.textContent = seatNumber;
            seat.dataset.seatNumber = seatNumber;

            seat.addEventListener('click', () => {
                seat.classList.toggle('selected');
                updateSelectedSeats();
            });

            row.appendChild(seat);
        }
        seatsContainer.appendChild(row);
    }
}

const PRICE_PER_SEAT = 10; // $10 per seat

function updateSelectedSeats() {
    const selectedSeats = document.querySelectorAll('.seat.selected');
    const seatNumbers = Array.from(selectedSeats).map(seat => seat.dataset.seatNumber);
    
    // Calculate total price
    const totalPrice = selectedSeats.length * PRICE_PER_SEAT;
    
    // Update the hidden input
    document.getElementById('selected_seats').value = seatNumbers.join(',');
    document.getElementById('total_price').value = totalPrice;
    
    // Update the summary
    document.getElementById('selected-seats-summary').textContent = 
        seatNumbers.length > 0 ? seatNumbers.join(', ') : 'No seats selected';
    document.getElementById('price-summary').textContent = 
        `Total Price: $${totalPrice}`;
        
    console.log('Selected seats:', seatNumbers);
    console.log('Total price:', totalPrice);
}

// Call createSeats when the page loads
createSeats();

// Form submission
document.querySelector('form').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const formData = {
        date: document.getElementById('selected_date').value,
        movie: document.getElementById('selected_movie').value,
        time: document.getElementById('selected_time').value,
        cinema: document.getElementById('selected_cinema').value,
        seats: document.getElementById('selected_seats').value,
        totalPrice: document.getElementById('total_price').value,
        name: document.getElementById('name').value,
        email: document.getElementById('email').value,
        phone: document.getElementById('phone').value
    };
    
    // Validate form
    if (!validateForm()) {
        return;
    }
    
    // Initialize PayPal payment
    initiatePayPalPayment(formData);
});

function validateForm() {
    const formData = {
        date: document.getElementById('selected_date').value,
        movie: document.getElementById('selected_movie').value,
        time: document.getElementById('selected_time').value,
        cinema: document.getElementById('selected_cinema').value,
        seats: document.getElementById('selected_seats').value,
        name: document.getElementById('name').value,
        email: document.getElementById('email').value,
        phone: document.getElementById('phone').value
    };
    
    if (!formData.date || !formData.movie || !formData.time || !formData.cinema) {
        alert('Please make all selections before booking');
        return false;
    }
    
    if (!formData.seats) {
        alert('Please select at least one seat');
        return false;
    }

    if (!formData.name || !formData.email || !formData.phone) {
        alert('Please fill in all contact information');
        return false;
    }
    
    return true;
}

function initiatePayPalPayment(formData) {
    // Create a hidden form to submit the data
    const paymentForm = document.createElement('form');
    paymentForm.method = 'POST';
    paymentForm.action = 'InitiatePayment';  // New servlet to handle PayPal integration

    // Add all form data as hidden fields
    for (const [key, value] of Object.entries(formData)) {
        const hiddenField = document.createElement('input');
        hiddenField.type = 'hidden';
        hiddenField.name = key;
        hiddenField.value = value;
        paymentForm.appendChild(hiddenField);
    }

    document.body.appendChild(paymentForm);
    paymentForm.submit();
}

// Add this to check if hidden inputs are being updated
setInterval(() => {
    console.log('Current hidden input values:', {
        date: document.getElementById('selected_date').value,
        movie: document.getElementById('selected_movie').value,
        time: document.getElementById('selected_time').value,
        cinema: document.getElementById('selected_cinema').value
    });
}, 5000); // Check every 5 seconds 