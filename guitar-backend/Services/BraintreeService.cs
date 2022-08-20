using Braintree;
namespace guitar_backend.Services
{
    /// <summary>
    /// A service that manages the interaction with BrainTree gateway, in order to enable purchases for the clients.
    /// </summary>
    public class BraintreeService : IBraintreeService
    {
        /// <summary>
        /// A refrence to the app configuration, passed with DI.
        /// </summary>
        private readonly IConfiguration _config;
        /// <summary>
        /// A constructor used by DI to inject the dependent services, in this case, the refrence to the app's configuration.
        /// </summary>
        /// <param name="config">The app configuration refrence.</param>
        public BraintreeService(IConfiguration config)
        {
            _config = config;
        }
        public IBraintreeGateway CreateGateway()
        {
            var newGateway = new BraintreeGateway()
            {
                Environment = Braintree.Environment.SANDBOX,
                MerchantId = _config["BraintreeGateway:MerchantId"],
                PublicKey = _config["BraintreeGateway:PublicKey"],
                PrivateKey = _config["BraintreeGateway:PrivateKey"]
            };
            return newGateway;
        }
        public async Task<string> GetToken()
        {
            var gateway = CreateGateway();
            return await gateway.ClientToken.GenerateAsync();  //Genarating a token
        }
        public async Task<bool> TryMakePurchase(decimal amount, string nonce)
        {
            var gateway = CreateGateway();
            var request = new TransactionRequest
            {
                Amount = amount,
                PaymentMethodNonce = nonce,
                Options = new TransactionOptionsRequest
                {
                    SubmitForSettlement = true
                }
            };

            Result<Transaction> result = await gateway.Transaction.SaleAsync(request);
            
            return result.IsSuccess();
        }
    }
}
