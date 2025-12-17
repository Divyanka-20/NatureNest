<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Explore Indian Forests</title>

    <style>
        body {
            background-image: url('back.jpg');
            background-size: cover;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .content {
            margin-top: 60px; /* To offset the fixed nav bar */
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .summary {
            background-color: rgba(0, 0, 0, 0.7); /* Light black shading */
            color: white;
            border-radius: 8px;
            padding: 20px;
            margin: 10px;
            width: 80%;
            max-width: 600px;
        }

        .summary h2 {
            margin-top: 0;
        }

        .learn-more-button {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            color: white;
            background-color: #333; /* Darker shade for button */
            text-decoration: none;
            border-radius: 5px;
        }

        .learn-more-button:hover {
            background-color: #555; /* Slightly lighter shade on hover */
        }

        .grid-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            width: 80%;
            max-width: 1200px;
        }

        .grid-item {
            position: relative;
            text-align: center;
            color: white;
        }

        /* Ensure all links inside grid items are white */
        .grid-item a {
            color: white;
            text-decoration: none;
        }

        .grid-item a:hover {
            text-decoration: underline; /* Optional: adds underline on hover */
        }

        /* Uniform image size across grid items */
        .grid-item img {
            width: 100%;
            height: 200px; /* Fixed height for all images */
            object-fit: cover; /* Ensures images cover the area without distortion */
            border-radius: 8px;
        }

        .grid-item .title {
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
            background-color: rgba(0, 0, 0, 0.7);
            padding: 5px 10px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

    <div class="content">
        <div class="summary">
            <h2>Explore the Indian Forests</h2>
            <p>
                Discover the various national parks, reserve forests, animal species, birds, wildlife sanctuaries,
                endangered species, forest bungalows, hotels, and tour plans in the vast Indian forests.
            </p>
        </div>
        <div class="grid-container">
            <div class="grid-item">
                <a href="nationalpark.jsp">
                    <img src="nationalpark.jpg" width="330" height="220" alt="National Parks" />
                    <div class="title">National Parks</div>
                </a>
            </div>
            <div class="grid-item">
                <a href="reserveforest.jsp">
                    <img src="reserveforest.jpg" width="330" height="220" alt="Reserve Forests" />
                    <div class="title">Reserve Forests</div>
                </a>
            </div>
            <div class="grid-item">
                <a href="animalspecies.jsp">
                    <img src="animal.jpg" width="330" height="220" alt="Animal Species" />
                    <div class="title">Animal Species</div>
                </a>
            </div>
            <div class="grid-item">
                <a href="birds.jsp">
                    <img src="birds.jpg" width="330" height="220" alt="Birds" />
                    <div class="title">Birds</div>
                </a>
            </div>
            <div class="grid-item">
                <a href="sanctuary.jsp">
                    <img src="sanctuary.jpg" width="330" height="220" alt="Wildlife Sanctuaries" />
                    <div class="title">Wildlife Sanctuaries</div>
                </a>
            </div>
            <div class="grid-item">
                <a href="endangeredspecies.jsp">
                    <img src="endangered.jpg" width="330" height="220" alt="Endangered Species" />
                    <div class="title">Endangered Species</div>
                </a>
            </div>
            <div class="grid-item">
                <a href="forestbungalows.jsp">
                    <img src="forestbanglow.jpg" width="330" height="220" alt="Forest Bungalows" />
                    <div class="title">Forest Bungalows</div>
                </a>
            </div>
            <div class="grid-item">
                <a href="tours.jsp">
                    <img src="tourplans.jpg" width="330" height="220" alt="Tours in Forest" />
                    <div class="title">Forest Tours</div>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
