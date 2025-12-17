<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UPI Payment</title>
    <link rel="stylesheet" href="payment.css">
</head>
<body>

    <div class="container">
        <h1>Bungalow Booking - UPI Payment</h1>
        
        <!-- UPI Payment Section -->
        <div id="upiPayment">
            <h3>Scan this QR Code to complete your payment</h3>
            <img src="upi-qr.jpg" alt="UPI QR Code" width="200" height="200">

            <p>Or enter your UPI ID below</p>
            <input type="text" id="upiId" placeholder="Enter your UPI ID">
            <button id="submitUPI">Pay with UPI</button>
        </div>

        <!-- Processing Message -->
        <div id="processingMessage" style="display:none;">
            <h2>Your payment is being processed...</h2>
        </div>

        <!-- Payment Success Message -->
        <div id="paymentSuccessMessage" style="display:none;">
            <h2>🎉Payment Successful!🎉</h2>
            <p>Thank you for your payment. Your transaction is complete.</p>
        </div>

        <!-- Timer Section -->
        <div id="timer" style="display:block;">
            <p>Time remaining: <span id="timeLeft">60</span> seconds</p>
        </div>
    </div>

    <script>
        let timeLeft = 60;
        let timer = document.getElementById('timeLeft');
        let timerInterval;

        function startTimer() {
            timerInterval = setInterval(function() {
                timeLeft--;
                timer.innerHTML = timeLeft;

                if (timeLeft <= 0) {
                    clearInterval(timerInterval);
                    alert('Time has expired! Please try again.');
                }
            }, 1000);
        }

        // Start the timer as soon as the page loads
        window.onload = function() {
            startTimer();
        };

        document.getElementById('submitUPI').onclick = function() {
            document.getElementById('processingMessage').style.display = 'block';
            
            // Simulate payment success (in a real scenario, integrate with UPI API)
            setTimeout(function() {
                document.getElementById('processingMessage').style.display = 'none';
                document.getElementById('paymentSuccessMessage').style.display = 'block';
                
                // Stop the timer and hide it when payment is successful
                clearInterval(timerInterval);
                document.getElementById('timer').style.display = 'none';
            }, 3000);
        };
    </script>

</body>
</html>
