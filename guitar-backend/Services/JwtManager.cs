using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace guitar_backend.Services
{
	/// <summary>
	/// A service that manages the generation of Jwt tokens.
	/// </summary>
    public class JwtManager : IJwtManager
    {
		/// <summary>
		/// A refrence to the application configuration, passed by DI.
		/// </summary>
        private readonly IConfiguration _config;
		/// <summary>
		/// A constructor that is used by DI to inject the configuration refrence.
		/// </summary>
		/// <param name="config">The configuration refrence</param>
        public JwtManager(IConfiguration config)
        {
            _config = config;
        }
        public string GenerateToken(User user)
		{
			var claimsIdentity = new ClaimsIdentity(new Claim[]
			{
				new Claim(ClaimTypes.NameIdentifier, user.Id.ToString())
			});
			if (user.Email != null)
				claimsIdentity.AddClaim(new Claim(ClaimTypes.Email, user.Email));
			if (user.Role != null)
				claimsIdentity.AddClaim(new Claim(ClaimTypes.Role, user.Role));

			var tokenKey = Encoding.UTF8.GetBytes(_config["Jwt:key"]);
			var tokenDescriptor = new SecurityTokenDescriptor
			{
				Subject = claimsIdentity,
				Expires = DateTime.UtcNow.AddMinutes(90),
				SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(tokenKey), SecurityAlgorithms.HmacSha256Signature),
				Issuer = _config["Jwt:Issuer"]
			};
			var tokenHandler = new JwtSecurityTokenHandler();
			var token = tokenHandler.CreateToken(tokenDescriptor);
			return tokenHandler.WriteToken(token);
		}
		public int GetUserIdFromToken(string token)
		{
			token = token.Replace("Bearer ", string.Empty);
			var handler = new JwtSecurityTokenHandler();
			var jwt = handler.ReadJwtToken(token);
			var userId = int.Parse(jwt.Claims.First(claim => claim.Type == "nameid").Value);
			return userId;
		} 
    }
}
