<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>College Lost & Found</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        /* Same CSS as before */
        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background: linear-gradient(to bottom right, #FEF3C7, #FFFFFF);
            color: #2D3748;
        }

        header {
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .container {
            max-width: 1024px;
            margin: 0 auto;
            padding: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        nav a {
            margin-left: 20px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            color: #4A5568;
        }

        nav a:hover,
        nav a.active {
            color: #D97706;
        }

        main {
            max-width: 1024px;
            margin: 0 auto;
            padding: 40px 16px;
        }

        h2.typewriter {
            font-size: 28px;
            font-weight: 700;
            color: #B45309;
            overflow: hidden;
            border-right: 2px solid;
            white-space: nowrap;
            animation: typing 3s steps(30, end) forwards;
            display: inline-block;
        }

        @keyframes typing {
            from {
                width: 0;
            }

            to {
                width: 100%;
            }
        }

        .glass {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.75);
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            border-radius: 16px;
            padding: 32px;
        }

        form {
            display: grid;
            grid-template-columns: 1fr;
            gap: 24px;
        }

        @media (min-width: 768px) {
            form {
                grid-template-columns: repeat(2, 1fr);
            }

            .full-width {
                grid-column: span 2;
            }

            .text-right {
                text-align: right;
            }
        }

        label {
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 4px;
            display: block;
        }

        input[type="text"],
        input[type="date"],
        input[type="time"],
        input[type="file"],
        textarea {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #CBD5E0;
            border-radius: 8px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
        }

        .submit-btn {
            background-color: #D97706;
            color: white;
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: #B45309;
        }

        footer {
            text-align: center;
            padding: 24px;
            font-size: 14px;
            color: #A0AEC0;
        }

        #successModal {
            position: fixed;
            inset: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 50;
            display: none;
        }

        #successModal.active {
            display: flex;
        }

        #successModal .modal-content {
            background-color: white;
            padding: 32px;
            border-radius: 16px;
            text-align: center;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
        }

        .modal-content h2 {
            color: #D97706;
            font-size: 24px;
            font-weight: 700;
        }

        .modal-content p {
            margin-top: 8px;
            color: #4A5568;
        }

        .modal-content button {
            margin-top: 16px;
            background-color: #D97706;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
        }

        .modal-content button:hover {
            background-color: #B45309;
        }

        button[title="Toggle Dark Mode"] {
            background: none;
            border: none;
            cursor: pointer;
            color: #718096;
            font-size: 16px;
        }

        button[title="Toggle Dark Mode"]:hover {
            color: #000000;
        }
    </style>
</head>

<body>
<header>
    <div class="container">
        <h1 style="font-size: 24px; font-weight: bold; color: #D97706;">College Lost & Found</h1>
        <nav>
            <a href="lost.jsp">Submit Lost Item</a>
            <a href="submit-found-item.jsp" class="active">Submit Found Item</a>
            <a href="#">View Posts</a>
            <button title="Toggle Dark Mode">
                <i class="fas fa-moon"></i>
            </button>
        </nav>
    </div>
</header>

<main>
    <div style="text-align: center; margin-bottom: 32px;">
        <h2 class="typewriter">Have you found something on campus?</h2>
        <p style="margin-top: 8px; color: #4A5568;">Submit the details to help it reach its rightful owner.</p>
    </div>

    <div class="glass">
        <!-- Form now submits to a servlet or JSP to process the data -->
        <form action="FoundItemServlet" method="post" enctype="multipart/form-data" onsubmit="showModal(event)">
            <div>
                <label for="itemFound">What was Found *</label>
                <input type="text" id="itemFound" name="itemFound" placeholder="e.g. Phone, Notebook, Keys" required />
            </div>
            <div>
                <label for="category">Category *</label>
                <input type="text" id="category" name="category" placeholder="e.g. Electronics, Stationery" required />
            </div>
            <div>
                <label for="dateFound">Date Found *</label>
                <input type="date" id="dateFound" name="dateFound" required />
            </div>
            <div>
                <label for="timeFound">Time Found *</label>
                <input type="time" id="timeFound" name="timeFound" required />
            </div>
            <div>
                <label for="brand">Brand (if any)</label>
                <input type="text" id="brand" name="brand" placeholder="e.g. Samsung, Nike" />
            </div>
            <div>
                <label for="primaryColor">Primary Color</label>
                <input type="text" id="primaryColor" name="primaryColor" placeholder="e.g. Red, Blue" />
            </div>
            <div>
                <label for="secondaryColor">Secondary Color</label>
                <input type="text" id="secondaryColor" name="secondaryColor" placeholder="(Optional) e.g. White, Grey" />
            </div>
            <div>
                <label for="image">Upload Image</label>
                <input type="file" id="image" name="image" />
            </div>
            <div class="full-width">
                <label for="locationFound">Location Found *</label>
                <input type="text" id="locationFound" name="locationFound" placeholder="e.g. Auditorium, Lab" required />
            </div>
            <div class="full-width">
                <label for="additionalInfo">Additional Information</label>
                <textarea id="additionalInfo" name="additionalInfo" rows="4" placeholder="Any additional details..."></textarea>
            </div>
            <div class="full-width text-right">
                <button type="submit" class="submit-btn">Submit Found Item</button>
            </div>
        </form>
    </div>
</main>

<footer>
    &copy; 2025 College Lost & Found | All rights reserved.
</footer>

<div id="successModal">
    <div class="modal-content">
        <h2>✅ Item Submitted!</h2>
        <p>Thanks for helping someone recover their lost item.</p>
        <button onclick="closeModal()">Close</button>
    </div>
</div>

<script>
    function showModal(e) {
        e.preventDefault();
        document.getElementById('successModal').classList.add('active');
    }

    function closeModal() {
        document.getElementById('successModal').classList.remove('active');
    }
</script>
</body>

</html>
