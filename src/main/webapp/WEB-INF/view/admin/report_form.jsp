<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 5/8/2025
  Time: 4:31 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${param.id != null ? 'Edit' : 'Create New'} Report</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css">
    <style>
        /* ____ Form Container ____ */
        .admin-page .form-container {
            background: #ffffff;
            padding: 2rem;
            border-radius: 0.75rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            max-width: 800px;
            margin: 2rem auto;
        }

        /* ____ Form Heading ____ */
        .admin-page .form-container h1 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: #2d3748;
        }

        /* ____ Form Grid Layout ____ */
        .admin-page .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }
        @media (max-width: 640px) {
            .admin-page .form-grid {
                grid-template-columns: 1fr;
            }
        }

        /* ____ Labels ____ */
        .admin-page .form-container label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #4a5568;
        }

        /* ____ Inputs & Textarea ____ */
        .admin-page .form-container input[type="text"],
        .admin-page .form-container input[type="number"],
        .admin-page .form-container input[type="date"],
        .admin-page .form-container select,
        .admin-page .form-container textarea {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #cbd5e0;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            color: #2d3748;
            background: #f7fafc;
            transition: border-color 0.2s;
        }
        .admin-page .form-container input:focus,
        .admin-page .form-container select:focus,
        .admin-page .form-container textarea:focus {
            outline: none;
            border-color: #38a169;
            background: #ffffff;
        }

        /* ____ File Input ____ */
        .admin-page .form-container input[type="file"] {
            padding: 0.5rem;
        }

        /* ____ Action Buttons ____ */
        .admin-page .form-actions {
            grid-column: span 2;
            text-align: right;
            margin-top: 1.5rem;
        }
        @media (max-width: 640px) {
            .admin-page .form-actions {
                grid-column: span 1;
            }
        }
        .admin-page .btn {
            display: inline-block;
            padding: 0.65rem 1.25rem;
            font-size: 0.875rem;
            font-weight: 600;
            border-radius: 0.5rem;
            text-decoration: none;
            transition: background 0.2s;
        }
        .admin-page .btn-create {
            background: #38a169;
            color: #fff;
        }
        .admin-page .btn-create:hover {
            background: #2f855a;
        }
        .admin-page .btn-cancel {
            background: #e2e8f0;
            color: #4a5568;
            margin-left: 0.5rem;
        }
        .admin-page .btn-cancel:hover {
            background: #cbd5e0;
        }

        /* ____ Utility: Full-Span for file and textarea ____ */
        .admin-page .full-span {
            grid-column: span 2;
        }
        @media (max-width: 640px) {
            .admin-page .full-span {
                grid-column: span 1;
            }
        }
    </style>
</head>
<body class="admin-page">

<!-- Card container for the form -->
<div class="form-container">
    <h1>${param.id != null ? 'Edit' : 'Create New'} Report</h1>

    <form action="${pageContext.request.contextPath}/admin/reports/create"
          method="post"
          enctype="multipart/form-data"
          class="form-grid">

        <!-- Request Type -->
        <div>
            <label for="reqType">Request Type</label>
            <select name="reqType" id="reqType" required>
                <option value="lost">Lost</option>
                <option value="found">Found</option>
            </select>
        </div>

        <!-- Item Name -->
        <div>
            <label for="itemName">Item Name</label>
            <input type="text" id="itemName" name="itemName" required/>
        </div>

        <!-- Item Type ID -->
        <div>
            <label for="itemTypeId">Item Type ID</label>
            <input type="number" id="itemTypeId" name="itemTypeId" required/>
            <small>(See <code>item_types</code> table for IDs)</small>
        </div>

        <!-- Date Reported -->
        <div>
            <label for="dateReported">Date Reported</label>
            <input type="date" id="dateReported" name="dateReported" required/>
        </div>

        <!-- Location -->
        <div>
            <label for="location">Location</label>
            <input type="text" id="location" name="location" required/>
        </div>

        <!-- Status -->
        <div>
            <label for="status">Status</label>
            <select name="status" id="status" required>
                <option value="unclaimed">Unclaimed</option>
                <option value="claimed">Claimed</option>
                <option value="returned">Returned</option>
            </select>
        </div>

        <!-- Description (full span) -->
        <div class="full-span">
            <label for="description">Description</label>
            <textarea id="description" name="description" rows="4"></textarea>
        </div>

        <!-- Image Upload (full span) -->
        <div class="full-span">
            <label for="image">Image (optional)</label>
            <input type="file" id="image" name="image" accept="image/*"/>
        </div>

        <!-- Buttons (full span) -->
        <div class="full-span form-actions">
            <button type="submit" class="btn btn-create">
                ${param.id != null ? 'Update' : 'Create'}
            </button>
            <a href="${pageContext.request.contextPath}/admin/reports"
               class="btn btn-cancel">
                Cancel
            </a>
        </div>
    </form>
</div>

</body>
</html>
