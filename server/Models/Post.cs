using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public class Post 
    {
        [Key]
        public int PostId { get; set; }

        public string PostTitle { get; set; }
        public string PostBody { get; set; }
        public string ImgUrl { get; set; }
        public string LinkUrl { get; set; }
    }
}