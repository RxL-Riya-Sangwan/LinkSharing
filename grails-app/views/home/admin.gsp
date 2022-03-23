<%@ page import="link_sharing.Seriousness; link_sharing.Visibility" %>
<!Doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <title>
        Admin
    </title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <asset:stylesheet src="app.css" />
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
    <style>
    html, body{
        background-color: aliceblue;
    }
    </style>
</head>
<body>
<nav class="mb-4 navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="${createLink(controller: 'home', action: 'index')}">
            <i class="bi bi-ui-radios"></i>
            LINK SHARING
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="Navbar for Link Sharing" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    %{--                    <a href="${createLink()}" class="nav-link">Home</a>--}%
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link active dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        ${session['username'].toString().capitalize()}
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#">Profile</a></li>
                    %{--                                If user is admin show them following 3 items as well--}%
                        <g:if test="${session['role'] == 'admin'}">
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">Users</a></li>
                            <li><a class="dropdown-item" href="#">Topics</a></li>
                            <li><a class="dropdown-item" href="#">Posts</a></li>
                            <li><hr class="dropdown-divider"></li>
                        </g:if>
                        <li><a class="dropdown-item" href="${createLink(controller: 'home', action: 'logout')}">Logout</a></li>
                    </ul>
                </li>
            </ul>
            <form class="d-flex">
                <input class="form-control me-2" type="search" placeholder="SEARCH" aria-label="Search">
                <button class="btn btn-outline-dark" type="submit">SEARCH</button>
            </form>
        </div>
    </div>
</nav>
    <g:if test="${flash.message}">
        <div class="alert alert-success text-center" role="alert" style="font-family: monospace">
            ${flash.message}
        </div>
    </g:if>
    <div class="container">
    <div class="row">
        <div class="col-1">
        </div>
        <div class="col-10">
            <table class="shadowC border-dark table table-hover table-striped table-bordered table-responsive" id="table_id">
                <thead style="background-color: #191c1f; color: white">
                <tr>
                    <th scope="col">Id</th>
                    <th scope="col">Username</th>
                    <th scope="col">Email Id</th>
                    <th scope="col">First Name</th>
                    <th scope="col">Last Name</th>
                    <th scope="col">Active</th>
                    <th scope="col">Manage</th>
                </tr>
                </thead>
                <tbody>
                <g:set var="counter" value="${1}"/>
                <g:each in="${userList}">
                    <tr>
                        <td>${counter}</td>
                        <td>${it.username}</td>
                        <td>${it.email}</td>
                        <td>${it.firstName}</td>
                        <td>${it.lastName}</td>
                        <td>${it.isActive}</td>
                        <td></td>
                    </tr>
                    <g:set var="counter" value="${counter + 1}" />
                </g:each>
                </tbody>
            </table>
        </div>
        <div class="col-1">
        </div>
    </div>
</div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
    <script>
        $(document).ready( function () {
            $('#table_id').DataTable();
        } );
    </script>
</body>
</html>