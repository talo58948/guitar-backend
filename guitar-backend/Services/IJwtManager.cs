namespace guitar_backend.Services
{
    /// <summary>
    /// A service interface that manages the generation of Jwt tokens.
    /// </summary>
    public interface IJwtManager
    {
        /// <summary>
        /// Generates a Jwt token for a specific user passed to it.
        /// </summary>
        /// <param name="user">Holds data about the user which is used to create the claims that are encoded into the Jwt token.</param>
        /// <returns></returns>
        string GenerateToken(User user);
        int GetUserIdFromToken(string token);
    }
}
