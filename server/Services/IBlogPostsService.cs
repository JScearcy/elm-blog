using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Models;

namespace WebApplication.Services
{
    public interface IBlogPostsService
    {
        List<Post> GetPosts();
        Post GetPost(int id);
        List<Post> InsertPost(Post post);
    }
}