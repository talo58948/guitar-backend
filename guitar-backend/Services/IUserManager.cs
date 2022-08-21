using guitar_backend.ActionModels;

namespace guitar_backend.Services
{
    /// <summary>
    /// A service interface that manages all of the interaction with users by the database.
    /// </summary>
    public interface IUserManager
    {
        /// <summary>
        /// Authenticating a given user.
        /// </summary>
        /// <param name="userModel">A model containing username and password, which are used to authenticate a user.</param>
        /// <returns>A tuple containing a success flag (<c>isSuccess</c>), and a message.</returns>
        Task<(bool isSuccess, string message)> AuthenticateUser(UserSignInModel userModel);
        /// <summary>
        /// Creates a user based on the userModel (<c>UserSignUpModel</c>) which is passed to it, saves it to the database in a secure manner.
        /// </summary>
        /// <param name="userModel">The model which represents the user, with all it's credentials.</param>
        /// <returns>A tuple containing a success flag (<c>isSuccess</c>), and a message.</returns>
        Task<(bool isSuccess, string message)> CreateUser(UserSignUpModel userModel);
        /// <summary>
        /// Gets <c>User</c> infromation from jwt token passed to it.
        /// </summary>
        /// <param name="token">jwt token with <c>User</c> information encoded.</param>
        /// <returns><c>User</c> object, representing a <c>User</c>.</returns>
        Task<User?> GetUserFromToken(string token);
    }
}
