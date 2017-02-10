using System.Collections.Generic;

namespace WebApplication.Models
{
    public class Posts
    {
        public Posts(List<Post> posts)
        {
            All = posts;
        }
        public List<Post> All {get; set;}
    }
}