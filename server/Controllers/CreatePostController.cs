using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebApplication.Models;
using WebApplication.Services;

namespace WebApplication.Controllers
{
    public class CreatePostController : Controller
    {
        private IBlogPostsService _blogPostsService;

        public CreatePostController (IBlogPostsService blogPostsService)
        {
          _blogPostsService = blogPostsService;
        }
        
        public IActionResult Error()
        {
            return View();
        }

        [HttpGet]
        [Route("CreatePost/Post/{id}")]
        public IActionResult Post(int? id) 
        {
            if(id == null) return this.Error();
            var test = Request;
            var post = _blogPostsService.GetPost(id.GetValueOrDefault());
            return Json(post);
        }

        [HttpPost]
        public IActionResult Post(Post post)
        {
            if(post == null) return this.Error();
            var newPosts = _blogPostsService.InsertPost(post, Request.Host.ToString(), Request.Path.ToString());
            return Json(newPosts);
        }

        [HttpGet]
        public IActionResult Posts()
        {
            var posts = _blogPostsService.GetPosts();
            return Json(posts);
        }

        [HttpDelete]
        public IActionResult RemovePost(Post post)
        {
            if(post == null) return this.Error();
            var newPosts = _blogPostsService.RemovePost(post);
            return Json(newPosts);
        }
    }
}
