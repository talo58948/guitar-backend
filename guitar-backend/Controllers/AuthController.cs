using guitar_backend.ActionModels;
using Microsoft.AspNetCore.Mvc;
using System.Text;

namespace guitar_backend.Controllers
{
    /// <summary>
    /// Defines authentication routes, that are used for authenticating uses using JWT.
    /// </summary>
    public class AuthController : Controller
    {
        /// <summary>
        /// Authenticaion manager service, injected in DI.
        /// </summary>
        private readonly IUserManager _authManager;
        /// <summary>
        /// Controller constructor used for DI.
        /// </summary>
        /// <param name="authManager">The <c>IAuthManager</c> service, used for authenticating uesrs in the actions.</param>
        public AuthController(IUserManager authManager)
        {
            _authManager = authManager;
        }
        /// <summary>
        /// Signs user in, by providing them a JWT token.
        /// </summary>
        /// <param name="userModel">The <c>User</c> model used to authenticate <c>User</c>.</param>
        /// <returns><c>Ok</c> with a JWT token if <c>User</c> is in the database and the password matches their password, otherwise <c>BadRequest</c>.</returns>
        [AllowAnonymous]
        [HttpPost("[action]")]
        public async Task<IActionResult> SignIn([FromBody] UserSignInModel userModel)
        {
            var res = await _authManager.AuthenticateUser(userModel);
            if (res.isSuccess)
                return Ok(res.message);
            return BadRequest(res.message);
        }
        /// <summary>
        /// Signs user up.
        /// </summary>
        /// <param name="userModel">The <c>User</c> model used to create and add to database a new <c>User</c>.</param>
        /// <returns><c>Ok</c> if <c>User</c> has succesfully been signed up and added to the database.</returns>
        [AllowAnonymous]
        [HttpPost("[action]")]
        public async Task<IActionResult> SignUp([FromBody] UserSignUpModel userModel)
        {
            var res = await _authManager.CreateUser(userModel);
            if (res.isSuccess)
                return Ok(res.message);
            return BadRequest(res.message);
        }
    }
}
