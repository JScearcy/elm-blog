using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Models;

namespace WebApplication.Services
{
    public class BlogPostsService : IBlogPostsService
    {
        public BlogPostsService()
        {
          this.Posts = new List<Post>() 
          {
              new Post() { PostId = 1, PostTitle = "First Post", PostBody = "First post body", ImgUrl = "https://i.imgur.com/aha9awt.png", LinkUrl = "http://localhost:5000/CreatePost/Post/1"  },
              new Post() { PostId = 2, PostTitle = "Second Post", PostBody = "Second post body", ImgUrl = "https://i.imgur.com/aha9awt.png", LinkUrl = "http://localhost:5000/CreatePost/Post/2"  },
              new Post() { PostId = 3, PostTitle = "Third Post", PostBody = "Third post body", ImgUrl = "https://i.imgur.com/aha9awt.png", LinkUrl = "http://localhost:5000/CreatePost/Post/3"  },
              new Post() { PostId = 4, PostTitle = "Fourth Post", PostBody = "Fourth post body", ImgUrl = "https://i.imgur.com/aha9awt.png", LinkUrl = "http://localhost:5000/CreatePost/Post/4"  }
          };
        }

        private List<Post> Posts;

        public List<Post> GetPosts() 
        {
            return this.Posts;
        }

        public Post GetPost(int id)
        {
            return this.Posts.FirstOrDefault(post => post.PostId == id);
        }

        public List<Post> InsertPost(Post post)
        {
            this.Posts.Add(post);
            return this.Posts;
        }
    }
}