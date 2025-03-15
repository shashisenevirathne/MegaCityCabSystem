<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Driver Registration</title>
    <style>
        .my-div {      
            font-family: Arial, sans-serif;
            background: #FFFFFF;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 500px;
            margin: 50px auto;
        }
        .input-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .input-group label {
            font-weight: bold;
            display: block;
        }
        .input-group input, .input-group select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
        }
        .error {
            color: red;
            font-size: 12px;
            display: none;
        }
        .error-border {
            border: 2px solid red;
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
    <script>
        function validateForm(event) {
            var isValid = true;

            var fullName = document.getElementById("fullName");
            var nic = document.getElementById("NIC");
            var email = document.getElementById("email");
            var phone = document.getElementById("phone");
            var licenseNo = document.getElementById("licenseNo");
            var vehicleNo = document.getElementById("vehicleNo");
            var userName = document.getElementById("userName");
            var password = document.getElementById("password");

            var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            var nicPattern = /^(\d{9}[vV]|\d{12})$/;  // Sri Lankan NIC format
            var phonePattern = /^\d{10}$/;
            var vehiclePattern = /^([A-Z]{2,3}-\d{4})|([A-Z]{1,2}-[A-Z]{2,3}-\d{4})$/; // Vehicle number formats
            var licensePattern = /^[A-Za-z0-9]{6,}$/; // At least 6 alphanumeric characters

            // Validate Full Name
            if (fullName.value.trim() === "") {
                document.getElementById("nameError").style.display = "block";
                fullName.classList.add("error-border");
                isValid = false;
            } else {
                document.getElementById("nameError").style.display = "none";
                fullName.classList.remove("error-border");
            }

            // Validate NIC
            if (!nic.value.match(nicPattern)) {
                document.getElementById("nicError").style.display = "block";
                nic.classList.add("error-border");
                isValid = false;
            } else {
                document.getElementById("nicError").style.display = "none";
                nic.classList.remove("error-border");
            }

            // Validate Email
            if (!emailPattern.test(email.value)) {
                document.getElementById("emailError").style.display = "block";
                email.classList.add("error-border");
                isValid = false;
            } else {
                document.getElementById("emailError").style.display = "none";
                email.classList.remove("error-border");
            }

            // Validate Phone Number
            if (!phone.value.match(phonePattern)) {
                document.getElementById("phoneError").style.display = "block";
                phone.classList.add("error-border");
                isValid = false;
            } else {
                document.getElementById("phoneError").style.display = "none";
                phone.classList.remove("error-border");
            }

            // Validate License Number
            if (!licenseNo.value.match(licensePattern)) {
                document.getElementById("licenseError").style.display = "block";
                licenseNo.classList.add("error-border");
                isValid = false;
            } else {
                document.getElementById("licenseError").style.display = "none";
                licenseNo.classList.remove("error-border");
            }

            // Validate Vehicle Number
            if (!vehicleNo.value.match(vehiclePattern)) {
                document.getElementById("vehicleError").style.display = "block";
                vehicleNo.classList.add("error-border");
                isValid = false;
            } else {
                document.getElementById("vehicleError").style.display = "none";
                vehicleNo.classList.remove("error-border");
            }

            return isValid;
        }
    </script>
</head>
<body>
    <div class="my-div">
        <h1>Driver Registration</h1>
        <h2>Sign up as a Driver</h2>
        <form action="../RegisterDriverServlet" method="post" onsubmit="return validateForm()">
            
            <div class="input-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" required>
                <small id="nameError" class="error">Full Name is required</small>
            </div>
            
            <div class="input-group">
                <label for="NIC">NIC NO</label>
                <input type="text" id="NIC" name="NIC" required>
                <small id="nicError" class="error">Invalid NIC (9 digits + V/v or 12 digits)</small>
            </div>

            <div class="input-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required>
                <small id="emailError" class="error">Invalid email format</small>
            </div>

            <div class="input-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone" required>
                <small id="phoneError" class="error">Invalid phone number (10 digits)</small>
            </div>

            <div class="input-group">
                <label for="licenseNo">License Number</label>
                <input type="text" id="licenseNo" name="licenseNo" required>
                <small id="licenseError" class="error">License number must be at least 6 characters</small>
            </div>

            <div class="input-group">
                <label for="vehicleNo">Vehicle Number</label>
                <input type="text" id="vehicleNo" name="vehicleNo" required>
                <small id="vehicleError" class="error">Invalid vehicle number format</small>
            </div>
            
             <div class="input-group">
                <label for="userName">User Name</label>
                <input type="userName" id="userName" name="userName" required>
                <small id="userNameError" class="error">User Name must be at least 6 characters</small>
            </div>

            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
                <small id="passwordError" class="error">Password must be at least 6 characters</small>
            </div>

            <button type="submit">Register</button>
        </form>
        
        <div class="extra-links">
            <p>Already have an account? <a href="login.jsp">Login</a></p>
        </div>
    </div>
</body>
</html>
