(function(undefined) {
    var POST_METHOD = 'POST';
    app.ports.postBlog.subscribe(function (blog) {
        var url = 'CreatePost/Post/',
            body = JSON.stringify(JSON.parse(blog));
            executeRequest(createRequest(POST_METHOD, url, body));
    });

    app.ports.removeBlog.subscribe(function (blog) {
        var url = 'CreatePost/RemovePost/',
            body = JSON.stringify(JSON.parse(blog));
            executeRequest(createRequest(POST_METHOD, url, body));
    });

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
})();