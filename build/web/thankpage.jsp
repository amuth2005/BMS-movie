<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Movie Schedule</title>
    <style>
      body {
        font-family: "Poppins", sans-serif;
        margin: 0;
        background-color: #121212;
        color: #ffffff;
      }
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
          url(images/bg2.jpeg);
        background-repeat: no-repeat;
        background-attachment: fixed;
        background-size: 100% 100%;
        background-position: center;
      }
    </style>
  </head>
  <body class="banner">
    <div class="navbar">
      <div class="logo">
        <a href="home.jsp" style="color: white"
          ><img
            src="images/logo.png"
            alt="logo"
            style="height: 3.5cm; width: 4cm"
        /></a>
      </div>
      <div class="menu-icon">☰</div>
    </div>
    <br /><br />

    <div
      style="
        width: 99%;
        border: solid;
        border-color: rgba(255, 0, 0, 0);
        height: 17cm;
      "
    >
      <br /><br /><br /><br />
      <p style="font-size: xxx-large; text-align: center; margin-top: 5cm">
        <b
          >THANK YOU! <br /><span
            style="
              font-size: medium;
              font-weight: lighter;
              font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS',
                sans-serif;
            "
            >order placed successfully, return
            <a href="home.jsp" style="color: white">home</a>
          </span></b
        >
      </p>
    </div>

    
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
