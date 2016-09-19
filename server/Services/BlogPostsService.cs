using System.Collections.Generic;
using System.Linq;
using WebApplication.Data;
using WebApplication.Models;

namespace WebApplication.Services
{
    public class BlogPostsService : IBlogPostsService
    {
        private BlogDbContext db;
        // TODO: Inject BlogDbContext
        public BlogPostsService()
        {
            this.db = new BlogDbContext();
        }

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
            
            post.LinkUrl = $"{path}{post.PostId}".TrimStart('/');
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