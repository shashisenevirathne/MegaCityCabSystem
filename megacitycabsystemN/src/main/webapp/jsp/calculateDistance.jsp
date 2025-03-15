<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ride Fare Estimator</title>
    <script>
        function calculateDistance() {
            var origin = document.getElementById("pickup").value;
            var destination = document.getElementById("dropoff").value;

            var service = new google.maps.DistanceMatrixService();
            service.getDistanceMatrix({
                origins: [origin],
                destinations: [destination],
                travelMode: 'DRIVING'
            }, function(response, status) {
                if (status === 'OK') {
                    var distanceText = response.rows[0].elements[0].distance.text;
                    var distanceValue = distanceText.replace(" km", ""); // Remove "km" text
                    document.getElementById("distance").value = distanceValue;
                } else {
                    alert("Error: " + status);
                }
            });
        }
    </script>
</head>
<body>

<h2>Ride Fare Estimator</h2>

<form method="post" action="fareCalculator.jsp">
    Pickup Location: <input type="text" id="pickup" name="pickup" required><br>
    Dropoff Location: <input type="text" id="dropoff" name="dropoff" required><br>
    <button type="button" onclick="calculateDistance()">Measure Distance</button><br><br>

    Distance (km): <input type="text" id="distance" name="distance" readonly><br>
    Time (minutes): <input type="number" name="time" required><br>
    <button type="submit">Calculate Fare</button>
</form>

<!-- Load Google Maps API -->
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places"></script>

</body>
</html>
