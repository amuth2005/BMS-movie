<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Movie Seat Reservation</title>
        <link rel="stylesheet" href="CSS/booking.css">
    </head>
    <body class="banner">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #121212;
            color: #ffffff;
        }

        .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #111;
        color: white;
        padding: 10px 2px;
    }
    .banner{
             background-image: linear-gradient(rgba(0, 0, 0, 0.75),rgba(23, 22, 22, 0.75)),url(images/bg.jpg) ;
             background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
             background-position: center;
  
        }

    .navbar .logo {
        font-size: 20px;
        font-weight: bold;
    }

    .navbar .menu-icon {
        font-size: 24px;
        cursor: pointer;
    }
    .footer {
        background: #1e1e1e;
        padding: 20px;
        text-align: center;
        color: #ffffff;
    }

    .footer .address, .footer .contact, .footer .links {
        margin: 10px 0;
    }

    .footer a {
        color: #FF0000;
        text-decoration: none;
    }

        @media (max-width: 600px) {
            .navbar .left, .navbar .right {
                display: block;
                text-align: center;
            }

            .navbar a {
                display: block;
                margin: 5px 0;
            }

            .navbar .logo {
                margin-bottom: 10px;
            }
        }

        .large-break 
        { 
            margin-top: 50px;
        }

        .summary-checkout {
            background-color: rgba(30, 30, 30, 0.95);
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
            margin-top: 20px;
        }

        .summary-checkout h2 {
            margin-bottom: 15px;
            font-size: 1.5em;
            color: #FF0000;
        }

        .summary-checkout p {
            margin: 10px 0;
            font-size: 1em;
            color: #ffffff;
        }

        .checkout input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #FF0000;
            border-radius: 4px;
            font-size: 1em;
            background-color: #1e1e1e;
            color: #ffffff;
            transition: border-color 0.3s;
        }

        .checkout input:focus {
            border-color: #FF0000;
            outline: none;
        }

        .btn {
            background-color: #FF0000;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 1em;
        }

        .btn:hover {
            background-color: #CC0000;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .right-section {
            max-width: 400px;
        }

        .checkout input {
            width: calc(100% - 24px);
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #FF0000;
            border-radius: 4px;
            font-size: 1em;
            background-color: #1e1e1e;
            color: #ffffff;
            transition: border-color 0.3s;
        }

        #seats {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            margin-top: 20px;
        }

        .seat-button {
            margin: 5px;
            padding: 10px;
            background-color: #444;
            color: #fff;
            border: 1px solid #FF0000;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .seat-button:hover {
            background-color: #FF0000;
        }

        .seat-button.selected {
            background-color: #CC0000;
        }

        .date-button,
        .movie-button,
        .time-button,
        .cinema-button {
            background-color: #444;
            color: #fff;
            border: 1px solid #FF0000;
            border-radius: 4px;
            padding: 10px 15px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .date-button:hover,
        .movie-button:hover,
        .time-button:hover,
        .cinema-button:hover {
            background-color: #FF0000;
        }

        .date-button.active,
        .movie-button.active,
        .time-button.active,
        .cinema-button.active {
            background-color: #CC0000;
            color: #fff;
        }

        .movie-button {
            display: flex;
            align-items: center;
            background-color: #444;
            color: #fff;
            border: 1px solid #FF0000;
            border-radius: 4px;
            padding: 15px;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
            max-width: 600px;
            margin: 5px;
        }

        .movie-button img {
            width: 150px;
            height: 100px;
            margin-right: 15px;
        }

        .movie-button:hover {
            background-color: #FF0000;
        }

        .movie-button.active {
            background-color: #CC0000;
        }
    </style>
    
    
<div class="navbar">
    <div class="logo"><a href="home.jsp" style="color: white;"><img src="images/logo.png" alt="logo" style="height: 3.5cm;width: 4cm;"></a></div>
    <div class="menu-icon">☰</div>
</div>

<div class="large-break"></div>

    <div class="container mx-auto p-4 flex">
        <div class="left-section flex-1">
            <h1 class="text-2xl font-bold mb-4">Book Your Movie</h1>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <form action="Booking" method="POST">
                    <input type="hidden" id="selected_date" name="date" value="">
                    <input type="hidden" id="selected_movie" name="movie" value="">
                    <input type="hidden" id="selected_time" name="time" value="">
                    <input type="hidden" id="selected_cinema" name="cinema" value="">
                    <input type="hidden" id="selected_seats" name="seats" value="">
                
                
                    <h2 class="text-lg mb-2">Select Date</h2>
                    <div class="date-buttons flex space-x-4" >
                        <button type="button" class="date-button active" name="date" value="Today">Today</button>
                        <button type="button" class="date-button" name="date" value="Mon, 9 Dec">Mon, 9 Dec</button>
                        <button type="button" class="date-button" name="date" value="Tue, 10 Dec">Tue, 10 Dec</button>
                        <button type="button" class="date-button" name="date" value="Wed, 11 Dec">Wed, 11 Dec</button>
                        <button type="button" class="date-button" name="date" value="Thu, 12 Dec">Thu, 12 Dec</button>
                    </div>

                    <h2 class="text-lg mt-4">Select Movie</h2>
                    <div class="movie-buttons flex flex-wrap gap-4">
                        <button type="button" class="movie-button" name="movie" value="Moana 2">
                            <img src="https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/rockcms/2024-11/241127-moana-vl-1244p-92deac.jpg" alt="Moana 2" class="movie-image"> Moana 2
                        </button>
                        <button type="button" class="movie-button" name="movie" value="Gladiator II">
                            <img src="images/movie2.png" alt="Gladiator II" class="movie-image"> Gladiator II

                        </button>
                        <button type="button" class="movie-button" name="movie" value="Kanguva">
                            <img src="images/movie3.png" alt="Kanguva" class="movie-image"> Kanguva
                        </button>
                        <button type="button" class="movie-button" name="movie" value="Venom: The Last Dance">
                            <img src="images/movie4.png" alt="Venom: The Last Dance" class="movie-image"> Venom: The Last Dance
                        </button>
                    </div>

                    <h2 class="text-lg mt-4">Select Time</h2>
                    <div class="time-buttons flex flex-wrap gap-4">
                        <button type="button" class="time-button" name="time" value="10:30 AM">10:30 AM</button>
                        <button type="button" class="time-button" name="time" value="1:00 PM">1:00 PM</button>
                        <button type="button" class="time-button" name="time" value="3:00 PM">3:00 PM</button>
                        <button type="button" class="time-button" name="time" value="7:00 PM">7:00 PM</button>
                        <button type="button" class="time-button" name="time" value="10:00 PM">10:00 PM</button>
                    </div>

                    <h2 class="text-lg mb-2">Select Cinema</h2>
                    <div class="cinema-buttons flex space-x-4">
                        <button type="button" class="cinema-button" name="cinema" value="2D">2D Screening</button>
                        <button type="button" class="cinema-button" name="cinema" value="3D">3D Screening</button>
                        <button type="button" class="cinema-button" name="cinema" value="Box Office">Box Office</button>
                    </div>
                
                
            </div>

            <h2 class="text-lg mt-4">Select Your Seats</h2>
            <div id="screen" class="screen">Screen</div>
            <div id="seats">
            </div>
        </div>
        <div class="right-section w-1/3 ml-4 summary-checkout">
            <h2>Booking Details</h2>
            <p>Date: <span id="selected-date">Today</span></p> 
            <p>Movie: <span id="selected-movie"></span></p> 
            <p>Time: <span id="selected-time"></span></p>
            <p>Cinema: <span id="selected-cinema">Cinema 1</span></p> 
            <p>Seats: <span id="selected-seats-summary"></span></p>
            <p><span id="price-summary">Total Price: $0</span></p>
            <input type="hidden" id="total_price" name="total_price" value="0">
            

            <div class="checkout mt-4">
                <h2>Checkout</h2>
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                <label for="phone">Phone Number:</label>
                <input type="tel" id="phone" name="phone" required>
                <button type="submit" class="btn" id="bookNowBtn">Book Now</button>
            </div>
            
        </div>
    </div>
    
    <script src="JS/booking.js"></script>
    <div class="footer">
        <div class="address">
            123 Market St. #22B <br> Charlottesville, California 44635
        </div>
        <div class="contact">
            <a href="tel:(434)546-4356">(434) 546-4356</a> | 
            <a href="mailto:bookmyshow476@gmail.com">bookmyshow476@gmail.com</a>
        </div>
        <div class="links">
            <a href="#">About</a> | <a href="#">Growers</a> | 
            <a href="#">Merchants</a> | <a href="#">Partners</a> | 
            <a href="#">Contact</a>
        </div>
        <div>© 2020 Book My Show. All rights reserved.</div>
    </div>
</body>
</html>
