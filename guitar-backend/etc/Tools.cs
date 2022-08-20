using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Linq.Expressions;
using System.Net.Mail;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace guitar_backend.etc;
/// <summary>
/// A static class containing complex methods used in code throughout the project.
/// </summary>
public static class Tools
{  
    /// <summary>
    /// Dynamically orders <c>IQueryable</c> by given entity's property name.
    /// </summary>
    /// <typeparam name="TEntity"></typeparam>
    /// <param name="source">IQueryable to order.</param>
    /// <param name="orderByProperty">The name of the property to order by.</param>
    /// <param name="desc">Bool, if true orders in descending order else in ascending order.</param>
    /// <returns><c>IQueryable</c> orderd by the given entity's property name for further querys.</returns>
    public static IQueryable<TEntity> OrderBy<TEntity>(this IQueryable<TEntity> source, string orderByProperty,
                     bool desc)
    {
        string command = desc ? "OrderByDescending" : "OrderBy";
        var type = typeof(TEntity);
        var property = type.GetProperty(orderByProperty);
        if (property == null)
            return source;
        var parameter = Expression.Parameter(type, "p");
        var propertyAccess = Expression.MakeMemberAccess(parameter, property);
        var orderByExpression = Expression.Lambda(propertyAccess, parameter);
        var resultExpression = Expression.Call(typeof(Queryable), command, new Type[] { type, property.PropertyType },
                                      source.Expression, Expression.Quote(orderByExpression));
        return source.Provider.CreateQuery<TEntity>(resultExpression);
    }
    /// <summary>
    /// Salts password and hashes it with SHA256.
    /// </summary>
    /// <param name="plainText">The password in plain text, <c>byte[]</c> of the password.</param>
    /// <param name="salt">The salt used to salt the password before hashing, should be <c>byte[]</c> containing 64 random bytes.</param>
    /// <returns>The salted and hashed password, ready to be stored or compared, it is a <c>byte[]</c></returns>
    public static byte[] GenerateSaltedHash(byte[] plainText, byte[] salt)
    {
        HashAlgorithm algorithm = SHA256.Create();

        byte[] plainTextWithSaltBytes =
          new byte[plainText.Length + salt.Length];

        for (int i = 0; i < plainText.Length; i++)
        {
            plainTextWithSaltBytes[i] = plainText[i];
        }
        for (int i = 0; i < salt.Length; i++)
        {
            plainTextWithSaltBytes[plainText.Length + i] = salt[i];
        }

        return algorithm.ComputeHash(plainTextWithSaltBytes);
    }
    /// <summary>
    /// Checks if 2 <c>byte[]</c> are equal.
    /// </summary>
    /// <param name="array1">The first <c>byte[]</c>.</param>
    /// <param name="array2">The second <c>byte[]</c>.</param>
    /// <returns>True if the two arrays are equal, otherwise false.</returns>
    public static bool CompareByteArrays(byte[] array1, byte[] array2)
    {
        if (array1.Length != array2.Length)
        {
            return false;
        }

        for (int i = 0; i < array1.Length; i++)
        {
            if (array1[i] != array2[i])
            {
                return false;
            }
        }

        return true;
    }
    /// <summary>
    /// Generates a random salt, which is a <c>byte[]</c> containing random values (noramlly 64 bytes long).
    /// </summary>
    /// <param name="saltByteLength">The length of the generated salt in bytes, 64 is recommended.</param>
    /// <returns>The random salt generated with the specified length.</returns>
    public static byte[] GenerateSalt(int saltByteLength)
    {
        byte[] salt = new byte[saltByteLength];
        Random random = new Random();
        random.NextBytes(salt);
        return salt;
    }
    /// <summary>
    /// Checks rigorously if email is valid.
    /// </summary>
    /// <param name="email">Email to be verified</param>
    /// <returns>True if email is valid, otherwise false.</returns>
    public static bool IsValidEmail(string email)
    {
        if (!MailAddress.TryCreate(email, out var mailAddress))
            return false;

        // And if you want to be more strict:
        var hostParts = mailAddress.Host.Split('.');
        if (hostParts.Length == 1)
            return false; // No dot.
        if (hostParts.Any(p => p == string.Empty))
            return false; // Double dot.
        if (hostParts[^1].Length < 2)
            return false; // TLD only one letter.

        if (mailAddress.User.Contains(' '))
            return false;
        if (mailAddress.User.Split('.').Any(p => p == string.Empty))
            return false; // Double dot or dot at end of user part.

        return true;
    }
}

