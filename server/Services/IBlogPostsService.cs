using System.Collections.Generic;
using WebApplication.Models;

namespace WebApplication.Services
{
    public interface IBlogPostsService
    {
        List<Post> GetPosts();
        Post GetPost(int id);
        List<Post> InsertPost(Post post, string host, string path);
        List<Post> RemovePost(Post post);
        Post UpdatePost(Post post);
    }
}