(function(document, undefined) {
    'use strict';
    var POST_METHOD = 'POST';
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
    function createRequest (method, url, body, succ, fail) {
        var successHandler = succ || app.ports.postBlogSuccess.send,
            failureHandler = fail || console.error,
            request = {
                method: 'POST',
                body: body,
                url: url,
                success: successHandler,
                failure: failureHandler
            }

        return request;
    }

    // request is { body, failure, success, method, url }
    // take the request and send it to the server
    function executeRequest (request) {
        var req = new XMLHttpRequest();
        
        req.open(request.method, request.url, true);
        req.setRequestHeader("Content-Type", "application/json");
        req.onreadystatechange = function reqComplete() {
            if(req.readyState === 4 && req.status === 200) {  
                var response = JSON.parse(req.responseText);
                if (request.success) request.success(response);
            } else if (req.readyState === 4 && req.status > 300) {
                var response = JSON.parse(req.responseText);
                if (request.failure) request.failure(response);
            }
        };
        req.send(request.body);
    }
})(document);