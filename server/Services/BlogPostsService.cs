using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Models;
using WebApplication.Data;

namespace WebApplication.Services
{
    public class BlogPostsService : IBlogPostsService
    {
        public BlogPostsService()
        {
            this.db = new BlogDbContext();
            this.Posts = new List<Post>() 
            {
                new Post() { PostId = 1, PostTitle = "First Post", PostBody = "First post body", ImgUrl = "https://i.imgur.com/aha9awt.png", LinkUrl = "http://localhost:5000/CreatePost/Post/1"  },
                new Post() { PostId = 2, PostTitle = "Second Post", PostBody = "Second post body", ImgUrl = "https://i.imgur.com/aha9awt.png", LinkUrl = "http://localhost:5000/CreatePost/Post/2"  },
                new Post() { PostId = 3, PostTitle = "Third Post", PostBody = "Third post body", ImgUrl = "https://i.imgur.com/aha9awt.png", LinkUrl = "http://localhost:5000/CreatePost/Post/3"  },
                new Post() { PostId = 4, PostTitle = "Fourth Post", PostBody = "Fourth post body", ImgUrl = "https://i.imgur.com/aha9awt.png", LinkUrl = "http://localhost:5000/CreatePost/Post/4"  }
            };

        }

        private BlogDbContext db;
        private List<Post> Posts;

        public List<Post> GetPosts() 
        {
            var posts = new List<Post>();
            foreach (var post in db.Posts) 
            {
                posts.Add(post);
            }
            return posts;
        }

        public Post GetPost(int id)
        {
            var post = db.Posts.FirstOrDefault(p => p.PostId == id);
            return post;
        }

        public List<Post> InsertPost(Post post, string host, string path)
        {
            db.Posts.Add(post);
            db.SaveChanges();
            
            post.LinkUrl = $"http://{host}{path}{post.PostId}";
            db.Posts.Update(post);
            db.SaveChanges();

            return db.Posts.ToList();
        }

        public List<Post> RemovePost(Post post)
        {
            db.Posts.Remove(post);
            db.SaveChanges();

            return db.Posts.ToList();
        }

        public Post UpdatePost(Post post)
        {
            var currentPost = db.Posts.FirstOrDefault(p => p.PostId == post.PostId);
            currentPost = post;
            db.Posts.Update(currentPost);
            db.SaveChanges();

            return post;
        }
    }
}