<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Book my show</title>
  </head>
  <body>
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Book My Show</title>
        <link
          href="https://fonts.googleapis.com/css?family=Poppins&display=swap"
          rel="stylesheet"
        />
        <style>
          body {
            font-family: "Poppins", sans-serif;
            margin: 0;
            background-color: #121212;
            color: #ffffff;
          }
          .container {
            width: 90%;
            margin: 0 auto;
            padding: 20px 0;
          }
          .header {
            text-align: center;
            margin-bottom: 20px;
          }
          .header h1 {
            margin: 0;
          }
          .search-bar {
            display: flex;
            justify-content: center;
            margin: 20px 0;
          }
          .search-bar input {
            width: 80%;
            padding: 10px;
            border-radius: 20px;
            border: none;
            font-size: 16px;
          }
          .carousel {
            width: 100%;
            text-align: center;
          }
          .carousel img {
            width: 100%;
            border-radius: 10px;
            margin-bottom: 20px;
          }
          .section-title {
            font-size: 24px;
            font-weight: bold;
            margin: 20px 0;
          }
          .movies-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
          }
          .movie-card {
            background: #1e1e1e;
            border-radius: 10px;
            overflow: hidden;
            text-align: center;
          }
          .movie-card img {
            width: 100%;
            border-bottom: 2px solid #333;
          }
          .movie-card .movie-title {
            font-size: 18px;
            margin: 10px 0;
          }
          .movie-card .movie-info {
            font-size: 14px;
            color: #999;
            margin-bottom: 10px;
          }
          .footer {
            background: #1e1e1e;
            padding: 20px;
            text-align: center;
          }
          .footer .address,
          .footer .contact,
          .footer .links {
            margin: 10px 0;
          }
          .footer a {
            color: #999;
            text-decoration: none;
            margin: 0 10px;
          }
          .banner {
            background-image: linear-gradient(
                rgba(0, 0, 0, 0.75),
                rgba(86, 13, 13, 0.75)
              ),
              url(images/bg.jpg);
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
            background-position: center;
          }
          .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #111;
            color: white;
            padding: 10px 2px;
          }

          .navbar .logo {
            font-size: 20px;
            font-weight: bold;
          }

          .navbar .menu-icon {
            font-size: 24px;
            cursor: pointer;
          }
          /* width */
          ::-webkit-scrollbar {
            width: 20px;
          }

          /* Track */
          ::-webkit-scrollbar-track {
            box-shadow: inset 0 0 5px grey;
            border-radius: 10px;
          }

          /* Handle */
          ::-webkit-scrollbar-thumb {
            background: rgba(255, 0, 0, 0.19);
            border-radius: 10px;
          }
        </style>
      </head>
      <body class="banner" background-image="images/bg.jpg">
        <div class="navbar">
          <div class="logo">
            <a href="home.html" style="color: white"
              ><img
                src="images/logo.png"
                alt="logo"
                style="height: 3.5cm; width: 4cm"
            /></a>
          </div>
          <div class="menu-icon">☰</div>
        </div>
        <div class="container">
          <!-- Header -->

          <!-- Search Bar -->
          <div class="search-bar">
            <input
              type="text"
              placeholder="SEARCH"
              style="width: 100%; margin-top: -1cm; color: red"
            />
          </div>

          <!-- Carousel -->
          <div class="carousel" style="opacity: 0; transition: opacity 2s">
            <img
              src="images/venom-banner.jpg"
              alt="Venom Movie Banner"
              style="width: 70%"
            />
            <br />
          </div>

          <script>
            // JavaScript , fade-in
            window.onload = function () {
              const carousel = document.querySelector(".carousel");
              carousel.style.opacity = 1; //  CSS transition
            };
          </script>

          <!-- Now Showing Section -->
          <div class="section">
            <div class="section-title"><br />NOW SHOWING</div>
            <div class="movies-grid">
              <div class="movie-card">
                <a href="movie.jsp?name=Moana%202"
                  ><img
                    src="https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/rockcms/2024-11/241127-moana-vl-1244p-92deac.jpg"
                    alt="Moana 2"
                /></a>
                <div class="movie-title">Moana 2</div>
                <div class="movie-info">English | Adventure</div>
              </div>
              <div class="movie-card">
                <a href="movie.jsp?name=Gladiator%20II"
                  ><img src="images/movie2.png" alt="Gladiator II"
                /></a>
                <div class="movie-title">Gladiator II</div>
                <div class="movie-info">English | Action</div>
              </div>
              <div class="movie-card">
                <a href="movie.jsp?name=Kanguva"
                  ><img src="images/movie3.png" alt="Kanguva"
                /></a>
                <div class="movie-title">Kanguva</div>
                <div class="movie-info">Tamil | Action</div>
              </div>
              <div class="movie-card">
                <a href="movie.jsp?name=Venom%3A%20The%20Last%20Dance"
                  ><img src="images/movie4.png" alt="Venom: The Last Dance"
                /></a>
                <div class="movie-title">Venom: The Last Dance</div>
                <div class="movie-info">English | Action</div>
              </div>
            </div>
          </div>

          <div class="section">
            <div class="section-title">COMING SOON</div>
            <div class="movies-grid">
              <div class="movie-card">
                <img src="images/movie5.png" alt="Pushpa 2" />
                <div class="movie-title">Pushpa: The Rule Part 2</div>
                <div class="movie-info">Tamil | Action</div>
              </div>
              <div class="movie-card">
                <img src="images/movie6.png" alt="Solo Town" />
                <div class="movie-title">Solo Town</div>
                <div class="movie-info">Sinhala | Drama</div>
              </div>
              <div class="movie-card">
                <img src="images/movie7.png" alt="Heretic" />
                <div class="movie-title">Heretic</div>
                <div class="movie-info">English | Horror</div>
              </div>
              <div class="movie-card">
                <img src="images/movie8.png" alt="Kraven The Hunter" />
                <div class="movie-title">Kraven The Hunter</div>
                <div class="movie-info">English | Action</div>
              </div>
              <!-- Add more cards as needed -->
            </div>
          </div>
        </div>

        <!-- Footer -->
        <div class="footer">
          <div class="address">
            123 Market St. #22B <br />
            Charlottesville, California 44635
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
  </body>
</html>
