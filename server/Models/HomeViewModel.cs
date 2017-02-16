using System.Collections.Generic;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace WebApplication.Models
{
    public class HomeViewModel
    {
        public HomeViewModel(List<Post> posts)
        {
            var settings = new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver()
            };

            Posts = new Posts(posts);
            JsonBlogs = JsonConvert.SerializeObject(posts, settings);
        }
        public Posts Posts {get; set;}
        public string JsonBlogs {get; set;}
    }
}