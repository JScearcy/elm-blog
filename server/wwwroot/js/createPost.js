(function(document, undefined) {
    var POST_METHOD = 'POST';
    // listen for login button click, tell elm that the button has been clicked
    document.getElementById("login-btn").addEventListener("click", function(e) {
        app.ports.loginRequest.send();
    });
    // remove default click events
    document.getElementById("elmApp").addEventListener("click", function(e) {
        e.preventDefault();
    });
    // listen for new blog data to come from the elm runtime and post it to the server
    app.ports.postBlog.subscribe(function (blog) {
        var url = 'CreatePost/Post/',
            body = JSON.stringify(JSON.parse(blog));
            executeRequest(createRequest(POST_METHOD, url, body));
    });
    // listen to the elm runtime for blog to delete and post it to the server
    app.ports.removeBlog.subscribe(function (blog) {
        var url = 'CreatePost/RemovePost/',
            body = JSON.stringify(JSON.parse(blog));
            executeRequest(createRequest(POST_METHOD, url, body));
    });
    // create a request to semd data to the server
    function createRequest (method, url, body) {
        request = {
            method: 'POST',
            body: body,
            url: url,
            success: app.ports.postBlogSuccess.send,
            failure: console.error
        }

        return request;
    }

    // request is { body, failure, success, method, url }
    // take the request and send it to the server
    function executeRequest (request) {
        req = new XMLHttpRequest();
            
        req.open(request.method, request.url, true);
        req.setRequestHeader("Content-Type", "application/json");
        req.onreadystatechange = function reqComplete() {
            var response = JSON.parse(req.responseText);
            if(req.readyState === 4 && req.status === 200) {
                if (request.success) request.success(response);
            } else {
                if (request.failure) request.error(response);
            }
        };
        req.send(request.body);
    }
})(document);