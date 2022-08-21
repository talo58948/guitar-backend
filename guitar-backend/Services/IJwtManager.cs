namespace guitar_backend.Services
{
    /// <summary>
    /// A service interface that manages the intercation with Jwt tokens.
    /// </summary>
    public interface IJwtManager
    {
        /// <summary>
        /// Generates a Jwt token for a specific user passed to it.
        /// </summary>
        /// <param name="user">Holds data about the user which is used to create the claims that are encoded into the Jwt token.</param>
        /// <returns></returns>
        string GenerateToken(User user);
        /// <summary>
        /// Extracts <c>User</c> id from jwt token.
        /// </summary>
        /// <param name="token">The token to extract the <c>User</c>'s id from.</param>
        /// <returns>The <c>User</c> id embedded in the given jwt token.</returns>
        int GetUserIdFromToken(string token);
    }
}
