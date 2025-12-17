<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Card Payment</title>
    <link rel="stylesheet" href="payment.css">
</head>
<body>

    <div class="container">
        <h1>Bungalow Booking - Card Payment</h1>
        <h3>Enter your card details to complete the payment</h3>

        <!-- Card Payment Form -->
        <div id="cardForm">
            <input type="text" id="cardNumber" placeholder="Card Number" maxlength="16">
            <input type="text" id="expiryDate" placeholder="Expiry Date (MM/YY)">
            <input type="text" id="cvv" placeholder="CVV" maxlength="3">
            <button id="submitCardPayment">Submit</button>
        </div>

        <!-- OTP Form -->
        <div id="otpForm" style="display:none;">
            <h3>Enter OTP Sent to Your Mobile</h3>
            <input type="text" id="otp" placeholder="Enter OTP" maxlength="6">
            <button id="verifyOtpButton">Verify OTP</button>
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
            <p>Transaction valid till : <span id="timeLeft">60</span> seconds</p>
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

        document.getElementById('submitCardPayment').onclick = function() {
            document.getElementById('cardForm').style.display = 'none';
            document.getElementById('otpForm').style.display = 'block';
            document.getElementById('processingMessage').style.display = 'block';
            
            // Simulate OTP verification
            setTimeout(function() {
                document.getElementById('processingMessage').style.display = 'none';
            }, 2000);
        };

        document.getElementById('verifyOtpButton').onclick = function() {
            document.getElementById('paymentSuccessMessage').style.display = 'block';
            document.getElementById('otpForm').style.display = 'none';

            // Stop the timer and hide it when payment is successful
            clearInterval(timerInterval);
            document.getElementById('timer').style.display = 'none';
        };
    </script>

</body>
</html>
