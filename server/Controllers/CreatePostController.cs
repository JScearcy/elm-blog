using Microsoft.AspNetCore.Authorization;
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

        [AllowAnonymous]
        public IActionResult Error()
        {
            return View();
        }

        [HttpGet]
        [Route("CreatePost/Post/{id}")]
        [AllowAnonymous]
        public IActionResult Post(int? id) 
        {
            if(id == null) return this.Error();
            return Json(_blogPostsService.GetPost(id.GetValueOrDefault()));
        }

        [HttpPost]
        public IActionResult Post([FromBody] Post post)
        {
            if(post == null || !ModelState.IsValid) return this.Error();
            var newPosts = _blogPostsService.InsertPost(post, Request.Path.ToString());
            return Json(newPosts);
        }

        [HttpGet]
        [AllowAnonymous]
        public IActionResult Posts()
        {
            return Json(_blogPostsService.GetPosts());
        }

        [HttpPost]
        public IActionResult RemovePost([FromBody] Post post)
        {
            if(post == null) return this.Error();
            return Json(_blogPostsService.RemovePost(post));
        }
    }
}
