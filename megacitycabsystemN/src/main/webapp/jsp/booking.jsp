<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Ride</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            text-align: center;
            padding: 25px;
        }
        .container {
            max-width: 500px;
            margin: auto;
            background: white;
            padding: 45px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        h2 {
            color: #333;
        }
        .input-group {
            text-align: left;
            margin-bottom: 15px;
        }
        .input-group label {
            display: block;
            font-weight: bold;
        }
        .input-group input, 
        .input-group select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .extra-links {
            margin-top: 10px;
        }
        .extra-links a {
            color: #0000EE;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>🚕 Your Ride Awaits...</h2>
        <form action="../BookingServlet" method="post">
            
            <div class="input-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="input-group">
                <label for="address">Pickup Address:</label>
                <input type="text" id="address" name="address" required>
            </div>

            <div class="input-group">
                <label for="phone">Phone Number:</label>
                <input type="text" id="phone" name="phone" required>
            </div>

            <div class="input-group">
                <label for="destination">Drop-off Location:</label>
                <select id="destination" name="destination" required>
                    <option value="">Select Drop-off Location</option>
                    <option value="Colombo 1 - Fort">Colombo 1 - Fort</option>
                    <option value="Colombo 2 - Slave Island">Colombo 2 - Slave Island</option>
                    <option value="Colombo 3 - Kollupitiya">Colombo 3 - Kollupitiya</option>
                    <option value="Colombo 4 - Bambalapitiya">Colombo 4 - Bambalapitiya</option>
                    <option value="Colombo 5 - Havelock Town">Colombo 5 - Havelock Town</option>
                    <option value="Colombo 6 - Wellawatte">Colombo 6 - Wellawatte</option>
                    <option value="Colombo 7 - Cinnamon Gardens">Colombo 7 - Cinnamon Gardens</option>
                    <option value="Colombo 8 - Borella">Colombo 8 - Borella</option>
                    <option value="Colombo 9 - Dematagoda">Colombo 9 - Dematagoda</option>
                    <option value="Colombo 10 - Maradana">Colombo 10 - Maradana</option>
                    <option value="Colombo 11 - Pettah">Colombo 11 - Pettah</option>
                    <option value="Colombo 12 - Hulftsdorp">Colombo 12 - Hulftsdorp</option>
                    <option value="Colombo 13 - Kotahena">Colombo 13 - Kotahena</option>
                    <option value="Colombo 14 - Grandpass">Colombo 14 - Grandpass</option>
                    <option value="Colombo 15 - Modara / Mutwal">Colombo 15 - Modara / Mutwal</option>
                </select>
            </div>

            <div class="input-group">
                <label for="fare">Estimated Fare (LKR):</label>
                <input type="number" id="fare" name="fare" step="0.01" required>
            </div>

            <button type="submit">Book Now</button>
        </form>

        <div class="extra-links">
            <p>Need help? <a href="help.html">Visit Help Page</a></p>
        </div>
    </div>
</body>
</html>
