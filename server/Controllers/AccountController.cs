using System;
using System.Security.Claims;
using System.Security.Principal;
using System.Threading.Tasks;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using WebApplication.Models;
using WebApplication.Services;

[Route("users/[controller]/[action]")]
public class AccountController : Controller
{
    private readonly SignInManager<ApplicationUser> _signInManager;
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly JwtIssuerOptions _jwtOptions;
    private readonly JsonSerializerSettings _serializerSettings;
    // private readonly ILogger _logger;

    public AccountController (SignInManager<ApplicationUser> signInManager,
        UserManager<ApplicationUser> userManager,
        IOptions<JwtIssuerOptions> jwtOptions)
    {
        _signInManager = signInManager;
        _userManager = userManager;
        _jwtOptions = jwtOptions.Value;
        // _logger = logger;

        _serializerSettings = new JsonSerializerSettings
        {
            Formatting = Formatting.Indented
        };
    }

    [HttpPost]
    [AllowAnonymous]
    public async Task<IActionResult> Register([FromBody] UserViewModel user)
    {
        if (ModelState.IsValid)
        {
            var newUser = new ApplicationUser { UserName = user.Username, Email = user.Email };
            var result = await _userManager.CreateAsync(newUser, user.Password);
            if (result.Succeeded)
            {
                // await _signInManager.SignInAsync(newUser, isPersistent: false);
                return Json($"Created {user.Username}");
            }
            return Json(result.Errors);
        }
        return Json("Unspecified Error");
    }

    public async Task<bool> IsValidUser(UserViewModel user)
    {
        bool isValidUser = false;
        if (ModelState.IsValid)
        {
            var result = await _signInManager.PasswordSignInAsync(user.Username, user.Password, false, false);
            if (result.Succeeded)
            {
                isValidUser = true;
            } 
            else
            {
                isValidUser = false;
            }
        }
        return isValidUser;
    }

    public Task<ClaimsIdentity> GetClaimsIdentity(string username) 
    {     
        Task<ClaimsIdentity> claim;
        if (!string.IsNullOrWhiteSpace(username))
        {
            claim = Task.FromResult(new ClaimsIdentity(
                new GenericIdentity(username, "Token"),
                new Claim[] {}
            ));
        }
        else
        {
            claim = Task.FromResult<ClaimsIdentity>(null);
        }

        return claim;
    }

    private static long ToUnixEpochDate(DateTime date)
      => (long)Math.Round((date.ToUniversalTime() - 
                           new DateTimeOffset(1970, 1, 1, 0, 0, 0, TimeSpan.Zero))
                          .TotalSeconds);

    [HttpPost]
    [AllowAnonymous]
    public async Task<IActionResult> Login([FromBody] UserViewModel user)
    {
        var isValidUser = await IsValidUser(user);
        ClaimsIdentity identity = null;
        if(isValidUser)
        {
            identity = await GetClaimsIdentity(user.Username);
        }
      
        if (identity == null)
        {
            //_logger.LogInformation($"Invalid username ({user.Username}) or password ({user.Password})");
            return BadRequest("Invalid credentials");
        }

        var claims = new[]
        {
            new Claim(JwtRegisteredClaimNames.Sub, user.Username),
            new Claim(JwtRegisteredClaimNames.Jti, await _jwtOptions.JtiGenerator()),
            new Claim(JwtRegisteredClaimNames.Iat, 
                    ToUnixEpochDate(_jwtOptions.IssuedAt).ToString(), 
                    ClaimValueTypes.Integer64),
            identity.FindFirst("DisneyCharacter")
        };

      // Create the JWT security token and encode it.
      var jwt = new JwtSecurityToken(
          issuer: _jwtOptions.Issuer,
          audience: _jwtOptions.Audience,
          claims: claims,
          notBefore: _jwtOptions.NotBefore,
          expires: _jwtOptions.Expiration,
          signingCredentials: _jwtOptions.SigningCredentials);

      var encodedJwt = new JwtSecurityTokenHandler().WriteToken(jwt);

      // Serialize and return the response
      var response = new
      {
        access_token = encodedJwt,
        expires_in = (int)_jwtOptions.ValidFor.TotalSeconds
      };

      var json = JsonConvert.SerializeObject(response, _serializerSettings);
      return new OkObjectResult(json);
    }
}