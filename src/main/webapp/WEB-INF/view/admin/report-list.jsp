<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Admin ▸ Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css"/>
</head>
<body>
<h1>Lost &amp; Found ▸ All Reports</h1>

<p>
    <a href="${pageContext.request.contextPath}/admin/reports/create">
        <button>Create New Report</button>
    </a>
</p>

<table border="1" cellpadding="5" cellspacing="0">
    <thead>
    <tr>
        <th>ID</th>
        <th>Type</th>
        <th>Item Name</th>
        <th>Category</th>
        <th>Location</th>
        <th>Date</th>
        <th>Status</th>
        <th>Submitted By</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="r" items="${reports}">
        <tr>
            <td><c:out value="${r.reportId}"/></td>
            <td><c:out value="${r.reqType}"/></td>
            <td><c:out value="${r.itemName}"/></td>
            <td><c:out value="${r.itemType}"/></td>
            <td><c:out value="${r.location}"/></td>
            <td>
                <fmt:formatDate value="${r.dateReported}" pattern="yyyy-MM-dd"/>
            </td>
            <td><c:out value="${r.status}"/></td>
            <td><c:out value="${r.username}"/></td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/reports/edit?id=${r.reportId}">Edit</a> |
                <a href="${pageContext.request.contextPath}/admin/reports/delete?id=${r.reportId}"
                   onclick="return confirm('Delete report #${r.reportId}?');">
                    Delete
                </a>
            </td>
        </tr>
    </c:forEach>

    <c:if test="${empty reports}">
        <tr><td colspan="9">No reports found.</td></tr>
    </c:if>
    </tbody>
</table>
</body>
</html>
