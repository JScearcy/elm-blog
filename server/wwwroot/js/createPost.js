(function(undefined) {
    app.ports.postBlog.subscribe(function (blog) {
        var url = 'CreatePost/Post/',
            body = JSON.stringify(JSON.parse(blog));
            postRequest(url, body);
    });

    app.ports.removeBlog.subscribe(function (blog) {
        var url = 'CreatePost/RemovePost/',
            body = JSON.stringify(JSON.parse(blog));
            postRequest(url, body)
    });

    function postRequest (url, body) {
        request = {
            method: 'POST',
            body: body,
            url: url,
            success: app.ports.postBlogSuccess.send,
            failure: console.error
        }

        sendRequest(request);
    }

    // request is { body, failure, success, method, url }
    function sendRequest (request) {
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