using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using WebApplication.Services;
using WebApplication.Models;

namespace WebApplication.Controllers
{
    public class HomeController : Controller
    {
        private IBlogPostsService _blogPostsService;
        public HomeController(IBlogPostsService blogPostsService)
        {
            _blogPostsService = blogPostsService;
        }

        [AllowAnonymous]
        public IActionResult Index()
        {
            var posts = _blogPostsService.GetPosts();

            var model = new HomeViewModel(posts);

            return View(model);
        }

        public IActionResult Error()
        {
            return View();
        }
    }
}
