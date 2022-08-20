using Braintree;

namespace guitar_backend.Services
{
    /// <summary>
    /// A service interface that manages the interaction with BrainTree gateway, in order to enable purchases for the clients.
    /// </summary>
    public interface IBraintreeService
    {
        /// <summary>
        /// Creates the payment gateway using BrainTree.
        /// </summary>
        /// <returns>The created gateway.</returns>
        IBraintreeGateway CreateGateway();
        /// <summary>
        /// Gets BrainTree token from BrainTree.
        /// </summary>
        /// <returns>The BrainTree token to the client, which is needed for the payment process in BrainTree.</returns>
        Task<string> GetToken();
        /// <summary>
        /// Tries to make the purchase using BrainTree.
        /// </summary>
        /// <param name="amount">The amount to of USD to be deducted of the client's balance.</param>
        /// <param name="nonce">The nonce of the purchase, a token which is then passed to BrainTree in order to validate the integrity of the purchase for the client and the host.</param>
        /// <returns>True if purchase has been successful, false otherwise.</returns>
        Task<bool> TryMakePurchase(decimal amount, string nonce);
    }
}
