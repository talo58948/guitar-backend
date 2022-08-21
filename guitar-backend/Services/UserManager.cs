using guitar_backend.ActionModels;
using System.Text;

namespace guitar_backend.Services
{
    /// <summary>
    /// A service that manages all of the interaction with users by the database.
    /// </summary>
    public class UserManager : IUserManager
    {
        /// <summary>
        /// The <c>DbContext</c> used to fetch user's information from the database.
        /// </summary>
        private readonly guitardbContext _db;
        /// <summary>
        /// A service that manages the intercation with JWT tokens.
        /// </summary>
        private readonly IJwtManager _jwt;
        /// <summary>
        /// The constructor used by DI to inject services.
        /// </summary>
        /// <param name="db">The <c>DbContext</c> to be injected into this service.</param>
        /// <param name="jwt">The JwtManager to be injected into this service.</param>
        public UserManager(guitardbContext db, IJwtManager jwt)
        {
            _db = db;
            _jwt = jwt;
        }
        public async Task<(bool isSuccess, string message)> AuthenticateUser(UserSignInModel userModel)
        {
            User user;
            try
            {
                user = await _db.Users.Where(u => u.Name == userModel.Username).Include(u => u.Password).FirstAsync();
            }
            catch
            {
                return (false, "No user with that username");
            }
            byte[] salt = user.Password.Salt, hash = user.Password.Hash;

            var newHash = Tools.GenerateSaltedHash(Encoding.UTF8.GetBytes(userModel.Password), salt);
            if (Tools.CompareByteArrays(hash, newHash))
                return (true, _jwt.GenerateToken(user));
            return (false, "Passwords don't match up");
        }
        public async Task<(bool isSuccess, string message)> CreateUser(UserSignUpModel userModel)
        {
            if (!Tools.IsValidEmail(userModel.Email))
                return (false, "Email Invalid");

            if (await _db.Users.AnyAsync(u => u.Email == userModel.Email))
                return (false, "Email is already in use, Insert another email");

            if (await _db.Users.AnyAsync(u => u.Name == userModel.Username))
                return (false, "Username is already in user, Choose another username");

            var passwordByteArray = Encoding.UTF8.GetBytes(userModel.Password);
            var salt = Tools.GenerateSalt(64);
            var hashedPassword = Tools.GenerateSaltedHash(passwordByteArray, salt);

            var password = new Password() { Hash = hashedPassword, Salt = salt };
            await _db.AddAsync(password);
            await _db.SaveChangesAsync();

            var user = new User()
            {
                Name = userModel.Username,
                Email = userModel.Email,
                PasswordId = password.Id,
                CreatedAt = DateTime.Now
            };
            await _db.AddAsync(user);
            await _db.SaveChangesAsync();
            return (true, "success");
        }
        public async Task<User?> GetUserFromToken(string token)
        {
            int userId = _jwt.GetUserIdFromToken(token);
            try
            {
                return await _db.Users.FirstAsync(u => u.Id == userId);
            }
            catch
            {
                return null;
            }
        }
    }
}
