<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:if test="${not empty success}">
    <div class="bg-green-100 p-3 mb-4 rounded-lg">
            ${success}
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="bg-red-100 p-3 mb-4 rounded-lg">
            ${error}
    </div>
</c:if>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>College Lost & Found</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        @keyframes typing {
            from { width: 0 }
            to { width: 100% }
        }
        .typewriter {
            display: inline-block;
            overflow: hidden;
            white-space: nowrap;
            border-right: 2px solid;
            animation: typing 3s steps(30, end) forwards;
        }
        .glass {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.75);
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
        }
    </style>
</head>

<body class="bg-gradient-to-br from-yellow-100 to-white text-gray-800">

<main class="container mx-auto px-4 py-10">
    <div class="text-center mb-8">
        <h2 class="text-3xl font-bold text-yellow-700 typewriter">Have you found something on campus?</h2>
        <p class="text-gray-600 mt-2">Submit the details to help it reach its rightful owner.</p>
    </div>

    <div class="bg-white glass rounded-2xl shadow-lg p-8">
        <form class="grid grid-cols-1 md:grid-cols-2 gap-6"  enctype="multipart/form-data" method="post" action="SubmitFoundItemServlet">
            <div>
                <label class="block text-sm font-semibold mb-1">What was Found *</label>
                <input type="text" name="item" placeholder="e.g. Phone, Notebook, Keys" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div>
                <label class="block text-sm font-semibold mb-1">Category *</label>
                <input type="text" name="category" placeholder="e.g. Electronics, Stationery" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div>
                <label class="block text-sm font-semibold mb-1">Date Found *</label>
                <input type="date" name="dateFound" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div>
                <label class="block text-sm font-semibold mb-1">Item Name </label>
                <input type="text" name="item-name" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div>
                <label class="block text-sm font-semibold mb-1">Brand (if any)</label>
                <input type="text" name="brand" placeholder="e.g. Samsung, Nike" class="w-full border border-gray-300 rounded-lg p-2" />
            </div>

            <div>
                <label class="block text-sm font-semibold mb-1">Upload Image</label>
                <input type="file" name="image" class="w-full border border-gray-300 rounded-lg p-2" />
            </div>

            <div class="md:col-span-2">
                <label class="block text-sm font-semibold mb-1">Location Found *</label>
                <input type="text" name="location" placeholder="e.g. Auditorium, Lab" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div class="md:col-span-2">
                <label class="block text-sm font-semibold mb-1">Additional Information</label>
                <textarea name="additionalInfo" rows="4" placeholder="Any additional details..." class="w-full border border-gray-300 rounded-lg p-2"></textarea>
            </div>

            <div class="md:col-span-2 text-right">
                <button type="submit" class="bg-yellow-600 text-white px-6 py-2 rounded-lg hover:bg-yellow-700 transition">Submit Found Item</button>
            </div>
        </form>
    </div>
</main>


<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden" id="successModal">
    <div class="bg-white p-8 rounded-xl shadow-lg text-center">
        <h2 class="text-2xl font-bold text-yellow-600">✅ Item Submitted!</h2>
        <p class="mt-2 text-gray-600">Thanks for helping someone recover their lost item.</p>
        <button onclick="closeModal()" class="mt-4 px-4 py-2 bg-yellow-600 text-white rounded hover:bg-yellow-700">Close</button>
    </div>
</div>


</body>

</html>
